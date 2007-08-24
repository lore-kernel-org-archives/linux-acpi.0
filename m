From: Len Brown <len.brown@intel.com>
Subject: [PATCH 15/25] sony-laptop: call sonypi_compat_init earlier
Date: Fri, 24 Aug 2007 03:21:02 -0400
Message-ID: <11879400911609-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
 <11879400762710-git-send-email-len.brown@intel.com>
 <11879400782033-git-send-email-len.brown@intel.com>
 <11879400793131-git-send-email-len.brown@intel.com>
 <11879400794174-git-send-email-len.brown@intel.com>
 <11879400802531-git-send-email-len.brown@intel.com>
 <11879400812208-git-send-email-len.brown@intel.com>
 <11879400823500-git-send-email-len.brown@intel.com>
 <11879400841550-git-send-email-len.brown@intel.com>
 <1187940085345-git-send-email-len.brown@intel.com>
 <1187940086685-git-send-email-len.brown@intel.com>
 <11879400872911-git-send-email-len.brown@intel.com>
 <11879400882727-git-send-email-len.brown@intel.com>
 <11879400892741-git-send-email-len.brown@intel.com>
 <11879400903190-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22482 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762486AbXHXHVc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:32 -0400
In-Reply-To: <11879400903190-git-send-email-len.brown@intel.com>
Message-Id: <015a916fbbf105bb15f4bbfd80c3b9b2f2e0d7db.1187939442.git.len.brown@intel.com>
In-Reply-To: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
References: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

sonypi_compat uses a kfifo that needs to be present before _SRS is
called to be able to cope with the IRQs triggered when setting
resources.

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/sony-laptop.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 7707cc2..7d8bebe 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -2317,8 +2317,6 @@ static int sony_pic_remove(struct acpi_device *device, int type)
 	struct sony_pic_ioport *io, *tmp_io;
 	struct sony_pic_irq *irq, *tmp_irq;
 
-	sonypi_compat_exit();
-
 	if (sony_pic_disable(device)) {
 		printk(KERN_ERR DRV_PFX "Couldn't disable device.\n");
 		return -ENXIO;
@@ -2328,6 +2326,8 @@ static int sony_pic_remove(struct acpi_device *device, int type)
 	release_region(spic_dev.cur_ioport->io.minimum,
 			spic_dev.cur_ioport->io.address_length);
 
+	sonypi_compat_exit();
+
 	sony_laptop_remove_input();
 
 	/* pf attrs */
@@ -2393,6 +2393,9 @@ static int sony_pic_add(struct acpi_device *device)
 		goto err_free_resources;
 	}
 
+	if (sonypi_compat_init())
+		goto err_remove_input;
+
 	/* request io port */
 	list_for_each_entry(io, &spic_dev.ioports, list) {
 		if (request_region(io->io.minimum, io->io.address_length,
@@ -2407,7 +2410,7 @@ static int sony_pic_add(struct acpi_device *device)
 	if (!spic_dev.cur_ioport) {
 		printk(KERN_ERR DRV_PFX "Failed to request_region.\n");
 		result = -ENODEV;
-		goto err_remove_input;
+		goto err_remove_compat;
 	}
 
 	/* request IRQ */
@@ -2447,9 +2450,6 @@ static int sony_pic_add(struct acpi_device *device)
 	if (result)
 		goto err_remove_pf;
 
-	if (sonypi_compat_init())
-		goto err_remove_pf;
-
 	return 0;
 
 err_remove_pf:
@@ -2465,6 +2465,9 @@ err_release_region:
 	release_region(spic_dev.cur_ioport->io.minimum,
 			spic_dev.cur_ioport->io.address_length);
 
+err_remove_compat:
+	sonypi_compat_exit();
+
 err_remove_input:
 	sony_laptop_remove_input();
 
-- 
1.5.3.rc6.17.g1911
