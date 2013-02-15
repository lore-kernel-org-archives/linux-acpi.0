From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: [PATCH EDAC 04/13] edac: add a new memory layer type
Date: Fri, 15 Feb 2013 10:44:52 -0200
Message-ID: <3602d1069551396b3d5db19f0ee171594090ef7f.1360931635.git.mchehab@redhat.com>
References: <cover.1360931635.git.mchehab@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24961 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935912Ab3BOMpY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Feb 2013 07:45:24 -0500
In-Reply-To: <cover.1360931635.git.mchehab@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Huang Ying <ying.huang@intel.com>, Tony Luck <tony.luck@intel.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, Linux Edac Mailing List <linux-edac@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

There are some cases where the memory controller layout is
completely hidden. This is the case of firmware-driven error
code, like the one provided by GHES. Add a new layer to be
used on such memory error report mechanisms.

Signed-off-by: Mauro Carvalho Chehab <mchehab@redhat.com>
---
 drivers/edac/edac_mc.c | 1 +
 include/linux/edac.h   | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 8e58b1c..8e33028 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -918,6 +918,7 @@ const char *edac_layer_name[] = {
 	[EDAC_MC_LAYER_CHANNEL] = "channel",
 	[EDAC_MC_LAYER_SLOT] = "slot",
 	[EDAC_MC_LAYER_CHIP_SELECT] = "csrow",
+	[EDAC_MC_LAYER_ALL_MEM] = "memory",
 };
 EXPORT_SYMBOL_GPL(edac_layer_name);
 
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 4784213..1b7744c 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -375,6 +375,9 @@ enum scrub_type {
  * @EDAC_MC_LAYER_CHANNEL:	memory layer is named "channel"
  * @EDAC_MC_LAYER_SLOT:		memory layer is named "slot"
  * @EDAC_MC_LAYER_CHIP_SELECT:	memory layer is named "chip select"
+ * @EDAC_MC_LAYER_ALL_MEM:	memory layout is unknown. All memory is mapped
+ *				as a single memory area. This is used when
+ *				retrieving errors from a firmware driven driver.
  *
  * This enum is used by the drivers to tell edac_mc_sysfs what name should
  * be used when describing a memory stick location.
@@ -384,6 +387,7 @@ enum edac_mc_layer_type {
 	EDAC_MC_LAYER_CHANNEL,
 	EDAC_MC_LAYER_SLOT,
 	EDAC_MC_LAYER_CHIP_SELECT,
+	EDAC_MC_LAYER_ALL_MEM,
 };
 
 /**
-- 
1.8.1.2

