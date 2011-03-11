From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH] ACPI: Handle multiple button devices with the same name
Date: Fri, 11 Mar 2011 15:54:48 -0500
Message-ID: <1299876888-6239-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29506 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489Ab1CKUzh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Mar 2011 15:55:37 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, Matthew Garrett <mjg@redhat.com>

It's valid for ACPI to have multiple devices with the same name. It's not
valid for us to create multiple identical directories in /proc. Let's
put some effort into uniqueness.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/button.c |   41 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 76bbb78..747db93 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -161,10 +161,15 @@ static struct proc_dir_entry *acpi_power_dir;
 static struct proc_dir_entry *acpi_sleep_dir;
 static struct proc_dir_entry *acpi_lid_dir;
 
+static int acpi_power_buttons;
+static int acpi_sleep_buttons;
+static int acpi_lid_buttons;
+
 static int acpi_button_add_fs(struct acpi_device *device)
 {
 	struct acpi_button *button = acpi_driver_data(device);
 	struct proc_dir_entry *entry = NULL;
+	char name[10];
 
 	switch (button->type) {
 	case ACPI_BUTTON_TYPE_POWER:
@@ -190,7 +195,41 @@ static int acpi_button_add_fs(struct acpi_device *device)
 	if (!entry)
 		return -ENODEV;
 
-	acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device), entry);
+	switch (button->type) {
+	case ACPI_BUTTON_TYPE_POWER:
+		if (!acpi_power_buttons) {
+			acpi_device_dir(device) =
+				proc_mkdir(acpi_device_bid(device), entry);
+		} else {
+			snprintf(name, sizeof(name), "%s_%d",
+				 acpi_device_bid(device), acpi_power_buttons);
+			acpi_device_dir(device) = proc_mkdir(name, entry);
+		}
+		acpi_power_buttons++;
+		break;
+	case ACPI_BUTTON_TYPE_SLEEP:
+		if (!acpi_sleep_buttons) {
+			acpi_device_dir(device) =
+				proc_mkdir(acpi_device_bid(device), entry);
+		} else {
+			snprintf(name, sizeof(name), "%s_%d",
+				 acpi_device_bid(device), acpi_sleep_buttons);
+			acpi_device_dir(device) = proc_mkdir(name, entry);
+		}
+		acpi_sleep_buttons++;
+		break;
+	case ACPI_BUTTON_TYPE_LID:
+		if (!acpi_lid_buttons) {
+			acpi_device_dir(device) =
+				proc_mkdir(acpi_device_bid(device), entry);
+		} else {
+			snprintf(name, sizeof(name), "%s_%d",
+				 acpi_device_bid(device), acpi_lid_buttons);
+			acpi_device_dir(device) = proc_mkdir(name, entry);
+		}
+		acpi_lid_buttons++;
+		break;
+	}
 	if (!acpi_device_dir(device))
 		return -ENODEV;
 
-- 
1.7.4.1

