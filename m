From: Maxime Austruy <maxime@tralhalla.org>
Subject: [PATCH] asus_acpi: fix oops on non-asus machines
Date: Tue, 5 Jun 2007 08:31:32 -0700
Message-ID: <20070605153132.GA7184@tralhalla.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:59799 "EHLO
	rwcrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764929AbXFEPgf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jun 2007 11:36:35 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: corentincj@iksaif.net, sziwan@users.sourceforge.net


This change fixes an oops when rmmod'ing the asus_acpi module on
non-asus machine.  Inspection of the code nearby also unveiled a problem
in the error path of backlight_device_register, so this fixes it too. 

Signed-off-by: Maxime Austruy <maxime@tralhalla.org>
--
 drivers/acpi/asus_acpi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
index 6d7d415..3cd79ca 100644
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
@@ -1407,6 +1407,7 @@ static int __init asus_acpi_init(void)
 		printk(KERN_ERR "Could not register asus backlight device\n");
 		asus_backlight_device = NULL;
 		asus_acpi_exit();
+		return -ENODEV;
 	}
         asus_backlight_device->props.max_brightness = 15;
 
