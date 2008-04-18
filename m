From: Sergey Yanovich <ynvich@gmail.com>
Subject: [PATCH 1/3] Correctly detect Sony TX770P PIC device type
Date: Sat, 19 Apr 2008 01:41:33 +0300
Message-ID: <1208558495-22792-1-git-send-email-ynvich@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:65210 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbYDRWmD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Apr 2008 18:42:03 -0400
Received: by ug-out-1314.google.com with SMTP id z38so174967ugc.16
        for <linux-acpi@vger.kernel.org>; Fri, 18 Apr 2008 15:42:01 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: malattia@linux.it, Sergey Yanovich <ynvich@gmail.com>

This laptop has Type 4 SPIC device, support for which has been added
recently. This device resides behind an older ISA bridge and was
earlier incorrectly detected as Type 3.
---
 drivers/misc/sony-laptop.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 02ff3d1..be70153 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -1563,6 +1563,11 @@ static void sony_pic_detect_device_type(struct sony_pic_dev *dev)
 	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
 			PCI_DEVICE_ID_INTEL_ICH6_1, NULL);
 	if (pcidev) {
+		if (pcidev->subsystem_vendor == PCI_VENDOR_ID_SONY &&
+				pcidev->subsystem_device == 0x81E2) {
+			dev->control = &spic_types[3];
+			goto out;
+		}
 		dev->control = &spic_types[2];
 		goto out;
 	}
-- 
1.5.5

