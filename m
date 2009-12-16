From: Len Brown <lenb@kernel.org>
Subject: [PATCH 079/103] ipmi: refer to table as "SPMI", not "ACPI"
Date: Wed, 16 Dec 2009 03:36:30 -0500
Message-ID: <18a3e0bfbcd589599d0affbfd484ba9a97e5f122.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41516 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760796AbZLPKFy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:05:54 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:05:52 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This discovery method uses the SPMI table, not the ACPI namespace.  In
the future, we will look in the namespace, so let's refer to the table
as "SPMI" and save "ACPI" for the namespace.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/char/ipmi/ipmi_si_intf.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index aaf6ead..b58e587 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1919,7 +1919,7 @@ struct SPMITable {
 	s8      spmi_id[1]; /* A '\0' terminated array starts here. */
 };
 
-static __devinit int try_init_acpi(struct SPMITable *spmi)
+static __devinit int try_init_spmi(struct SPMITable *spmi)
 {
 	struct smi_info  *info;
 	u8 		 addr_space;
@@ -1940,7 +1940,7 @@ static __devinit int try_init_acpi(struct SPMITable *spmi)
 		return -ENOMEM;
 	}
 
-	info->addr_source = "ACPI";
+	info->addr_source = "SPMI";
 
 	/* Figure out the interface type. */
 	switch (spmi->InterfaceType) {
@@ -2002,7 +2002,7 @@ static __devinit int try_init_acpi(struct SPMITable *spmi)
 	return 0;
 }
 
-static __devinit void acpi_find_bmc(void)
+static __devinit void spmi_find_bmc(void)
 {
 	acpi_status      status;
 	struct SPMITable *spmi;
@@ -2020,7 +2020,7 @@ static __devinit void acpi_find_bmc(void)
 		if (status != AE_OK)
 			return;
 
-		try_init_acpi(spmi);
+		try_init_spmi(spmi);
 	}
 }
 #endif
@@ -3104,7 +3104,7 @@ static __devinit int init_ipmi_si(void)
 #endif
 
 #ifdef CONFIG_ACPI
-	acpi_find_bmc();
+	spmi_find_bmc();
 #endif
 
 #ifdef CONFIG_PCI
-- 
1.6.0.6

