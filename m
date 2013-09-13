From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 09/12] ACPI/IPMI: Cleanup some initialization codes
Date: Fri, 13 Sep 2013 13:14:31 +0800
Message-ID: <b29f953d135445a7e9e1d55b9a285cabbdc2a79f.1379048860.git.lv.zheng@intel.com>
References: <cover.1370652213.git.lv.zheng@intel.com> <cover.1379048860.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59734 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694Ab3IMFOh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Sep 2013 01:14:37 -0400
In-Reply-To: <cover.1379048860.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Corey Minyard <minyard@acm.org>, Zhao Yakui <yakui.zhao@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net

This is a trivial patch.
1. Changes dynamic mutex initialization to static initialization.
2. Removes one acpi_ipmi_init() variable initialization as it is not
   needed.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Reviewed-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/acpi_ipmi.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index 90d57c8..f7b6598 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -127,6 +127,7 @@ static struct ipmi_driver_data driver_data = {
 	.ipmi_hndlrs = {
 		.ipmi_recv_hndl = ipmi_msg_handler,
 	},
+	.ipmi_lock = __MUTEX_INITIALIZER(driver_data.ipmi_lock)
 };
 
 static struct acpi_ipmi_device *
@@ -591,13 +592,11 @@ out_msg:
 
 static int __init acpi_ipmi_init(void)
 {
-	int result = 0;
+	int result;
 	acpi_status status;
 
 	if (acpi_disabled)
-		return result;
-
-	mutex_init(&driver_data.ipmi_lock);
+		return 0;
 
 	status = acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
 				ACPI_ADR_SPACE_IPMI, &acpi_ipmi_space_handler,
-- 
1.7.10

