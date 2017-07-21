From: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Subject: [PATCH] ACPIi / lpat: Fix typos and kernel-doc style
Date: Sat, 22 Jul 2017 00:14:42 +0530
Message-ID: <1500662682-29595-1-git-send-email-sumeet.r.pawnikar@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:56616 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751504AbdGUSoJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Jul 2017 14:44:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, sumeet.r.pawnikar@intel.com

This patch fix the typos in function header of
acpi_lpat_raw_to_temp and acpi_lpat_temp_to_raw.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 drivers/acpi/acpi_lpat.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_lpat.c b/drivers/acpi/acpi_lpat.c
index c1c4877..2cd9f73 100644
--- a/drivers/acpi/acpi_lpat.c
+++ b/drivers/acpi/acpi_lpat.c
@@ -25,7 +25,7 @@
  * @raw: the raw value, used as a key to get the temerature from the
  *       above mapping table
  *
- * A positive converted temperarure value will be returned on success,
+ * A positive converted temperature value will be returned on success,
  * a negative errno will be returned in error cases.
  */
 int acpi_lpat_raw_to_temp(struct acpi_lpat_conversion_table *lpat_table,
@@ -55,11 +55,11 @@ int acpi_lpat_raw_to_temp(struct acpi_lpat_conversion_table *lpat_table,
  * acpi_lpat_temp_to_raw(): Return raw value from temperature through
  * LPAT conversion table
  *
- * @lpat: the temperature_raw mapping table
+ * @lpat_table: the temperature_raw mapping table
  * @temp: the temperature, used as a key to get the raw value from the
  *        above mapping table
  *
- * A positive converted temperature value will be returned on success,
+ * The raw value will be returned on success,
  * a negative errno will be returned in error cases.
  */
 int acpi_lpat_temp_to_raw(struct acpi_lpat_conversion_table *lpat_table,
-- 
1.7.9.5

