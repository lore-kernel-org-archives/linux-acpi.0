From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 14/15] ACPICA: ACPI 6.2: Additional PPTT flags
Date: Fri, 17 Nov 2017 15:42:29 -0800
Message-ID: <20171117234230.913-15-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
 <20171117234230.913-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39440 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161767AbdKQXqp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:46:45 -0500
In-Reply-To: <20171117234230.913-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jeremy Linton <jeremy.linton@arm.com>, Bob Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>

From: Jeremy Linton <jeremy.linton@arm.com>

ACPICA commit fba3ae99b2bc514ca34f0d7b2609c2a043582784

The ACPI 6.2 spec has flags to describe cache
allocation, write back, and whether
it is an instruction, data or unified cache.

Link: https://github.com/acpica/acpica/commit/fba3ae99
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 include/acpi/actbl1.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 178661f1b896..4c304bf4d591 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1441,6 +1441,20 @@ struct acpi_pptt_cache {
 #define ACPI_PPTT_MASK_CACHE_TYPE           (0x0C)	/* Cache type */
 #define ACPI_PPTT_MASK_WRITE_POLICY         (0x10)	/* Write policy */
 
+/* Attributes describing cache */
+#define ACPI_PPTT_CACHE_READ_ALLOCATE       (0x0)	/* Cache line is allocated on read */
+#define ACPI_PPTT_CACHE_WRITE_ALLOCATE      (0x01)	/* Cache line is allocated on write */
+#define ACPI_PPTT_CACHE_RW_ALLOCATE         (0x02)	/* Cache line is allocated on read and write */
+#define ACPI_PPTT_CACHE_RW_ALLOCATE_ALT     (0x03)	/* Alternate representation of above */
+
+#define ACPI_PPTT_CACHE_TYPE_DATA           (0x0)	/* Data cache */
+#define ACPI_PPTT_CACHE_TYPE_INSTR          (1<<2)	/* Instruction cache */
+#define ACPI_PPTT_CACHE_TYPE_UNIFIED        (2<<2)	/* Unified I & D cache */
+#define ACPI_PPTT_CACHE_TYPE_UNIFIED_ALT    (3<<2)	/* Alternate representation of above */
+
+#define ACPI_PPTT_CACHE_POLICY_WB           (0x0)	/* Cache is write back */
+#define ACPI_PPTT_CACHE_POLICY_WT           (1<<4)	/* Cache is write through */
+
 /* 2: ID Structure */
 
 struct acpi_pptt_id {
-- 
2.13.6

