From: akpm@linux-foundation.org
Subject: [patch 20/26] toshiba_acpi: rename add_device() and remove_device() to create_toshiba_proc_entries() and remove_toshiba_proc_entries()
Date: Tue, 20 Jul 2010 15:19:51 -0700
Message-ID: <201007202219.o6KMJpb2021082@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43522 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932070Ab0GTWZ6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jul 2010 18:25:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, axel.lin@gmail.com, mjg@redhat.com, nm127@freemail.hu

=46rom: Axel Lin <axel.lin@gmail.com>

To improve readability rename add_device() to
create_toshiba_proc_entries() and rename remove_device() to
remove_toshiba_proc_entries().

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: M=E1rton N=E9meth <nm127@freemail.hu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/toshiba_acpi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -puN drivers/platform/x86/toshiba_acpi.c~toshiba_acpi-rename-add_d=
evice-and-remove_device-to-create_toshiba_proc_entries-and-remove_toshi=
ba_proc_entries drivers/platform/x86/toshiba_acpi.c
--- a/drivers/platform/x86/toshiba_acpi.c~toshiba_acpi-rename-add_devic=
e-and-remove_device-to-create_toshiba_proc_entries-and-remove_toshiba_p=
roc_entries
+++ a/drivers/platform/x86/toshiba_acpi.c
@@ -720,7 +720,7 @@ static const struct file_operations vers
=20
 #define PROC_TOSHIBA		"toshiba"
=20
-static void __init add_device(void)
+static void __init create_toshiba_proc_entries(void)
 {
 	proc_create("lcd", S_IRUGO | S_IWUSR, toshiba_proc_dir, &lcd_proc_fop=
s);
 	proc_create("video", S_IRUGO | S_IWUSR, toshiba_proc_dir, &video_proc=
_fops);
@@ -729,7 +729,7 @@ static void __init add_device(void)
 	proc_create("version", S_IRUGO, toshiba_proc_dir, &version_proc_fops)=
;
 }
=20
-static void remove_device(void)
+static void remove_toshiba_proc_entries(void)
 {
 	remove_proc_entry("lcd", toshiba_proc_dir);
 	remove_proc_entry("video", toshiba_proc_dir);
@@ -903,7 +903,7 @@ static void toshiba_acpi_exit(void)
 	if (toshiba_backlight_device)
 		backlight_device_unregister(toshiba_backlight_device);
=20
-	remove_device();
+	remove_toshiba_proc_entries();
=20
 	if (toshiba_proc_dir)
 		remove_proc_entry(PROC_TOSHIBA, acpi_root_dir);
@@ -965,7 +965,7 @@ static int __init toshiba_acpi_init(void
 		toshiba_acpi_exit();
 		return -ENODEV;
 	} else {
-		add_device();
+		create_toshiba_proc_entries();
 	}
=20
 	props.max_brightness =3D HCI_LCD_BRIGHTNESS_LEVELS - 1;
_
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
