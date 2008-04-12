From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/73] ACPICA: Add minimal disassembly support for the SLIC table
Date: Sat, 12 Apr 2008 00:25:01 -0400
Message-ID: <a16317ac7d590cd3a25d37f88d33da11b432304f.1207973799.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:7534 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752496AbYDLE16 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:27:58 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

SLIC - Software Licensing Description Table.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acdisasm.h |    1 +
 include/acpi/actbl1.h   |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/acpi/acdisasm.h b/include/acpi/acdisasm.h
index 389d772..75c354f 100644
--- a/include/acpi/acdisasm.h
+++ b/include/acpi/acdisasm.h
@@ -180,6 +180,7 @@ extern struct acpi_dmtable_info acpi_dm_table_info_mcfg0[];
 extern struct acpi_dmtable_info acpi_dm_table_info_rsdp1[];
 extern struct acpi_dmtable_info acpi_dm_table_info_rsdp2[];
 extern struct acpi_dmtable_info acpi_dm_table_info_sbst[];
+extern struct acpi_dmtable_info acpi_dm_table_info_slic[];
 extern struct acpi_dmtable_info acpi_dm_table_info_slit[];
 extern struct acpi_dmtable_info acpi_dm_table_info_spcr[];
 extern struct acpi_dmtable_info acpi_dm_table_info_spmi[];
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index a1b1b2e..dd8e11e 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -67,6 +67,7 @@
 #define ACPI_SIG_MADT           "APIC"	/* Multiple APIC Description Table */
 #define ACPI_SIG_MCFG           "MCFG"	/* PCI Memory Mapped Configuration table */
 #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
+#define ACPI_SIG_SLIC           "SLIC"	/* Software Licensing Description Table */
 #define ACPI_SIG_SLIT           "SLIT"	/* System Locality Distance Information Table */
 #define ACPI_SIG_SPCR           "SPCR"	/* Serial Port Console Redirection table */
 #define ACPI_SIG_SPMI           "SPMI"	/* Server Platform Management Interface table */
-- 
1.5.5.29.g7134

