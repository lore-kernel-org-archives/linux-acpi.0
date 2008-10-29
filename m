From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch] ACPI: remove comments about debug layer/level to use
Date: Wed, 29 Oct 2008 15:26:57 -0600
Message-ID: <200810291526.58149.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:1211 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbYJ2V11 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Oct 2008 17:27:27 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

I don't think there's any point in cluttering the code with these.
Better to improve the documentation so *anybody* can figure out
what layer & level to use.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/pci_root.c |    6 ------
 drivers/acpi/video.c    |    6 ------
 2 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 1b8f67d..642554b 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -376,15 +376,9 @@ static int acpi_pci_root_remove(struct acpi_device *device, int type)
 
 static int __init acpi_pci_root_init(void)
 {
-
 	if (acpi_pci_disabled)
 		return 0;
 
-	/* DEBUG:
-	   acpi_dbg_layer = ACPI_PCI_COMPONENT;
-	   acpi_dbg_level = 0xFFFFFFFF;
-	 */
-
 	if (acpi_bus_register_driver(&acpi_pci_root_driver) < 0)
 		return -ENODEV;
 
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index a29b0cc..bf0c26a 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -2094,12 +2094,6 @@ static int __init acpi_video_init(void)
 {
 	int result = 0;
 
-
-	/*
-	   acpi_dbg_level = 0xFFFFFFFF;
-	   acpi_dbg_layer = 0x08000000;
-	 */
-
 	acpi_video_dir = proc_mkdir(ACPI_VIDEO_CLASS, acpi_root_dir);
 	if (!acpi_video_dir)
 		return -ENODEV;
