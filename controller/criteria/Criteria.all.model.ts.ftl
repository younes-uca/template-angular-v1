<#list pojo.types as type>
  <#if pojo.name != type.simpleName>
import {${type.simpleName}Criteria} from './${type.simpleName}Criteria.model';
    </#if>
</#list>
<#if pojo.actor>
import {User} from 'src/app/zynerator/security/User.model';
<#else>
import {BaseCriteria} from 'src/app/zynerator/criteria/BaseCriteria.model';
</#if>


export class ${pojo.name}Criteria  extends  <#if !pojo.actor> BaseCriteria <#else>  User</#if> {

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
    public ${fieldSimple.name?uncap_first}Like: string;
   </#if>
    <#if fieldSimple.nombre>
     public ${fieldSimple.name?uncap_first}: number;
     public ${fieldSimple.name?uncap_first}Min: number;
     public ${fieldSimple.name?uncap_first}Max: number;
   </#if>
   <#if fieldSimple.type.simpleName == "Boolean">
    public ${fieldSimple.name?uncap_first}: null | boolean;
   </#if>
      <#if fieldSimple.type.simpleName == "Date" ||  fieldSimple.dateTime>
    public ${fieldSimple.name?uncap_first}: Date;
    public ${fieldSimple.name?uncap_first}From: Date;
    public ${fieldSimple.name?uncap_first}To: Date;
   </#if>
   </#if>
  </#list>
    <#list pojo.fieldsGeneric as fieldGeneric>
    <#if fieldGeneric.pojo??>
  public ${fieldGeneric.name?uncap_first}: ${fieldGeneric.pojo.name}Criteria ;
  public ${fieldGeneric.name?uncap_first}s: Array<${fieldGeneric.pojo.name}Criteria> ;
    </#if>
    </#list>
    <#list pojo.fields as field>
    <#if field.list>
      public ${field.name?uncap_first}: Array<${field.typeAsPojo.name}Criteria>;
    </#if>
    </#list>

}
