From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/21] ACPI: remove comments about debug layer/level to use
Date: Thu, 06 Nov 2008 23:39:13 -0500
Message-ID: <5704d626e7c770ef4a984a697bac7eff07420a39.1226032677.git.len.brown@intel.com>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:37272 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbYKGEjb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:39:31 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9Y00LHU4XUN5P0@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:39:31 -0600 (CST)
In-reply-to: <1226032765-15330-1-git-send-email-lenb@kernel.org>
In-reply-to: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

I don't think there's any point in cluttering the code with these.
Better to improve the documentation so *anybody* can figure out
what layer & level to use.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
-- 
1.5.6.5

