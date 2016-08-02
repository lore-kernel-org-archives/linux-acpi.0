From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0044/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:36:43 +0800
Message-ID: <20160802103643.16703-1-baolex.ni@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:49357 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754701AbcHBLPY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Aug 2016 07:15:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, x86@kernel.org, hpa@zytor.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, travis@sgi.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/acpi/dock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index e8e128d..b417560 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -41,7 +41,7 @@ MODULE_DESCRIPTION(ACPI_DOCK_DRIVER_DESCRIPTION);
 MODULE_LICENSE("GPL");
 
 static bool immediate_undock = 1;
-module_param(immediate_undock, bool, 0644);
+module_param(immediate_undock, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(immediate_undock, "1 (default) will cause the driver to "
 	"undock immediately when the undock button is pressed, 0 will cause"
 	" the driver to wait for userspace to write the undock sysfs file "
-- 
2.9.2

