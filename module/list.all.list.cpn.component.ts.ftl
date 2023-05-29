import {Component, OnInit} from '@angular/core';
import {${pojo.name}Service} from 'src/app/controller/service/${pojo.name}.service';
import {${pojo.name}Dto} from 'src/app/controller/model/${pojo.name}.model';
import {${pojo.name}Criteria} from 'src/app/controller/criteria/${pojo.name}Criteria.model';
import {AbstractListController} from 'src/app/zynerator/controller/AbstractListController';
import { environment } from 'src/environments/environment';

<#list pojo.fieldsGeneric as field>
import { ${field.typeAsPojo.name?cap_first}Service } from 'src/app/controller/service/${field.typeAsPojo.name?cap_first}.service';
</#list>

<#list pojo.types as type>
  <#if pojo.name != type.simpleName>
import {${type.simpleName}Dto} from 'src/app/controller/model/${type.simpleName}.model';
    </#if>
</#list>
<#list pojo.fieldsSimple as simpleField>
  <#if simpleField.dateTime>
      <#assign dateFieldName = simpleField.name>
  </#if>
</#list>


@Component({
  selector: 'app-${pojo.formatedUrl}-list-${role.name}',
  templateUrl: './${pojo.formatedUrl}-list-${role.name}.component.html'
})
export class ${pojo.name}List${role.name?cap_first}Component extends AbstractListController<${pojo.name}Dto, ${pojo.name}Criteria, ${pojo.name}Service>  implements OnInit {

    fileName = '${pojo.name}';

 <#list pojo.fields as field>
     <#if field.simple && field.bool>
     yesOrNo${field.name?cap_first} :any[] =[];
    </#if>
 </#list>
<#list pojo.fieldsGeneric as field>
    ${field.name}s :Array<${field.typeAsPojo.name?cap_first}Dto>;
</#list>
  
    constructor(${pojo.name?uncap_first}Service: ${pojo.name?cap_first}Service<#list pojo.fieldsGeneric as field>, private ${field.typeAsPojo.name?uncap_first}Service: ${field.typeAsPojo.name?cap_first}Service</#list>) {
        super(${pojo.name?uncap_first}Service);
<#if pojo.exportable == true>
        this.pdfName='${pojo.name}.pdf';
</#if>
    }

    ngOnInit() : void {
      this.findPaginatedByCriteria();
      this.initExport();
      this.initCol();
    <#list pojo.fieldsGeneric as field>
      this.load${field.name?cap_first}();
    </#list>
    <#list pojo.fields as field>
     <#if field.simple && field.bool>
    this.yesOrNo${field.name?cap_first} =  [{label: '${field.name?cap_first}', value: null},{label: 'Oui', value: 1},{label: 'Non', value: 0}];
    </#if>
    </#list>
    }

    public async load${pojo.name?cap_first}s(){
        await this.roleService.findAll();
        const isPermistted = await this.roleService.isPermitted('${pojo.name}', 'list');
        isPermistted ? this.service.findAll().subscribe(${pojo.name?uncap_first}s => this.items = ${pojo.name?uncap_first}s,error=>console.log(error))
        : this.messageService.add({severity: 'error', summary: 'erreur', detail: 'problème d\'autorisation'});
    }

<#if pojo.createUpdateConfounded>
   public navigateTo${pojo.name}Create(){
        this.router.navigate(['/app/${role.name}/${pojo.name?uncap_first}/create']);
    }
</#if>

    public initCol() {
        this.cols = [
            <#list pojo.fields as field>
                <#if field.name != pojo.id.name && !field.large && !field.list>
                    <#if field.simple>
            {field: '${field.name}', header: '${field.formatedName}'},
                    <#elseif field.generic>
            {field: '${field.name}?.${field.typeAsPojo.labelOrReferenceOrId.name}', header: '${field.formatedName}'},
                    </#if>
                </#if>
            </#list>
        ];
    }

<#if 1 == 0 &&  pojo.archivable>
    public async archiver${pojo.name}(${pojo.name?uncap_first}: ${pojo.name}Dto){
        const isPermistted = await this.roleService.isPermitted('${pojo.name}', 'delete');
        if(isPermistted){
            this.confirmationService.confirm({
                message: 'Voulez-vous archiver cet élément (${pojo.formatedName}) ?',
                header: 'Confirmation',
                icon: 'pi pi-exclamation-triangle',
                accept: () => {
                this.service.archiver(${pojo.name?uncap_first}).subscribe(status=>{
                    const myIndex = this.${pojo.name?uncap_first}s.indexOf(${pojo.name?uncap_first});
                    this.${pojo.name?uncap_first}s[myIndex] = status;
                    this.messageService.add({
                    severity: 'success',
                    summary: 'Succès',
                    detail: '${pojo.formatedName} archivé',
                    life: 3000
                    });
                },error=>console.log(error))
            }
        });
        }else{
            this.messageService.add({
            severity: 'error', summary: 'erreur', detail: 'Problème de permission'
            });
        }
    }

