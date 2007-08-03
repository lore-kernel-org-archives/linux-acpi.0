From: Len Brown <len.brown@intel.com>
Subject: [PATCH 06/12] ACPI: button: re-scan lid state on resume
Date: Fri,  3 Aug 2007 18:33:39 -0400
Message-ID: <11861804313089-git-send-email-len.brown@intel.com>
References: <11861804251625-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28479 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763755AbXHCWdw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Aug 2007 18:33:52 -0400
In-Reply-To: <11861804251625-git-send-email-len.brown@intel.com>
Message-Id: <6c77088daa419b0bba83b0ce162e2f25a1a5e131.1186180370.git.len.brown@intel.com>
In-Reply-To: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
References: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Richard Hughes <richard@hughsie.com>, Len Brown <len.brown@intel.com>

From: Richard Hughes <richard@hughsie.com>

On resume we need to refresh the lid status as we will not get an event if
the lid opening was what triggered the suspend.
This manifests itself in users never getting a "lid open" event when a
suspend happens because of lid close on hardware that supports wake on
lid open. This makes userspace gets very confused indeed.

Signed-off-by: Richard Hughes <richard@hughsie.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/button.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 5405813..b3c88aa 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -78,6 +78,7 @@ MODULE_DEVICE_TABLE(acpi, button_device_ids);
 
 static int acpi_button_add(struct acpi_device *device);
 static int acpi_button_remove(struct acpi_device *device, int type);
+static int acpi_button_resume(struct acpi_device *device);
 static int acpi_button_info_open_fs(struct inode *inode, struct file *file);
 static int acpi_button_state_open_fs(struct inode *inode, struct file *file);
 
@@ -87,6 +88,7 @@ static struct acpi_driver acpi_button_driver = {
 	.ids = button_device_ids,
 	.ops = {
 		.add = acpi_button_add,
+		.resume = acpi_button_resume,
 		.remove = acpi_button_remove,
 	},
 };
@@ -497,6 +499,29 @@ static int acpi_button_remove(struct acpi_device *device, int type)
 	return 0;
 }
 
+/* this is needed to learn about changes made in suspended state */
+static int acpi_button_resume(struct acpi_device *device)
+{
+	struct acpi_button *button;
+	struct acpi_handle *handle;
+	struct input_dev *input;
+	unsigned long state;
+
+	button = device->driver_data;
+	handle = button->device->handle;
+	input = button->input;
+
+	/*
+	 * On resume we send the state; if it matches to what input layer
+	 * thinks then the event will not even reach userspace.
+	 */
+	if (!ACPI_FAILURE(acpi_evaluate_integer(handle, "_LID",
+						NULL, &state)))
+		input_report_switch(input, SW_LID, !state);
+
+	return 0;
+}
+
 static int __init acpi_button_init(void)
 {
 	int result;
-- 
1.5.3.rc3.7.gd58e
