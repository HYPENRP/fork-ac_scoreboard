import { fontFamily } from 'tailwindcss/defaultTheme';
import type { Config } from 'tailwindcss';

const config: Config = {
  content: ['./src/**/*.{html,js,svelte,ts}'],
  theme: {
    extend: {
      colors: {
        border: 'hsl(var(--border) / <alpha-value>)',
        input: 'hsl(var(--input) / <alpha-value>)',
        ring: 'hsl(var(--ring) / <alpha-value>)',
        background: 'hsl(var(--background) / <alpha-value>)',
        foreground: 'hsl(var(--foreground) / <alpha-value>)',
        primary: {
          DEFAULT: 'hsl(var(--primary) / <alpha-value>)',
          foreground: 'hsl(var(--primary-foreground) / <alpha-value>)',
        },
        secondary: {
          DEFAULT: 'hsl(var(--secondary) / <alpha-value>)',
          foreground: 'hsl(var(--secondary-foreground) / <alpha-value>)',
        },
        hypen: {
          gray: {
            400: '#141321',
            300: '#191b2a',
            200: '#2e2e46',
            150: '#242639',
            100: '#32324a',
          },
          blue: {
            100: '#534bf9',
            200: '#5077fe',
            300: '#2bb7e8',
          },
          indigo: '#666698',
          pink: '#fc4160',
          orange: '#ee9a38',
          yellow: '#f4d836',
          zinc: '#453849',
          green: '#02f3b8',
        },
      },
      borderRadius: {
        lg: 'var(--radius)',
        md: 'calc(var(--radius) - 2px)',
        sm: 'calc(var(--radius) - 4px)',
      },
      fontFamily: {
        sans: ['Inter var', ...fontFamily.sans],
      },
    },
  },
};

export default config;
