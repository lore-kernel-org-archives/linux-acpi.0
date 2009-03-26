From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 09/14] sony-laptop: detect the ICH9 chipset as Type3
Date: Thu, 26 Mar 2009 21:58:20 +0900
Message-ID: <1238072305-8085-10-git-send-email-malattia@linux.it>
References: <1238072305-8085-1-git-send-email-malattia@linux.it>
 <1238072305-8085-2-git-send-email-malattia@linux.it>
 <1238072305-8085-3-git-send-email-malattia@linux.it>
 <1238072305-8085-4-git-send-email-malattia@linux.it>
 <1238072305-8085-5-git-send-email-malattia@linux.it>
 <1238072305-8085-6-git-send-email-malattia@linux.it>
 <1238072305-8085-7-git-send-email-malattia@linux.it>
 <1238072305-8085-8-git-send-email-malattia@linux.it>
 <1238072305-8085-9-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:53421
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756009AbZCZM6a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Mar 2009 08:58:30 -0400
In-Reply-To: <1238072305-8085-9-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ISHIKAWA Mutsumi <ishikawa@hanzubon.jp>, Mattia Dongili <malattia@linux.it>

From: ISHIKAWA Mutsumi <ishikawa@hanzubon.jp>

Signed-off-by: ISHIKAWA Mutsumi <ishikawa@hanzubon.jp>
Signed-off-by: Mattia Dongili <malattia@linux.it>
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
1.6.2

