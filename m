From: Myron Stowe <myron.stowe@hp.com>
Subject: [PATCH 1/4] ipmi: Raise precedence of PNP based discovery mechanisms
	(ACPI, PCI)
Date: Wed, 03 Mar 2010 20:44:10 -0700
Message-ID: <20100304034410.30205.13074.stgit@bob.kio>
References: <20100304033146.30205.68689.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0184.atlanta.hp.com ([15.193.32.61]:40841 "EHLO
	g6t0184.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728Ab0CDDoL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Mar 2010 22:44:11 -0500
In-Reply-To: <20100304033146.30205.68689.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: minyard@acm.org
Cc: linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, lenb@kernel.org

This raises the precedence of PNP discovery mechanisms, ACPI and  PCI,
above SMBIOS and SPMI as indicated by Appendix C1 of the IPMI
specification.

Reference: IPMI - Intelligent Platform Management Interface Specification
           v2.0, Document Revision 1.0, 05.05.2005 Markup

  Appendix C1 - Locating IPMI System Interfaces via SMBIOS Tables
      "Note that the settings that this structure reports may be over-
      ridden by `Plug-and-Play' reassignment by the OS.  Therefore, this
      structure should be used only when the interface cannot be
      discovered via `Plug-and-Play' discovery mechanisms incorporated
      in interfaces such as PCI and ACPI."

Signed-off-by: Myron Stowe <myron.stowe@hp.com>
---

 drivers/char/ipmi/ipmi_si_intf.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 176f175..86a7dd7 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -3197,13 +3197,6 @@ static __devinit int init_ipmi_si(void)
 
 	hardcode_find_bmc();
 
-#ifdef CONFIG_DMI
-	dmi_find_bmc();
-#endif
-
-#ifdef CONFIG_ACPI
-	spmi_find_bmc();
-#endif
 #ifdef CONFIG_ACPI
 	pnp_register_driver(&ipmi_pnp_driver);
 #endif
@@ -3220,6 +3213,14 @@ static __devinit int init_ipmi_si(void)
 	of_register_platform_driver(&ipmi_of_platform_driver);
 #endif
 
+#ifdef CONFIG_DMI
+	dmi_find_bmc();
+#endif
+
+#ifdef CONFIG_ACPI
+	spmi_find_bmc();
+#endif
+
 	if (si_trydefaults) {
 		mutex_lock(&smi_infos_lock);
 		if (list_empty(&smi_infos)) {

