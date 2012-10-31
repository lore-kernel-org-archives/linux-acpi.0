From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 23/26] ACPICA: Fix externalize name to complete migration to ACPI_MOVE_NAME
Date: Wed, 31 Oct 2012 10:28:19 +0800
Message-ID: <9558a6a1006529db12cd76b2e2a168eda83b28d1.1351649951.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5102 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932324Ab2JaCiq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:38:46 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fix for name segment copy and validation.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsutils.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 0d3d481..b5b4cb7 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -557,8 +557,11 @@ acpi_ns_externalize_name(u32 internal_name_length,
 				(*converted_name)[j++] = '.';
 			}
 
-			ACPI_MOVE_NAME(*converted_name, internal_name);
-			acpi_ut_repair_name(*converted_name);
+			/* Copy and validate the 4-char name segment */
+
+			ACPI_MOVE_NAME(&(*converted_name)[j],
+				       &internal_name[names_index]);
+			acpi_ut_repair_name(&(*converted_name)[j]);
 
 			j += ACPI_NAME_SIZE;
 			names_index += ACPI_NAME_SIZE;
-- 
1.7.10

