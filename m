From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/32] ACPICA: Remove a prototype for the reduced hardware case.
Date: Fri, 19 Jun 2015 11:39:21 +0800
Message-ID: <62415c63b2c3e0708dd0f223a9f5e6092b2ed134.1434684720.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4731 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753879AbbFSDjZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Jun 2015 23:39:25 -0400
In-Reply-To: <cover.1434684719.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 70f62a80d65515e1285fdeeb50d94ee6f07df4bd

Causes an error on some hosts.

Link: https://github.com/acpica/acpica/commit/70f62a80
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/hwxfsleep.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index 5601fed..c25fedb 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -50,10 +50,12 @@
 ACPI_MODULE_NAME("hwxfsleep")
 
 /* Local prototypes */
+#if (!ACPI_REDUCED_HARDWARE)
 static acpi_status
 acpi_hw_set_firmware_waking_vector(struct acpi_table_facs *facs,
 				   acpi_physical_address physical_address,
 				   acpi_physical_address physical_address64);
+#endif
 
 static acpi_status acpi_hw_sleep_dispatch(u8 sleep_state, u32 function_id);
 
-- 
1.7.10

