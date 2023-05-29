<div class="login-body">
    <div class="card login-panel p-fluid">
        <div class="login-panel-content">
            <div class="grid" [formGroup]="loginForm">
                <div class="col-12 p-sm-6 md:col-6 logo-container">
                    <img src="../../../assets/layout/images/logo-roma.svg" />
                    <span class="guest-sign-in">Welcome, please use the form to sign-in </span>
                </div>

                <div class="col-12 username-container">
                    <!-- <h:panelGroup> -->
                    <label>Username</label>
                    <div class="login-input">
                        <input class="mb-2 mr-2" type="text" pInputText formControlName="username" id="1" required
                            autofocus />
                    </div>
                    <!-- </h:panelGroup> -->
                </div>
                <div class="col-12 password-container">
                    <!-- <h:panelGroup> -->
                    <label>Password</label>
                    <div class="login-input">
                        <input pPassword type="password" [feedback]="false" formControlName="password" />
                    </div>
                    <!-- </h:panelGroup> -->
                </div>
                <div class="col-12 p-sm-6 md:col-6 rememberme-container">
                </div>

                <div class="col-6 md:col-12">
                    <button pButton type="button" icon="pi pi-check" label="Sign In" (click)="submit()"></button>
                </div>
                <div class="col-6 md:col-12">
                    <button pButton type="button" icon="pi pi-check" class="p-button p-button-success" label="Register" (click)="register()"></button>
                </div>
            </div>
        </div>
    </div>
</div>
