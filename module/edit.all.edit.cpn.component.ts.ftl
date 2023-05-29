import {Component, OnInit, Input} from '@angular/core';
<#assign myimports = [""]>
<#assign declarations = [""]>


import {AbstractEditController} from 'src/app/zynerator/controller/AbstractEditController';
<#if pojo.createUpdateConfounded>
import { TokenService } from 'src/app/zynerator/security/Token.service';
</#if>

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
  selector: 'app-${pojo.formatedUrl}-edit-${role.name}',
  templateUrl: './${pojo.formatedUrl}-edit-${role.name}.component.html'
})
export class ${pojo.name}Edit${role.name?cap_first}Component extends AbstractEditController<${pojo.name}Dto, ${pojo.name}Criteria, ${pojo.name}Service>   implements OnInit {

<#list pojo.fields as field>
    <#if field.list>
        <#if !declarations?seq_contains(field.name?cap_first)>
    private _${field.name}Element = new ${field.typeAsPojo.name}Dto();
        <#assign declarations = declarations + [field.name]>
        </#if>
    </#if>
</#list>
 <#if pojo.createUpdateConfounded>
    msgsContents: string;
    info: string;
    isLoaded: boolean = false;
    isBlocked: boolean = true;
    data: any;
</#if>

<#list pojo.fields as fieldRequiered>
    <#if fieldRequiered.requierd>
    private _valid${pojo.name?cap_first}${fieldRequiered.name?cap_first} = true;
   </#if>
</#list>

<#list pojo.fields as field>
    <#list field.typeAsPojo.fields as fieldRequiered>
        <#if fieldRequiered.requierd>
    private _valid${field.name?cap_first}${fieldRequiered.name?cap_first} = true;
        </#if>
    </#list>
</#list>

<#list pojo.fields as field>
<#if field.list>
        <#list field.typeAsPojo.fields as innerField>
            <#if innerField.list && innerField.association>
    private _${innerField.name?uncap_first}: Array<${innerField.typeAsPojo.name?cap_first}Dto> = [];
            </#if>
        </#list>
</#if>
</#list>

<#list pojo.fields as field>
<#if field.list && field.association>
    private _${field.name?uncap_first}: Array<${field.typeAsPojo.name?cap_first}Dto> = [];
</#if>
</#list>

    constructor( private ${pojo.name?uncap_first}Service: ${pojo.name?cap_first}Service <#if pojo.createUpdateConfounded>, private tokenService: TokenService</#if><#list pojo.viewServices as viewService>, private ${viewService.name?uncap_first}Service: ${viewService.name?cap_first}Service</#list>) {
        super(${pojo.name?uncap_first}Service);
    }

    ngOnInit(): void {
<#list pojo.fields as field>
    <#if field.list>
        <#if field.association>
        this.${field.fieldOfAssociation.name?uncap_first}Service.findAll().subscribe(data => this.prepare${field.name?cap_first}(data));
        </#if>
        <#list field.typeAsPojo.fieldsGeneric as fieldGeneric>
            <#if fieldGeneric.typeAsPojo.name != pojo.name>
        this.${field.name}Element.${fieldGeneric.name} = new ${fieldGeneric.typeAsPojo.name}Dto();
        this.${fieldGeneric.name?uncap_first}Service.findAll().subscribe((data) => this.${fieldGeneric.name?uncap_first}s = data);
            </#if>
        </#list>
         <#list field.typeAsPojo.fields as innerField>
            <#if innerField.list && innerField.association>
         this.${innerField.fieldOfAssociation.name?uncap_first}Service.findAll().subscribe(data => this.prepare${innerField.name?cap_first}(data));
            </#if>
        </#list>

    </#if>
</#list>
<#list pojo.fieldsGeneric as fieldGeneric>
    this.${fieldGeneric.name} = new ${fieldGeneric.name?cap_first}Dto();
    this.${fieldGeneric.name?uncap_first}Service.findAll().subscribe((data) => this.${fieldGeneric.name?uncap_first}s = data);
</#list>
}
<#if pojo.hasDateTime>
    public prepareEdit() {
<#list pojo.fields as myField>
    <#if myField.simple && myField.dateTime>
        this.item.${myField.name} = this.${pojo.name?uncap_first}Service.format(this.item.${myField.name});
    </#if>
</#list>
    }

</#if>


