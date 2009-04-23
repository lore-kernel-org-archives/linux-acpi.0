From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/29] ACPI: button: use Linux style for getting driver_data
Date: Thu, 23 Apr 2009 02:23:25 -0400
Message-ID: <1bce81131c71064bc3163078f24545b839a31967.1240467664.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:54737 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754012AbZDWGYN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:24:13 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ00DLYJ3V6BF8@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:24:02 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

It's typical and slightly more compact to look up the driver_data
structure by initializing the automatic variable at its definition.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/button.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index c463236..8ef8f44 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -162,10 +162,8 @@ static struct proc_dir_entry *acpi_lid_dir;
 
 static int acpi_button_add_fs(struct acpi_device *device)
 {
+	struct acpi_button *button = acpi_driver_data(device);
 	struct proc_dir_entry *entry = NULL;
-	struct acpi_button *button;
-
-	button = acpi_driver_data(device);
 
 	switch (button->type) {
 	case ACPI_BUTTON_TYPE_POWER:
@@ -291,9 +289,8 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 
 static int acpi_button_resume(struct acpi_device *device)
 {
-	struct acpi_button *button;
+	struct acpi_button *button = acpi_driver_data(device);
 
-	button = acpi_driver_data(device);
 	if (button->type == ACPI_BUTTON_TYPE_LID)
 		return acpi_lid_send_state(button);
 	return 0;
@@ -301,9 +298,9 @@ static int acpi_button_resume(struct acpi_device *device)
 
 static int acpi_button_add(struct acpi_device *device)
 {
-	int error;
 	struct acpi_button *button;
 	struct input_dev *input;
+	int error;
 
 	button = kzalloc(sizeof(struct acpi_button), GFP_KERNEL);
 	if (!button)
@@ -419,9 +416,7 @@ static int acpi_button_add(struct acpi_device *device)
 
 static int acpi_button_remove(struct acpi_device *device, int type)
 {
-	struct acpi_button *button;
-
-	button = acpi_driver_data(device);
+	struct acpi_button *button = acpi_driver_data(device);
 
 	acpi_button_remove_fs(device);
 	input_unregister_device(button->input);
-- 
1.6.0.6

