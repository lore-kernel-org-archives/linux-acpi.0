From: Len Brown <len.brown@intel.com>
Subject: [PATCH 22/77] ACPI EC: Re-factor EC space handler to avoid using label/goto for cycle.
Date: Sun, 22 Jul 2007 05:14:07 -0400
Message-ID: <11850957252722-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51283 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762049AbXGVJP0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:26 -0400
In-Reply-To: <11850957242656-git-send-email-len.brown@intel.com>
Message-Id: <5b7734b440d29dab583a6c3f0ee49ff20f323332.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   56 ++++++++++++++++------------------------------------
 1 files changed, 17 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 82f496c..5534b23 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -454,57 +454,35 @@ acpi_ec_space_setup(acpi_handle region_handle,
 }
 
 static acpi_status
-acpi_ec_space_handler(u32 function,
-		      acpi_physical_address address,
-		      u32 bit_width,
-		      acpi_integer * value,
+acpi_ec_space_handler(u32 function, acpi_physical_address address,
+		      u32 bits, acpi_integer *value,
 		      void *handler_context, void *region_context)
 {
-	int result = 0;
 	struct acpi_ec *ec = handler_context;
-	u64 temp = *value;
-	acpi_integer f_v = 0;
-	int i = 0;
+	int result = 0, i = 0;
+	u8 temp = 0;
 
 	if ((address > 0xFF) || !value || !handler_context)
 		return AE_BAD_PARAMETER;
 
-	if (bit_width != 8 && acpi_strict) {
+	if (function != ACPI_READ && function != ACPI_WRITE)
 		return AE_BAD_PARAMETER;
-	}
-
-      next_byte:
-	switch (function) {
-	case ACPI_READ:
-		temp = 0;
-		result = acpi_ec_read(ec, (u8) address, (u8 *) & temp);
-		break;
-	case ACPI_WRITE:
-		result = acpi_ec_write(ec, (u8) address, (u8) temp);
-		break;
-	default:
-		result = -EINVAL;
-		goto out;
-		break;
-	}
 
-	bit_width -= 8;
-	if (bit_width) {
-		if (function == ACPI_READ)
-			f_v |= temp << 8 * i;
-		if (function == ACPI_WRITE)
-			temp >>= 8;
-		i++;
-		address++;
-		goto next_byte;
-	}
+	if (bits != 8 && acpi_strict)
+		return AE_BAD_PARAMETER;
 
-	if (function == ACPI_READ) {
-		f_v |= temp << 8 * i;
-		*value = f_v;
+	while (bits - i > 0) {
+		if (function == ACPI_READ) {
+			result = acpi_ec_read(ec, address, &temp);
+			(*value) |= ((acpi_integer)temp) << i;
+		} else {
+			temp = 0xff & ((*value) >> i);
+			result = acpi_ec_write(ec, address, temp);
+		}
+		i += 8;
+		++address;
 	}
 
-      out:
 	switch (result) {
 	case -EINVAL:
 		return AE_BAD_PARAMETER;
-- 
1.5.3.rc2.22.g69a9b
