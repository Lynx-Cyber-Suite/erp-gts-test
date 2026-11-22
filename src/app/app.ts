import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';

export interface Invoice { id: string; client: string; amount: number; status: 'Payée' | 'En attente' | 'En retard'; }

@Component({
  selector: 'app-root',
  imports: [RouterOutlet],
  templateUrl: './app.html',
  styleUrl: './app.css',
})
export class App {
  readonly version = '1.0.0';
  readonly invoices: Invoice[] = [
    { id: 'F-2026-001', client: 'Acme SARL', amount: 1200, status: 'Payée' },
    { id: 'F-2026-002', client: 'Baobab SA', amount: 860, status: 'En attente' },
    { id: 'F-2026-003', client: 'Cauris SAS', amount: 2450, status: 'En retard' },
  ];
  readonly kpis = [
    { label: 'Clients', value: 3 },
    { label: 'Factures', value: this.invoices.length },
    { label: 'Chiffre d’affaires', value: `${this.invoices.reduce((s, f) => s + f.amount, 0)} €` },
  ];
}
