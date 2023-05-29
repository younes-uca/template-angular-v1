
<p-dialog [(visible)]="viewDialog" [style]="{width: '70vw'}" header="${pojo.tabPanelI18nView}" [modal]="true" styleClass="p-fluid">
    <ng-template pTemplate="content">
        <p-tabView>
            <p-tabPanel header="${pojo.tabPanelI18nCreate}">
                <div class="grid">
                    <#list pojo.fields as field>
                        <#if field.simple && !field.notVisibleInViewPage && !field.notIncluded && !field.password>
                            <#if  field.type.simpleName == "Date" || field.dateTime>
                    <div class="field col-12 md:col-${pojo.columnStyle}">
                        <label for="${field?index}">${field.name18nView}</label>
                        <p-calendar id="${field?index}" [disabled]="true"  [showTime]="true" [showSeconds]="false" placeholder="${field.name18nView}"  [(ngModel)]="item.${field.name}" dateFormat="{{dateFormat}}"></p-calendar>
                    </div>
                            <#elseif  field.large>
                    <div class="field col-12 md:col-${pojo.columnStyle}">
                        <label for="${field?index}">${field.name18nView}</label>
                        <textarea id="${field?index}" pInputTextarea rows="5" cols="30" [disabled]="true" placeholder="${field.name18nView}"  [(ngModel)]="item.${field.name}"></textarea>
                    </div>
                            <#elseif field.pureString>
                    <div class="field col-12 md:col-${pojo.columnStyle}">
                        <label for="${field?index}">${field.name18nView}</label>
                        <input class="mb-2 mr-2" type="text" pInputText [disabled]="true" placeholder="${field.name18nView}" autofocus  id="${field?index}" [(ngModel)]="item.${field.name}">
                    </div>
                            <#elseif field.bool>
                    <div class="field align-inputswitch col-12  md:col-${pojo.columnStyle}">
                        <div  class="label-inputswitch">
                            <label for="${field?index}">${field.name18nView}</label>
                        </div>
                        <div class="input-switch">
                            <p-inputSwitch id="${field?index}"  [disabled]="true" [(ngModel)]="item.${field.name}"></p-inputSwitch>
                        </div>
                    </div>
                            <#elseif field.id == false>
                    <div class="field col-12 md:col-${pojo.columnStyle}">
                        <label for="${field?index}">${field.name18nView}</label>
                        <p-inputNumber class="mb-2 mr-2" id="${field?index}" [disabled]="true" placeholder="${field.name18nView}" [(ngModel)]="item.${field.name}"></p-inputNumber>
                    </div>
                            </#if>
                        <#elseif field.generic>
                    <div class="field col-12 md:col-${pojo.columnStyle}">
                        <label for="${field?index}">${field.name18nView}</label>
                        <p-dropdown [options]="${field.name}s" [(ngModel)]="item.${field.name}" id="${field?index}" [disabled]="true" optionLabel="${field.typeAsPojo.labelOrReferenceOrId.name}" placeholder="${field.name18nView}"></p-dropdown>
                    </div>
                        </#if>
                    </#list>
                </div>
            </p-tabPanel>

            <#list pojo.fields as field>
                <#if field.list>
            <p-tabPanel header="${field.name18nCreateKey}">
                <div class="grid">
                    <div class="col">
                        <div class="card">
                            <p-table [value]="item.${field.name?uncap_first}" [scrollable]="true" scrollHeight="200px">
                                <ng-template pTemplate="header">
                                    <tr>
                                                <#list field.typeAsPojo.fields as myField>
                                                    <#if myField.simple && !myField.notVisibleInViewPage>
                                                        <#if !myField.id>
                                        <th>${myField.formatedName}</th>
                                                        </#if>
                                                    <#elseif myField.generic && !myField.notVisibleInViewPage>
                                                        <#if myField.typeAsPojo.name != pojo.name>
                                        <th>${myField.formatedName}</th>
                                                        </#if>
                                                    <#else>
                                                    </#if>
                                                </#list>
                                    </tr>
                                </ng-template>
                                <ng-template pTemplate="body" let-p>
                                    <tr>
                                                <#list field.typeAsPojo.fields as myField>
                                                    <#if myField.simple && !myField.id && !myField.notVisibleInViewPage>
                                                        <#if myField.type.name == "Date" || myField.dateTime>
                                        <td>{{p.${myField.name} | date: dateFormatColumn}}</td>
                                                        <#elseif myField.bool>
                                        <td><i *ngIf="p.${myField.name}" class="pi pi-check checked-toogle"></i>
                                            <i *ngIf="!p.${myField.name}" class="pi pi-times unchecked-toogle"></i>
                                        </td>
                                                        <#else>
                                        <td>{{p.${myField.name}}}</td>
                                                        </#if>
                                                    <#elseif myField.generic && myField.typeAsPojo.name != pojo.name && !myField.notVisibleInViewPage>
                                        <td>{{p.${myField.name}?.${myField.typeAsPojo.labelOrReferenceOrId.name}}}</td>
                                                    </#if>
                                                </#list>
                                    </tr>
                                </ng-template>
                            </p-table>
                        </div>
                    </div>
                </div>
            </p-tabPanel>
                </#if>
        </#list>
        </p-tabView>

    </ng-template>

    <ng-template pTemplate="footer" >
        <div class="grid-footer">
            <div>
                <button pButton pRipple label="Annuler" icon="pi pi-times" class="p-button-outlined" (click)="hideViewDialog()"></button>
            </div>
        </div>
    </ng-template>
</p-dialog>



