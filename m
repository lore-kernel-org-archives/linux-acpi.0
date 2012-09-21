From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCH] Thermal: Provide option to choose default thermal governor
Date: Fri, 21 Sep 2012 14:32:24 +0530
Message-ID: <1348218144-6845-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12182 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932195Ab2IUJD1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Sep 2012 05:03:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org, Durgadoss R <durgadoss.r@intel.com>

This patch provides option to choose the default thermal
governor. If no option is provided, the step_wise
governor is selected by default.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/Kconfig |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 040c626..c0e11aa 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -71,3 +71,36 @@ config USER_SPACE
 	depends on THERMAL
 	help
 	  Enable this to let the user space manage the platform thermals.
+
+choice
+	prompt "Default Thermal governor"
+	depends on THERMAL
+	default THERMAL_DEFAULT_GOV_STEP_WISE
+	help
+	  This option sets which thermal governor shall be loaded at
+	  startup. If in doubt, select 'step_wise'.
+
+config THERMAL_DEFAULT_GOV_STEP_WISE
+	bool "step_wise"
+	select STEP_WISE
+	help
+	  Use the step_wise governor as default. This throttles the
+	  devices one step at a time.
+
+config THERMAL_DEFAULT_GOV_FAIR_SHARE
+	bool "fair_share"
+	select FAIR_SHARE
+	help
+	  Use the fair_share governor as default. This throttles the
+	  devices based on their 'contribution' to a zone. The
+	  contribution should be provided through platform data.
+
+config THERMAL_DEFAULT_GOV_USER_SPACE
+	bool "user_space"
+	select USER_SPACE
+	help
+	  Select this if you want to let the user space manage the
+	  platform thermals.
+endchoice
+
+
-- 
1.7.9.5

