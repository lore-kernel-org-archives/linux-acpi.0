From: Naga Chumbalkar <nagananda.chumbalkar@hp.com>
Subject: [PATCH]: ACPI: Fix comments that describe the DWORDs for _OSC
Date: Tue, 26 Apr 2011 15:06:22 +0000 (UTC)
Message-ID: <20110426150105.3041.66845.sendpatchset@nchumbalkar.americas.hpqcorp.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0184.atlanta.hp.com ([15.193.32.61]:10482 "EHLO
	g6t0184.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756095Ab1DZPGZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Apr 2011 11:06:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, Naga Chumbalkar <nagananda.chumbalkar@hp.com>

Made the _OSC comments more helpful to someone viewing the source.

Signed-off-by: Naga Chumbalkar <nagananda.chumbalkar@hp.com>
---
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a2e910e..cdc8739 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -275,6 +275,7 @@ struct acpi_osc_context {
 acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 
 /* platform-wide _OSC bits */
+/* _OSC DW1 Definition (OS Support Fields) */
 #define OSC_SB_PAD_SUPPORT		1
 #define OSC_SB_PPC_OST_SUPPORT		2
 #define OSC_SB_PR3_SUPPORT		4
@@ -290,7 +291,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 #define OSC_MSI_SUPPORT				16
 #define OSC_PCI_SUPPORT_MASKS			0x1f
 
-/* _OSC DW1 Definition (OS Control Fields) */
+/* _OSC DW2 Definition (OS Control Fields) */
 #define OSC_PCI_EXPRESS_NATIVE_HP_CONTROL	1
 #define OSC_SHPC_NATIVE_HP_CONTROL 		2
 #define OSC_PCI_EXPRESS_PME_CONTROL		4
