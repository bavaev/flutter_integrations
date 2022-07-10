class EventEmitter {
    constructor() {
        this._storage = new Map();
    }

    addEventListener(type, handler) {
        if (this._storage.has(type)) {
            this._storage.get(type).push(handler);
        } else {
            this._storage.set(type, [handler]);
        }
    }

    removeEventListener(type, handler) {
        if(this._storage.has(type)) {
            this._storage.set(type, this._storage.get(type).filter((fn) => fn !== handler));
            return true;
        }

        return false;
    }

    dispatchEvent(event) {
        if (this._storage.has(event.type)) {
            this._storage.get(event.type).forEach(handler => handler(event));
            return true;
        }

        return false;
    }
}

class JsInteropManager extends EventEmitter {
    constructor() {
        super();

        this.wrap = document.createElement('div');

        this.inputElement = document.createElement('input');
        this.inputElement.style.border = "2px solid #DA1884";
        this.inputElement.style.width = "192px"
        this.inputElement.style.height = "50px"

        this.buttonElement = document.createElement('button');
        this.buttonElement.style.width = "200px"
        this.buttonElement.style.height = "50px"
        this.buttonElement.innerText = 'Web Native Button';

        this.wrap.append(this.inputElement);
        this.wrap.append(this.buttonElement);

        window.addEventListener('click', (e) => {
            if (e.target === this.buttonElement) {
                const interopEvent = new JsInteropEvent(this.inputElement.value.toString());
                this.dispatchEvent(interopEvent);
            }
        });

        window._clickManager = this;
    }

    getValueFromJs() {
        return this.inputElement.value.toString();
    }
}

class JsInteropEvent {
    constructor(value) {
        this.type = 'InteropEvent';
        this.value = value;
    }
}

window.ClicksNamespace = {
    JsInteropManager,
    JsInteropEvent
}
