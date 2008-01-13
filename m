From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 4/6] sony-laptop: bump version to 0.6
Date: Sun, 13 Jan 2008 13:23:30 +0900
Message-ID: <1200198212-10526-5-git-send-email-malattia@linux.it>
References: <1200198212-10526-1-git-send-email-malattia@linux.it>
 <1200198212-10526-2-git-send-email-malattia@linux.it>
 <1200198212-10526-3-git-send-email-malattia@linux.it>
 <1200198212-10526-4-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi15.ns.itscom.net ([219.110.2.185]:59190 "EHLO
	mtoichi15.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbYAMEXs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Jan 2008 23:23:48 -0500
In-Reply-To: <1200198212-10526-4-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 3d3843a..84430b4 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -73,7 +73,7 @@
 	if (debug) printk(KERN_WARNING DRV_PFX  msg);	\
 } while (0)
 
-#define SONY_LAPTOP_DRIVER_VERSION	"0.5"
+#define SONY_LAPTOP_DRIVER_VERSION	"0.6"
 
 #define SONY_NC_CLASS		"sony-nc"
 #define SONY_NC_HID		"SNY5001"
-- 
1.5.3.7

