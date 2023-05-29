<div class="grid">
    <div class="col-12">
        <p-toast></p-toast>
        <div class="card">
            <p-toolbar styleClass="mb-4">
                <ng-template pTemplate="left">
                    <#if pojo.showPopupCreate==true>
                    <button pButton pRipple label=" ${pojo.newI18n}" icon="pi pi-plus" class="p-button-success mr-2 mb-2" (click)="openCreate('${pojo.name}')"></button>
                    <#else>
                    <button pButton pRipple label=" ${pojo.newI18n}" icon="pi pi-plus" class="p-button-success mr-2 mb-2" (click)="navigateTo${pojo.name}Create()"></button>
                    </#if>
                    <button [disabled]="isSelectionDisabled()" pButton pRipple label=" ${pojo.deleteI18n}" icon="pi pi-trash" class="p-button-danger mr-2 mb-2" (click)=deleteMultiple()></button>
                    <button pButton pRipple label=" ${pojo.rechercheI18n}" icon="pi pi-{{findByCriteriaShow?'angle-down':'angle-right'}}" class="p-button-warning mr-2 mb-2" (click)="this.showSearch()"></button>
                </ng-template>
                <ng-template pTemplate="right">
                    <div class="flex">
                        <p-splitButton label=" ${pojo.exportI18n}" icon="pi pi-download" styleClass="p-button-help" [model]="excelPdfButons"></p-splitButton>
                        <#if pojo.importable == true>
                        <label for="file-upload" class="file-upload-label">
                            <span class="upload-icon"><i class="fas fa-cloud-upload-alt"></i></span>
                            <span class="upload-text">Click to select a file</span>
                        </label>
                        <input id="file-upload" type="file" (change)="onExcelFileSelected($event)" accept=".xlsx, .xls" style="display: none;">
                        <p-splitButton (click)="importExcel()"  [disabled]="!excelFile" label=" {{'import' | translate}}" icon="pi pi-upload"  styleClass="p-button-help"  style="margin-right: 2% ; color: #1BA7AF"></p-splitButton>
                       </#if>
                    </div>
                </ng-template>

            </p-toolbar>
            <p-toolbar *ngIf="findByCriteriaShow">

                <div class="align-form-search">
                <#list pojo.fields as field>
                        <#if field.simple  && !field.notIncluded  && !field.password>
                            <#if field.dateTime>

                        <span class=" p-float-label mr-3 align-search-items mt-4">
                            <p-calendar class="mr-2" [(ngModel)]="criteria.${field.name}From"
                                    id="${field?index}-1"
                                    dateFormat="dd-MM-yy"></p-calendar>
                            <label for="${field?index}-1">${field.name18nList} Min</label>
                        </span>

                         <span class=" p-float-label mr-3 align-search-items mt-4">
                            <p-calendar class="mr-2" [(ngModel)]="criteria.${field.name}To"
                                    id="${field?index}-2"
                                    dateFormat="dd-MM-yy"></p-calendar>
                            <label for="${field?index}-2">${field.name18nList} Max</label>
                        </span>

                    <#elseif field.pureString>
                        <span class=" p-float-label mr-3 align-search-items mt-4">
                            <input class="mr-2" pInputText id="${field?index}" type="text"  [(ngModel)]="criteria.${field.name}Like">
                            <label for="${field?index}">${field.name18nList}</label>
                        </span>
                    <#elseif field.bool>
                        <span class=" p-float-label mr-3 align-search-items mt-4">
                            <p-dropdown  id="${field?index}" [options]="yesOrNo${field.name?cap_first}" [(ngModel)]="criteria.${field.name}"
                                    [filter]="false" [showClear]="true"  placeholder="${field.name18nList?cap_first}" optionLabel="label" optionValue="value">
                            </p-dropdown>
                        </span>
                   <#elseif field.nombre == true>
                                <#if field.name != pojo.id.name>
                        <span class=" p-float-label mr-3 align-search-items mt-4">
                            <p-inputNumber class="mr-2" mode="decimal" [(ngModel)]="criteria.${field.name}Min" id="${field?index}-1"></p-inputNumber>
                            <label for="${field?index}-1">${field.name18nList} Min</label>
                        </span>
                       <span class=" p-float-label mr-3 align-search-items mt-4">
                            <p-inputNumber class="mr-2" mode="decimal" [(ngModel)]="criteria.${field .name}Max" id="${field?index}-2"></p-inputNumber>
                            <label for="${field?index}-2">${field.name18nList} Max</label>
                       </span>
                                </#if>
                            </#if>
                        </#if>
                        <#if field.generic == true>
                        <span class=" p-float-label mr-3 align-search-items mt-4">
                             <#if field.searchOne>
                            <p-dropdown [options]="${field.name}s" [(ngModel)]="criteria.${field.name}" id="${field?index}" [filter]="true"
                                        [showClear]="true"  placeholder="${field.name18nList}" optionLabel="${field.typeAsPojo.labelOrReferenceOrId.name}">
                            </p-dropdown>
                            <#else >
                            <p-multiSelect   appendTo="body" [options]="${field.name}s" [(ngModel)]="criteria.${field.name}s" itemSize="30" [virtualScroll]="true"
                                                  defaultLabel="${field.name18nList}" id="${field?index}" optionLabel="${field.typeAsPojo.labelOrReferenceOrId.name}"  display="chip">
                            </p-multiSelect>
                             </#if>
                        </span>
                        </#if>
                </#list>
                </div>

                <div class="align-search-button">
                    <button pButton pRipple label="${pojo.validateI18n}" icon="pi pi-sort-amount-down" class="p-button-info mr-2" (click)="findPaginatedByCriteria()"></button>
                </div>
            </p-toolbar>


            <p-table #dt [value]="items" [columns]="cols" [rows]="8" [paginator]="false"
                    [globalFilterFields]="[${pojo.globaleFilter}]" [(selection)]="selections"
                    [rowHover]="true" dataKey="id" styleClass="p-datatable-customers"
                    currentPageReportTemplate="${pojo.listElementFromToI18n}"
                    [showCurrentPageReport]="true" [rowsPerPageOptions]="[10,25,50]" selectionMode="multiple">
                <ng-template pTemplate="caption">
                    <div class="flex flex-column flex-row justify-content-between table-header">
                        <h5 class="p-m-0">${pojo.listHeaderI18n}</h5>
                        <span class="p-input-icon-left ml-auto">
                            <i class="pi pi-search"></i>
                            <input pInputText type="text" placeholder="${pojo.listSearchI18n}" (input)="dt.filterGlobal($event.target.value, 'contains')"/>
                        </span>
                    </div>
                </ng-template>
                <ng-template pTemplate="header">
                    <tr>
                        <th style="width: 3rem">
                            <p-tableHeaderCheckbox></p-tableHeaderCheckbox>
                        </th>
                        <#assign i=0>
                        <#list pojo.fields as field>
                            <#if field.name != pojo.id.name && !field.large && !field.list>
                                <#assign i++>
                                <#if i &gt; 9><!-- </#if>
                        <th pSortableColumn="${field.name?uncap_first}">
                            <div class="p-d-flex p-jc-between p-ai-center">
                                <span>${field.name18nList}</span>
                                <p-sortIcon field="${field.name?uncap_first}"></p-sortIcon>
                                <#if field.pureString >
                                <p-columnFilter type="text" field="element.${field.name?uncap_first}" display="menu" class="ml-auto"></p-columnFilter>
                                </#if>
                            </div>
                        </th>
                                <#if i &gt; 9>--> </#if>
                            </#if>
                        </#list>
                        <th>Actions</th>
                    </tr>
                </ng-template>
                <ng-template pTemplate="body" let-element>
                    <tr>
                        <td>
                            <p-tableCheckbox [value]="element"></p-tableCheckbox>
                        </td>
                        <#assign i=0>
                        <#list pojo.fields as field>
                        <#if field.name != pojo.id.name && !field.large && !field.list>
                            <#assign i++>
                            <#if i &gt; 9> <!-- </#if>
                            <#if field.dateTime>
                        <td>{{element.${field.name} | date :'dd/MM/yyyy HH:mm' }}</td>
                             <#elseif field.bool>
                        <td><i *ngIf="element.${field.name}" class="pi pi-check checked-toogle"></i>
                            <i *ngIf="!element.${field.name}" class="pi pi-times unchecked-toogle"></i>
                        </td>
                             <#elseif field.simple && !field.notIncluded  && !field.password>
                        <td>{{element.${field.name}}}</td>
                            <#elseif field.generic>
                        <td>{{element.${field.name}?.${field.typeAsPojo.labelOrReferenceOrId.name}}}</td>
                            </#if>
                            <#if i &gt; 9> --> </#if>
                        </#if>
                        </#list>
                        <td>
                            <button pButton pRipple icon="pi pi-pencil"  class="p-button-rounded p-button-success mr-2" (click)="edit(element)"></button>
                            <button pButton pRipple icon="pi pi-list" class="p-button-rounded p-button-info mr-2" (click)="view(element)"></button>
                            <#if !pojo.archivable>
                            <button pButton pRipple icon="pi pi-trash" class="p-button-rounded p-button-danger mr-2" (click)="delete(element)"></button>
                            </#if>
                            <#if 1 != 1 && pojo.archivable>
                            <button *ngIf="!element.archive" pButton pRipple icon="pi pi-calendar-minus" class="p-button-rounded p-button-help mr-2" (click)="archiver(element)"></button>
                            <button *ngIf="element.archive" pButton pRipple icon="pi pi-calendar-plus" class="p-button-rounded p-button-secondary mr-2" (click)="desarchiver(element)"></button>
                            </#if>
                            <button pButton pRipple icon="pi pi-copy" class="p-button-rounded p-button-raised p-button-warning" (click)="duplicate(element)"></button>
                            <#if pojo.exportable == true>
                            <button pButton pRipple icon="pi pi-download" class="p-button-rounded p-button-secondary" (click)="exportPdf(element)"></button>
                            </#if>
                        </td>
                    </tr>
                </ng-template>

                <ng-template pTemplate="summary">
                    <p-paginator  [rows]="10" [totalRecords]="totalRecords" (onPageChange)="onPage($event)"></p-paginator>
                    <div class="p-d-flex p-ai-center p-jc-between">
                        En totale il {{items ? totalRecords == 1 ? 'y a' : 'y a' : 'y a' }} {{items ? totalRecords : 0 }} {{items ? totalRecords == 1 ? '${pojo.formatedNameLowerCase?uncap_first}' : '${pojo.formatedNameLowerCase?uncap_first}s' : 0 }}.
                    </div>
                </ng-template>
            </p-table>
        </div>

        <#if !pojo.createUpdateConfounded>
        <app-${pojo.formatedUrl}-create-${role.name?lower_case}></app-${pojo.formatedUrl}-create-${role.name?lower_case}>
        <app-${pojo.formatedUrl}-edit-${role.name?lower_case}></app-${pojo.formatedUrl}-edit-${role.name?lower_case}>
        </#if>
        <app-${pojo.formatedUrl}-view-${role.name?lower_case}></app-${pojo.formatedUrl}-view-${role.name?lower_case}>
        <p-confirmDialog [style]="{width: '450px'}"></p-confirmDialog>
    </div>
</div>
