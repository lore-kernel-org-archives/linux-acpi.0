From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/13] ACPI/IPMI: Cleanup some initialization codes
Date: Tue, 23 Jul 2013 16:10:13 +0800
Message-ID: <9a0e5abf2ba5b9965867569e41574fda49826f16.1374566394.git.lv.zheng@intel.com>
References: <cover.1370652213.git.lv.zheng@intel.com> <cover.1374566394.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1374566394.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Corey Minyard <minyard@acm.org>, Zhao Yakui <yakui.zhao@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

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
index 7f93ffd..2d31003 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -128,6 +128,7 @@ static struct ipmi_driver_data driver_data = {
 	.ipmi_hndlrs = {
 		.ipmi_recv_hndl = ipmi_msg_handler,
 	},
+	.ipmi_lock = __MUTEX_INITIALIZER(driver_data.ipmi_lock)
 };
 
 static struct acpi_ipmi_device *
@@ -583,12 +584,10 @@ out_msg:
 
 static int __init acpi_ipmi_init(void)
 {
-	int result = 0;
+	int result;
 
 	if (acpi_disabled)
-		return result;
-
-	mutex_init(&driver_data.ipmi_lock);
+		return 0;
 
 	result = acpi_register_region(ACPI_ADR_SPACE_IPMI,
 				      &acpi_ipmi_space_handler,
-- 
1.7.10
