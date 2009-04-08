From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/6] ACPI: button: remove unnecessary null pointer checks
Date: Wed, 08 Apr 2009 09:39:43 -0600
Message-ID: <20090408153943.12354.43191.stgit@bob.kio>
References: <20090408153427.12354.62167.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:29267 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933890AbZDHPjo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Apr 2009 11:39:44 -0400
In-Reply-To: <20090408153427.12354.62167.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Better to oops and learn about a bug than to silently cover it up.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
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

