<div class="card">
    <p-toolbar styleClass="mb-4">
        <ng-template pTemplate="left">
            <button pButton pRipple label="New" icon="pi pi-plus" class="p-button-success mr-2"
                (click)="openNew()"></button>
            <button pButton pRipple [label]="Delete" icon="pi pi-trash" class="p-button-danger"></button>
        </ng-template>

        <ng-template pTemplate="right">
            <p-fileUpload mode="basic" accept="image/*" [maxFileSize]="1000000" label="Import" chooseLabel="Import"
                class="mr-2 p-d-inline-block"></p-fileUpload>
            <button pButton pRipple label="Export" icon="pi pi-upload" class="p-button-help"></button>
        </ng-template>
    </p-toolbar>

    <p-table #dt [value]="users" [rows]="10" [paginator]="true"
        [globalFilterFields]="['prenom','nom','email','username']" [(selection)]="selectedUsers"
        [rowHover]="true" dataKey="id" currentPageReportTemplate="Showing {first} to {last} of {totalRecords} entries"
        [showCurrentPageReport]="true">
        <ng-template pTemplate="caption">
            <div class="p-d-flex p-ai-center p-jc-between">
                <h5 class="p-m-0">Manage Users</h5>
                <span class="p-input-icon-left ml-auto">
                    <i class="pi pi-search"></i>
                    <input pInputText type="text" (input)="dt.filterGlobal($event.target.value, 'contains')"
                        placeholder="Search..." />
                </span>
            </div>
        </ng-template>
        <ng-template pTemplate="header">
            <tr>
                <th style="width: 3rem">
                    <p-tableHeaderCheckbox></p-tableHeaderCheckbox>
                </th>
                <th pSortableColumn="prenom">prenom <p-sortIcon field="prenom"></p-sortIcon>
                </th>
                <th pSortableColumn="nom">nom <p-sortIcon field="nom"></p-sortIcon>
                </th>
                <th pSortableColumn="email">email <p-sortIcon field="email"></p-sortIcon>
                </th>

                <th>role <p-sortIcon field="roles"></p-sortIcon>
                </th>
                <th></th>
            </tr>
        </ng-template>
        <ng-template pTemplate="body" let-user>
            <tr>
                <td>
                    <p-tableCheckbox [value]="user"></p-tableCheckbox>
                </td>
                <td>{{user.prenom}}</td>
                <td>{{user.nom}}</td>
                <td>{{user.email}}</td>
                <td>
                    {{user.roles.length > 0 ? user.roles[0].authority:'Aucun role' }}
                </td>
                <td>
                    <button pButton pRipple icon="pi pi-pencil" class="p-button-rounded p-button-success mr-2"
                        (click)="editUser(user)"></button>
                    <button pButton pRipple icon="pi pi-trash" class="p-button-rounded p-button-warning"
                        (click)="deleteUser(user)"></button>
                </td>
            </tr>
        </ng-template>
        <ng-template pTemplate="summary">
            <div class="p-d-flex p-ai-center p-jc-between">
                In total there are {{users ? users.length : 0 }} Users.
            </div>
        </ng-template>
    </p-table>
</div>

<p-dialog [(visible)]="userDialog" [style]="{width: '450px'}" header="Product Details" [modal]="true"
    styleClass="p-fluid">
    <ng-template pTemplate="content">
        <div class="field">
            <label for="prenom">prenom</label>
            <input type="text" pInputText id="prenom" [(ngModel)]="user.prenom" required autofocus />
            <small class="p-error" *ngIf="submitted && !user.prenom">prenom is required.</small>
        </div>
        <div class="field">
            <label for="nom">nom</label>
            <input id="nom" pInputTextarea [(ngModel)]="user.nom" required rows="3" cols="20" />
            <small class="p-error" *ngIf="submitted && !user.nom">nom is required.</small>
        </div>
        <div class="field">
            <label for="password">username</label>
            <input id="password" pInputText [(ngModel)]="user.username" required rows="3" cols="20" />
            <small class="p-error" *ngIf="submitted && !user.username">nom is required.</small>
        </div>
        <div class="field" *ngIf="!user.id">
            <label for="password">password</label>
            <input id="password" pPassword [(ngModel)]="user.password" required rows="3" cols="20" />
            <small class="p-error" *ngIf="submitted && !user.password">nom is required.</small>
        </div>
        <div class="field">
            <label for="password">Email</label>
            <input id="password" pInputText [(ngModel)]="user.email" required rows="3" cols="20" />
            <small class="p-error" *ngIf="submitted && !user.email">Email is required.</small>
        </div>
        <div class="field" *ngIf="user.roles[0]">
            <label for="roles">Role</label>
            <p-dropdown [options]="roles" [(ngModel)]="user.roles[0]" optionLabel="authority">
            </p-dropdown>
        </div>
    </ng-template>

    <ng-template pTemplate="footer">
        <button pButton pRipple label="Cancel" icon="pi pi-times" class="p-button-text" (click)="hideDialog()"></button>
        <button pButton pRipple *ngIf="!user.id" label="Save" icon="pi pi-check" class="p-button-text"
            (click)="saveUser()"></button>
        <button pButton pRipple *ngIf="user.id" label="Edit" icon="pi pi-check" class="p-button-text"
            (click)="editUserSubmit()"></button>
    </ng-template>
</p-dialog>

<p-confirmDialog [style]="{width: '450px'}"></p-confirmDialog>
<p-toast position="bottom-center"></p-toast>
