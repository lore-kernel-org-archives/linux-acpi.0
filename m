From: Richard Hughes <hughsient@gmail.com>
Subject: Re: ACPI patches for 2.6.23-rc1
Date: Wed, 25 Jul 2007 10:49:44 +0100
Message-ID: <1185356984.2579.7.camel@work>
References: <11853426852588-git-send-email-len.brown@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-KOHXEFuk50TIOhm/DEPY"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.236]:15765 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756687AbXGYJy1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jul 2007 05:54:27 -0400
Received: by wx-out-0506.google.com with SMTP id h31so128282wxd
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jul 2007 02:54:26 -0700 (PDT)
In-Reply-To: <11853426852588-git-send-email-len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, "kay.sievers" <kay.sievers@vrfy.org>, Matthias Clasen <mclasen@redhat.com>, Zack Cerza <zcerza@redhat.com>


--=-KOHXEFuk50TIOhm/DEPY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2007-07-25 at 01:51 -0400, Len Brown wrote:
> I wish this batch did not miss the -rc1 deadline.
> Some of them must go into -rc2, bug some of them are
> probably bigger than should really go in post -rc1 --
> lets see how good a mood Linus is in tomorrow:-)

Len, the attached patch has been ignored two or three times now.
I've been getting about 2-3 duplicate bugs a week about this.

Please apply,

Richard.

From: Richard Hughes <richard@hughsie.com>
Date: Fri, 15 Jun 2007 15:53:11 +0100
Subject: No Subject
Message-Id: <1181919191.2681.5.camel@work>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On resume we need to refresh the lid status as we will not get an event if
the lid opening was what triggered the suspend.
This manifests itself in users never getting a "lid open" event when a
suspend happens because of lid close on hardware that supports wake on
lid open. This makes userspace gets very confused indeed.
Patch attached forces a check of the lid status in the resume handler.

Signed-off-by: Richard Hughes <richard@hughsie.com>
---

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index cb4110b..fd3473b 100644
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
@@ -487,6 +489,29 @@ static int acpi_button_remove(struct acpi_device *device, int type)
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


--=-KOHXEFuk50TIOhm/DEPY
Content-Disposition: attachment; filename=button-resume.patch
Content-Type: message/rfc822; name=button-resume.patch

From: Richard Hughes <richard@hughsie.com>
Date: Fri, 15 Jun 2007 15:53:11 +0100
Subject: No Subject
Message-Id: <1181919191.2681.5.camel@work>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On resume we need to refresh the lid status as we will not get an event if
the lid opening was what triggered the suspend.
This manifests itself in users never getting a "lid open" event when a
suspend happens because of lid close on hardware that supports wake on
lid open. This makes userspace gets very confused indeed.
Patch attached forces a check of the lid status in the resume handler.

Signed-off-by: Richard Hughes <richard@hughsie.com>
---

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index cb4110b..fd3473b 100644
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
@@ -487,6 +489,29 @@ static int acpi_button_remove(struct acpi_device *device, int type)
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

--=-KOHXEFuk50TIOhm/DEPY--

