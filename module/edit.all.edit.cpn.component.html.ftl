<#if pojo.createUpdateConfounded>
    <p-toast></p-toast>
    <div class="card">
        <message severity="{{info}}" text="{{msgsContents}}"></message>
    </div>
<p-panel header="${pojo.tabPanelI18nEdit}" <#if pojo.createUpdateConfounded>  *ngIf="isLoaded"</#if> >
    <div class="p-fluid">
        <#else>
        <p-dialog [(visible)]="editDialog" [style]="{width: '70vw'}" header="${pojo.tabPanelI18nEdit}" [modal]="true" styleClass="p-fluid" [maximizable]="true" [draggable]="false" [resizable]="false">
            </#if>
            <ng-template pTemplate="content" <#if pojo.createUpdateConfounded>[ngIf]="true"</#if>>
                <p-tabView>
                    <p-tabPanel header="${pojo.tabPanelI18nEdit}">
                        <div class="grid">
                            <#list pojo.fields as field>

                                <#if field.simple && !field.notVisibleInEditPage>
                                    <#if  field.dateTime>
                                        <div class="field col-12 md:col-${pojo.columnStyle}">
                                            <label for="${field?index}">${field.name18nEdit!'walo'}<#if field.requierd><span style="color: red;">*</span></#if></label>
                                            <p-calendar appendTo="body" id="${field?index}"   [showTime]="true" [showSeconds]="false" placeholder="${field.name18nEdit!'walo'}"  [(ngModel)]="item.${field.name}"
                                                     <#if field.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${pojo.name?cap_first}${field.name?cap_first}}" </#if> >
                                            </p-calendar>
                                            <#if field.requierd><small class='p-error' *ngIf='!valid${pojo.name?cap_first}${field.name?cap_first}'>${field.name?cap_first} est obligatoire.</small></#if>
                                        </div>
                                    <#elseif  field.large>
                                        <div class="field col-12 md:col-${pojo.columnStyle}">
                                            <label for="${field?index}">${field.name18nEdit!'walo'}<#if field.requierd><span style="color: red;">*</span></#if></label>
                                            <textarea appendTo="body" id="${field?index}" pInputTextarea rows="5" cols="30" placeholder="${field.name18nEdit!'walo'}"  [(ngModel)]="item.${field.name}"
                                                    <#if field.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${pojo.name?cap_first}${field.name?cap_first}}" </#if> ></textarea>
                                            <#if field.requierd><small class='p-error' *ngIf='!valid${pojo.name?cap_first}${field.name?cap_first}'>${field.name?cap_first} est obligatoire.</small></#if>
                                        </div>
                                    <#elseif field.pureString>
                                        <div class="field col-12 md:col-${pojo.columnStyle}">
                                            <label for="${field?index}">${field.name18nEdit!'walo'}<#if field.requierd><span style="color: red;">*</span></#if></label>
                                            <input   appendTo="body" class="mb-2 mr-2" type="text" pInputText placeholder="${field.name18nEdit!'walo'}" id="${field?index}" [(ngModel)]="item.${field.name}"
                                                    <#if field.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${pojo.name?cap_first}${field.name?cap_first}}" </#if> />
                                            <#if field.requierd><small class='p-error' *ngIf='!valid${pojo.name?cap_first}${field.name?cap_first}'>${field.name?cap_first} est obligatoire.</small></#if>
                                        </div>
                                    <#elseif field.bool>
                                        <div class="field align-inputswitch col-12  md:col-${pojo.columnStyle}">
                                            <div  class="label-inputswitch">
                                                <label for="${field?index}">${field.name18nEdit!'walo'}<#if field.requierd><span style="color: red;">*</span></#if></label>
                                            </div>
                                            <div class="input-switch">
                                                <p-inputSwitch   appendTo="body" id="${field?index}"  [(ngModel)]="item.${field.name}"
                                                        <#if field.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${pojo.name?cap_first}${field.name?cap_first}}" </#if> >
                                                </p-inputSwitch>
                                                <#if field.requierd><small class='p-error' *ngIf='!valid${pojo.name?cap_first}${field.name?cap_first}'>${field.name?cap_first} est obligatoire.</small></#if>
                                            </div>
                                        </div>
                                    <#elseif field.id == false>
                                        <div class="field col-12 md:col-${pojo.columnStyle}">
                                            <label for="${field?index}">${field.name18nEdit!'walo'}<#if field.requierd><span style="color: red;">*</span></#if></label>
                                            <p-inputNumber  appendTo="body" class="mb-2 mr-2" id="${field?index}"
                                                           placeholder="${field.name18nEdit!'walo'}" [(ngModel)]="item.${field.name}" <#if field.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${pojo.name?cap_first}${field.name?cap_first}}" </#if> >
                                            </p-inputNumber>
                                            <#if field.requierd><small class='p-error' *ngIf='!valid${pojo.name?cap_first}${field.name?cap_first}'>${field.name?cap_first} est obligatoire.</small></#if>
                                        </div>
                                    </#if>
                                <#elseif field.generic && !field.notVisibleInEditPage>
                                    <div class="field col-11 md:col-<#if field.typeAsPojo.ignoreFront == false>${pojo.columnStyle -1}<#else >${pojo.columnStyle}</#if>">
                                            <label for="${field?index}">${field.name18nEdit!'walo'}<#if field.requierd><span style="color: red;">*</span></#if></label>
                                            <p-dropdown   appendTo="body" [options]="${field.name}s" [(ngModel)]="item.${field.name}" id="${field?index}"[filter]="true" filterMatchMode="contains"
                                                    [showClear]="true" optionLabel="<#if field.typeAsPojo??>${field.typeAsPojo.labelOrReferenceOrId.name}<#else>${field.name}</#if>" placeholder="${field.name18nEdit!'walo'}" <#if field.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${pojo.name?cap_first}${field.name?cap_first}}" </#if> >
                                            </p-dropdown>
                                            <#if field.requierd><small class='p-error' *ngIf='!valid${pojo.name?cap_first}${field.name?cap_first}'>${field.name?cap_first} est obligatoire.</small></#if>
                                        </div>
                                 <#if field.typeAsPojo.ignoreFront == false  && field.typeAsPojo.subModule.name == pojo.subModule.name>
                                        <div class="col-1">
                                            <label></label>
                                            <button pButton pRipple type="button" icon="pi pi-plus" (click)="openCreate${field.typeAsPojo.name?cap_first}('${field.typeAsPojo.name}')" class="p-button-success one-colonne-btn-success-align"></button>
                                        </div>
                                 </#if>
                                 </#if>
                            </#list>
                        </div>
                    </p-tabPanel>
                    <#list pojo.fields as field>
                        <#if field.list && field.association>
                            <p-tabPanel header="${field.fieldOfAssociation.name}">
                                <div class="grid">
                                    <div class="col">
                                        <div class="card">
                                            <p-table [value]="${field.name}" [(selection)]="item.${field.name}" dataKey="${field.fieldOfAssociation.name}.${field.fieldOfAssociation.typeAsPojo.labelOrReferenceOrId.name}" [scrollable]="true" scrollHeight="200px">
                                                <ng-template pTemplate="header">
                                                    <tr>
                                                        <th>${field.fieldOfAssociation.name?cap_first}</th>
                                                    </tr>
                                                </ng-template>
                                                <ng-template pTemplate="body" let-p>
                                                    <tr>
                                                        <td><p-tableCheckbox [value]="p" ></p-tableCheckbox></td>
                                                        <td>{{p.${field.fieldOfAssociation.name}?.${field.fieldOfAssociation.typeAsPojo.labelOrReferenceOrId.name}}}</td>
                                                    </tr>
                                                </ng-template>
                                            </p-table>
                                        </div>
                                    </div>
                                </div>
                            </p-tabPanel>
                        </#if>
                    </#list>

                    <#list pojo.fields as field>
                        <#if field.list && (field.associationComplex || field.fakeAssociation)>
                            <p-tabPanel header="${field.name18nCreateKey}">
                                <#if !field.createAndListPageInOneTab>
                                <p-tabView [(activeIndex)]="activeTab">
                                    <p-tabPanel header="Création">
                                        </#if>
                                        <div class="grid">
                                            <#if field.createAndListPageInOneTab>
                                            <div class="col">
                                                </#if>
                                                <#list field.typeAsPojo.fields as innerField>
                                                    <#if  !innerField.notVisibleInEditPage>
                                                        <#if innerField.dateTime>
                                                            <div class="field col-12 md:col-${field.columnStyle}">
                                                                <label for="${innerField?index}">${innerField.formatedName}<#if innerField.requierd><span style="color: red;">*</span></#if></label>
                                                                <p-calendar  appendTo="body" id="${innerField?index}" placeholder="${innerField.formatedName}"  [showTime]="true" [showSeconds]="false"
                                                                        [(ngModel)]="${field.name}Element.${innerField.name}"  [showIcon]="true"  <#if innerField.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${field.name?cap_first}${innerField.name?cap_first}}" </#if>></p-calendar>
                                                                <#if innerField.requierd><small class='p-error' *ngIf='!valid${field.name?cap_first}${innerField.name?cap_first}'>${innerField.name?cap_first} est obligatoire.</small></#if>
                                                            </div>
                                                        <#elseif innerField.pureString>
                                                            <div class="field col-12 md:col-${field.columnStyle}">
                                                                <label for="${innerField?index}">${innerField.formatedName}<#if innerField.requierd><span style="color: red;">*</span></#if></label>
                                                                <input appendTo="body" class="mb-2 mr-2" type="text" pInputText placeholder="${innerField.formatedName}"
                                                                       id="${innerField?index}" [(ngModel)]="${field.name}Element.${innerField.name}"
                                                                       autofocus  <#if innerField.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${field.name?cap_first}${innerField.name?cap_first}}" </#if> >
                                                                <#if innerField.requierd><small class='p-error' *ngIf='!valid${field.name?cap_first}${innerField.name?cap_first}'>${innerField.name?cap_first} est obligatoire.</small></#if>
                                                            </div>
                                                        <#elseif innerField.bool>
                                                            <div class="field  align-inputswitch col-12 md:col-${field.columnStyle}">
                                                                <div  class="label-inputswitch">
                                                                    <label for="${innerField?index}">${innerField.formatedName}<#if innerField.requierd><span style="color: red;">*</span></#if></label>
                                                                </div>
                                                                <div class="input-switch">
                                                                    <p-inputSwitch  appendTo="body" id="${innerField?index}"  [(ngModel)]="${field.name}Element.${innerField.name}"></p-inputSwitch>
                                                                </div>
                                                            </div>
                                                        <#elseif innerField.simple && innerField.id == false>
                                                            <div class="field col-12 md:col-${field.columnStyle}">
                                                                <label for="${innerField?index}">${innerField.formatedName}<#if innerField.requierd><span style="color: red;">*</span></#if></label>
                                                                <p-inputNumber  appendTo="body" class="mb-2 mr-2" id="${innerField.name}" [(ngModel)]="${field.name}Element.${innerField.name}" placeholder="${innerField.formatedName}"  <#if innerField.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${field.name?cap_first}${innerField.name?cap_first}}" </#if>></p-inputNumber>
                                                                <#if innerField.requierd><small class='p-error' *ngIf='!valid${field.name?cap_first}${innerField.name?cap_first}'>${innerField.name?cap_first} est obligatoire.</small></#if>
                                                            </div>
                                                        <#elseif innerField.generic && innerField.typeAsPojo.name != pojo.name>
                                                            <div class="field col-11 md:col-${field.columnStyle -1}">
                                                                <label>${innerField.formatedName}<#if innerField.requierd><span style="color: red;">*</span></#if></label>
                                                                <p-dropdown appendTo="body" [options]="${innerField.name}s" [(ngModel)]="${field.name}Element.${innerField.name}"
                                                                        id="${innerField?index}"  [filter]="true" filterMatchMode="contains" [showClear]="true"
                                                                        optionLabel="${innerField.typeAsPojo.labelOrReferenceOrId.name}" placeholder="${innerField.formatedName}"  <#if innerField.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${field.name?cap_first}${innerField.name?cap_first}}" </#if>>
                                                                </p-dropdown>
                                                                <#if innerField.requierd><small class='p-error' *ngIf='!valid${field.name?cap_first}${innerField.name?cap_first}'>${innerField.name?cap_first} est obligatoire.</small></#if>
                                                            </div>
                                                            <#if innerField.typeAsPojo.ignoreFront == false  && innerField.typeAsPojo.subModule.name == pojo.subModule.name>
                                                            <div class="col-1">
                                                                <label></label>
                                                                <button pButton pRipple type="button" icon="pi pi-plus" (click)="openCreate${innerField.typeAsPojo.name?cap_first}('${innerField.typeAsPojo.name}')"  class="p-button-success one-colonne-btn-success-align"></button>
                                                            </div>
                                                            </#if>
                                                        <#elseif innerField.list && innerField.association>
                                                            <div class="field col-12  md:col-${field.columnStyle}">
                                                                <label>${innerField.fieldOfAssociation.formatedName}<#if innerField.requierd><span style="color: red;">*</span></#if></label>
                                                                <p-multiSelect  appendTo="body" [options]="${innerField.name}" [(ngModel)]="${field.name}Element.${innerField.name}" defaultLabel="Selectionner un ${innerField.fieldOfAssociation.formatedName}" optionLabel="${innerField.fieldOfAssociation.name}.${innerField.fieldOfAssociation.typeAsPojo.labelOrReferenceOrId.name}"  display="chip"></p-multiSelect>
                                                            </div>
                                                        </#if>
                                                    </#if>
                                                </#list>
                                                <div class="field col-12 md:col-1">
                                                    <button pButton pRipple type="button" icon="pi pi-plus" class="mt-4" label="OK" (click)="add${field.name?cap_first}()"></button>
                                                </div>
                                                <#if field.createAndListPageInOneTab>
                                            </div>
                                            </#if>
                                        </div>
                                        <#if !field.createAndListPageInOneTab>
                                    </p-tabPanel>
                                    <p-tabPanel header="Liste {{item.${field.name?uncap_first}?.length > 0 ? '(' + item.${field.name?uncap_first}?.length + ')' : ''}}">
                                        </#if>
                                        <#if field.createAndListPageInOneTab>
                                        <div class="col">
                                            </#if>
                                            <div class="card">
                                                <p-table [value]="item.${field.name?uncap_first}" [scrollable]="true" scrollHeight="200px">
                                                    <ng-template pTemplate="header">
                                                        <tr>
                                                            <#list field.typeAsPojo.fields as myField>
                                                                <#if myField.simple && !myField.notVisibleInEditPage>
                                                                    <#if !myField.id>
                                                                        <th>${myField.formatedName}</th>
                                                                    </#if>
                                                                <#elseif myField.generic && !myField.notVisibleInEditPage>
                                                                    <#if myField.typeAsPojo.name != pojo.name>
                                                                        <th>${myField.formatedName}</th>
                                                                    </#if>
                                                                <#else>
                                                                </#if>
                                                            </#list>
                                                            <th>Actions</th>
                                                        </tr>
                                                    </ng-template>
                                                    <ng-template pTemplate="body" let-p>
                                                        <tr>
                                                            <#list field.typeAsPojo.fields as myField>
                                                                <#if myField.simple && !myField.id && !myField.notVisibleInEditPage>
                                                                    <#if myField.dateTime>
                                                                        <td>{{p.${myField.name} | date: dateFormatColumn}}</td>
                                                                    <#elseif myField.bool>
                                                                        <td><i *ngIf="p.${myField.name}" class="pi pi-check checked-toogle"></i>
                                                                            <i *ngIf="!p.${myField.name}" class="pi pi-times unchecked-toogle"></i>
                                                                        </td>
                                                                    <#else>
                                                                        <td>{{p.${myField.name}}}</td>
                                                                    </#if>
                                                                <#elseif myField.generic && myField.typeAsPojo.name != pojo.name && !myField.notVisibleInEditPage>
                                                                    <td>{{p.${myField.name}?.${myField.typeAsPojo.labelOrReferenceOrId.name}}}</td>
                                                                </#if>
                                                            </#list>
                                                            <td>
                                                                <button (click)="delete${field.typeAsPojo.name}(p)" pButton type="button" icon="pi pi-times"  class="p-button-rounded p-button-danger"></button>
                                                                <button (click)="edit${field.typeAsPojo.name}(p)" pButton type="button" icon="pi pi-pencil" class="p-button-rounded p-button-success mr-2"></button>
                                                            </td>
                                                        </tr>
                                                    </ng-template>
                                                </p-table>
                                            </div>
                                            <#if field.createAndListPageInOneTab>
                                        </div>
                                        <#else>
                                    </p-tabPanel>
                                </p-tabView>
                                </#if>
                            </p-tabPanel>
                        </#if>
                    </#list>
                </p-tabView>
            </ng-template>

            <ng-template pTemplate="footer" <#if pojo.createUpdateConfounded>[ngIf]="true"</#if>>
                <div class="grid-footer">
                    <#if !pojo.createUpdateConfounded>
                        <div>
                            <button pButton pRipple label="Annuler" icon="pi pi-times" class="p-button-outlined" (click)="hideEditDialog()"></button>
                        </div>
                    </#if>
                    <div>
                        <button pButton pRipple label="Valider" icon="pi pi-check" style="margin:10px" (click)="edit()"></button>
                    </div>
                </div>
            </ng-template>

            <#list pojo.fieldsGeneric as field>
                <#if field.typeAsPojo.name != pojo.name  && field.typeAsPojo.ignoreFront == false   && field.typeAsPojo.subModule.name == pojo.subModule.name>
                    <app-${field.formatedUrl}-create-${role.name}></app-${field.formatedUrl}-create-${role.name}>
                </#if>
            </#list>

            <#list pojo.fields as fieldList>
                <#if fieldList.list == true && !fieldList.notVisibleInViewPage>
                    <#list fieldList.typeAsPojo.fieldsGeneric as field>
                        <#if field.typeAsPojo.name != pojo.name  && field.typeAsPojo.ignoreFront == false   && field.typeAsPojo.subModule.name == pojo.subModule.name>
                            <app-${field.formatedUrl}-create-${role.name?lower_case}></app-${field.formatedUrl}-create-${role.name?lower_case}>
                        </#if>
                    </#list>
                </#if>
            </#list>

            <#if pojo.createUpdateConfounded>
    </div>
</p-panel>
<#else>
    </p-dialog>
</#if>
