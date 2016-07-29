From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2] ACPI / button: remove pointer to old lid_sysfs on unbind
Date: Fri, 29 Jul 2016 17:08:41 +0200
Message-ID: <1469804921-23086-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48906 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544AbcG2PIq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Jul 2016 11:08:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

When we removed the procfs dir on error or if the driver is
unbound, the two variables acpi_lid_dir and acpi_button_dir
were not reset. On the next rebind, those static variables
were not null and we couldn't re-register the device again.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

--
changes in v2:
- put the NULL assignments at their correct place
---
 drivers/acpi/button.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 5c3b091..a3873b3 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -191,8 +191,10 @@ remove_dev_dir:
 	acpi_device_dir(device) = NULL;
 remove_lid_dir:
 	remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID, acpi_button_dir);
+	acpi_lid_dir = NULL;
 remove_button_dir:
 	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
+	acpi_button_dir = NULL;
 	goto done;
 }
 
@@ -209,7 +211,9 @@ static int acpi_button_remove_fs(struct acpi_device *device)
 			  acpi_lid_dir);
 	acpi_device_dir(device) = NULL;
 	remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID, acpi_button_dir);
+	acpi_lid_dir = NULL;
 	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
+	acpi_button_dir = NULL;
 
 	return 0;
 }
-- 
2.5.5

