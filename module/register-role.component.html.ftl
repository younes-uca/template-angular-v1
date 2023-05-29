<div class="login-body">
    <div class="card login-panel p-fluid">
        <div class="mt-4">
            <div class="grid" [formGroup]="registerForm">
                <div class="col-12 p-sm-6 md:col-6 logo-container">
                    <span class="guest-sign-in" style="font-weight: 600;font-size: 2rem;">Inscription</span>
                </div>

                <div class="col-12 username-container">
                    <!-- <h:panelGroup> -->
                    <label>prenom</label>
                    <div class="login-input">
                        <input formControlName="prenom" class="mb-2 mr-2" type="text" pInputText id="1" required
                            autofocus />
                    </div>
                    <!-- </h:panelGroup> -->
                </div>
                <div class="col-12 username-container">
                    <!-- <h:panelGroup> -->
                    <label>nom</label>
                    <div class="login-input">
                        <input formControlName="nom" class="mb-2 mr-2" type="text" pInputText id="1" required
                            autofocus />
                    </div>
                    <!-- </h:panelGroup> -->
                </div>
                <div class="col-12 username-container">
                    <!-- <h:panelGroup> -->
                    <label>Username</label>
                    <div class="login-input">
                        <input formControlName="userName" class="mb-2 mr-2" type="text" pInputText id="1" required
                            autofocus />
                    </div>
                    <!-- </h:panelGroup> -->
                </div>
                <div class="col-12 username-container">
                    <!-- <h:panelGroup> -->
                    <label>Email</label>
                    <div class="login-input">
                        <input formControlName="email" class="mb-2 mr-2" type="email" pInputText id="1" required
                            autofocus />
                    </div>
                    <!-- </h:panelGroup> -->
                </div>

                <div class="col-12 password-container">
                    <!-- <h:panelGroup> -->
                    <label>Password</label>
                    <div class="login-input">
                        <input formControlName="password" pPassword type="password" />
                    </div>
                    <!-- </h:panelGroup> -->
                </div>


                <div class="col-12 p-sm-6 md:col-6">
                    <button pButton type="button" icon="pi pi-check" label="Register" [disabled]="registerForm.invalid"
                        (click)="submit()"></button>
                </div>
            </div>
        </div>
    </div>
</div>
