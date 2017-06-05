From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 31/53] ACPICA: Explicitly cast 1 to u32
Date: Mon,  5 Jun 2017 16:40:15 +0800
Message-ID: <4e48a3685ab5128a4e1bed8010cb352203624280.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:14096 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751589AbdFEIkS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:40:18 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>

From: Erik Schmauss <erik.schmauss@intel.com>

ACPICA commit 4091360d6526c8d4f1e6bccb6b1c3123bda9ac33

The runtime errors caused when acpica tools are compiled with
-fsanitize=shift imply that these 1s are stored in integers.
This cast insures that 1 is stored in unsigned integers.

Link: https://github.com/acpica/acpica/commit/4091360d
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utownerid.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/utownerid.c b/drivers/acpi/acpica/utownerid.c
index c82399f..1b3ee74 100644
--- a/drivers/acpi/acpica/utownerid.c
+++ b/drivers/acpi/acpica/utownerid.c
@@ -104,13 +104,19 @@ acpi_status acpi_ut_allocate_owner_id(acpi_owner_id *owner_id)
 				break;
 			}
 
-			if (!(acpi_gbl_owner_id_mask[j] & (1 << k))) {
+			/*
+			 * Note: the u32 cast ensures that 1 is stored as a unsigned
+			 * integer. Omitting the cast may result in 1 being stored as an
+			 * int. Some compilers or runtime error detection may flag this as
+			 * an error.
+			 */
+			if (!(acpi_gbl_owner_id_mask[j] & ((u32)1 << k))) {
 				/*
 				 * Found a free ID. The actual ID is the bit index plus one,
 				 * making zero an invalid Owner ID. Save this as the last ID
 				 * allocated and update the global ID mask.
 				 */
-				acpi_gbl_owner_id_mask[j] |= (1 << k);
+				acpi_gbl_owner_id_mask[j] |= ((u32)1 << k);
 
 				acpi_gbl_last_owner_id_index = (u8)j;
 				acpi_gbl_next_owner_id_offset = (u8)(k + 1);
@@ -201,7 +207,7 @@ void acpi_ut_release_owner_id(acpi_owner_id *owner_id_ptr)
 	/* Decode ID to index/offset pair */
 
 	index = ACPI_DIV_32(owner_id);
-	bit = 1 << ACPI_MOD_32(owner_id);
+	bit = (u32)1 << ACPI_MOD_32(owner_id);
 
 	/* Free the owner ID only if it is valid */
 
-- 
2.7.4

