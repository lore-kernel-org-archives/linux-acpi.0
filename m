From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 4/9] [sony-laptop] detect the ICH9 chipset as Type3
Date: Sun,  1 Mar 2009 13:40:40 +0900
Message-ID: <1235882445-2404-5-git-send-email-malattia@linux.it>
References: <1235882445-2404-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:48655
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756455AbZCAEuT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Feb 2009 23:50:19 -0500
In-Reply-To: <1235882445-2404-1-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ISHIKAWA Mutsumi <ishikawa@hanzubon.jp>, Mattia Dongili <malattia@linux.it>

From: ISHIKAWA Mutsumi <ishikawa@hanzubon.jp>

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 35491d9..3322368 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1596,6 +1596,13 @@ static void sony_pic_detect_device_type(struct sony_pic_dev *dev)
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
1.6.1.3

