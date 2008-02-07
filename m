From: Len Brown <lenb@kernel.org>
Subject: [PATCH 028/112] sony-laptop: bump version to 0.6
Date: Thu,  7 Feb 2008 04:33:50 -0500
Message-ID: <425ef5d75de25c53b6dc79008fe3678d2fe7e8ed.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:42392 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757855AbYBGJfw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:52 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/sony-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index a650f25..9869286 100644
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
1.5.4.23.gef5b9

