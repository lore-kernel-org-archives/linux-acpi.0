From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 4/7] [sony-laptop] detect the ICH9 chipset as Type3
Date: Mon,  3 Nov 2008 18:41:17 +0900
Message-ID: <1225705280-12775-5-git-send-email-malattia@linux.it>
References: <1225705280-12775-1-git-send-email-malattia@linux.it>
 <1225705280-12775-2-git-send-email-malattia@linux.it>
 <1225705280-12775-3-git-send-email-malattia@linux.it>
 <1225705280-12775-4-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:48101
	"EHLO tadamune.kami.home" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754945AbYKCJlY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2008 04:41:24 -0500
In-Reply-To: <1225705280-12775-4-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ISHIKAWA Mutsumi <ishikawa@hanzubon.jp>, Mattia Dongili <malattia@linux.it>

From: ISHIKAWA Mutsumi <ishikawa@hanzubon.jp>

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index c9e5651..19f3306 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -1589,6 +1589,13 @@ static void sony_pic_detect_device_type(struct sony_pic_dev *dev)
 		goto out;
 	}
 
+	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
+			PCI_DEVICE_ID_INTEL_ICH9_1, NULL);
+	if (pcidev) {
+		dev->control = &spic_types[4];
+		goto out;
+	}
+
 	/* default */
 	dev->control = &spic_types[1];
 
-- 
1.5.6.5

