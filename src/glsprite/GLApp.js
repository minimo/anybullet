phina.namespace(() => {

  phina.define("GLApp", {
    superClass: "phina.display.DomApp",

    gl: null,

    init: function (params) {
      params = ({}).$extend(GLApp.defaults, params);
      if (!params.query && !params.domElement) {
        params.domElement = document.createElement('canvas');
        if (params.append) {
          document.body.appendChild(params.domElement);
        }
      }

      this.superInit(params);

      this.domElement.width = params.width;
      this.domElement.height = params.height;

      if (params.fit) {
        this.fitScreen();
      }

      this.gl = this.domElement.getContext("webgl");
      this.renderer = GLAppRenderer(this.gl);
    },

    _draw: function () {
      const gl = this.gl;

      gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
      this.renderer.render(this.currentScene);
      gl.flush();
    },

    fitScreen: function () {
      phina.graphics.Canvas.prototype.fitScreen.call(this);
    },

    _static: {
      defaults: {
        width: 640,
        height: 960,
        fit: true,
        append: true,
        fps: 60,
      },
    },
  });

});