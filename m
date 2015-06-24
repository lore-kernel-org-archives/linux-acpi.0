From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 06/28] ACPICA: Hardware: Cleanup the return values in acpi_set_waking_vector().
Date: Wed, 24 Jun 2015 11:03:06 +0800
Message-ID: <a4c7d94c3150c683c2709bebad2ca45615b13045.1435114811.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com> <cover.1435114811.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7552 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934035AbbFXDDN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jun 2015 23:03:13 -0400
In-Reply-To: <cover.1435114811.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit a04dbfa308a48ab0b2d10519c54a6c533c5c8949

The return statement in acpi_set_waking_vector() is wrong and this patch
corrects it. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/a04dbfa3
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/hwxfsleep.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index e273b2e..c25fedb 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -161,7 +161,7 @@ acpi_set_firmware_waking_vector(acpi_physical_address physical_address,
 	/* If Hardware Reduced flag is set, there is no FACS */
 
 	if (acpi_gbl_reduced_hardware) {
-		return (AE_OK);
+		return_ACPI_STATUS(AE_OK);
 	}
 
 	if (acpi_gbl_facs32) {
-- 
1.7.10

