import type { Metadata } from 'next';
import './globals.css';

export const metadata: Metadata = {
  title: 'Giada Taribelli',
  description: 'Pedagogia e gioco di ruolo — corsi e prenotazioni',
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="it">
      <body>{children}</body>
    </html>
  );
}