    public async desarchiver${pojo.name}(${pojo.name?uncap_first}: ${pojo.name}Dto){
        const isPermistted = await this.roleService.isPermitted('${pojo.name}', 'delete');
        if(isPermistted){
            this.confirmationService.confirm({
            message: 'Voulez-vous désarchiver cet élément (${pojo.formatedName}) ?',
            header: 'Confirmation',
            icon: 'pi pi-exclamation-triangle',
            accept: () => {
                this.service.desarchiver(${pojo.name?uncap_first}).subscribe(status=>{
                const myIndex = this.${pojo.name?uncap_first}s.indexOf(${pojo.name?uncap_first});
                this.${pojo.name?uncap_first}s[myIndex] = status;
                this.messageService.add({
                    severity: 'success',
                    summary: 'Succès',
                    detail: '${pojo.formatedName} désarchivé',
                    life: 3000
                });
                },error=>console.log(error))
                }
            });
        }else{
            this.messageService.add({
                severity: 'error', summary: 'erreur', detail: 'Problème de permission'
            });
        }
    }
</#if>

<#list pojo.fieldsGeneric as field>
    public async load${field.name?cap_first}(){
        await this.roleService.findAll();
        const isPermistted = await this.roleService.isPermitted('${pojo.name}', 'list');
        isPermistted ? this.${field.typeAsPojo.name?uncap_first}Service.findAll<#if field.typeAsPojo.labelOrReference??>Optimized</#if>().subscribe(${field.name?uncap_first}s => this.${field.name?uncap_first}s = ${field.name?uncap_first}s,error=>console.log(error))
        : this.messageService.add({severity: 'error', summary: 'Erreur', detail: 'Problème de permission'});
    }
</#list>

	public initDuplicate(res: ${pojo.name?cap_first}Dto) {
    <#list pojo.fields as field>
            <#if field.list>
        if (res.${field.name?uncap_first} != null) {
             res.${field.name?uncap_first}.forEach(d => { d.${pojo.name?uncap_first} = null; d.${field.typeAsPojo.id.name} = null; });
        }
        </#if>
    </#list>
	}

   public prepareColumnExport() : void {
        this.exportData = this.items.map(e => {
            return {
    <#list pojo.fields as field>
            <#if field.simple && field.id ==false>
                <#if field.dateTime>
                '${field.formatedName}': this.datePipe.transform(e.${field.name} , 'dd/MM/yyyy hh:mm'),
                <#elseif field.bool>
                '${field.formatedName}': e.${field.name}? 'Vrai' : 'Faux' ,
                <#else>
                 '${field.formatedName}': e.${field.name} ,
               </#if>
          <#elseif field.generic>
                '${field.formatedName}': e.${field.name}?.${field.typeAsPojo.labelOrReferenceOrId.name} ,
        </#if>
    </#list>
            }
        });

        this.criteriaData = [{
<#list pojo.fields as field>
    <#if field.simple && field.id ==false>
        <#if field.dateTime>
            '${field.formatedName} Min': this.criteria.${field.name}From ? this.datePipe.transform(this.criteria.${field.name}From , this.dateFormat) : environment.emptyForExport ,
            '${field.formatedName} Max': this.criteria.${field.name}To ? this.datePipe.transform(this.criteria.${field.name}To , this.dateFormat) : environment.emptyForExport ,
        <#elseif field.bool>
            '${field.formatedName}': this.criteria.${field.name} ? (this.criteria.${field.name} ? environment.trueValue : environment.falseValue) : environment.emptyForExport ,
        <#elseif field.nombre>
            '${field.formatedName} Min': this.criteria.${field.name}Min ? this.criteria.${field.name}Min : environment.emptyForExport ,
            '${field.formatedName} Max': this.criteria.${field.name}Max ? this.criteria.${field.name}Max : environment.emptyForExport ,
        <#else>
            '${field.formatedName}': this.criteria.${field.name} ? this.criteria.${field.name} : environment.emptyForExport ,
        </#if>
    <#elseif field.generic>
        //'${field.formatedName}': this.criteria.${field.name}?.${field.typeAsPojo.labelOrReferenceOrId.name} ? this.criteria.${field.name}?.${field.typeAsPojo.labelOrReferenceOrId.name} : environment.emptyForExport ,
    </#if>
</#list>
        }];
      }
}
