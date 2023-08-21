"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[8177],{3905:(e,r,t)=>{t.d(r,{Zo:()=>s,kt:()=>m});var n=t(7294);function o(e,r,t){return r in e?Object.defineProperty(e,r,{value:t,enumerable:!0,configurable:!0,writable:!0}):e[r]=t,e}function a(e,r){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(e);r&&(n=n.filter((function(r){return Object.getOwnPropertyDescriptor(e,r).enumerable}))),t.push.apply(t,n)}return t}function i(e){for(var r=1;r<arguments.length;r++){var t=null!=arguments[r]?arguments[r]:{};r%2?a(Object(t),!0).forEach((function(r){o(e,r,t[r])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):a(Object(t)).forEach((function(r){Object.defineProperty(e,r,Object.getOwnPropertyDescriptor(t,r))}))}return e}function l(e,r){if(null==e)return{};var t,n,o=function(e,r){if(null==e)return{};var t,n,o={},a=Object.keys(e);for(n=0;n<a.length;n++)t=a[n],r.indexOf(t)>=0||(o[t]=e[t]);return o}(e,r);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);for(n=0;n<a.length;n++)t=a[n],r.indexOf(t)>=0||Object.prototype.propertyIsEnumerable.call(e,t)&&(o[t]=e[t])}return o}var p=n.createContext({}),d=function(e){var r=n.useContext(p),t=r;return e&&(t="function"==typeof e?e(r):i(i({},r),e)),t},s=function(e){var r=d(e.components);return n.createElement(p.Provider,{value:r},e.children)},c={inlineCode:"code",wrapper:function(e){var r=e.children;return n.createElement(n.Fragment,{},r)}},u=n.forwardRef((function(e,r){var t=e.components,o=e.mdxType,a=e.originalType,p=e.parentName,s=l(e,["components","mdxType","originalType","parentName"]),u=d(t),m=o,y=u["".concat(p,".").concat(m)]||u[m]||c[m]||a;return t?n.createElement(y,i(i({ref:r},s),{},{components:t})):n.createElement(y,i({ref:r},s))}));function m(e,r){var t=arguments,o=r&&r.mdxType;if("string"==typeof e||o){var a=t.length,i=new Array(a);i[0]=u;var l={};for(var p in r)hasOwnProperty.call(r,p)&&(l[p]=r[p]);l.originalType=e,l.mdxType="string"==typeof e?e:o,i[1]=l;for(var d=2;d<a;d++)i[d]=t[d];return n.createElement.apply(null,i)}return n.createElement.apply(null,t)}u.displayName="MDXCreateElement"},7090:(e,r,t)=>{t.r(r),t.d(r,{assets:()=>p,contentTitle:()=>i,default:()=>c,frontMatter:()=>a,metadata:()=>l,toc:()=>d});var n=t(7462),o=(t(7294),t(3905));const a={sidebar_position:2,keywords:["react-native-keyboard-controller","KeyboardProvider"]},i="KeyboardProvider",l={unversionedId:"api/keyboard-provider",id:"api/keyboard-provider",title:"KeyboardProvider",description:"KeyboardProvider should wrap your app. Underhood it works with KeyboardControllerView to receive events during keyboard movements, maps these events to Animated/Reanimated values and store them in context.",source:"@site/docs/api/keyboard-provider.md",sourceDirName:"api",slug:"/api/keyboard-provider",permalink:"/react-native-keyboard-controller/pr-preview/pr-214/docs/next/api/keyboard-provider",draft:!1,editUrl:"https://github.com/kirillzyusko/react-native-keyboard-controller/tree/main/docs/docs/api/keyboard-provider.md",tags:[],version:"current",sidebarPosition:2,frontMatter:{sidebar_position:2,keywords:["react-native-keyboard-controller","KeyboardProvider"]},sidebar:"tutorialSidebar",previous:{title:"useReanimatedKeyboardAnimation",permalink:"/react-native-keyboard-controller/pr-preview/pr-214/docs/next/api/hooks/use-reanimated-keyboard-animation"},next:{title:"KeyboardControllerView",permalink:"/react-native-keyboard-controller/pr-preview/pr-214/docs/next/api/keyboard-controller-view"}},p={},d=[{value:"Props",id:"props",level:2},{value:"<code>statusBarTranslucent</code>",id:"statusbartranslucent",level:3},{value:"<code>navigationBarTranslucent</code>",id:"navigationbartranslucent",level:3},{value:"Example",id:"example",level:2}],s={toc:d};function c(e){let{components:r,...t}=e;return(0,o.kt)("wrapper",(0,n.Z)({},s,t,{components:r,mdxType:"MDXLayout"}),(0,o.kt)("h1",{id:"keyboardprovider"},"KeyboardProvider"),(0,o.kt)("p",null,(0,o.kt)("inlineCode",{parentName:"p"},"KeyboardProvider")," should wrap your app. Underhood it works with ",(0,o.kt)("inlineCode",{parentName:"p"},"KeyboardControllerView")," to receive events during keyboard movements, maps these events to ",(0,o.kt)("inlineCode",{parentName:"p"},"Animated"),"/",(0,o.kt)("inlineCode",{parentName:"p"},"Reanimated")," values and store them in ",(0,o.kt)("inlineCode",{parentName:"p"},"context"),"."),(0,o.kt)("h2",{id:"props"},"Props"),(0,o.kt)("h3",{id:"statusbartranslucent"},(0,o.kt)("inlineCode",{parentName:"h3"},"statusBarTranslucent")),(0,o.kt)("p",null,"A boolean prop to indicate whether ",(0,o.kt)("inlineCode",{parentName:"p"},"StatusBar")," should be translucent on ",(0,o.kt)("inlineCode",{parentName:"p"},"Android")," or not."),(0,o.kt)("admonition",{title:"Important defaults",type:"caution"},(0,o.kt)("p",{parentName:"admonition"},"By default this library stretches to full screen (",(0,o.kt)("inlineCode",{parentName:"p"},"edge-to-edge")," mode) and status bar becomes translucent. But the library tries to use standard RN app behavior and automatically applies padding from top to look like a standard RN app. If you use ",(0,o.kt)("inlineCode",{parentName:"p"},"translucent")," prop for ",(0,o.kt)("inlineCode",{parentName:"p"},"StatusBar")," component - it will not work anymore. You'll need to specify it on provider level. For more info ",(0,o.kt)("a",{parentName:"p",href:"https://github.com/kirillzyusko/react-native-keyboard-controller/pull/30"},"see")," this PR.")),(0,o.kt)("h3",{id:"navigationbartranslucent"},(0,o.kt)("inlineCode",{parentName:"h3"},"navigationBarTranslucent")),(0,o.kt)("p",null,"A boolean prop to indicate whether ",(0,o.kt)("a",{parentName:"p",href:"https://m2.material.io/design/platform-guidance/android-bars.html#android-navigation-bar"},"NavigationBar")," should be translucent on ",(0,o.kt)("inlineCode",{parentName:"p"},"Android")," or not."),(0,o.kt)("h2",{id:"example"},"Example"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-tsx"},'import { KeyboardProvider } from "react-native-keyboard-controller";\n\nconst App = () => {\n  return (\n    <KeyboardProvider>\n      {/* other components in your tree */}\n    </KeyboardProvider>\n  );\n}\n')))}c.isMDXComponent=!0}}]);