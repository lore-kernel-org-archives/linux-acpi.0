From: Len Brown <len.brown@intel.com>
Subject: [PATCH 20/77] ACPI: asus_acpi: Do not load if no device has been found
Date: Sun, 22 Jul 2007 05:14:05 -0400
Message-ID: <11850957232745-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51283 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762671AbXGVJPZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:25 -0400
In-Reply-To: <1185095721760-git-send-email-len.brown@intel.com>
Message-Id: <e4d49531dcc2f334205d99614164ea900216b1cb.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

asus_acpi_init() has a hack to prevent the driver from loading
when asus_hotk_add() fails.  However, it was returning the successful
return value of acpi_bug_registger_driver() on failure.  This caused
an oops on unload.  Instead it should return -ENODEV.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/asus_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
index 6d7d415..45360df 100644
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -1398,7 +1398,7 @@ static int __init asus_acpi_init(void)
 	if (!asus_hotk_found) {
 		acpi_bus_unregister_driver(&asus_hotk_driver);
 		remove_proc_entry(PROC_ASUS, acpi_root_dir);
-		return result;
+		return -ENODEV;
 	}
 
 	asus_backlight_device = backlight_device_register("asus",NULL,NULL,
-- 
1.5.3.rc2.22.g69a9b
