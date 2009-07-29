From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] fujitsu-laptop: remove superfluous NULL pointer checks
Date: Wed, 29 Jul 2009 22:14:30 +0200
Message-ID: <200907292214.31038.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756004AbZG2URY@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>, corbet@lwn.net, eteo@redhat.com, Julia Lawall <julia@diku.dk>
List-Id: linux-acpi@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] fujitsu-laptop: remove superfluous NULL pointer checks

This takes care of the following entries from Dan's list:

drivers/platform/x86/fujitsu-laptop.c +327 set_lcd_level(13) warning: variable derefenced before check 'fujitsu'
drivers/platform/x86/fujitsu-laptop.c +358 set_lcd_level_alt(13) warning: variable derefenced before check 'fujitsu'

Reported-by: Dan Carpenter <error27@gmail.com>
Cc: corbet@lwn.net
Cc: eteo@redhat.com
Cc: Julia Lawall <julia@diku.dk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/platform/x86/fujitsu-laptop.c |    6 ------
 1 file changed, 6 deletions(-)

Index: b/drivers/platform/x86/fujitsu-laptop.c
===================================================================
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -324,9 +324,6 @@ static int set_lcd_level(int level)
 	if (level < 0 || level >= fujitsu->max_brightness)
 		return -EINVAL;
 
-	if (!fujitsu)
-		return -EINVAL;
-
 	status = acpi_get_handle(fujitsu->acpi_handle, "SBLL", &handle);
 	if (ACPI_FAILURE(status)) {
 		vdbg_printk(FUJLAPTOP_DBG_ERROR, "SBLL not present\n");
@@ -355,9 +352,6 @@ static int set_lcd_level_alt(int level)
 	if (level < 0 || level >= fujitsu->max_brightness)
 		return -EINVAL;
 
-	if (!fujitsu)
-		return -EINVAL;
-
 	status = acpi_get_handle(fujitsu->acpi_handle, "SBL2", &handle);
 	if (ACPI_FAILURE(status)) {
 		vdbg_printk(FUJLAPTOP_DBG_ERROR, "SBL2 not present\n");
