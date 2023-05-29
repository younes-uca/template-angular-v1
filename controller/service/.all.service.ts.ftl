import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {BehaviorSubject, Observable} from 'rxjs';

import * as moment from 'moment';

import { RoleService } from 'src/app/zynerator/security/Role.service';
import {environment} from 'src/environments/environment';
import {PaginatedList} from 'src/app/zynerator/dto/PaginatedList.model';
import {BaseDto} from 'src/app/zynerator/dto/BaseDto.model';

import {${pojo.name}Dto} from '../model/${pojo.name}.model';
import {${pojo.name}Criteria} from '../criteria/${pojo.name}Criteria.model';
import {AbstractService} from 'src/app/zynerator/service/AbstractService';

<#list pojo.types as type>
  <#if pojo.name != type.simpleName>
import {${type.simpleName}Dto} from '../model/${type.simpleName}.model';
    </#if>
</#list>

@Injectable({
  providedIn: 'root'
})
export class ${pojo.name}Service extends AbstractService<${pojo.name}Dto, ${pojo.name}Criteria> {
     constructor(private http: HttpClient, private roleService: RoleService) {
        super();
        this.setHttp(http);
<#if true && config.groupId == "enova">
        this.setApi(environment.apiUrl + '/${pojo.name?uncap_first}/');
<#else>
        this.setApi(environment.apiUrl + 'admin/${pojo.name?uncap_first}/');
</#if>
    }

    public constrcutDto(): ${pojo.name}Dto {
        return new ${pojo.name}Dto();
    }

    public constrcutCriteria(): ${pojo.name}Criteria {
        return new ${pojo.name}Criteria();
    }
}
