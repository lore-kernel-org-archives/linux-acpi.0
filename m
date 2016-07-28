From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] ACPI / button: remove pointer to old lid_sysfs on unbind
Date: Thu, 28 Jul 2016 12:19:27 +0200
Message-ID: <1469701167-24257-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54666 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753251AbcG1KTc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Jul 2016 06:19:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

When we removed the procfs dir on error or if the driver is
unbound, the two variables acpi_lid_dir and acpi_button_dir
were not reset. On the next rebind, those static variables
were not null and we couldn't re-register the device again.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/acpi/button.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 5c3b091..e413599 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -188,9 +188,11 @@ done:
 remove_dev_dir:
 	remove_proc_entry(acpi_device_bid(device),
 			  acpi_lid_dir);
+	acpi_lid_dir = NULL;
 	acpi_device_dir(device) = NULL;
 remove_lid_dir:
 	remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID, acpi_button_dir);
+	acpi_button_dir = NULL;
 remove_button_dir:
 	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
 	goto done;
@@ -207,8 +209,10 @@ static int acpi_button_remove_fs(struct acpi_device *device)
 			  acpi_device_dir(device));
 	remove_proc_entry(acpi_device_bid(device),
 			  acpi_lid_dir);
+	acpi_lid_dir = NULL;
 	acpi_device_dir(device) = NULL;
 	remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID, acpi_button_dir);
+	acpi_button_dir = NULL;
 	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
 
 	return 0;
-- 
2.5.5

