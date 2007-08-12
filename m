From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 2/3] sony-laptop: call sonypi_compat_init earlier
Date: Sun, 12 Aug 2007 16:20:27 +0900
Message-ID: <11869032282373-git-send-email-malattia@linux.it>
References: <11869032283795-git-send-email-malattia@linux.it>
 <11869032283577-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi14.ns.itscom.net ([219.110.2.184]:36174 "EHLO
	mtoichi14.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747AbXHLHUp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Aug 2007 03:20:45 -0400
In-Reply-To: <11869032283577-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>

sonypi_compat uses a kfifo that needs to be present before _SRS is
called to be able to cope with the IRQs triggered when setting
resources.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 7e621c6..e4d8f73 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -2305,8 +2305,6 @@ static int sony_pic_remove(struct acpi_device *device, int type)
 	struct sony_pic_ioport *io, *tmp_io;
 	struct sony_pic_irq *irq, *tmp_irq;
 
-	sonypi_compat_exit();
-
 	if (sony_pic_disable(device)) {
 		printk(KERN_ERR DRV_PFX "Couldn't disable device.\n");
 		return -ENXIO;
@@ -2316,6 +2314,8 @@ static int sony_pic_remove(struct acpi_device *device, int type)
 	release_region(spic_dev.cur_ioport->io.minimum,
 			spic_dev.cur_ioport->io.address_length);
 
+	sonypi_compat_exit();
+
 	sony_laptop_remove_input();
 
 	/* pf attrs */
@@ -2381,6 +2381,9 @@ static int sony_pic_add(struct acpi_device *device)
 		goto err_free_resources;
 	}
 
+	if (sonypi_compat_init())
+		goto err_remove_input;
+
 	/* request io port */
 	list_for_each_entry(io, &spic_dev.ioports, list) {
 		if (request_region(io->io.minimum, io->io.address_length,
@@ -2395,7 +2398,7 @@ static int sony_pic_add(struct acpi_device *device)
 	if (!spic_dev.cur_ioport) {
 		printk(KERN_ERR DRV_PFX "Failed to request_region.\n");
 		result = -ENODEV;
-		goto err_remove_input;
+		goto err_remove_compat;
 	}
 
 	/* request IRQ */
@@ -2435,9 +2438,6 @@ static int sony_pic_add(struct acpi_device *device)
 	if (result)
 		goto err_remove_pf;
 
-	if (sonypi_compat_init())
-		goto err_remove_pf;
-
 	return 0;
 
 err_remove_pf:
@@ -2453,6 +2453,9 @@ err_release_region:
 	release_region(spic_dev.cur_ioport->io.minimum,
 			spic_dev.cur_ioport->io.address_length);
 
+err_remove_compat:
+	sonypi_compat_exit();
+
 err_remove_input:
 	sony_laptop_remove_input();
 
-- 
1.5.2.4

