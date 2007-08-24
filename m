From: Len Brown <len.brown@intel.com>
Subject: [PATCH 21/25] ISAPNP: removed unused isapnp_detected and ISAPNP_DEBUG
Date: Fri, 24 Aug 2007 03:21:08 -0400
Message-ID: <11879400972603-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
 <11879400762710-git-send-email-len.brown@intel.com>
 <11879400782033-git-send-email-len.brown@intel.com>
 <11879400793131-git-send-email-len.brown@intel.com>
 <11879400794174-git-send-email-len.brown@intel.com>
 <11879400802531-git-send-email-len.brown@intel.com>
 <11879400812208-git-send-email-len.brown@intel.com>
 <11879400823500-git-send-email-len.brown@intel.com>
 <11879400841550-git-send-email-len.brown@intel.com>
 <1187940085345-git-send-email-len.brown@intel.com>
 <1187940086685-git-send-email-len.brown@intel.com>
 <11879400872911-git-send-email-len.brown@intel.com>
 <11879400882727-git-send-email-len.brown@intel.com>
 <11879400892741-git-send-email-len.brown@intel.com>
 <11879400903190-git-send-email-len.brown@intel.com>
 <11879400911609-git-send-email-len.brown@intel.com>
 <11879400921598-git-send-email-len.brown@intel.com>
 <11879400933976-git-send-email-len.brown@intel.com>
 <1187940094867-git-send-email-len.brown@intel.com>
 <11879400951708-git-send-email-len.brown@intel.com>
 <11879400963954-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23132 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755313AbXHXHVk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:40 -0400
In-Reply-To: <11879400963954-git-send-email-len.brown@intel.com>
Message-Id: <6c504d30a48157b7c05a0dfb6a799c72095e957d.1187939443.git.len.brown@intel.com>
In-Reply-To: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
References: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

ISAPNP_DEBUG isn't used at all.  isapnp_detected is set but never read.
So remove them both.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Adam Belay <abelay@novell.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/isapnp/core.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index 32386ce..1a0d33a 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -47,9 +47,6 @@
 #if 0
 #define ISAPNP_REGION_OK
 #endif
-#if 0
-#define ISAPNP_DEBUG
-#endif
 
 int isapnp_disable;		/* Disable ISA PnP */
 static int isapnp_rdp;		/* Read Data Port */
@@ -93,7 +90,6 @@ MODULE_LICENSE("GPL");
 
 static unsigned char isapnp_checksum_value;
 static DEFINE_MUTEX(isapnp_cfg_mutex);
-static int isapnp_detected;
 static int isapnp_csn_count;
 
 /* some prototypes */
@@ -1067,7 +1063,6 @@ static int __init isapnp_init(void)
 	struct pnp_dev *dev;
 
 	if (isapnp_disable) {
-		isapnp_detected = 0;
 		printk(KERN_INFO "isapnp: ISA Plug & Play support disabled\n");
 		return 0;
 	}
@@ -1115,7 +1110,6 @@ static int __init isapnp_init(void)
 		}
 		isapnp_set_rdp();
 	}
-	isapnp_detected = 1;
 	if (isapnp_rdp < 0x203 || isapnp_rdp > 0x3ff) {
 		cards = isapnp_isolate();
 		if (cards < 0 || (isapnp_rdp < 0x203 || isapnp_rdp > 0x3ff)) {
@@ -1123,7 +1117,6 @@ static int __init isapnp_init(void)
 			release_region(_PIDXR, 1);
 #endif
 			release_region(_PNPWRP, 1);
-			isapnp_detected = 0;
 			printk(KERN_INFO
 			       "isapnp: No Plug & Play device found\n");
 			return 0;
-- 
1.5.3.rc6.17.g1911
