From: Len Brown <len.brown@intel.com>
Subject: [PATCH 05/12] ACPI: thinkpad-acpi: fix the module init failure path
Date: Fri,  3 Aug 2007 18:33:38 -0400
Message-ID: <11861804303949-git-send-email-len.brown@intel.com>
References: <11861804251625-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28479 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763697AbXHCWdv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Aug 2007 18:33:51 -0400
In-Reply-To: <11861804251625-git-send-email-len.brown@intel.com>
Message-Id: <ac36393de6034be7266264a435360e7628849005.1186180370.git.len.brown@intel.com>
In-Reply-To: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
References: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Thomas Renninger reports that if one tries to load thinkpad-acpi in a
non-thinkpad, one gets:

Call Trace:
 [<ffffffff802fa57d>] kref_get+0x2f/0x36
 [<ffffffff802f97f7>] kobject_get+0x12/0x17
 [<ffffffff8036dfd7>] get_driver+0x14/0x1a
 [<ffffffff8036dfee>] driver_remove_file+0x11/0x32
 [<ffffffff8823b9be>] :thinkpad_acpi:thinkpad_acpi_module_exit+0xa8/0xfc
 [<ffffffff8824b8a0>] :thinkpad_acpi:thinkpad_acpi_module_init+0x74a/0x776
 [<ffffffff8024f968>] __link_module+0x0/0x25
 [<ffffffff80252269>] sys_init_module+0x162c/0x178f
 [<ffffffff8020bc2e>] system_call+0x7e/0x83

So, track if the platform driver and its driver attributes were registered,
and only deallocate them in that case.

This patch is based on Thomas Renninger's patch for the issue.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Acked-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   10 ++++++++--
 drivers/misc/thinkpad_acpi.h |    2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index fa80f35..f6cd34a 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -4668,12 +4668,15 @@ static int __init thinkpad_acpi_module_init(void)
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
+	tp_features.platform_drv_registered = 1;
+
 	ret = tpacpi_create_driver_attributes(&tpacpi_pdriver.driver);
 	if (ret) {
 		printk(IBM_ERR "unable to create sysfs driver attributes\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
+	tp_features.platform_drv_attrs_registered = 1;
 
 
 	/* Device initialization */
@@ -4756,8 +4759,11 @@ static void thinkpad_acpi_module_exit(void)
 	if (tpacpi_pdev)
 		platform_device_unregister(tpacpi_pdev);
 
-	tpacpi_remove_driver_attributes(&tpacpi_pdriver.driver);
-	platform_driver_unregister(&tpacpi_pdriver);
+	if (tp_features.platform_drv_attrs_registered)
+		tpacpi_remove_driver_attributes(&tpacpi_pdriver.driver);
+
+	if (tp_features.platform_drv_registered)
+		platform_driver_unregister(&tpacpi_pdriver);
 
 	if (proc_dir)
 		remove_proc_entry(IBM_PROC_DIR, acpi_root_dir);
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 88af089..eee8809 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -246,6 +246,8 @@ static struct {
 	u16 wan:1;
 	u16 fan_ctrl_status_undef:1;
 	u16 input_device_registered:1;
+	u16 platform_drv_registered:1;
+	u16 platform_drv_attrs_registered:1;
 } tp_features;
 
 struct thinkpad_id_data {
-- 
1.5.3.rc3.7.gd58e
