// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get title => 'College Scheduler';

  @override
  String get deleteConfirmationTitle => 'Konfirmasi Penghapusan!';

  @override
  String get deleteDescription => 'Data yang terhapus tidak dapat dikembalikan. Apakah Anda yakin ingin menghapusnya?';

  @override
  String get deleteCancelButton => 'Batal';

  @override
  String get deleteProceedButton => 'Ya, Hapus';

  @override
  String get quoteAfterLogin => '\"WAKTU TERBAIK UNTUK MENANAM POHON ADALAH 20 TAHUN YANG LALU, WAKTU TERBAIK KEDUA ADALAH SEKARANG\"';

  @override
  String get quoteAfterLoginMark => '~ Pepatah Cina';

  @override
  String gettingDataSuccess(Object feature) {
    return 'Berhasil mendapatkan data $feature';
  }

  @override
  String creatingDataSuccess(Object feature) {
    return 'Berhasil membuat data $feature';
  }

  @override
  String updatingDataSuccess(Object feature) {
    return 'Berhasil mengubah data $feature';
  }

  @override
  String deletingDataSuccess(Object feature) {
    return 'Berhasil menghapus data $feature';
  }

  @override
  String gettingDataEmpty(Object feature) {
    return 'Anda tidak memiliki data $feature';
  }

  @override
  String gettingDataProblem(Object feature) {
    return 'Ada masalah saat mendapatkan data $feature';
  }

  @override
  String creatingDataProblem(Object feature) {
    return 'Ada masalah saat membuat data $feature';
  }

  @override
  String updatingDataProblem(Object feature) {
    return 'Ada masalah saat mengubah data $feature';
  }

  @override
  String deletingDataProblem(Object feature) {
    return 'Ada masalah saat menghapus data $feature';
  }

  @override
  String get homeMenuButton => 'Beranda';

  @override
  String get eventsMenuButton => 'Acara';

  @override
  String get settingsMenuButton => 'Pengaturan';

  @override
  String get dataSettingsLabel => 'Data';

  @override
  String get notificationSettingsLabel => 'Pemberitahuan';

  @override
  String get accountSettingsLabel => 'Akun';

  @override
  String get incoming => 'Segera Hadir';

  @override
  String get changeFullnameOrUsernameTitle => 'Ubah Nama Lengkap Atau Nama Pengguna';

  @override
  String get fullnameLabel => 'Nama Lengkap';

  @override
  String get fullnameHint => 'Masukkan Nama Lengkap Anda';

  @override
  String get fullnameEmpty => 'Silakan masukkan Nama Lengkap Anda';

  @override
  String get fullnameNewhint => 'Masukkan Nama Lengkap baru Anda';

  @override
  String get fullnameNewEmptyError => 'Silakan masukkan Nama Lengkap baru Anda';

  @override
  String get usernameLabel => 'Nama Pengguna';

  @override
  String get usernameEmpty => 'Silakan masukkan nama pengguna akun Anda';

  @override
  String get usernameHint => 'Masukkan Nama Pengguna Anda';

  @override
  String get usernameNewHint => 'Masukan nama pengguna baru';

  @override
  String get usernameNewEmptyError => 'Silakan masukkan Nama Pengguna baru Anda';

  @override
  String get passwordLabel => 'Kata Sandi';

  @override
  String get passwordHint => 'Masukkan kata sandi Anda';

  @override
  String get passwordEmpty => 'Silakan masukkan kata sandi akun Anda';

  @override
  String get passwordUpTo8 => 'Kata Sandi Harus Hingga 8 Karakter';

  @override
  String get passwordContainNumber => 'Kata Sandi Harus Mengandung Setidaknya Satu Angka';

  @override
  String get passwordContainerSymbol => 'Kata Sandi Harus Mengandung Simbol';

  @override
  String get confirmationPasswordTitle => 'Konfirmasi Kata Sandi';

  @override
  String get confirmationPasswordHint => 'Masukkan Kata Sandi Konfirmasi Anda';

  @override
  String get confirmationPasswordEmpty => 'Harap masukkan konfirmasi kata sandi';

  @override
  String get passwordAndConfirmationDontMatch => 'Kata sandi dan kata sandi konfirmasi Anda tidak cocok';

  @override
  String get registerFailed => 'Daftar Gagal';

  @override
  String get registerAccount => 'Daftar Akun';

  @override
  String get registerSuccess => 'Daftar Berhasil';

  @override
  String get alreadyHaveAccount => 'Sudah Punya Akun? ';

  @override
  String get loginHere => 'Masuk di sini';

  @override
  String get loginFailed => 'Masuk Gagal';

  @override
  String get loginEmpty => 'Silakan masukkan kredensial Anda';

  @override
  String get loginLabel => 'Masuk';

  @override
  String get loginSuccess => 'Masuk Berhasil';

  @override
  String get noAccount => 'Belum Punya Akun? ';

  @override
  String get registerHere => 'Daftar Di sini';

  @override
  String get passwordChangeFullnameUsernameHint => 'Masukkan kata sandi Anda untuk validasi akun';

  @override
  String get passwordEmptyError => 'Harap masukkan kata sandi Anda untuk tujuan keamanan';

  @override
  String get changingFullnameUsernamePasswordDisclamer => 'Demi keamanan, mohon masukkan password akun Anda, sehingga kami dapat mengetahui bahwa Andalah yang mencoba mengubah nama pengguna.';

  @override
  String get changeFullnameUsernameFailedTitle => 'Gagal mengubah Nama Lengkap atau Nama Pengguna';

  @override
  String get emptyFieldError => 'Silakan isi data yang dibutuhkan';

  @override
  String get submitChange => 'Kirim Perubahan';

  @override
  String greetingFriend(Object user) {
    return 'Selamat Datang Kembali! \n$user';
  }

  @override
  String get dataStatusTitle => 'Data Status';

  @override
  String get idleStatus => 'BELUM DIMULAI';

  @override
  String get progressStatus => 'PROGRESS';

  @override
  String get doneStatus => 'SELESAI';

  @override
  String get dataPriorityTitle => 'Data Prioritas';

  @override
  String get lowPriority => 'RENDAH';

  @override
  String get mediumPriority => 'SEDANG';

  @override
  String get highPriority => 'TINGGI';

  @override
  String get coreMenuTitle => 'Menu Utama';

  @override
  String get dataClassTitle => 'Data Kelas';

  @override
  String get dataEventsTitle => 'Data Acara';

  @override
  String get dataLecturerTitle => 'Data Dosen';

  @override
  String get recentDataEvents => 'Data Acara Terbaru';

  @override
  String get createDataClass => 'Buat Data Kelas';

  @override
  String get editButton => 'Ubah';

  @override
  String get deleteButton => 'Hapus';

  @override
  String get searchItemByTitle => 'Cari Data Berdasarkan Nama';

  @override
  String get filterEvents => 'Filter Acara';

  @override
  String get dateOfEventsLabel => 'Tanggal Acara';

  @override
  String get dateOfEventsHint => 'Silakan masukkan tanggal acara';

  @override
  String get priorityLabel => 'Prioritas';

  @override
  String get prioritySelect => 'Pilih Prioritas';

  @override
  String get statusLabel => 'Status';

  @override
  String get statusSelect => 'Pilih Status';

  @override
  String get clearButton => 'Bersihkan';

  @override
  String get submitButton => 'Kirim';

  @override
  String get deadlineLabel => 'Tenggat Waktu';

  @override
  String get selectClassLabel => 'Daftar Kelas';

  @override
  String get createDataLecturer => 'Buat Data Dosen';

  @override
  String get detailEventTitle => 'Rincian Acara';

  @override
  String get startHourLabel => 'Waktu Dimulainya';

  @override
  String get endHourLabel => 'Waktu Berakhirnya';

  @override
  String get locationLabel => 'Lokasi';

  @override
  String get classNameLabel => 'Nama Kelas';

  @override
  String get descriptionLabel => 'Deskripsi';

  @override
  String get eventHistory => 'Riwayat Acara';

  @override
  String get inputDataClassTitle => 'Data Input Kelas';

  @override
  String get classNameHint => 'Masukkan Nama Kelas';

  @override
  String get classNameEmpty => 'Silakan masukkan nama kelas';

  @override
  String get lecturerLabel => 'Dosen';

  @override
  String get lecturerSelect => 'Pilih Dosen';

  @override
  String get dayLabel => 'Hari';

  @override
  String get daySelect => 'Pilih Hari';

  @override
  String get dayMonday => 'Senin';

  @override
  String get dayTuesday => 'Selasa';

  @override
  String get dayWednesday => 'Rabu';

  @override
  String get dayThursday => 'Kamis';

  @override
  String get dayFriday => 'Jumat';

  @override
  String get daySaturday => 'Sabtu';

  @override
  String get daySunday => 'Minggu';

  @override
  String get startHourEmpty => 'Silakan masukkan waktu dimulainya kelas';

  @override
  String get endHourEmpty => 'Silakan masukkan waktu berakhirnya kelas';

  @override
  String get createDataClassFailed => 'Buat Data Kelas Gagal';

  @override
  String get createDataClassSuccess => 'Buat Data Kelas Berhasil';

  @override
  String get inputDataLecturerTitle => 'Data Input Dosen';

  @override
  String get lecturerNameLabel => 'Nama Dosen';

  @override
  String get lecturerNameHint => 'Masukkan Nama Dosen';

  @override
  String get lecturerNameEmpty => 'Silakan masukkan nama dosen';

  @override
  String get lecturerInputFailed => 'Buat Data Dosen Gagal';

  @override
  String get loginHistoryTitle => 'Riwayat Masuk';

  @override
  String get createEventSchedule => 'Buat Jadwal Acara';

  @override
  String get titleLabel => 'Judul Acara';

  @override
  String get titleHint => 'Masukkan Judul Acara';

  @override
  String get titleEmpty => 'Silakan masukkan Judul Acara';

  @override
  String get createEventSuccess => 'Berhasil Membuat Jadwal Acara';

  @override
  String get createEventFailed => 'Pembuatan Acara Gagal';

  @override
  String actionFeatureSuccess(Object action) {
    return '$action Berhasil';
  }

  @override
  String actionFeatureFailed(Object action) {
    return '$action Gagal';
  }

  @override
  String get to => 'Sampai';

  @override
  String menuSettingsLabel(String menu) {
    String _temp0 = intl.Intl.selectLogic(
      menu,
      {
        'menuDataClass': 'Data Kelas',
        'menuDataLecturer': 'Data Dosen',
        'menuEventHistory': 'Riwayat Acara',
        'menuReminderEvent': 'Pengingat Acara',
        'menuReminderInput': 'Pengingat Masukkan Data',
        'menuChangePassword': 'Ganti Kata Sandi',
        'menuChangeFullnameOrUsername': 'Ganti Nama Lengkap Atau Nama Pengguna',
        'menuLoginHistory': 'Riwayat Masuk',
        'menuExportDatabase': 'Ekspor Database',
        'menuImportDatabase': 'Impor Database',
        'menuLogout': 'Keluar',
        'other': '',
      },
    );
    return '$_temp0';
  }

  @override
  String get quoteDante => '\"JALAN MENUJU SURGA DIMULAI DI NERAKA\"';

  @override
  String get changePasswordTitle => 'Ganti Kata Sandi';

  @override
  String get oldPasswordLabel => 'Kata Sandi Lama';

  @override
  String get newPaswordLabel => 'Kata Sandi Baru';

  @override
  String get confirmNewPasswordLabel => 'Konfirmasi Kata Sandi Baru';

  @override
  String get oldPasswordHint => 'Masukan kata sandi lama';

  @override
  String get newPasswordHint => 'Masukan kata sandi baru';

  @override
  String get confirmNewPasswordHint => 'Masukkan konfirmasi kata sandi baru';
}
