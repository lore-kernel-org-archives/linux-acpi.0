From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/22] ACPICA: Add support for MCHI table
Date: Thu, 20 May 2010 01:18:30 -0400
Message-ID: <0e264f0bc22207b99f33ee06e614186480682f15.1274332657.git.len.brown@intel.com>
References: <1274332730-27370-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:64217 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756Ab0ETFTh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2010 01:19:37 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2P004R8DFHX524@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 20 May 2010 00:18:53 -0500 (CDT)
In-reply-to: <1274332730-27370-1-git-send-email-lenb@kernel.org>
In-reply-to: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
References: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Disassembler and header file support for MCHI - Managment
Controller Host Interface table.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/actbl2.h |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 5b02e30..95f4d0e 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -69,6 +69,7 @@
 #define ACPI_SIG_IBFT           "IBFT"	/* i_sCSI Boot Firmware Table */
 #define ACPI_SIG_IVRS           "IVRS"	/* I/O Virtualization Reporting Structure */
 #define ACPI_SIG_MCFG           "MCFG"	/* PCI Memory Mapped Configuration table */
+#define ACPI_SIG_MCHI           "MCHI"	/* Management Controller Host Interface table */
 #define ACPI_SIG_SLIC           "SLIC"	/* Software Licensing Description Table */
 #define ACPI_SIG_SPCR           "SPCR"	/* Serial Port Console Redirection table */
 #define ACPI_SIG_SPMI           "SPMI"	/* Server Platform Management Interface table */
@@ -679,6 +680,32 @@ struct acpi_mcfg_allocation {
 
 /*******************************************************************************
  *
+ * MCHI - Management Controller Host Interface Table
+ *        Version 1
+ *
+ * Conforms to "Management Component Transport Protocol (MCTP) Host
+ * Interface Specification", Revision 1.0.0a, October 13, 2009
+ *
+ ******************************************************************************/
+
+struct acpi_table_mchi {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u8 interface_type;
+	u8 protocol;
+	u64 protocol_data;
+	u8 interrupt_type;
+	u8 gpe;
+	u8 pci_device_flag;
+	u32 global_interrupt;
+	struct acpi_generic_address control_register;
+	u8 pci_segment;
+	u8 pci_bus;
+	u8 pci_device;
+	u8 pci_function;
+};
+
+/*******************************************************************************
+ *
  * SPCR - Serial Port Console Redirection table
  *        Version 1
  *
-- 
1.6.0.6

