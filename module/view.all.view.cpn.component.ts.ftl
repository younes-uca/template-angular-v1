import {Component, OnInit} from '@angular/core';

<#assign myimports = [""]>
<#assign declarations = [""]>

import {AbstractViewController} from 'src/app/zynerator/controller/AbstractViewController';
import { environment } from 'src/environments/environment';

import {${pojo.name}Service} from 'src/app/controller/service/${pojo.name}.service';
import {${pojo.name}Dto} from 'src/app/controller/model/${pojo.name}.model';
import {${pojo.name}Criteria} from 'src/app/controller/criteria/${pojo.name}Criteria.model';

<#if pojo.dependencies??>
<#list pojo.dependencies as dependency>
<#if dependency?? && dependency.name??>
import {${dependency.name?cap_first}Dto} from 'src/app/controller/model/${dependency.name?cap_first}.model';
import {${dependency.name?cap_first}Service} from 'src/app/controller/service/${dependency.name?cap_first}.service';
</#if>
</#list>
</#if>
@Component({
  selector: 'app-${pojo.formatedUrl}-view-${role.name}',
  templateUrl: './${pojo.formatedUrl}-view-${role.name}.component.html'
})
export class ${pojo.name}View${role.name?cap_first}Component extends AbstractViewController<${pojo.name}Dto, ${pojo.name}Criteria, ${pojo.name}Service> implements OnInit {

<#list pojo.fields as field>
    <#if field.list>
        <#if !declarations?seq_contains(field.name)>
    ${field.name} = new ${field.typeAsPojo.name}Dto();
        <#assign declarations = declarations + [field.name]>
        </#if>
        <#if !declarations?seq_contains(field.name+"s")>
    ${field.name}s: Array<${field.typeAsPojo.name}Dto> = [];
        <#assign declarations = declarations + [field.name+"s"]>
        </#if>
    </#if>
</#list>

    constructor(private ${pojo.name?uncap_first}Service: ${pojo.name?cap_first}Service<#if pojo.createUpdateConfounded>, private tokenService: TokenService</#if><#list pojo.viewServices as viewService>, private ${viewService.name?uncap_first}Service: ${viewService.name?cap_first}Service</#list>){
        super(${pojo.name?uncap_first}Service);
    }

    ngOnInit(): void {
    <#list pojo.fields as field>
        <#if field.list>
            <#list field.typeAsPojo.fieldsGeneric as fieldGeneric>
                <#if fieldGeneric.typeAsPojo.name != pojo.name>
        this.${field.name}.${fieldGeneric.name} = new ${fieldGeneric.typeAsPojo.name}Dto();
        this.${fieldGeneric.typeAsPojo.name?uncap_first}Service.findAll().subscribe((data) => this.${fieldGeneric.name}s = data);
                </#if>
            </#list>
        </#if>
    </#list>
    <#list pojo.fieldsGeneric as fieldGeneric>
        this.${fieldGeneric.name} = new ${fieldGeneric.name?cap_first}Dto();
        this.${fieldGeneric.name}Service.findAll().subscribe((data) => this.${fieldGeneric.name}s = data);
    </#list>
    }

<#if pojo.mustValidate>
    get hide${pojo.name?cap_first}(): boolean {
        return this.${pojo.name}.username != null;
    }
    </#if>

<#list pojo.fieldsGenericIncludingInnerTypeInListField as fieldGeneric>
    get ${fieldGeneric.name}(): ${fieldGeneric.typeAsPojo.name}Dto {
       return this.${fieldGeneric.typeAsPojo.name?uncap_first}Service.item;
    }
    set ${fieldGeneric.name}(value: ${fieldGeneric.typeAsPojo.name?cap_first}Dto) {
        this.${fieldGeneric.typeAsPojo.name?uncap_first}Service.item = value;
    }
    get ${fieldGeneric.name?uncap_first}s():Array<${fieldGeneric.typeAsPojo.name}Dto> {
       return this.${fieldGeneric.typeAsPojo.name?uncap_first}Service.items;
    }
    set ${fieldGeneric.name?uncap_first}s(value: Array<${fieldGeneric.typeAsPojo.name}Dto>) {
        this.${fieldGeneric.typeAsPojo.name?uncap_first}Service.items = value;
    }
</#list>


}
