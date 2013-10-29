From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/20] ACPICA: Hardcode access width for the reset register.
Date: Tue, 29 Oct 2013 09:29:45 +0800
Message-ID: <9ce8f8381fac027384a713f8566761ec9f59672a.1383009405.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17005 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755810Ab3J2B3y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Oct 2013 21:29:54 -0400
In-Reply-To: <cover.1383009405.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

The ACPI spec requires the reset register width to be 8, so we
now hardcode it and ignore the FADT value. This provides/maintains
compatibility with other ACPI implementations that have allowed
BIOS code with bad register width values to go unnoticed.
Matthew Garett, Bob Moore, Lv Zheng.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/hwxface.c |   10 ++++++++--
 include/acpi/actypes.h        |    1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index f81fb06..d3682c2 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -83,11 +83,17 @@ acpi_status acpi_reset(void)
 		 * For I/O space, write directly to the OSL. This bypasses the port
 		 * validation mechanism, which may block a valid write to the reset
 		 * register.
-		 * Spec section 4.7.3.6 requires register width to be 8.
+		 *
+		 * NOTE:
+		 * The ACPI spec requires the reset register width to be 8, so we
+		 * hardcode it here and ignore the FADT value. This maintains
+		 * compatibility with other ACPI implementations that have allowed
+		 * BIOS code with bad register width values to go unnoticed.
 		 */
 		status =
 		    acpi_os_write_port((acpi_io_address) reset_reg->address,
-				       acpi_gbl_FADT.reset_value, 8);
+				       acpi_gbl_FADT.reset_value,
+				       ACPI_RESET_REGISTER_WIDTH);
 	} else {
 		/* Write the reset value to the reset register */
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index fed5af2..63909d9 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -349,6 +349,7 @@ typedef u32 acpi_physical_address;
 #define ACPI_PM1_REGISTER_WIDTH         16
 #define ACPI_PM2_REGISTER_WIDTH         8
 #define ACPI_PM_TIMER_WIDTH             32
+#define ACPI_RESET_REGISTER_WIDTH       8
 
 /* Names within the namespace are 4 bytes long */
 
-- 
1.7.10

