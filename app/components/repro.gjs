import { array } from '@ember/helper';
import { getOwner } from '@ember/owner';
import Component from '@glimmer/component';
import BsDropdown from 'ember-bootstrap/components/bs-dropdown';
import BsButton from 'ember-bootstrap/components/bs-button';
import { renderComponent } from '@ember/renderer';

const LeButton = class extends Component {
  <template>
    <BsButton>BsButton: renderPanel</BsButton>
  </template>
}

const LePanel = <template>
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

function renderButton(parent) {
  const el = document.getElementById('button');
  const app = getOwner(parent);
  console.log('!! rB', el, parent, app);

  const owner = {
    lookup(specifier) {
      return app.lookup(specifier);
    }
  }

  try {
    let result = renderComponent(LeButton, {
      into: el,
      owner: getOwner(parent),
    });
  } catch (e) {
    console.log("!!E", e);
  }
}


function renderPanel(parent) {
  const el = document.getElementById('panel');
  console.log('!! rP', el);

  try {
    return renderComponent(LePanel, {
      into: el,
      owner: getOwner(parent),
    });
  } catch (e) {
    console.log("!!EP", e);
  }
}

export default class Repro extends Component {
  <template>
    <h2>component invocation via template:</h2>
    <LeButton/>
    <LePanel/>
    <br/>
    <h2>component invocation via renderComponent:</h2>
    <div id="button"></div>
    <div id="panel"></div>
    {{(renderButton this)}}
    {{(renderPanel this)}}

    <div id="ember-bootstrap-wormhole"></div>
  </template>
}
