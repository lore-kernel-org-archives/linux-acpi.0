From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 3/6] ACPI: button: use Linux style for getting driver_data
Date: Wed, 08 Apr 2009 09:39:49 -0600
Message-ID: <20090408153948.12354.95163.stgit@bob.kio>
References: <20090408153427.12354.62167.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:29296 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933805AbZDHPjt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Apr 2009 11:39:49 -0400
In-Reply-To: <20090408153427.12354.62167.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

It's typical and slightly more compact to look up the driver_data
structure by initializing the automatic variable at its definition.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
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