 <#list pojo.fields as field>
        <#if field.list && field.association>
    prepare${field.name?cap_first}(${field.fieldOfAssociation.typeAsPojo.name?uncap_first}s: Array<${field.fieldOfAssociation.typeAsPojo.name?cap_first}Dto>): void{
        if( ${field.fieldOfAssociation.typeAsPojo.name?uncap_first}s != null){
            ${field.fieldOfAssociation.typeAsPojo.name?uncap_first}s.forEach(e => {
                const ${field.typeAsPojo.name?uncap_first} = new ${field.typeAsPojo.name?cap_first}Dto();
                ${field.typeAsPojo.name?uncap_first}.${field.fieldOfAssociation.name?uncap_first} = e;
                this.${field.name?uncap_first}.push(${field.typeAsPojo.name?uncap_first});
            });
        }
    }
       <#elseif field.list && (field.associationComplex || field.fakeAssociation)>
         <#list field.typeAsPojo.fields as innerField>
            <#if innerField.list && innerField.association>
    prepare${innerField.name?cap_first}(${innerField.fieldOfAssociation.typeAsPojo.name?uncap_first}s: Array<${innerField.fieldOfAssociation.typeAsPojo.name?cap_first}Dto>): void{
        if( ${innerField.fieldOfAssociation.typeAsPojo.name?uncap_first}s != null){
            ${innerField.fieldOfAssociation.typeAsPojo.name?uncap_first}s.forEach(e => {
                const ${innerField.typeAsPojo.name?uncap_first} = new ${innerField.typeAsPojo.name?cap_first}Dto();
                ${innerField.typeAsPojo.name?uncap_first}.${innerField.fieldOfAssociation.name?uncap_first} = e;
                this.${innerField.name?uncap_first}.push(${innerField.typeAsPojo.name?uncap_first});
            });
        }
   }
        </#if>
        </#list>
    </#if>
</#list>
<#list pojo.fields as field>
<#if field.list && !field.association>
    public validate${field.name?cap_first}(){
        this.errorMessages = new Array();
        <#list field.typeAsPojo.fields as innerField>
            <#if innerField.requierd>
        this.validate${field.name?cap_first}${innerField.name?cap_first}();
            </#if>
        </#list>
    }
</#if>
</#list>
    public setValidation(value : boolean){
    <#list pojo.fields as field>
    <#if field.requierd>
        this.valid${pojo.name?cap_first}${field.name?cap_first} = value;
    </#if>
    <#if field.list && !field.association>
            <#list field.typeAsPojo.fields as innerField>
                <#if innerField.requierd>
        this.valid${field.name?cap_first}${innerField.name?cap_first} = value;
                </#if>
            </#list>
    </#if>
    </#list>
        }
<#list pojo.fields as field>
    <#if field.list && !field.association>
   public add${field.name?cap_first}() {
        if( this.item.${field.name} == null )
            this.item.${field.name} = new Array<${field.typeAsPojo.name}Dto>();
       this.validate${field.name?cap_first}();
       if (this.errorMessages.length === 0) {
            if(this.${field.name}Element.id == null){
                this.item.${field.name}.push(this.${field.name}Element);
            }else{
                const index = this.item.${field.name}.findIndex(e => e.id == this.${field.name}Element.id);
                this.item.${field.name}[index] = this.${field.name}Element;
            }
          this.${field.name}Element = new ${field.typeAsPojo.name}Dto();
       }else{
            this.messageService.add({severity: 'error',summary: 'Erreurs', detail: 'Merci de corrigé les erreurs suivant : ' + this.errorMessages});
        }
   }

