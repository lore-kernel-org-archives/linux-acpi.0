From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/11] ACPICA: FADT: Remove extraneous warning for very large GPE registers
Date: Fri, 12 Apr 2013 08:25:17 +0800
Message-ID: <e9be66fd432a2fc7218eb13537ffa6bef227be90.1365473142.git.lv.zheng@intel.com>
References: <cover.1364865215.git.lv.zheng@intel.com> <cover.1365473141.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50929 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355Ab3DLAZU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Apr 2013 20:25:20 -0400
In-Reply-To: <cover.1365473141.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Linn Crosetto <linn@hp.com>, Lv Zheng <lv.zheng@intel.com>

From: Linn Crosetto <linn@hp.com>

This change removes a size mismatch warning if the legacy
length field for a GPE register set is larger than the 64-bit
GAS structure can accomodate. GPE register sets can be larger
than the 255 bit limitation of the GAS structure. Linn Crosetto
(linn@hp.com).

Signed-off-by: Linn Crosetto <linn@hp.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbfadt.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 74181bf..33b00d2 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -559,8 +559,12 @@ static void acpi_tb_validate_fadt(void)
 		/*
 		 * For each extended field, check for length mismatch between the
 		 * legacy length field and the corresponding 64-bit X length field.
+		 * Note: If the legacy length field is > 0xFF bits, ignore this
+		 * check. (GPE registers can be larger than the 64-bit GAS structure
+		 * can accomodate, 0xFF bits).
 		 */
 		if (address64->address &&
+		    (ACPI_MUL_8(length) <= ACPI_UINT8_MAX) &&
 		    (address64->bit_width != ACPI_MUL_8(length))) {
 			ACPI_BIOS_WARNING((AE_INFO,
 					   "32/64X length mismatch in FADT/%s: %u/%u",
-- 
1.7.10

