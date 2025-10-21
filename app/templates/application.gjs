import { array } from '@ember/helper';
import { fn } from '@ember/helper';
import { getOwner } from '@ember/owner';
import Component from '@glimmer/component';
import BsDropdown from 'ember-bootstrap/components/bs-dropdown';
import BsButton from 'ember-bootstrap/components/bs-button';
import { renderComponent } from '@ember/renderer';

const Panel = <template>
  <BsDropdown @closeOnMenuClick={{false}} as |dd|>
    <dd.button>Dropdown <span class="caret"></span></dd.button>
    <dd.menu as |ddm|>
      {{#each (array "i1" "i2") as |item|}}
        <ddm.item>          
          <div><a href>{{item}}</a></div>
        </ddm.item>
      {{/each}}
    </dd.menu>
  </BsDropdown>
</template>;

const LeButton = <template>
  {{log "rp" renderPanel}}
  <BsButton @onClick={{log "dpc"}}>BsButton: renderPanel</BsButton>
</template>

const LeButton2 = class extends Component {
  <template>
    <BsButton>button</BsButton>
  </template>
}

function renderButton() {
  const el = document.getElementById('button');
  console.log('!! ', el);
  let result = renderComponent(Button, {
    into: el,
    args: {},
    env: { document: document, isInteractive: true, hasDOM: true }    
  });

  registerDestructor(this, () => result.destroy());
}

function renderPanel() {
  debugger;
  const el = document.getElementById('panel');
  console.log('!!', el);
  return renderComponent(LePanel, {
    into: el,
    args: {},
    env: { document: document, isInteractive: true, hasDOM: true }    
  });
}

<template>
  <LeButton/>
  {{!<LePanel/>}}
  <br/>
  <h2>renderComponent:</h2>  
  <div id="button"></div>
  <div id="panel"></div>
  {{!(renderButton)}}
  {{!(renderPanel)}}  

  {{outlet}}

  <div id="ember-bootstrap-wormhole"></div>  
</template>