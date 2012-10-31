From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 21/26] ACPICA: Deploy ACPI_MOVE_NAME across ACPICA source base
Date: Wed, 31 Oct 2012 10:28:03 +0800
Message-ID: <2952e6a9f9c061949e0bc7fb3f3389b13c3bc21c.1351649951.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:27211 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932069Ab2JaC2J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:28:09 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Replaces instances of strncpy(...,4) for ACPI_NAMEs.
ACPI_MOVE_NAME optimizes these to a single 32-bit copy on machines
that support misaligned transfers.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsxfname.c |    3 +--
 drivers/acpi/acpica/tbfind.c   |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index ce87897..2d10df2 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -202,8 +202,7 @@ acpi_get_name(acpi_handle handle, u32 name_type, struct acpi_buffer * buffer)
 
 	/* Just copy the ACPI name from the Node and zero terminate it */
 
-	ACPI_STRNCPY(buffer->pointer, acpi_ut_get_node_name(node),
-		     ACPI_NAME_SIZE);
+	ACPI_MOVE_NAME(buffer->pointer, acpi_ut_get_node_name(node));
 	((char *)buffer->pointer)[ACPI_NAME_SIZE] = 0;
 	status = AE_OK;
 
diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index 57deae1..77d1db2 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -77,7 +77,7 @@ acpi_tb_find_table(char *signature,
 	/* Normalize the input strings */
 
 	ACPI_MEMSET(&header, 0, sizeof(struct acpi_table_header));
-	ACPI_STRNCPY(header.signature, signature, ACPI_NAME_SIZE);
+	ACPI_MOVE_NAME(header.signature, signature);
 	ACPI_STRNCPY(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
 	ACPI_STRNCPY(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
 
-- 
1.7.10

