From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH] Disable MSI per FADT
Date: Wed, 25 Apr 2007 11:05:12 +0800
Message-ID: <1177470312.11073.10.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58294 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169AbXDYDIl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Apr 2007 23:08:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Greg KH <greg@kroah.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

ACPI spec defines the bit and Microsoft uses it. Suppose Linux should
use it too.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

Index: 2.6.21-rc6/drivers/pci/pci-acpi.c
===================================================================
--- 2.6.21-rc6.orig/drivers/pci/pci-acpi.c	2007-04-06 10:36:56.000000000 +0800
+++ 2.6.21-rc6/drivers/pci/pci-acpi.c	2007-04-25 10:58:12.000000000 +0800
@@ -317,6 +317,10 @@ static int __init acpi_pci_init(void)
 {
 	int ret;
 
+	if (acpi_gbl_FADT.boot_flags & BAF_MSI_NOT_SUPPORTED) {
+		printk(KERN_INFO"ACPI FADT declares the system doesn't support MSI, so disable it\n");
+		pci_no_msi();
+	}
 	ret = register_acpi_bus_type(&acpi_pci_bus);
 	if (ret)
 		return 0;
Index: 2.6.21-rc6/include/acpi/actbl.h
===================================================================
--- 2.6.21-rc6.orig/include/acpi/actbl.h	2007-04-06 10:36:56.000000000 +0800
+++ 2.6.21-rc6/include/acpi/actbl.h	2007-04-25 10:22:28.000000000 +0800
@@ -276,6 +276,7 @@ enum acpi_prefered_pm_profiles {
 
 #define BAF_LEGACY_DEVICES              0x0001
 #define BAF_8042_KEYBOARD_CONTROLLER    0x0002
+#define BAF_MSI_NOT_SUPPORTED           0x0008
 
 #define FADT2_REVISION_ID               3
 #define FADT2_MINUS_REVISION_ID         2
