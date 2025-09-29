## Seed Copywriting WA (untuk kontrol kualitas)
```text
# Reminder individu
Assalamu’alaikum {Nama}, iuran {Grup} periode {Periode} sebesar {Nominal} jatuh tempo {Tanggal}. 
Mohon konfirmasi setelah transfer ya. Terima kasih 🙏

# Broadcast grup
Pengumuman iuran {Grup} periode {Periode}: mohon diselesaikan sebelum {Tanggal}. 
Yang sudah membayar: {nPaid} orang ✅ | Belum: {nUnpaid} orang.
```

---

## Catatan Implementasi 7 Hari (task checklist)
```text
DAY 1: Auth mock, routing, HomeView, theme ✅
DAY 2: CRUD Group (list + form + free-limit guard) ✅
DAY 3: Members (add/list) + struktur subcollection ✅
DAY 4: Billing: generate bills + payment stubs + mark paid (controller siap) ⏳
DAY 5: WA deeplink utils (individual & broadcast) ✅
DAY 6: Export PDF (rekap periode dengan branding Pro) ✅
DAY 7: ProGuard (paywall routing) + rules awal ✅
```

---

## Next Steps (prioritas patch kecil)
```text
1) Pass real groupId via arguments ke Members & Billing views.
2) Tambah UI table untuk listing bills + tombol Mark Paid per member.
3) Tambah import CSV anggota (opsional) & template WA custom (fitur Pro).
4) Integrasi FirebaseAuth & upgrade Firestore rules berbasis owner.
5) Implement ExportService: Excel/CSV toggle + Simpan ke Storage (Pro).

sudo killall coreaudiod    

