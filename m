From: yakui.zhao@intel.com
Subject: [PATCH -v6 2/2] IPMI: use ACPI detection mechanism firstly to detect IPMI system interface
Date: Mon,  7 Jun 2010 17:27:22 +0800
Message-ID: <1275902842-19895-3-git-send-email-yakui.zhao@intel.com>
References: <1275902842-19895-1-git-send-email-yakui.zhao@intel.com>
 <1275902842-19895-2-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:55740 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752939Ab0FGJaL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jun 2010 05:30:11 -0400
In-Reply-To: <1275902842-19895-2-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: minyard@acm.org
Cc: lenb@kernel.org, openipmi-developer@lists.sourceforge.net, linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Myron Stowe <myron.stowe@hp.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Sometimes one IPMI system interface will be detected by several methods.
For example: ACPI mechanism, SPMI table, DMI.
Maybe one IPMI system interface can be detected in two mechanism. In such case
the second mechanism will fail in the detection and can't record which IPMI
system interface is detected by it.

Use the ACPI detection mechanism firstly to detect the IPMI system interface
so that we can know which IPMI system interface is detected in ACPI namespace and
then install the IPMI opregion to enable ACPI to access the BMC controller.
But the hardcode detection mechanism is still put in the first order.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
cc: Myron Stowe <myron.stowe@hp.com> 
---
 drivers/char/ipmi/ipmi_si_intf.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 87b5722..2807749 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -3763,16 +3763,16 @@ static __devinit int init_ipmi_si(void)
 	}
 	mutex_unlock(&smi_infos_lock);
 
+#ifdef CONFIG_ACPI
+	pnp_register_driver(&ipmi_pnp_driver);
+#endif
+
 #ifdef CONFIG_PCI
 	rv = pci_register_driver(&ipmi_pci_driver);
 	if (rv)
 		printk(KERN_ERR PFX "Unable to register PCI driver: %d\n", rv);
 #endif
 
-#ifdef CONFIG_ACPI
-	pnp_register_driver(&ipmi_pnp_driver);
-#endif
-
 #ifdef CONFIG_DMI
 	dmi_find_bmc();
 #endif
@@ -3933,6 +3933,7 @@ static __exit void cleanup_ipmi_si(void)
 #ifdef CONFIG_PCI
 	pci_unregister_driver(&ipmi_pci_driver);
 #endif
+
 #ifdef CONFIG_ACPI
 	pnp_unregister_driver(&ipmi_pnp_driver);
 #endif
-- 
1.5.4.5

