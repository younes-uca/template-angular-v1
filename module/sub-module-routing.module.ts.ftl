
// const root = environment.rootAppUrl;

import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { AuthGuard } from 'src/app/controller/guards/auth.guard';



<#list subModule.pojos as pojo>
<#if pojo.ignoreFront == false>
import { ${pojo.name?cap_first}List${role.name?cap_first}Component } from './${pojo.formatedUrl?uncap_first}-${role.name}/list-${role.name}/${pojo.formatedUrl?uncap_first}-list-${role.name}.component';
</#if>
</#list>
@NgModule({
    imports: [
        RouterModule.forChild(
            [
                {
                    path: '',
                    children: [

                        <#list subModule.pojos as pojo>
                        <#if pojo.ignoreFront == false>

                        {

                            path: '${pojo.formatedUrl?uncap_first}',
                            children: [
                                {
                                    path: 'list',
                                    component: ${pojo.name?cap_first}List${role.name?cap_first}Component ,
                                    canActivate: [AuthGuard]
                                }
                                <#if pojo.createUpdateConfounded>
                                 ,{
                                    path: 'create',
                                    component: ${pojo.name?cap_first}Create${role.name?cap_first}Component ,
                                    canActivate: [AuthGuard]
                                }
                                </#if>
                            ]
                        },
                            </#if>
                        </#list>

                    ]
                },
            ]
        ),
    ],
    exports: [RouterModule],
})
export class ${subModule.folder?cap_first}${role.name?cap_first}RoutingModule { }
