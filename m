From: Richard Hughes <hughsient@gmail.com>
Subject: [patch] Reporting the lid status using INPUT
Date: Fri, 15 Jun 2007 14:12:59 +0100
Message-ID: <1181913179.21041.3.camel@work>
References: <1181910567.4819.7.camel@work>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-2qwsAoyiRPSMQphBIo6R"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.236]:47304 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210AbXFONOF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jun 2007 09:14:05 -0400
Received: by wx-out-0506.google.com with SMTP id t15so861607wxc
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jun 2007 06:14:04 -0700 (PDT)
In-Reply-To: <1181910567.4819.7.camel@work>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: a_bartok@freemail.hu, Bastien Nocera <hadess@hadess.net>, David Zeuthen <david@fubar.dk>


--=-2qwsAoyiRPSMQphBIo6R
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2007-06-15 at 13:29 +0100, Richard Hughes wrote:
> in response to an event, but I'm thinking in a resume hook we should
> probably do acpi_evaluate_integer(handle, "_LID", NULL, &state) and then
> send an event, just so userspace is aware of what the state of the panel
> is.

Attached patch fixed the issue for me. Comments?

Richard.


--=-2qwsAoyiRPSMQphBIo6R
Content-Disposition: attachment; filename=acpi-resume-lid-event.patch
Content-Type: text/x-patch; name=acpi-resume-lid-event.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index cb4110b..3631b8f 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -68,6 +68,7 @@ MODULE_LICENSE("GPL");
 
 static int acpi_button_add(struct acpi_device *device);
 static int acpi_button_remove(struct acpi_device *device, int type);
+static int acpi_button_resume(struct acpi_device *device);
 static int acpi_button_info_open_fs(struct inode *inode, struct file *file);
 static int acpi_button_state_open_fs(struct inode *inode, struct file *file);
 
@@ -77,6 +78,7 @@ static struct acpi_driver acpi_button_driver = {
 	.ids = "button_power,button_sleep,PNP0C0D,PNP0C0C,PNP0C0E",
 	.ops = {
 		.add = acpi_button_add,
+		.resume = acpi_button_resume,
 		.remove = acpi_button_remove,
 	},
 };
@@ -487,6 +489,27 @@ static int acpi_button_remove(struct acpi_device *device, int type)
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
+	/* on resume we send the state; it might be the same, but userspace
+	 * should handle duplicated events */
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

--=-2qwsAoyiRPSMQphBIo6R--

