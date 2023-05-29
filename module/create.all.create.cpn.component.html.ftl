<#if pojo.createUpdateConfounded>
    <p-toast></p-toast>
    <div class="card">
        <message severity="{{info}}" text="{{msgsContents}}"></message>
    </div>

    <div class="p-fluid">

        <#else>
        <p-dialog [(visible)]="createDialog" [style]="{width: '70vw'}" header="${pojo.tabPanelI18nCreate}" [modal]="true" styleClass="p-fluid" [maximizable]="true" [draggable]="false" [resizable]="false">
        </#if>
            <#if pojo.steps>
            <div class="card">
                <p-toast></p-toast>
                <p-steps [model]="steps" [(activeIndex)]="next" [readonly]="true">
                </p-steps>
            </div>
            </#if>
            <ng-template pTemplate="content" <#if pojo.createUpdateConfounded>[ngIf]="true"</#if>>
                <#if pojo.steps>
                            <#list pojo.steper.steps as myStep>
                                <div *ngIf="next == ${myStep?index}">
                                    <div class="grid">
                                        <#list myStep.fields as field>
                                            <#if field.list && field.association>
                                                <div class="field col-12  md:col-${pojo.columnStyle}">
                                                    <label>${field.fieldOfAssociation.formatedName}</label>
                                                    <p-multiSelect [options]="${field.name}" [(ngModel)]="item.${field.name}" itemSize="30" [virtualScroll]="true"
                                                                                                                              defaultLabel="Select un ${field.fieldOfAssociation.name}" optionLabel="${field.fieldOfAssociation.name}.${field.fieldOfAssociation.typeAsPojo.labelOrReferenceOrId.name}"  display="chip"></p-multiSelect>
                                                </div>
                                            <#elseif field.simple && !field.notVisibleInCreatePage>
                                                <#if  field.type.simpleName == "Date" || field.dateTime>
                                                    <div class="field col-12 md:col-${pojo.columnStyle}">
                                                        <label for="${field?index}">${field.name18nCreate!'walo'}<#if field.requierd><span style="color: red;">*</span></#if></label>
                                                        <p-calendar appendTo="body" id="${field?index}"  [showTime]="true" [showSeconds]="false" placeholder="${field.name18nCreate!'walo'}"  [(ngModel)]="item.${field.name}"
                                                                dateFormat="{{dateFormat}}" <#if field.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${pojo.name?cap_first}${field.name?cap_first}}" </#if> >
                                                        </p-calendar>
                                                        <#if field.requierd><small class='p-error' *ngIf='!valid${pojo.name?cap_first}${field.name?cap_first}'>${field.name?cap_first} est obligatoire.</small></#if>
                                                    </div>
                                                <#elseif  field.large>
                                                    <div class="field col-12 md:col-${pojo.columnStyle}">
                                                        <label for="${field?index}">${field.name18nCreate!'walo'}<#if field.requierd><span style="color: red;">*</span></#if></label>
                                                        <textarea id="${field?index}" pInputTextarea rows="5" cols="30" placeholder="${field.name18nCreate!'walo'}"  [(ngModel)]="item.${field.name}"
                                                                <#if field.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${pojo.name?cap_first}${field.name?cap_first}}" </#if> ></textarea>
                                                        <#if field.requierd><small class='p-error' *ngIf='!valid${pojo.name?cap_first}${field.name?cap_first}'>${field.name?cap_first} est obligatoire.</small></#if>
                                                    </div>
                                                <#elseif field.pureString>
                                                    <div class="field col-12 md:col-${pojo.columnStyle}">
                                                        <label for="${field?index}">${field.name18nCreate!'walo'}<#if field.requierd><span style="color: red;">*</span></#if></label>
                                                        <input class="mb-2 mr-2" type="text" pInputText  placeholder="${field.name18nCreate!'walo'}" id="${field?index}" [(ngModel)]="item.${field.name}"
                                                                <#if field.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${pojo.name?cap_first}${field.name?cap_first}}" </#if> />
                                                        <#if field.requierd><small class='p-error' *ngIf='!valid${pojo.name?cap_first}${field.name?cap_first}'>${field.name?cap_first} est obligatoire.</small></#if>
                                                    </div>

                                                <#elseif field.uploadOne>
                                                    <div class="field col-12 md:col-${pojo.columnStyle}">
                                                        <label for="${field?index}">${field.name18nCreate!'walo'}<#if field.requierd><span style="color: red;">*</span></#if></label>
                                                        <p-fileUpload name="files" [customUpload]="true" (uploadHandler)="uploadOne($event, 0)" [auto]="true" ></p-fileUpload>
                                                        <#if field.requierd><small class='p-error' *ngIf='!valid${pojo.name?cap_first}${field.name?cap_first}'>${field.name?cap_first} est obligatoire.</small></#if>
                                                    </div>


                                                <#elseif field.bool>
                                                    <div class="field align-inputswitch col-12  md:col-${pojo.columnStyle}">
                                                        <div  class="label-inputswitch">
                                                            <label for="${field?index}">${field.name18nCreate!'walo'}<#if field.requierd><span style="color: red;">*</span></#if></label>
                                                        </div>
                                                        <div class="input-switch">
                                                            <p-inputSwitch id="${field?index}"  [(ngModel)]="item.${field.name}"
                                                                    <#if field.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${pojo.name?cap_first}${field.name?cap_first}}" </#if> >
                                                            </p-inputSwitch>
                                                            <#if field.requierd><small class='p-error' *ngIf='!valid${pojo.name?cap_first}${field.name?cap_first}'>${field.name?cap_first} est obligatoire.</small></#if>
                                                        </div>
                                                    </div>

                                                <#elseif field.id == false>
                                                    <div class="field col-12 md:col-${pojo.columnStyle}">
                                                        <label for="${field?index}">${field.name18nCreate!'walo'}<#if field.requierd><span style="color: red;">*</span></#if></label>
                                                        <p-inputNumber class="mb-2 mr-2" id="${field?index}" placeholder="${field.name18nCreate!'walo'}" [(ngModel)]="item.${field.name}" <#if field.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${pojo.name?cap_first}${field.name?cap_first}}" </#if> >
                                                        </p-inputNumber>
                                                        <#if field.requierd><small class='p-error' *ngIf='!valid${pojo.name?cap_first}${field.name?cap_first}'>${field.name?cap_first} est obligatoire.</small></#if>
                                                    </div>
                                                </#if>

                                            <#elseif field.generic && !field.notVisibleInCreatePage>
                                                <div class="field col-11 md:col-<#if field.typeAsPojo.ignoreFront == false>${pojo.columnStyle -1}<#else >${pojo.columnStyle}</#if>">
                                                    <label for="${field?index}">${field.name18nCreate!'walo'}<#if field.requierd><span style="color: red;">*</span></#if></label>
                                                    <p-dropdown  appendTo="body"  [options]="${field.name}s" [(ngModel)]="item.${field.name}" id="${field?index}" [filter]="true" filterMatchMode="contains"
                                                            [showClear]="true" optionLabel="<#if field.typeAsPojo??>${field.typeAsPojo.labelOrReferenceOrId.name}<#else>${field..name}</#if>" placeholder="${field.name18nCreate!'walo'}" <#if field.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${pojo.name?cap_first}${field.name?cap_first}}" </#if> >
                                                    </p-dropdown>
                                                    <#if field.requierd><small class='p-error' *ngIf='!valid${pojo.name?cap_first}${field.name?cap_first}'>${field.name?cap_first} est obligatoire.</small></#if>
                                                </div>
                                                <#if field.typeAsPojo.ignoreFront == false && field.typeAsPojo.subModule.name == pojo.subModule.name>
                                                    <div class="col-1">
                                                        <label></label>
                                                        <button pButton pRipple type="button" icon="pi pi-plus" (click)="openCreate${field.typeAsPojo.name?cap_first}('${field.typeAsPojo.name?cap_first}')" class="p-button-success one-colonne-btn-success-align"></button>
                                                    </div>
                                                </#if>
                                            </#if>
                                        </#list>
                                    </div>
                                </div>
                            </#list>
                <#else>
                        <p-tabView>
                            <p-tabPanel header="${pojo.tabPanelI18nCreate}">
                                <div class="grid">
                                    <#list pojo.fields as field>
                                        <#if field.list && field.association>
                                            <div class="field col-12  md:col-${pojo.columnStyle}">
                                                <label>${field.fieldOfAssociation.formatedName}</label>
                                                <p-multiSelect [options]="${field.name}" [(ngModel)]="item.${field.name}" itemSize="30" [virtualScroll]="true"
                                                                                                                          defaultLabel="Select un ${field.fieldOfAssociation.name}" optionLabel="${field.fieldOfAssociation.name}.${field.fieldOfAssociation.typeAsPojo.labelOrReferenceOrId.name}"  display="chip"></p-multiSelect>
                                            </div>
                                        <#elseif field.simple && !field.notVisibleInCreatePage>
                                            <#if  field.type.simpleName == "Date" || field.dateTime>
                                                <div class="field col-12 md:col-${pojo.columnStyle}">
                                                    <label for="${field?index}">${field.name18nCreate!'walo'}<#if field.requierd><span style="color: red;">*</span></#if></label>
                                                    <p-calendar appendTo="body" id="${field?index}"  [showTime]="true" [showSeconds]="false" placeholder="${field.name18nCreate!'walo'}"  [(ngModel)]="item.${field.name}"
                                                            dateFormat="{{dateFormat}}" <#if field.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${pojo.name?cap_first}${field.name?cap_first}}" </#if> >
                                                    </p-calendar>
                                                    <#if field.requierd><small class='p-error' *ngIf='!valid${pojo.name?cap_first}${field.name?cap_first}'>${field.name?cap_first} est obligatoire.</small></#if>
                                                </div>
                                            <#elseif  field.large>
                                                <div class="field col-12 md:col-${pojo.columnStyle}">
                                                    <label for="${field?index}">${field.name18nCreate!'walo'}<#if field.requierd><span style="color: red;">*</span></#if></label>
                                                    <textarea id="${field?index}" pInputTextarea rows="5" cols="30" placeholder="${field.name18nCreate!'walo'}"  [(ngModel)]="item.${field.name}"
                                                            <#if field.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${pojo.name?cap_first}${field.name?cap_first}}" </#if> ></textarea>
                                                    <#if field.requierd><small class='p-error' *ngIf='!valid${pojo.name?cap_first}${field.name?cap_first}'>${field.name?cap_first} est obligatoire.</small></#if>
                                                </div>
                                            <#elseif field.pureString>
                                                <div class="field col-12 md:col-${pojo.columnStyle}">
                                                    <label for="${field?index}">${field.name18nCreate!'walo'}<#if field.requierd><span style="color: red;">*</span></#if></label>
                                                    <input class="mb-2 mr-2" type="text" pInputText  placeholder="${field.name18nCreate!'walo'}" id="${field?index}" [(ngModel)]="item.${field.name}"
                                                            <#if field.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${pojo.name?cap_first}${field.name?cap_first}}" </#if> />
                                                    <#if field.requierd><small class='p-error' *ngIf='!valid${pojo.name?cap_first}${field.name?cap_first}'>${field.name?cap_first} est obligatoire.</small></#if>
                                                </div>


                                            <#elseif field.type.simpleName == "Boolean">
                                                <div class="field align-inputswitch col-12  md:col-${pojo.columnStyle}">
                                                    <div  class="label-inputswitch">
                                                        <label for="${field?index}">${field.name18nCreate!'walo'}<#if field.requierd><span style="color: red;">*</span></#if></label>
                                                    </div>
                                                    <div class="input-switch">
                                                        <p-inputSwitch id="${field?index}"  [(ngModel)]="item.${field.name}"
                                                                <#if field.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${pojo.name?cap_first}${field.name?cap_first}}" </#if> >
                                                        </p-inputSwitch>
                                                        <#if field.requierd><small class='p-error' *ngIf='!valid${pojo.name?cap_first}${field.name?cap_first}'>${field.name?cap_first} est obligatoire.</small></#if>
                                                    </div>
                                                </div>

                                            <#elseif field.id == false>
                                                <div class="field col-12 md:col-${pojo.columnStyle}">
                                                    <label for="${field?index}">${field.name18nCreate!'walo'}<#if field.requierd><span style="color: red;">*</span></#if></label>
                                                    <p-inputNumber class="mb-2 mr-2" id="${field?index}" placeholder="${field.name18nCreate!'walo'}" [(ngModel)]="item.${field.name}" <#if field.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${pojo.name?cap_first}${field.name?cap_first}}" </#if> >
                                                    </p-inputNumber>
                                                    <#if field.requierd><small class='p-error' *ngIf='!valid${pojo.name?cap_first}${field.name?cap_first}'>${field.name?cap_first} est obligatoire.</small></#if>
                                                </div>
                                            </#if>

                                        <#elseif field.generic && !field.notVisibleInCreatePage>
                                            <div class="field col-11 md:col-<#if field.typeAsPojo.ignoreFront == false>${pojo.columnStyle -1}<#else >${pojo.columnStyle}</#if>">
                                                <label for="${field?index}">${field.name18nCreate!'walo'}<#if field.requierd><span style="color: red;">*</span></#if></label>
                                                <p-dropdown  appendTo="body"  [options]="${field.name}s" [(ngModel)]="item.${field.name}" id="${field?index}" [filter]="true" filterMatchMode="contains"
                                                        [showClear]="true" optionLabel="<#if field.typeAsPojo??>${field.typeAsPojo.labelOrReferenceOrId.name}<#else>${field..name}</#if>" placeholder="${field.name18nCreate!'walo'}" <#if field.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${pojo.name?cap_first}${field.name?cap_first}}" </#if> >
                                                </p-dropdown>
                                                <#if field.requierd><small class='p-error' *ngIf='!valid${pojo.name?cap_first}${field.name?cap_first}'>${field.name?cap_first} est obligatoire.</small></#if>
                                            </div>
                                            <#if field.typeAsPojo.ignoreFront == false && field.typeAsPojo.subModule.name == pojo.subModule.name>
                                                <div class="col-1">
                                                    <label></label>
                                                    <button pButton pRipple type="button" icon="pi pi-plus" (click)="openCreate${field.typeAsPojo.name?cap_first}('${field.typeAsPojo.name?cap_first}')" class="p-button-success one-colonne-btn-success-align"></button>
                                                </div>
                                            </#if>
                                        </#if>
                                    </#list>
                                </div>
                            </p-tabPanel>
                            <#list pojo.fields as field>
                                <#if field.list && (field.associationComplex || field.fakeAssociation)>
                                    <p-tabPanel header="${field.name18nCreateKey}">
                                        <#if !field.createAndListPageInOneTab>
                                        <p-tabView [(activeIndex)]="activeTab">
                                            <p-tabPanel header="Création">
                                                </#if>
                                                <#if field.createAndListPageInOneTab>
                                                <div class="p-col">
                                                    </#if>
                                                    <div class="grid">
                                                        <#list field.typeAsPojo.fields as innerField>
                                                            <#if  !innerField.notVisibleInCreatePage>
                                                                <#if innerField.dateTime>
                                                                    <div class="field col-12 md:col-${field.columnStyle}">
                                                                        <label for="${innerField?index}">${innerField.formatedName}<#if innerField.requierd><span style="color: red;">*</span></#if></label>
                                                                        <p-calendar appendTo="body" id="${innerField?index}"  [showTime]="true" [showSeconds]="false" placeholder="${innerField.formatedName}" [(ngModel)]="${field.name}Element.${innerField.name}"
                                                                                dateFormat="{{dateFormat}}" [showIcon]="true"  <#if innerField.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${field.name?cap_first}${innerField.name?cap_first}}" </#if>></p-calendar>
                                                                        <#if innerField.requierd><small class='p-error' *ngIf='!valid${field.name?cap_first}${innerField.name?cap_first}'>${innerField.name?cap_first} est obligatoire.</small></#if>
                                                                    </div>
                                                                <#elseif innerField.pureString>
                                                                    <div class="field col-12 md:col-${field.columnStyle}">
                                                                        <label for="${innerField?index}">${innerField.formatedName}<#if innerField.requierd><span style="color: red;">*</span></#if></label>
                                                                        <input class="mb-2 mr-2" type="text" pInputText placeholder="${innerField.formatedName}"
                                                                               id="${innerField?index}" [(ngModel)]="${field.name}Element.${innerField.name}" autofocus  <#if innerField.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${field.name?cap_first}${innerField.name?cap_first}}" </#if> >
                                                                        <#if innerField.requierd><small class='p-error' *ngIf='!valid${field.name?cap_first}${innerField.name?cap_first}'>${innerField.name?cap_first} est obligatoire.</small></#if>
                                                                    </div>
                                                                <#elseif innerField.bool>
                                                                    <div class="field  align-inputswitch col-12 md:col-${field.columnStyle}">
                                                                        <div  class="label-inputswitch">
                                                                            <label for="${innerField?index}">${innerField.formatedName}<#if innerField.requierd><span style="color: red;">*</span></#if></label>
                                                                        </div>
                                                                        <div class="input-switch">
                                                                            <p-inputSwitch id="${innerField?index}"  [(ngModel)]="${field.name}Element.${innerField.name}"></p-inputSwitch>
                                                                        </div>
                                                                    </div>
                                                                <#elseif innerField.simple && innerField.id == false>
                                                                    <div class="field col-12 md:col-${field.columnStyle}">
                                                                        <label for="${innerField?index}">${innerField.formatedName}<#if innerField.requierd><span style="color: red;">*</span></#if></label>
                                                                        <p-inputNumber class="mb-2 mr-2" id="${innerField.name}" placeholder="${innerField.formatedName}"  <#if innerField.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${field.name?cap_first}${innerField.name?cap_first}}" </#if>[(ngModel)]="${field.name}Element.${innerField.name}"></p-inputNumber>
                                                                        <#if innerField.requierd><small class='p-error' *ngIf='!valid${field.name?cap_first}${innerField.name?cap_first}'>${innerField.name?cap_first} est obligatoire.</small></#if>
                                                                    </div>
                                                                <#elseif innerField.generic && innerField.typeAsPojo.name != pojo.name>
                                                                    <div class="field col-11 md:col-${field.columnStyle -1}">
                                                                        <label>${innerField.formatedName}<#if innerField.requierd><span style="color: red;">*</span></#if></label>
                                                                        <p-dropdown  appendTo="body"  [options]="${innerField.name}s" [(ngModel)]="${field.name}Element.${innerField.name}"
                                                                                     id="${innerField?index}"  [filter]="true" filterMatchMode="contains" [showClear]="true" optionLabel="${innerField.typeAsPojo.labelOrReferenceOrId.name!'walo'}"
                                                                                     placeholder="${innerField.formatedName}"  <#if innerField.requierd>[ngClass]="{'ng-invalid ng-dirty' : !valid${field.name?cap_first}${innerField.name?cap_first}}" </#if>>
                                                                        </p-dropdown>
                                                                        <#if innerField.requierd><small class='p-error' *ngIf='!valid${field.name?cap_first}${innerField.name?cap_first}'>${innerField.name?cap_first} est obligatoire.</small></#if>
                                                                    </div>
                                                                    <#if innerField.typeAsPojo.ignoreFront == false && innerField.typeAsPojo.subModule.name == pojo.subModule.name>
                                                                    <div class="col-1">
                                                                        <label></label>
                                                                        <button pButton pRipple type="button" icon="pi pi-plus" (click)="openCreate${innerField.typeAsPojo.name?cap_first}('${innerField.typeAsPojo.name?uncap_first}')" class="p-button-success one-colonne-btn-success-align"></button>
                                                                    </div>
                                                                    </#if>
                                                                <#elseif innerField.list && innerField.association>
                                                                    <div class="field col-12  md:col-${field.columnStyle}">
                                                                        <label>${innerField.fieldOfAssociation.formatedName}<#if innerField.requierd><span style="color: red;">*</span></#if></label>
                                                                        <p-multiSelect appendTo="body" [options]="${innerField.name}" [(ngModel)]="${field.name}Element.${innerField.name}" defaultLabel="Selectionner un ${innerField.fieldOfAssociation.formatedName}" itemSize="30" [virtualScroll]="true"
                                                                                       optionLabel="${innerField.fieldOfAssociation.name}.${innerField.fieldOfAssociation.typeAsPojo.labelOrReferenceOrId.name}"  display="chip"></p-multiSelect>
                                                                    </div>
                                                                </#if>
                                                            </#if>
                                                        </#list>
                                                        <div class="field col-12 md:col-1">
                                                            <button pButton pRipple type="button" icon="pi pi-plus" class="mt-4" label="OK" (click)="add${field.name?cap_first}()"></button>
                                                        </div>

                                                    </div>
                                                    <#if field.createAndListPageInOneTab>
                                                </div>
                                                </#if>
                                                <#if !field.createAndListPageInOneTab>
                                            </p-tabPanel>
                                            <p-tabPanel header="Liste {{item.${field.name?uncap_first}?.length > 0 ? '(' + item.${field.name?uncap_first}?.length + ')' : ''}}">
                                                </#if>
                                                <#if field.createAndListPageInOneTab>
                                                <div class="p-col">
                                                    </#if>
                                                    <div class="card">
                                                        <p-table [value]="item.${field.name?uncap_first}" [scrollable]="true" scrollHeight="200px">
                                                            <ng-template pTemplate="header">
                                                                <tr>
                                                                    <#list field.typeAsPojo.fields as myField>
                                                                        <#if myField.simple && !myField.notVisibleInCreatePage>
                                                                            <#if !myField.id>
                                                                                <th>${myField.formatedName}</th>
                                                                            </#if>
                                                                        <#elseif myField.generic && !myField.notVisibleInCreatePage>
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
                                                                        <#if myField.simple && !myField.id && !myField.notVisibleInCreatePage>
                                                                            <#if myField.type.name == "Date" || myField.dateTime>
                                                                                <td>{{p.${myField.name} | date: dateFormatColumn}}</td>
                                                                            <#elseif myField.type.simpleName == "Boolean">
                                                                                <td><i *ngIf="p.${myField.name}" class="pi pi-check checked-toogle"></i>
                                                                                    <i *ngIf="!p.${myField.name}" class="pi pi-times unchecked-toogle"></i>
                                                                                </td>
                                                                            <#else>
                                                                                <td>{{p.${myField.name}}}</td>
                                                                            </#if>
                                                                        <#elseif myField.generic && myField.typeAsPojo.name != pojo.name && !myField.notVisibleInCreatePage>
                                                                            <td>{{p.${myField.name}?.${myField.typeAsPojo.labelOrReferenceOrId.name!'walo'}}}</td>
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
                </#if>

            </ng-template>

            <ng-template pTemplate="footer" <#if pojo.createUpdateConfounded>[ngIf]="true"</#if>>
                <div class="grid-step">
                    <#if !pojo.createUpdateConfounded>
                    <#if pojo.steps>
                        <div>
                            <button pButton pRipple label="Back" *ngIf="back" icon="pi pi-angle-left" class="p-button-outlined" (click)="back()"></button>
                        </div>
                        </#if>
                        <div style="margin-left: auto;">
                            <button pButton pRipple  label="{{'validate' | translate}}" <#if pojo.steps> *ngIf="validate" </#if> icon="pi pi-check" style="margin:10px" (click)="save()"></button>
                        </div>
                    <#if !pojo.steps>
                        <div>
                            <button pButton pRipple  label="{{'cancel' | translate}}" icon="pi pi-times" class="p-button-outlined" (click)="hideCreateDialog()"></button>
                        </div>
                    </#if>
                    <#if pojo.steps>
                        <div>
                            <button pButton pRipple  label="{{'next' | translate}}"   *ngIf="next" icon="pi pi-times" class="p-button-outlined" (click)="next()"></button>
                        </div>
                    </#if>
                    </#if>

                </div>
            </ng-template>

            <#list pojo.fieldsGeneric as field>
                <#if field.typeAsPojo.name != pojo.name && field.typeAsPojo.ignoreFront == false   && field.typeAsPojo.subModule.name == pojo.subModule.name>
            <app-${field.formatedUrl}-create-${role.name}></app-${field.formatedUrl}-create-${role.name}>
                </#if>
            </#list>

            <#list pojo.fields as fieldList>
                <#if fieldList.list == true && !fieldList.notVisibleInViewPage>
                    <#list fieldList.typeAsPojo.fieldsGeneric as field>
                        <#if field.typeAsPojo.name != pojo.name && field.typeAsPojo.ignoreFront == false  && field.typeAsPojo.subModule.name == pojo.subModule.name>
            <app-${field.formatedUrl}-create-${role.name?lower_case}></app-${field.formatedUrl}-create-${role.name?lower_case}>
                        </#if>
                    </#list>
                </#if>
            </#list>

            <#if pojo.createUpdateConfounded>
    </div>
<#else>
    </p-dialog>
</#if>
