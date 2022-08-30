import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AccountListComponent } from './account-list/account-list.component';
import { AccountCreateComponent } from './account-create/account-create.component';
import { ContactListComponent } from './contact-list/contact-list.component';
import { ContactCreateComponent } from './contact-create/contact-create.component';
import { ActivityListComponent } from './activity-list/activity-list.component';
import { ActivityCreateComponent } from './activity-create/activity-create.component';

const routes: Routes = [
  { path:  '', redirectTo:  'contacts', pathMatch:  'full' },
  {
    path: 'accounts',
    component: AccountListComponent
  },
  {
    path: 'create-account',
    component: AccountCreateComponent
  },
  {
    path: 'contacts',
    component: ContactListComponent
  },
  {
    path: 'create-contact',
    component: ContactCreateComponent
  },
  {
    path: 'activities',
    component: ActivityListComponent
  },
  {
    path: 'create-activity',
    component: ActivityCreateComponent
  }
];


@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})


export class AppRoutingModule { }
