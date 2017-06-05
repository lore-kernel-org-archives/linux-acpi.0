From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 50/53] ACPICA: Simplify output for the ACPI Debug Object
Date: Mon,  5 Jun 2017 16:42:17 +0800
Message-ID: <53b2e761d6de49fe634feab3a5a2d64900857d54.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46482 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbdFEImU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:42:20 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit ea08cda9859d9f758f4832400b2d559847c2d52a

Cleanup the output, change [Acpi Debug] to Acpi Debug:

Link: https://github.com/acpica/acpica/commit/ea08cda9
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exdebug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/exdebug.c b/drivers/acpi/acpica/exdebug.c
index ec614f5..a8191d2 100644
--- a/drivers/acpi/acpica/exdebug.c
+++ b/drivers/acpi/acpica/exdebug.c
@@ -117,10 +117,10 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 			timer = ((u32)acpi_os_get_timer() / 10);
 			timer &= 0x03FFFFFF;
 
-			acpi_os_printf("[ACPI Debug T=0x%8.8X] %*s", timer,
+			acpi_os_printf("ACPI Debug: T=0x%8.8X %*s", timer,
 				       level, " ");
 		} else {
-			acpi_os_printf("[ACPI Debug] %*s", level, " ");
+			acpi_os_printf("ACPI Debug: %*s", level, " ");
 		}
 	}
 
-- 
2.7.4

