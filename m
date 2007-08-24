From: Len Brown <len.brown@intel.com>
Subject: [PATCH 01/25] ACPI: thermal: clean up MODULE_PARM_DESC newlines
Date: Fri, 24 Aug 2007 03:20:48 -0400
Message-ID: <11879400762710-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8759 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762218AbXHXHVS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:18 -0400
In-Reply-To: <11879400723077-git-send-email-len.brown@intel.com>
Message-Id: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

Reported-by: Randy Dunlap <randy.dunlap@oracle.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 1e06159..9b31f36 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -77,23 +77,23 @@ MODULE_LICENSE("GPL");
 
 static int act;
 module_param(act, int, 0644);
-MODULE_PARM_DESC(act, "Disable or override all lowest active trip points.\n");
+MODULE_PARM_DESC(act, "Disable or override all lowest active trip points.");
 
 static int tzp;
 module_param(tzp, int, 0444);
-MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.\n");
+MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.");
 
 static int nocrt;
 module_param(nocrt, int, 0);
-MODULE_PARM_DESC(nocrt, "Set to disable action on ACPI thermal zone critical and hot trips.\n");
+MODULE_PARM_DESC(nocrt, "Set to disable action on ACPI thermal zone critical and hot trips.");
 
 static int off;
 module_param(off, int, 0);
-MODULE_PARM_DESC(off, "Set to disable ACPI thermal support.\n");
+MODULE_PARM_DESC(off, "Set to disable ACPI thermal support.");
 
 static int psv;
 module_param(psv, int, 0644);
-MODULE_PARM_DESC(psv, "Disable or override all passive trip points.\n");
+MODULE_PARM_DESC(psv, "Disable or override all passive trip points.");
 
 static int acpi_thermal_add(struct acpi_device *device);
 static int acpi_thermal_remove(struct acpi_device *device, int type);
-- 
1.5.3.rc6.17.g1911
