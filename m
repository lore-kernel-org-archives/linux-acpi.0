From: John Keller <jpk@sgi.com>
Subject: [RESEND] [PATCH] x86: Allow MMCONFIG above 4GB on x86_64
Date: Tue, 29 Jul 2008 14:34:16 -0500 (CDT)
Message-ID: <200807291934.m6TJYGai478010@fcbayern.americas.sgi.com>
References: <20080715194714.1437.92354.57492@attica.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:43880 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751958AbYG2TeT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Jul 2008 15:34:19 -0400
In-Reply-To: <20080715194714.1437.92354.57492@attica.americas.sgi.com> from "John Keller" at Jul 15, 2008 02:47:14 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: jpk@sgi.com

Just checking on the status of this patch.
If there are no issues, please apply.

Thanks,
John

================================


SGI UV will have MMCFG base addresses that are greater than 4GB (32 bits).

Signed-off-by: John Keller <jpk@sgi.com>
---

Resend #2: Create a flag, that is set by platform specific code,
           to disable the > 4GB check.

Resend #1: Use CONFIG_RESOURCES_64BIT instead of CONFIG_X86_64.



Index: linux-2.6/arch/x86/kernel/acpi/boot.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/boot.c	2008-07-15 11:04:14.000000000 -0500
+++ linux-2.6/arch/x86/kernel/acpi/boot.c	2008-07-15 11:08:11.000000000 -0500
@@ -97,6 +97,8 @@ static u64 acpi_lapic_addr __initdata = 
 #warning ACPI uses CMPXCHG, i486 and later hardware
 #endif
 
+static int acpi_mcfg_64bit_base_addr __initdata = FALSE;
+
 /* --------------------------------------------------------------------------
                               Boot-time Configuration
    -------------------------------------------------------------------------- */
@@ -158,6 +160,14 @@ char *__init __acpi_map_table(unsigned l
 struct acpi_mcfg_allocation *pci_mmcfg_config;
 int pci_mmcfg_config_num;
 
+static int __init acpi_mcfg_oem_check(struct acpi_table_mcfg *mcfg)
+{
+	if (!strcmp(mcfg->header.oem_id, "SGI"))
+		acpi_mcfg_64bit_base_addr = TRUE;
+
+	return 0;
+}
+
 int __init acpi_parse_mcfg(struct acpi_table_header *header)
 {
 	struct acpi_table_mcfg *mcfg;
@@ -190,8 +200,12 @@ int __init acpi_parse_mcfg(struct acpi_t
 	}
 
 	memcpy(pci_mmcfg_config, &mcfg[1], config_size);
+
+	acpi_mcfg_oem_check(mcfg);
+
 	for (i = 0; i < pci_mmcfg_config_num; ++i) {
-		if (pci_mmcfg_config[i].address > 0xFFFFFFFF) {
+		if ((pci_mmcfg_config[i].address > 0xFFFFFFFF) &&
+		    !acpi_mcfg_64bit_base_addr) {
 			printk(KERN_ERR PREFIX
 			       "MMCONFIG not in low 4GB of memory\n");
 			kfree(pci_mmcfg_config);


