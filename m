From: yakui.zhao@intel.com
Subject: [PATCH v4 1/2] IPMI/ACPI: use ACPI detection mechanism firstly to detect IPMI system interface
Date: Fri, 18 Dec 2009 15:57:00 +0800
Message-ID: <1261123021-22836-2-git-send-email-yakui.zhao@intel.com>
References: <1261123021-22836-1-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62022 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbZLRH64 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Dec 2009 02:58:56 -0500
In-Reply-To: <1261123021-22836-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com, minyard@acm.org, openipmi-developer@lists.sourceforge.net, Zhao Yakui <yakui.zhao@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Sometimes one IPMI system interface will be detected by several methods.
For example: ACPI mechanism, SPMI table, DMI or hardcode mechanism.
In such case when one IPMI system interface can be detected in two mechanism,
the second mechanism will fail in the detection and can't record which IPMI
system interface is detected by it.

Use the ACPI detection mechanism firstly to detect the IPMI system interface
so that we can know which IPMI system interface is detected in ACPI namespace.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/char/ipmi/ipmi_si_intf.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 679cd08..99fecd2 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -3195,6 +3195,10 @@ static __devinit int init_ipmi_si(void)
 
 	printk(KERN_INFO "IPMI System Interface driver.\n");
 
+#ifdef CONFIG_PNP
+	pnp_register_driver(&ipmi_pnp_driver);
+#endif
+
 	hardcode_find_bmc();
 
 #ifdef CONFIG_DMI
@@ -3204,9 +3208,6 @@ static __devinit int init_ipmi_si(void)
 #ifdef CONFIG_ACPI
 	spmi_find_bmc();
 #endif
-#ifdef CONFIG_PNP
-	pnp_register_driver(&ipmi_pnp_driver);
-#endif
 
 #ifdef CONFIG_PCI
 	rv = pci_register_driver(&ipmi_pci_driver);
-- 
1.5.4.5

