From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/33] Add CPER PCIe error section structure and constants
 definition
Date: Sun, 26 Dec 2010 17:43:46 -0500
Message-ID: <c9aa308fd5c373faeda588cfb02b04f116904613.1293403342.git.len.brown@intel.com>
References: <1293403434-12054-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:51680 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab0LZW6v (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Dec 2010 17:58:51 -0500
Received: from localhost.localdomain ([unknown] [108.7.186.163])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LE200DX055VNMD4@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 26 Dec 2010 16:58:50 -0600 (CST)
In-reply-to: <1293403434-12054-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <len.brown@intel.com>

From: Huang Ying <ying.huang@intel.com>

On some machine, PCIe error is reported via APEI (ACPI Platform Error
Interface).  The error data is passed from firmware to Linux via CPER
PCIe error section structure.

This patch adds CPER PCIe error section structure and constants
definition.

Signed-off-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/cper.h |   86 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/include/linux/cper.h b/include/linux/cper.h
index bf972f8..3104aaf 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -39,10 +39,12 @@
  * Severity difinition for error_severity in struct cper_record_header
  * and section_severity in struct cper_section_descriptor
  */
-#define CPER_SEV_RECOVERABLE			0x0
-#define CPER_SEV_FATAL				0x1
-#define CPER_SEV_CORRECTED			0x2
-#define CPER_SEV_INFORMATIONAL			0x3
+enum {
+	CPER_SEV_RECOVERABLE,
+	CPER_SEV_FATAL,
+	CPER_SEV_CORRECTED,
+	CPER_SEV_INFORMATIONAL,
+};
 
 /*
  * Validation bits difinition for validation_bits in struct
@@ -201,6 +203,47 @@
 	UUID_LE(0x036F84E1, 0x7F37, 0x428c, 0xA7, 0x9E, 0x57, 0x5F,	\
 		0xDF, 0xAA, 0x84, 0xEC)
 
+#define CPER_PROC_VALID_TYPE			0x0001
+#define CPER_PROC_VALID_ISA			0x0002
+#define CPER_PROC_VALID_ERROR_TYPE		0x0004
+#define CPER_PROC_VALID_OPERATION		0x0008
+#define CPER_PROC_VALID_FLAGS			0x0010
+#define CPER_PROC_VALID_LEVEL			0x0020
+#define CPER_PROC_VALID_VERSION			0x0040
+#define CPER_PROC_VALID_BRAND_INFO		0x0080
+#define CPER_PROC_VALID_ID			0x0100
+#define CPER_PROC_VALID_TARGET_ADDRESS		0x0200
+#define CPER_PROC_VALID_REQUESTOR_ID		0x0400
+#define CPER_PROC_VALID_RESPONDER_ID		0x0800
+#define CPER_PROC_VALID_IP			0x1000
+
+#define CPER_MEM_VALID_ERROR_STATUS		0x0001
+#define CPER_MEM_VALID_PHYSICAL_ADDRESS		0x0002
+#define CPER_MEM_VALID_PHYSICAL_ADDRESS_MASK	0x0004
+#define CPER_MEM_VALID_NODE			0x0008
+#define CPER_MEM_VALID_CARD			0x0010
+#define CPER_MEM_VALID_MODULE			0x0020
+#define CPER_MEM_VALID_BANK			0x0040
+#define CPER_MEM_VALID_DEVICE			0x0080
+#define CPER_MEM_VALID_ROW			0x0100
+#define CPER_MEM_VALID_COLUMN			0x0200
+#define CPER_MEM_VALID_BIT_POSITION		0x0400
+#define CPER_MEM_VALID_REQUESTOR_ID		0x0800
+#define CPER_MEM_VALID_RESPONDER_ID		0x1000
+#define CPER_MEM_VALID_TARGET_ID		0x2000
+#define CPER_MEM_VALID_ERROR_TYPE		0x4000
+
+#define CPER_PCIE_VALID_PORT_TYPE		0x0001
+#define CPER_PCIE_VALID_VERSION			0x0002
+#define CPER_PCIE_VALID_COMMAND_STATUS		0x0004
+#define CPER_PCIE_VALID_DEVICE_ID		0x0008
+#define CPER_PCIE_VALID_SERIAL_NUMBER		0x0010
+#define CPER_PCIE_VALID_BRIDGE_CONTROL_STATUS	0x0020
+#define CPER_PCIE_VALID_CAPABILITY		0x0040
+#define CPER_PCIE_VALID_AER_INFO		0x0080
+
+#define CPER_PCIE_SLOT_SHIFT			3
+
 /*
  * All tables and structs must be byte-packed to match CPER
  * specification, since the tables are provided by the system BIOS
@@ -306,6 +349,41 @@ struct cper_sec_mem_err {
 	__u8	error_type;
 };
 
+struct cper_sec_pcie {
+	__u64		validation_bits;
+	__u32		port_type;
+	struct {
+		__u8	minor;
+		__u8	major;
+		__u8	reserved[2];
+	}		version;
+	__u16		command;
+	__u16		status;
+	__u32		reserved;
+	struct {
+		__u16	vendor_id;
+		__u16	device_id;
+		__u8	class_code[3];
+		__u8	function;
+		__u8	device;
+		__u16	segment;
+		__u8	bus;
+		__u8	secondary_bus;
+		__u16	slot;
+		__u8	reserved;
+	}		device_id;
+	struct {
+		__u32	lower;
+		__u32	upper;
+	}		serial_number;
+	struct {
+		__u16	secondary_status;
+		__u16	control;
+	}		bridge;
+	__u8	capability[60];
+	__u8	aer_info[96];
+};
+
 /* Reset to default packing */
 #pragma pack()
 
-- 
1.7.3.3.557.gb5c17

