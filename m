From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 23/25] ACPICA: Hardware: back port of a recursive locking fix.
Date: Tue,  8 Jul 2014 10:08:19 +0800
Message-ID: <dd920b3a15dabbd1381cde9d9d2ac5c569ea1cc2.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11012 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753486AbaGHCIu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:08:50 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

This patch is a back port result of the following Linux commit:
 Commit: f7f71cfbf0c276ee3d8d856d0f35a41aed997fa4
 Author: Rakib Mullick <rakib.mullick@gmail.com>
 Subject: ACPI: Fix possible recursive locking in hwregs.c

As a result of different coding style rules, the back ported code generates
source code differences between the Linux kernel and the ACPICA upstream.
This patch reduces such source code differences.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/hwregs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index e0fd9b4..a4c34d2 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -278,8 +278,9 @@ acpi_status acpi_hw_clear_acpi_status(void)
 
 	acpi_os_release_lock(acpi_gbl_hardware_lock, lock_flags);
 
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)) {
 		goto exit;
+	}
 
 	/* Clear the GPE Bits in all GPE registers in all GPE blocks */
 
-- 
1.7.10

