import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import {Router} from '@angular/router';

import { AuthService } from 'src/app/zynerator/security/Auth.service';


@Component({
  selector: 'app-login-${role.name}',
  templateUrl: './login-${role.name}.component.html',
  styleUrls: ['./login-${role.name}.component.scss']
})
export class Login${role.name?cap_first}Component implements OnInit {
  loginForm = new FormGroup({
    username:new FormControl('',Validators.required),
    password:new FormControl('',Validators.required)
  })
  constructor(private authService:AuthService,private router: Router) { }

  ngOnInit(): void {
  }
  submit(){
    const formValues = this.loginForm.value;
    const username = formValues.username;
    const passowrd = formValues.password;
    this.authService.login${role.name?cap_first}(username,passowrd);

  }
    register(){
    this.router.navigate(['/${role.name}/register']);
  }
}
