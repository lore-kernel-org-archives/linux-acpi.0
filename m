From: Len Brown <lenb@kernel.org>
Subject: [PATCH 63/98] sony-laptop: detect the ICH9 chipset as Type3
Date: Sat, 28 Mar 2009 00:31:38 -0400
Message-ID: <d5b02695d5471b38064efeba2b102bd5ead55297.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:27224 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740AbZC1Ed0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:26 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700L868NOL67D@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:25 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: ISHIKAWA Mutsumi <ishikawa@hanzubon.jp>, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: ISHIKAWA Mutsumi <ishikawa@hanzubon.jp>

Signed-off-by: ISHIKAWA Mutsumi <ishikawa@hanzubon.jp>
Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/sony-laptop.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 813d0e0..5030f99 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1824,6 +1824,13 @@ static void sony_pic_detect_device_type(struct sony_pic_dev *dev)
 		goto out;
 	}
 
+	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
+			PCI_DEVICE_ID_INTEL_ICH9_1, NULL);
+	if (pcidev) {
+		dev->control = &spic_types[2];
+		goto out;
+	}
+
 	/* default */
 	dev->control = &spic_types[1];
 
-- 
1.6.0.6