    public delete${field.typeAsPojo.name}(p: ${field.typeAsPojo.name}Dto) {
        this.item.${field.name}.forEach((element, index) => {
            if (element === p) { this.item.${field.name}.splice(index, 1); }
        });
    }

    public edit${field.typeAsPojo.name}(p: ${field.typeAsPojo.name}Dto) {
        this.${field.name}Element = {... p};
        this.activeTab = 0;
    }
    </#if>
</#list>
<#if pojo.showPopupEdit==false>
    public navigateTo${pojo.name}List(){
        this.router.navigate(['/app/${pojo.name?uncap_first}/list']);
    }
</#if>
    public validateForm(): void{
        this.errorMessages = new Array<string>();
<#list pojo.fields as field>
    <#if field.requierd>
        this.validate${pojo.name?cap_first}${field.name?cap_first}();
    </#if>
</#list>
    }
<#list pojo.fields as fieldRequiered>
<#if fieldRequiered.requierd>
    public validate${pojo.name?cap_first}${fieldRequiered.name?cap_first}(){
        <#if fieldRequiered.simple>
        if (this.stringUtilService.isEmpty(this.item.${fieldRequiered.name})) {
        <#elseif fieldRequiered.generic>
        if (this.stringUtilService.isEmpty(this.item.${fieldRequiered.name})) {
        <#elseif fieldRequiered.list>
        if (this.stringUtilService.isEmpty(this.item.${fieldRequiered.name})) {
        </#if>
            this.errorMessages.push('${fieldRequiered.formatedName?cap_first} non valide');
            this.valid${pojo.name?cap_first}${fieldRequiered.name?cap_first} = false;
        } else {
            this.valid${pojo.name?cap_first}${fieldRequiered.name?cap_first} = true;
        }
    }
</#if>
</#list>


<#list pojo.fields as field>
    <#if field.list>
        <#list field.typeAsPojo.fields as fieldRequiered>
            <#if fieldRequiered.requierd>
    private validate${field.name?cap_first}${fieldRequiered.name?cap_first}(){
    <#if fieldRequiered.simple>
        if (this.${field.name}Element.${fieldRequiered.name} == null) {
    <#elseif fieldRequiered.generic>
        if (this.${field.name}Element.${fieldRequiered.name} == null) {
    <#elseif fieldRequiered.list>
        if (this.${field.name}Element.${fieldRequiered.name} == null || this.${field.name}.${fieldRequiered.name}.length === 0) {
    </#if>
        this.errorMessages.push('${fieldRequiered.name?cap_first} de la ${field.typeAsPojo.name?uncap_first} est  invalide');
            this.valid${field.name?cap_first}${fieldRequiered.name?cap_first} = false;
        } else {
            this.valid${field.name?cap_first}${fieldRequiered.name?cap_first} = true;
        }
    }
            </#if>
    </#list>
    </#if>
</#list>

<#list pojo.fieldsGenericIncludingInnerTypeInListField as fieldGeneric>
   <#if fieldGeneric.typeAsPojo.ignoreFront == false &&  fieldGeneric.typeAsPojo.subModule.name == pojo.subModule.name>
   public async openCreate${fieldGeneric.name?cap_first}(${fieldGeneric.name}: string) {
        const isPermistted = await this.roleService.isPermitted('${fieldGeneric.typeAsPojo.name}', 'edit');
        if(isPermistted) {
             this.${fieldGeneric.name} = new ${fieldGeneric.typeAsPojo.name}Dto();
             this.create${fieldGeneric.name?cap_first}Dialog = true;
        }else{
             this.messageService.add({
                severity: 'error', summary: 'erreur', detail: 'problème de permission'
            });
        }
    }
</#if>
</#list>

<#list pojo.fieldsGenericIncludingInnerTypeInListField as fieldGeneric>
   get ${fieldGeneric.name}(): ${fieldGeneric.typeAsPojo.name}Dto {
       return this.${fieldGeneric.typeAsPojo.name?uncap_first}Service.item;
   }
  set ${fieldGeneric.name}(value: ${fieldGeneric.typeAsPojo.name?cap_first}Dto) {
        this.${fieldGeneric.typeAsPojo.name?uncap_first}Service.item = value;
   }
   get ${fieldGeneric.name?uncap_first}s(): Array<${fieldGeneric.typeAsPojo.name}Dto> {
        return this.${fieldGeneric.typeAsPojo.name?uncap_first}Service.items;
   }
   set ${fieldGeneric.name?uncap_first}s(value: Array<${fieldGeneric.typeAsPojo.name}Dto>) {
        this.${fieldGeneric.typeAsPojo.name?uncap_first}Service.items = value;
   }
   <#if fieldGeneric.typeAsPojo.ignoreFront == false>
   get create${fieldGeneric.name?cap_first}Dialog(): boolean {
       return this.${fieldGeneric.typeAsPojo.name?uncap_first}Service.createDialog;
   }
  set create${fieldGeneric.name?cap_first}Dialog(value: boolean) {
       this.${fieldGeneric.typeAsPojo.name?uncap_first}Service.createDialog= value;
   }
   </#if>
</#list>

    <#list pojo.fields as field>
    <#if field.list && field.association>
    get ${field.name?uncap_first}(): Array<${field.typeAsPojo.name?cap_first}Dto> {
        if( this._${field.name?uncap_first} == null )
            this._${field.name?uncap_first} = new Array();
         return this._${field.name?uncap_first};
    }

    set ${field.name?uncap_first}(value: Array<${field.typeAsPojo.name?cap_first}Dto>) {
        this._${field.name?uncap_first} = value;
    }
    </#if>
    </#list>
    <#list pojo.fields as field>
    <#if field.list>
    get ${field.name}Element(): ${field.typeAsPojo.name?cap_first}Dto {
        if( this._${field.name}Element == null )
            this._${field.name}Element = new ${field.typeAsPojo.name?cap_first}Dto();
         return this._${field.name}Element;
    }

    set ${field.name}Element(value: ${field.typeAsPojo.name}Dto) {
        this._${field.name}Element = value;
    }
    </#if>
    </#list>

<#list pojo.fields as field>
<#if field.list>
    <#list field.typeAsPojo.fields as innerField>
    <#if innerField.list && innerField.association>
    get ${innerField.name?uncap_first}(): Array<${innerField.typeAsPojo.name?cap_first}Dto> {
        if( this._${innerField.name?uncap_first} == null )
            this._${innerField.name?uncap_first} = new Array();
        return this._${innerField.name?uncap_first};
    }

    set ${innerField.name?uncap_first}(value: Array<${innerField.typeAsPojo.name?cap_first}Dto>) {
        this._${innerField.name?uncap_first} = value;
    }
    </#if>
    </#list>
</#if>
</#list>
    <#list pojo.fields as fieldRequiered>
    <#if fieldRequiered.requierd>
    get valid${pojo.name?cap_first}${fieldRequiered.name?cap_first}(): boolean {
        return this._valid${pojo.name?cap_first}${fieldRequiered.name?cap_first};
    }
    set valid${pojo.name?cap_first}${fieldRequiered.name?cap_first}(value: boolean) {
        this._valid${pojo.name?cap_first}${fieldRequiered.name?cap_first} = value;
    }
    </#if>
    </#list>

    <#list pojo.fields as field>
    <#list field.typeAsPojo.fields as fieldRequiered>
    <#if fieldRequiered.requierd>
    get valid${field.name?cap_first}${fieldRequiered.name?cap_first}(): boolean {
        return this._valid${field.name?cap_first}${fieldRequiered.name?cap_first};
    }
    set valid${field.name?cap_first}${fieldRequiered.name?cap_first}(value: boolean) {
        this._valid${field.name?cap_first}${fieldRequiered.name?cap_first} = value;
    }
    </#if>
    </#list>
    </#list>
}
