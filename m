From: akpm@linux-foundation.org
Subject: [patch 09/26] compal-laptop/fujitsu-laptop/msi-laptop: make dmi_check_cb to return 1 instead of 0
Date: Tue, 20 Jul 2010 15:19:40 -0700
Message-ID: <201007202219.o6KMJeEv021022@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43533 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932946Ab0GTWk2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jul 2010 18:40:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, axel.lin@gmail.com, jwoithe@physics.adelaide.edu.au, mjg@redhat.com

From: Axel Lin <axel.lin@gmail.com>

dmi_check_system() walks the table running matching functions until
someone returns non zero or we hit the end.

This patch makes dmi_check_cb to return 1 so dmi_check_system() return
immediately when a match is found.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Acked-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Matthew Garrett <mjg@redhat.com>a
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/compal-laptop.c  |    2 +-
 drivers/platform/x86/fujitsu-laptop.c |    6 +++---
 drivers/platform/x86/msi-laptop.c     |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff -puN drivers/platform/x86/compal-laptop.c~compal-laptop-fujitsu-laptop-msi-laptop-make-dmi_check_cb-to-return-1-instead-of-0 drivers/platform/x86/compal-laptop.c
--- a/drivers/platform/x86/compal-laptop.c~compal-laptop-fujitsu-laptop-msi-laptop-make-dmi_check_cb-to-return-1-instead-of-0
+++ a/drivers/platform/x86/compal-laptop.c
@@ -275,7 +275,7 @@ static int set_backlight_level(int level
 
 	ec_write(BACKLIGHT_LEVEL_ADDR, level);
 
-	return 0;
+	return 1;
 }
 
 static int get_backlight_level(void)
diff -puN drivers/platform/x86/fujitsu-laptop.c~compal-laptop-fujitsu-laptop-msi-laptop-make-dmi_check_cb-to-return-1-instead-of-0 drivers/platform/x86/fujitsu-laptop.c
--- a/drivers/platform/x86/fujitsu-laptop.c~compal-laptop-fujitsu-laptop-msi-laptop-make-dmi_check_cb-to-return-1-instead-of-0
+++ a/drivers/platform/x86/fujitsu-laptop.c
@@ -603,7 +603,7 @@ static int dmi_check_cb_s6410(const stru
 	dmi_check_cb_common(id);
 	fujitsu->keycode1 = KEY_SCREENLOCK;	/* "Lock" */
 	fujitsu->keycode2 = KEY_HELP;	/* "Mobility Center" */
-	return 0;
+	return 1;
 }
 
 static int dmi_check_cb_s6420(const struct dmi_system_id *id)
@@ -611,7 +611,7 @@ static int dmi_check_cb_s6420(const stru
 	dmi_check_cb_common(id);
 	fujitsu->keycode1 = KEY_SCREENLOCK;	/* "Lock" */
 	fujitsu->keycode2 = KEY_HELP;	/* "Mobility Center" */
-	return 0;
+	return 1;
 }
 
 static int dmi_check_cb_p8010(const struct dmi_system_id *id)
@@ -620,7 +620,7 @@ static int dmi_check_cb_p8010(const stru
 	fujitsu->keycode1 = KEY_HELP;	/* "Support" */
 	fujitsu->keycode3 = KEY_SWITCHVIDEOMODE;	/* "Presentation" */
 	fujitsu->keycode4 = KEY_WWW;	/* "Internet" */
-	return 0;
+	return 1;
 }
 
 static struct dmi_system_id fujitsu_dmi_table[] = {
diff -puN drivers/platform/x86/msi-laptop.c~compal-laptop-fujitsu-laptop-msi-laptop-make-dmi_check_cb-to-return-1-instead-of-0 drivers/platform/x86/msi-laptop.c
--- a/drivers/platform/x86/msi-laptop.c~compal-laptop-fujitsu-laptop-msi-laptop-make-dmi_check_cb-to-return-1-instead-of-0
+++ a/drivers/platform/x86/msi-laptop.c
@@ -434,7 +434,7 @@ static int dmi_check_cb(const struct dmi
 {
 	printk(KERN_INFO "msi-laptop: Identified laptop model '%s'.\n",
 	       id->ident);
-	return 0;
+	return 1;
 }
 
 static struct dmi_system_id __initdata msi_dmi_table[] = {
_
