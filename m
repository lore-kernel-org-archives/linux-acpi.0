From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 52/53] ACPICA: Update a couple of debug output messages
Date: Mon,  5 Jun 2017 16:42:28 +0800
Message-ID: <af4642108d55e0eeef6ba3b765933e9787002db7.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59391 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751453AbdFEImb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:42:31 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 809c1766598c7f3decaeeba2c6ed603c538d0270

Cleanup output.

Link: https://github.com/acpica/acpica/commit/809c1766
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dbxface.c | 2 +-
 drivers/acpi/acpica/nsutils.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/dbxface.c b/drivers/acpi/acpica/dbxface.c
index 8f665d9..b698532 100644
--- a/drivers/acpi/acpica/dbxface.c
+++ b/drivers/acpi/acpica/dbxface.c
@@ -244,7 +244,7 @@ acpi_db_single_step(struct acpi_walk_state *walk_state,
 		if ((acpi_gbl_db_output_to_file) ||
 		    (acpi_dbg_level & ACPI_LV_PARSE)) {
 			acpi_os_printf
-			    ("\n[AmlDebug] Next AML Opcode to execute:\n");
+			    ("\nAML Debug: Next AML Opcode to execute:\n");
 		}
 
 		/*
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 2fe87d0..b43fe5fc 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -89,7 +89,7 @@ acpi_ns_print_node_pathname(struct acpi_namespace_node *node,
 			acpi_os_printf("%s ", message);
 		}
 
-		acpi_os_printf("[%s] (Node %p)", (char *)buffer.pointer, node);
+		acpi_os_printf("%s", (char *)buffer.pointer);
 		ACPI_FREE(buffer.pointer);
 	}
 }
-- 
2.7.4

