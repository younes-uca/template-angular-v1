
// const root = environment.rootAppUrl;

import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { AuthGuard } from 'src/app/controller/guards/auth.guard';

import { Login${role.name?cap_first}Component } from './login-${role.name}/login-${role.name}.component';
import { Register${role.name?cap_first}Component } from './register-${role.name}/register-${role.name}.component';

@NgModule({
    imports: [
        RouterModule.forChild(
            [
                {
                    path: '',
                    children: [
                        {
                            path: 'login',
                            children: [
                                {
                                    path: '',
                                    component: Login${role.name?cap_first}Component ,
                                    canActivate: [AuthGuard]
                                }
                              ]
                        },
                        {
                            path: 'register',
                            children: [
                                {
                                    path: '',
                                    component: Register${role.name?cap_first}Component ,
                                    canActivate: [AuthGuard]
                                }
                              ]
                        },
                        <#list subModules as subModule>
                        {

                            path: '${subModule.folder}',
                            loadChildren: () => import('./view/${subModule.folder}/${subModule.folder}-${role.name}-routing.module').then(x=>x.${subModule.folder?cap_first}${role.name?cap_first}RoutingModule),
                            canActivate: [AuthGuard],
                        },
                        </#list>
                    ]
                },
            ]
        ),
    ],
    exports: [RouterModule],
})
export class ${role.name?cap_first}RoutingModule { }
