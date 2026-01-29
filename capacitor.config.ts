import type { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'org.thedailycanon.app',
  appName: 'The Daily Canon',
  webDir: 'www',

  server: {
    // Load the deployed web app — all logic lives in the Next.js repo
    url: 'https://thedailycanon.org',
    cleartext: false,
  },

  ios: {
    contentInset: 'automatic',
    backgroundColor: '#FAF9F6',
    preferredContentMode: 'mobile',
    scheme: 'The Daily Canon',
  },

  plugins: {
    SplashScreen: {
      launchAutoHide: true,
      launchFadeOutDuration: 300,
      backgroundColor: '#FAF9F6',
      showSpinner: false,
    },
    StatusBar: {
      style: 'DARK',
      backgroundColor: '#FAF9F6',
    },
    Keyboard: {
      resize: 'body',
      resizeOnFullScreen: true,
    },
  },
};

export default config;
