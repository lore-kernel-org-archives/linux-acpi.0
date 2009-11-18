From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v1 4/5] ipmi: refer to table as "SPMI", not "ACPI"
Date: Tue, 17 Nov 2009 17:05:29 -0700
Message-ID: <20091118000529.14214.69672.stgit@bob.kio>
References: <20091118000427.14214.14043.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:13722 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbZKRAFY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Nov 2009 19:05:24 -0500
In-Reply-To: <20091118000427.14214.14043.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Corey Minyard <minyard@acm.org>, Bela Lubkin <blubkin@vmware.com>, linux-acpi@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>, openipmi-developer@lists.sourceforge.net, Len Brown <lenb@kernel.org>

This discovery method uses the SPMI table, not the ACPI namespace.  In
the future, we will look in the namespace, so let's refer to the table
as "SPMI" and save "ACPI" for the namespace.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
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

