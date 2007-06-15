From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [patch] Reporting the lid status using INPUT
Date: Fri, 15 Jun 2007 15:53:28 +0100
Message-ID: <1181919208.2681.6.camel@work>
References: <1181910567.4819.7.camel@work> <1181913179.21041.3.camel@work>
	 <d120d5000706150729i24763e00o7d2c48ef16960b2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-7TGIuZmkkPPhMJFtmkRr"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.227]:38886 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754371AbXFOOyg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jun 2007 10:54:36 -0400
Received: by wx-out-0506.google.com with SMTP id t15so889536wxc
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jun 2007 07:54:35 -0700 (PDT)
In-Reply-To: <d120d5000706150729i24763e00o7d2c48ef16960b2f@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, a_bartok@freemail.hu, Bastien Nocera <hadess@hadess.net>, David Zeuthen <david@fubar.dk>, linux-kernel <linux-kernel@vger.kernel.org>


--=-7TGIuZmkkPPhMJFtmkRr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2007-06-15 at 10:29 -0400, Dmitry Torokhov wrote:
> On 6/15/07, Richard Hughes <hughsient@gmail.com> wrote:
> > On Fri, 2007-06-15 at 13:29 +0100, Richard Hughes wrote:
> > > in response to an event, but I'm thinking in a resume hook we should
> > > probably do acpi_evaluate_integer(handle, "_LID", NULL, &state) and then
> > > send an event, just so userspace is aware of what the state of the panel
> > > is.
> >
> > Attached patch fixed the issue for me. Comments?
> >
> 
> The patch makes perfect sense. The only issue I have is this:
> 
> > +	/* on resume we send the state; it might be the same, but userspace
> > +	 * should handle duplicated events */
> 
> If switch state matches to what input layer thinks it is the event
> will not even reach userspace.

Okay, new patch attached, thanks for the speedy review.

Signed-off-by: Richard Hughes <richard@hughsie.com>


--=-7TGIuZmkkPPhMJFtmkRr
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

--=-7TGIuZmkkPPhMJFtmkRr--

