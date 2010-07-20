From: akpm@linux-foundation.org
Subject: [patch 19/26] toshiba_acpi: make remove_device() and add_device() void
Date: Tue, 20 Jul 2010 15:19:50 -0700
Message-ID: <201007202219.o6KMJops021079@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, axel.lin@gmail.com, mjg@redhat.com, nm127@freemail.hu
List-Id: linux-acpi@vger.kernel.org

=46rom: Axel Lin <axel.lin@gmail.com>

remove_device() and add_device() are not related to ACPI APIs, it does =
not
make sense to return acpi_status for both functions.

Current implementation of add_device() always AE_OK, thus the return va=
lue
checking for add_device() always return false for ACPI_FAILURE(status).=
=20
This patch makes add_device() to be void and remove the unnecessary ret=
urn
value checking.

remove_proc_entry() won't fail, thus change remove_device() to be void.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: M=E1rton N=E9meth <nm127@freemail.hu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/toshiba_acpi.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff -puN drivers/platform/x86/toshiba_acpi.c~toshiba_acpi-make-remove_=
device-and-add_device-void drivers/platform/x86/toshiba_acpi.c
--- a/drivers/platform/x86/toshiba_acpi.c~toshiba_acpi-make-remove_devi=
ce-and-add_device-void
+++ a/drivers/platform/x86/toshiba_acpi.c
@@ -720,25 +720,22 @@ static const struct file_operations vers
=20
 #define PROC_TOSHIBA		"toshiba"
=20
-static acpi_status __init add_device(void)
+static void __init add_device(void)
 {
 	proc_create("lcd", S_IRUGO | S_IWUSR, toshiba_proc_dir, &lcd_proc_fop=
s);
 	proc_create("video", S_IRUGO | S_IWUSR, toshiba_proc_dir, &video_proc=
_fops);
 	proc_create("fan", S_IRUGO | S_IWUSR, toshiba_proc_dir, &fan_proc_fop=
s);
 	proc_create("keys", S_IRUGO | S_IWUSR, toshiba_proc_dir, &keys_proc_f=
ops);
 	proc_create("version", S_IRUGO, toshiba_proc_dir, &version_proc_fops)=
;
-
-	return AE_OK;
 }
=20
-static acpi_status remove_device(void)
+static void remove_device(void)
 {
 	remove_proc_entry("lcd", toshiba_proc_dir);
 	remove_proc_entry("video", toshiba_proc_dir);
 	remove_proc_entry("fan", toshiba_proc_dir);
 	remove_proc_entry("keys", toshiba_proc_dir);
 	remove_proc_entry("version", toshiba_proc_dir);
-	return AE_OK;
 }
=20
 static struct backlight_ops toshiba_backlight_data =3D {
@@ -921,7 +918,6 @@ static void toshiba_acpi_exit(void)
=20
 static int __init toshiba_acpi_init(void)
 {
-	acpi_status status =3D AE_OK;
 	u32 hci_result;
 	bool bt_present;
 	int ret =3D 0;
@@ -969,11 +965,7 @@ static int __init toshiba_acpi_init(void
 		toshiba_acpi_exit();
 		return -ENODEV;
 	} else {
-		status =3D add_device();
-		if (ACPI_FAILURE(status)) {
-			toshiba_acpi_exit();
-			return -ENODEV;
-		}
+		add_device();
 	}
=20
 	props.max_brightness =3D HCI_LCD_BRIGHTNESS_LEVELS - 1;
_
