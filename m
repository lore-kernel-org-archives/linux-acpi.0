From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 09/15] ACPICA: ACPI 6.0A: Changes to the NFIT ACPI table
Date: Fri, 17 Nov 2017 15:42:24 -0800
Message-ID: <20171117234230.913-10-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234230.913-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39437 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759969AbdKQXqk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:46:40 -0500
In-Reply-To: <20171117234230.913-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit a42a086b8d682ab8dfbc4666cf6b9c8a5ee23a77

Adds a new subtable.

Link: https://github.com/acpica/acpica/commit/a42a086b
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 include/acpi/actbl1.h | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 5ef905626c6d..867f4136dbac 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1150,7 +1150,8 @@ enum acpi_nfit_type {
 	ACPI_NFIT_TYPE_CONTROL_REGION = 4,
 	ACPI_NFIT_TYPE_DATA_REGION = 5,
 	ACPI_NFIT_TYPE_FLUSH_ADDRESS = 6,
-	ACPI_NFIT_TYPE_RESERVED = 7	/* 7 and greater are reserved */
+	ACPI_NFIT_TYPE_CAPABILITIES = 7,
+	ACPI_NFIT_TYPE_RESERVED = 8	/* 8 and greater are reserved */
 };
 
 /*
@@ -1282,6 +1283,69 @@ struct acpi_nfit_flush_address {
 	u64 hint_address[1];	/* Variable length */
 };
 
+/* 7: Platform Capabilities Structure */
+
+struct acpi_nfit_capabilities {
+	struct acpi_nfit_header header;
+	u8 highest_capability;
+	u8 reserved[3];		/* Reserved, must be zero */
+	u32 capabilities;
+	u32 reserved2;
+};
+
+/* Capabilities Flags */
+
+#define ACPI_NFIT_CAPABILITY_CACHE_FLUSH       (1)	/* 00: Cache Flush to NVDIMM capable */
+#define ACPI_NFIT_CAPABILITY_MEM_FLUSH         (1<<1)	/* 01: Memory Flush to NVDIMM capable */
+#define ACPI_NFIT_CAPABILITY_MEM_MIRRORING     (1<<2)	/* 02: Memory Mirroring capable */
+
+/*
+ * NFIT/DVDIMM device handle support - used as the _ADR for each NVDIMM
+ */
+struct nfit_device_handle {
+	u32 handle;
+};
+
+/* Device handle construction and extraction macros */
+
+#define ACPI_NFIT_DIMM_NUMBER_MASK              0x0000000F
+#define ACPI_NFIT_CHANNEL_NUMBER_MASK           0x000000F0
+#define ACPI_NFIT_MEMORY_ID_MASK                0x00000F00
+#define ACPI_NFIT_SOCKET_ID_MASK                0x0000F000
+#define ACPI_NFIT_NODE_ID_MASK                  0x0FFF0000
+
+#define ACPI_NFIT_DIMM_NUMBER_OFFSET            0
+#define ACPI_NFIT_CHANNEL_NUMBER_OFFSET         4
+#define ACPI_NFIT_MEMORY_ID_OFFSET              8
+#define ACPI_NFIT_SOCKET_ID_OFFSET              12
+#define ACPI_NFIT_NODE_ID_OFFSET                16
+
+/* Macro to construct a NFIT/NVDIMM device handle */
+
+#define ACPI_NFIT_BUILD_DEVICE_HANDLE(dimm, channel, memory, socket, node) \
+	((dimm)                                         | \
+	((channel) << ACPI_NFIT_CHANNEL_NUMBER_OFFSET)  | \
+	((memory)  << ACPI_NFIT_MEMORY_ID_OFFSET)       | \
+	((socket)  << ACPI_NFIT_SOCKET_ID_OFFSET)       | \
+	((node)    << ACPI_NFIT_NODE_ID_OFFSET))
+
+/* Macros to extract individual fields from a NFIT/NVDIMM device handle */
+
+#define ACPI_NFIT_GET_DIMM_NUMBER(handle) \
+	((handle) & ACPI_NFIT_DIMM_NUMBER_MASK)
+
+#define ACPI_NFIT_GET_CHANNEL_NUMBER(handle) \
+	(((handle) & ACPI_NFIT_CHANNEL_NUMBER_MASK) >> ACPI_NFIT_CHANNEL_NUMBER_OFFSET)
+
+#define ACPI_NFIT_GET_MEMORY_ID(handle) \
+	(((handle) & ACPI_NFIT_MEMORY_ID_MASK)      >> ACPI_NFIT_MEMORY_ID_OFFSET)
+
+#define ACPI_NFIT_GET_SOCKET_ID(handle) \
+	(((handle) & ACPI_NFIT_SOCKET_ID_MASK)      >> ACPI_NFIT_SOCKET_ID_OFFSET)
+
+#define ACPI_NFIT_GET_NODE_ID(handle) \
+	(((handle) & ACPI_NFIT_NODE_ID_MASK)        >> ACPI_NFIT_NODE_ID_OFFSET)
+
 /*******************************************************************************
  *
  * PDTT - Platform Debug Trigger Table (ACPI 6.2)
-- 
2.13.6

