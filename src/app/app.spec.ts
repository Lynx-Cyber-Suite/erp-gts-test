import { TestBed } from '@angular/core/testing';
import { App } from './app';

describe('App', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({ imports: [App] }).compileComponents();
  });

  it('affiche le titre, les indicateurs et les factures', () => {
    const fixture = TestBed.createComponent(App);
    fixture.detectChanges();
    const el = fixture.nativeElement as HTMLElement;
    expect(el.querySelector('h1')?.textContent).toContain('ERP GTS');
    expect(el.querySelectorAll('.kpi').length).toBe(3);
    expect(el.querySelectorAll('tbody tr').length).toBe(3);
    expect(el.textContent).toContain('4510 €');
  });
});
