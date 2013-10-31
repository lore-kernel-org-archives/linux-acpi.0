From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/15] ACPICA: Update RSDP table definitions.
Date: Thu, 31 Oct 2013 09:30:16 +0800
Message-ID: <1f247ad98411c41328e6d9bcf941ba97b8f8dfb4.1383182393.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com> <cover.1383182392.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49435 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306Ab3JaBaz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Oct 2013 21:30:55 -0400
In-Reply-To: <cover.1383182392.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch does not affect the generation of the Linux binary.
This patch decreases 26 lines of divergences.

This patch updates RSDP table header definitions as such enhancement
already has been done in ACPICA.  This patch merges such changes into Linux
to reduce the source code differences between Linux and ACPICA upstream.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl.h |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 9b58a8f..9497088 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -146,7 +146,24 @@ struct acpi_table_rsdp {
 	u8 reserved[3];		/* Reserved, must be zero */
 };
 
-#define ACPI_RSDP_REV0_SIZE     20	/* Size of original ACPI 1.0 RSDP */
+/* Standalone struct for the ACPI 1.0 RSDP */
+
+struct acpi_rsdp_common {
+	char signature[8];
+	u8 checksum;
+	char oem_id[ACPI_OEM_ID_SIZE];
+	u8 revision;
+	u32 rsdt_physical_address;
+};
+
+/* Standalone struct for the extended part of the RSDP (ACPI 2.0+) */
+
+struct acpi_rsdp_extension {
+	u32 length;
+	u64 xsdt_physical_address;
+	u8 extended_checksum;
+	u8 reserved[3];
+};
 
 /*******************************************************************************
  *
-- 
1.7.10

