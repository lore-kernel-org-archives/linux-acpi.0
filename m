From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/21] ACPICA: Enhance ACPI warning for memory/IO address conflicts.
Date: Wed,  8 Jan 2014 13:44:21 +0800
Message-ID: <1e6b0ffa5843ada83559254721e596e008345643.1387505703.git.lv.zheng@intel.com>
References: <cover.1387505702.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30928 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754503AbaAHFo3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Jan 2014 00:44:29 -0500
In-Reply-To: <cover.1387505702.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

This change improves the warning message when a system address
conflicts with an existing operation region. It now emits the region
address range in addition to the input (system) address range.

Reported-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utaddress.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/utaddress.c b/drivers/acpi/acpica/utaddress.c
index e0a2e27..2c2b6ae 100644
--- a/drivers/acpi/acpica/utaddress.c
+++ b/drivers/acpi/acpica/utaddress.c
@@ -224,10 +224,11 @@ acpi_ut_check_address_range(acpi_adr_space_type space_id,
 
 	while (range_info) {
 		/*
-		 * Check if the requested Address/Length overlaps this address_range.
-		 * Four cases to consider:
+		 * Check if the requested address/length overlaps this
+		 * address range. There are four cases to consider:
 		 *
-		 * 1) Input address/length is contained completely in the address range
+		 * 1) Input address/length is contained completely in the
+		 *    address range
 		 * 2) Input address/length overlaps range at the range start
 		 * 3) Input address/length overlaps range at the range end
 		 * 4) Input address/length completely encompasses the range
@@ -244,11 +245,17 @@ acpi_ut_check_address_range(acpi_adr_space_type space_id,
 								  region_node);
 
 				ACPI_WARNING((AE_INFO,
-					      "0x%p-0x%p %s conflicts with Region %s %d",
+					      "%s range 0x%p-0x%p conflicts with OpRegion 0x%p-0x%p (%s)",
+					      acpi_ut_get_region_name(space_id),
 					      ACPI_CAST_PTR(void, address),
 					      ACPI_CAST_PTR(void, end_address),
-					      acpi_ut_get_region_name(space_id),
-					      pathname, overlap_count));
+					      ACPI_CAST_PTR(void,
+							    range_info->
+							    start_address),
+					      ACPI_CAST_PTR(void,
+							    range_info->
+							    end_address),
+					      pathname));
 				ACPI_FREE(pathname);
 			}
 		}
-- 
1.7.10

