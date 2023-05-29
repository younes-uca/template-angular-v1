import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import {ToastModule} from 'primeng/toast';
import {ToolbarModule} from 'primeng/toolbar';
import {TableModule} from 'primeng/table';
import {DropdownModule} from 'primeng/dropdown';
import {InputSwitchModule} from 'primeng/inputswitch';
import {InputTextareaModule} from 'primeng/inputtextarea';

import { ConfirmDialogModule } from 'primeng/confirmdialog';
import { DialogModule } from 'primeng/dialog';
import { Login${role.name?cap_first}Component } from './login-${role.name}/login-${role.name}.component';
import { Register${role.name?cap_first}Component } from './register-${role.name}/register-${role.name}.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import {CalendarModule} from 'primeng/calendar';
import {PanelModule} from 'primeng/panel';
import {InputNumberModule} from 'primeng/inputnumber';
import {BadgeModule} from 'primeng/badge';
import { MultiSelectModule } from 'primeng/multiselect';
<#list subModules as subModule>
import { ${subModule.folder?cap_first}${role.name?cap_first}Module } from './view/${subModule.folder}/${subModule.folder}-${role.name}.module';
import { ${subModule.folder?cap_first}${role.name?cap_first}RoutingModule } from './view/${subModule.folder}/${subModule.folder}-${role.name}-routing.module';
</#list>


import { PasswordModule } from 'primeng/password';
import { InputTextModule } from 'primeng/inputtext';
import {ButtonModule} from 'primeng/button';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {RouterModule} from '@angular/router';
import {TabViewModule} from 'primeng/tabview';
import { SplitButtonModule } from 'primeng/splitbutton';
import { MessageModule } from 'primeng/message';
import {MessagesModule} from 'primeng/messages';


@NgModule({
  declarations: [
   Login${role.name?cap_first}Component,
   Register${role.name?cap_first}Component
  ],
  imports: [
    CommonModule,
    ToastModule,
    ToolbarModule,
    TableModule,
    ConfirmDialogModule,
    DialogModule,
    PasswordModule,
    InputTextModule,
    ButtonModule,
    FormsModule,
    ReactiveFormsModule,
    RouterModule,
    SplitButtonModule,
    BrowserAnimationsModule,
    DropdownModule,
    TabViewModule,
    InputSwitchModule,
    InputTextareaModule,
    CalendarModule,
    PanelModule,
    MessageModule,
    MessagesModule,
    InputNumberModule,
    BadgeModule,
    MultiSelectModule,
<#list subModules as subModule>
  ${subModule.folder?cap_first}${role.name?cap_first}Module,
  ${subModule.folder?cap_first}${role.name?cap_first}RoutingModule,
</#list>
  ],
  exports: [
  Login${role.name?cap_first}Component,
  Register${role.name?cap_first}Component,

<#list subModules as subModule>
    ${subModule.folder?cap_first}${role.name?cap_first}Module,
</#list>
  ],
  entryComponents: [],
})
export class ${role.name?cap_first}Module { }
