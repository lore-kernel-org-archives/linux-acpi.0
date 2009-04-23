From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/29] ACPI: button: remove unnecessary null pointer checks
Date: Thu, 23 Apr 2009 02:23:24 -0400
Message-ID: <e2fb9754d27513918a4936e8cbaad50ff56cfd3d.1240467664.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:45053 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbZDWGX6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:23:58 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ00DB9J3VSDA4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:23:56 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Better to oops and learn about a bug than to silently cover it up.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/button.c |   22 +---------------------
 1 files changed, 1 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 52eb06e..c463236 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -128,9 +128,6 @@ static int acpi_button_info_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_button *button = seq->private;
 
-	if (!button || !button->device)
-		return 0;
-
 	seq_printf(seq, "type:                    %s\n",
 		   acpi_device_name(button->device));
 	return 0;
@@ -147,9 +144,6 @@ static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
 	acpi_status status;
 	unsigned long long state;
 
-	if (!button || !button->device)
-		return 0;
-
 	status = acpi_evaluate_integer(button->device->handle, "_LID", NULL, &state);
 	seq_printf(seq, "state:      %s\n",
 		   ACPI_FAILURE(status) ? "unsupported" :
@@ -171,9 +165,6 @@ static int acpi_button_add_fs(struct acpi_device *device)
 	struct proc_dir_entry *entry = NULL;
 	struct acpi_button *button;
 
-	if (!device || !acpi_driver_data(device))
-		return -EINVAL;
-
 	button = acpi_driver_data(device);
 
 	switch (button->type) {
@@ -270,9 +261,6 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 	struct acpi_button *button = acpi_driver_data(device);
 	struct input_dev *input;
 
-	if (!button || !button->device)
-		return;
-
 	switch (event) {
 	case ACPI_FIXED_HARDWARE_EVENT:
 		event = ACPI_BUTTON_NOTIFY_STATUS;
@@ -305,10 +293,8 @@ static int acpi_button_resume(struct acpi_device *device)
 {
 	struct acpi_button *button;
 
-	if (!device)
-		return -EINVAL;
 	button = acpi_driver_data(device);
-	if (button && button->type == ACPI_BUTTON_TYPE_LID)
+	if (button->type == ACPI_BUTTON_TYPE_LID)
 		return acpi_lid_send_state(button);
 	return 0;
 }
@@ -319,9 +305,6 @@ static int acpi_button_add(struct acpi_device *device)
 	struct acpi_button *button;
 	struct input_dev *input;
 
-	if (!device)
-		return -EINVAL;
-
 	button = kzalloc(sizeof(struct acpi_button), GFP_KERNEL);
 	if (!button)
 		return -ENOMEM;
@@ -438,9 +421,6 @@ static int acpi_button_remove(struct acpi_device *device, int type)
 {
 	struct acpi_button *button;
 
-	if (!device || !acpi_driver_data(device))
-		return -EINVAL;
-
 	button = acpi_driver_data(device);
 
 	acpi_button_remove_fs(device);
-- 
1.6.0.6

