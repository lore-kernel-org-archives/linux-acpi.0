From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] acpi, add region addresses to conflict output
Date: Mon, 25 Nov 2013 12:01:07 -0500
Message-ID: <1385398867-10238-1-git-send-email-prarit@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11097 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754020Ab3KYRBY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Nov 2013 12:01:24 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Myron Stowe <mstowe@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>

Currently the kernel does

 ACPI Warning: 0x0000000000000428-0x000000000000042f SystemIO conflicts
 with Region \PMIO 1 (20130517/utaddress-251)

This patch outputs the region address so that we now see

ACPI Warning: 0x0000000000000428-0x000000000000042f SystemIO conflicts
with Region 0x0000000000000400-0x000000000000047f \PMIO 1
(20130927/utaddress-252)

which is a lot more useful for debugging.

Also fix some simple comment linewrapping issues in this function.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Myron Stowe <mstowe@redhat.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/utaddress.c | 52 +++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/acpica/utaddress.c b/drivers/acpi/acpica/utaddress.c
index e0a2e27..1467fd4 100644
--- a/drivers/acpi/acpica/utaddress.c
+++ b/drivers/acpi/acpica/utaddress.c
@@ -224,35 +224,41 @@ acpi_ut_check_address_range(acpi_adr_space_type space_id,
 
 	while (range_info) {
 		/*
-		 * Check if the requested Address/Length overlaps this address_range.
+		 * Check if the requested Address/Length overlaps this
+		 * address_range.
 		 * Four cases to consider:
 		 *
-		 * 1) Input address/length is contained completely in the address range
+		 * 1) Input address/length is contained completely in the
+		 *    address range
 		 * 2) Input address/length overlaps range at the range start
 		 * 3) Input address/length overlaps range at the range end
 		 * 4) Input address/length completely encompasses the range
 		 */
-		if ((address <= range_info->end_address) &&
-		    (end_address >= range_info->start_address)) {
-
-			/* Found an address range overlap */
-
-			overlap_count++;
-			if (warn) {	/* Optional warning message */
-				pathname =
-				    acpi_ns_get_external_pathname(range_info->
-								  region_node);
-
-				ACPI_WARNING((AE_INFO,
-					      "0x%p-0x%p %s conflicts with Region %s %d",
-					      ACPI_CAST_PTR(void, address),
-					      ACPI_CAST_PTR(void, end_address),
-					      acpi_ut_get_region_name(space_id),
-					      pathname, overlap_count));
-				ACPI_FREE(pathname);
-			}
-		}
-
+		if ((address > range_info->end_address) &&
+		    (end_address < range_info->start_address))
+			goto next_range;
+
+		/* Found an address range overlap */
+		overlap_count++;
+
+		if (!warn)
+			goto next_range;
+
+		/* Optional warning message */
+		pathname =
+			 acpi_ns_get_external_pathname(range_info->region_node);
+
+		ACPI_WARNING((AE_INFO,
+			      "0x%p-0x%p %s conflicts with Region 0x%p-0x%p %s %d",
+			      ACPI_CAST_PTR(void, address),
+			      ACPI_CAST_PTR(void, end_address),
+			      acpi_ut_get_region_name(space_id),
+			      ACPI_CAST_PTR(void, range_info->start_address),
+			      ACPI_CAST_PTR(void, range_info->end_address),
+			      pathname, overlap_count));
+		ACPI_FREE(pathname);
+
+next_range:
 		range_info = range_info->next;
 	}
 
-- 
1.8.4.2

