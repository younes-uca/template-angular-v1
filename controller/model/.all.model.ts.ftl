<#list pojo.types as type>
  <#if pojo.name != type.simpleName>
import {${type.simpleName}Dto} from './${type.simpleName}.model';
    </#if>
</#list>
<#if pojo.actor>
import {User} from 'src/app/zynerator/security/User.model';
<#else>
import {BaseDto} from 'src/app/zynerator/dto/BaseDto.model';

</#if>

export class ${pojo.name}Dto <#if pojo.actor> extends User<#else> extends BaseDto</#if>{

<#assign numberTypes = ["BigDecimal","Double"]>
    <#if !pojo.actor>
    <#if pojo.id??>
    public ${pojo.id.name?uncap_first}: number;
   </#if>
   </#if>
   <#list pojo.fieldsSimple as fieldSimple>
   <#if fieldSimple.id == false>
   <#if fieldSimple.type.simpleName == "String">
    public ${fieldSimple.name?uncap_first}: string;
   </#if>
    <#if fieldSimple.type.simpleName == "BigDecimal" || fieldSimple.type.simpleName == "Double">
    public ${fieldSimple.name?uncap_first}: number;
   </#if>
   <#if fieldSimple.type.simpleName == "Boolean">
   public ${fieldSimple.name?uncap_first}: null | boolean;
   </#if>
      <#if fieldSimple.type.simpleName == "Date" ||  fieldSimple.dateTime>
   public ${fieldSimple.name?uncap_first}: Date;
   </#if>
       <#if fieldSimple.type.simpleName == "Integer" || fieldSimple.type.simpleName == "Long">
   public ${fieldSimple.name?uncap_first}: number;
   </#if>
   </#if>
  </#list>
    <#list pojo.fieldsSimpleNumberOrDate as fieldSimpleNumberOrDate>
        <#if pojo.id??>
            <#if pojo.id.name != fieldSimpleNumberOrDate.name>
    public ${fieldSimpleNumberOrDate.name?uncap_first}Max: string ;
    public ${fieldSimpleNumberOrDate.name?uncap_first}Min: string ;
            </#if>
        </#if>
    </#list>
    <#list pojo.fieldsGeneric as fieldGeneric>
    <#if fieldGeneric.pojo??>
    public ${fieldGeneric.name?uncap_first}: ${fieldGeneric.pojo.name}Dto ;
    </#if>
    </#list>
    <#list pojo.fields as field>
    <#if field.list>
     public ${field.name?uncap_first}: Array<${field.typeAsPojo.name}Dto>;
    </#if>
    </#list>

}
