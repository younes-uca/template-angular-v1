import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { AppMainComponent } from './app.main.component';
import { AuthGuard } from './controller/guards/auth.guard';
import { AccessDeniedComponent } from './auth/access-denied/access-denied.component';
import {HomeComponent} from './module/home/home.component';

<#list roles as role>
import {Login${role.name?cap_first}Component} from './module/${role.name}/login-${role.name}/login-${role.name}.component';
import {Register${role.name?cap_first}Component} from './module/${role.name}/register-${role.name}/register-${role.name}.component';
</#list>
@NgModule({
  imports: [
    RouterModule.forRoot(
      [
          { path: '', component: HomeComponent },
        <#list roles as role>
        {path: '${role.name}/login', component: Login${role.name?cap_first}Component },
        {path: '${role.name}/register', component: Register${role.name?cap_first}Component },
        </#list>
         {
          path: 'app', // '\'' + root + '\'',
          component: AppMainComponent,
          children: [
            <#list roles as role>
            {
              path: '${role.name}',
              loadChildren: () => import( './module/${role.name}/${role.name}-routing.module').then(x => x.${role.name?cap_first}RoutingModule),
              canActivate: [AuthGuard],
            },
            </#list>
            { path: 'denied', component: AccessDeniedComponent },
          ],
          canActivate: [AuthGuard]
        },
      ],
      { scrollPositionRestoration: 'enabled' }
    ),
  ],
  exports: [RouterModule],
})
export class AppRoutingModule { }
