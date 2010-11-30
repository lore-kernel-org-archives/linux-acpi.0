From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v2 1/3] Add CPER PCIe error section structure and constants definition
Date: Tue, 30 Nov 2010 10:51:39 +0800
Message-ID: <1291085501-31494-2-git-send-email-ying.huang@intel.com>
References: <1291085501-31494-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291085501-31494-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-acpi@vger.kernel.org

On some machine, PCIe error is reported via APEI (ACPI Platform Error
Interface).  The error data is passed from firmware to Linux via CPER
PCIe error section structure.

This patch adds CPER PCIe error section structure and constants
definition.

Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 include/linux/cper.h |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -201,6 +201,47 @@
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
@@ -306,6 +347,41 @@ struct cper_sec_mem_err {
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
 
