From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: acpi button event to input layer (was [RFC] [PATCH] Make ACPI button driver an input device)
Date: Wed, 6 Sep 2006 01:15:49 -0400
Message-ID: <200609060115.50348.dtor@insightbb.com>
References: <200608281506.50738.luming.yu@intel.com> <200608302257.25382.dtor@insightbb.com> <200609051615.56245.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Gml/E7fGKBqdMad"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway.insightbb.com ([74.128.0.19]:54176 "EHLO
	asav13.insightbb.com") by vger.kernel.org with ESMTP
	id S932161AbWIFFPy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Sep 2006 01:15:54 -0400
In-Reply-To: <200609051615.56245.luming.yu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yu Luming <luming.yu@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

--Boundary-00=_Gml/E7fGKBqdMad
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 05 September 2006 04:15, Yu Luming wrote:
> On Thursday 31 August 2006 10:57, Dmitry Torokhov wrote:
> > On Monday 28 August 2006 03:06, Yu Luming wrote:
> >  > Matthew / Dmitry,
> >  >
> >  > I recall there was a patch to make acpi button driver as input devic=
e.
> >  > Do you have any update patch? Because we want to transition acpi eve=
nt
> >  > mechanism from /proc/acpi/event to input layer. I guess the acpi but=
ton
> >  > driver would be the first one to complete such transition.
> >  >
> >  > http://www.gatago.com/linux/kernel/11320641.html
> >
> >  I sent the following patch to Len some time ago. It needs the attached
> > cleanup patch.
>=20
> Hi Dmitry,
>=20
> The patch doesn't apply. It is somehow changed by email client or server.
> And, I got :
> patching file drivers/acpi/button.c
> patch: **** malformed patch at line 4: =C2=A0#include <linux/types.h>
>=20
> Could you please send the patch as attachment to me.
>=20

Hi Luming,

Here they are, with 2 changes:

 - button module now depends on CONFIG_INPUT (per discussion with Len)
 - if "_LID" evaluation fails SW__LID event is not delivered to userspace

acpi-button-as-input is on top of acpi-button-cleanup...

=2D-=20
Dmitry

--Boundary-00=_Gml/E7fGKBqdMad
Content-Type: text/x-diff;
  charset="utf-8";
  name="acpi-button-as-input.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="acpi-button-as-input.patch"

Subject: ACPI: button - register with input layer

ACPI: button - register with input layer

In addition to signalling button/lid events through /proc/acpi/event
create separate input devices and report KEY_POWER, KEY_SLEEP and
SW_LID through input layer.

My sleep button autorepeat but userspace will have to filter duplicate
sleep requests anyway (and discard unprocessed events right after
wakeup).

Unlike /proc/acpi/event interface input device corresponding to LID
switch reports true lid state instead of just a counter. SW_LID is
active when lid is closed.

The driver now depends on CONFIG_INPUT.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/acpi/Kconfig  |    1 
 drivers/acpi/button.c |  170 ++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 124 insertions(+), 47 deletions(-)

Index: work/drivers/acpi/button.c
===================================================================
--- work.orig/drivers/acpi/button.c
+++ work/drivers/acpi/button.c
@@ -29,6 +29,7 @@
 #include <linux/types.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/input.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
@@ -83,7 +84,9 @@ static struct acpi_driver acpi_button_dr
 
 struct acpi_button {
 	struct acpi_device *device;	/* Fixed button kludge */
-	u8 type;
+	unsigned int type;
+	struct input_dev *input;
+	char phys[32];			/* for input device */
 	unsigned long pushed;
 };
 
@@ -245,12 +248,33 @@ static int acpi_button_remove_fs(struct 
 static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_button *button = data;
+	struct input_dev *input;
 
 	if (!button || !button->device)
 		return;
 
 	switch (event) {
 	case ACPI_BUTTON_NOTIFY_STATUS:
+		input = button->input;
+
+		if (button->type == ACPI_BUTTON_TYPE_LID) {
+			struct acpi_handle *handle = button->device->handle;
+			unsigned long state;
+
+			if (!ACPI_FAILURE(acpi_evaluate_integer(handle, "_LID",
+								NULL, &state)))
+				input_report_switch(input, SW_LID, !state);
+
+		} else {
+			int keycode = test_bit(KEY_SLEEP, input->keybit) ?
+						KEY_SLEEP : KEY_POWER;
+
+			input_report_key(input, keycode, 1);
+			input_sync(input);
+			input_report_key(input, keycode, 0);
+		}
+		input_sync(input);
+
 		acpi_bus_generate_event(button->device, event,
 					++button->pushed);
 		break;
@@ -275,11 +299,58 @@ static acpi_status acpi_button_notify_fi
 	return AE_OK;
 }
 
-static int acpi_button_add(struct acpi_device *device)
+static int acpi_button_install_notify_handlers(struct acpi_button *button)
 {
-	int result;
 	acpi_status status;
+
+	switch (button->type) {
+	case ACPI_BUTTON_TYPE_POWERF:
+		status =
+		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+						     acpi_button_notify_fixed,
+						     button);
+		break;
+	case ACPI_BUTTON_TYPE_SLEEPF:
+		status =
+		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+						     acpi_button_notify_fixed,
+						     button);
+		break;
+	default:
+		status = acpi_install_notify_handler(button->device->handle,
+						     ACPI_DEVICE_NOTIFY,
+						     acpi_button_notify,
+						     button);
+		break;
+	}
+
+	return ACPI_FAILURE(status) ? -ENODEV : 0;
+}
+
+static void acpi_button_remove_notify_handlers(struct acpi_button *button)
+{
+	switch (button->type) {
+	case ACPI_BUTTON_TYPE_POWERF:
+		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+						acpi_button_notify_fixed);
+		break;
+	case ACPI_BUTTON_TYPE_SLEEPF:
+		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+						acpi_button_notify_fixed);
+		break;
+	default:
+		acpi_remove_notify_handler(button->device->handle,
+					   ACPI_DEVICE_NOTIFY,
+					   acpi_button_notify);
+		break;
+	}
+}
+
+static int acpi_button_add(struct acpi_device *device)
+{
+	int error;
 	struct acpi_button *button;
+	struct input_dev *input;
 
 	if (!device)
 		return -EINVAL;
@@ -291,6 +362,12 @@ static int acpi_button_add(struct acpi_d
 	button->device = device;
 	acpi_driver_data(device) = button;
 
+	button->input = input = input_allocate_device();
+	if (!input) {
+		error = -ENOMEM;
+		goto err_free_button;
+	}
+
 	/*
 	 * Determine the button type (via hid), as fixed-feature buttons
 	 * need to be handled a bit differently than generic-space.
@@ -325,39 +402,48 @@ static int acpi_button_add(struct acpi_d
 	} else {
 		printk(KERN_ERR PREFIX "Unsupported hid [%s]\n",
 			    acpi_device_hid(device));
-		result = -ENODEV;
-		goto end;
+		error = -ENODEV;
+		goto err_free_input;
 	}
 
-	result = acpi_button_add_fs(device);
-	if (result)
-		goto end;
+	error = acpi_button_add_fs(device);
+	if (error)
+		goto err_free_input;
+
+	error = acpi_button_install_notify_handlers(button);
+	if (error)
+		goto err_remove_fs;
+
+	snprintf(button->phys, sizeof(button->phys),
+		 "%s/button/input0", acpi_device_hid(device));
+
+	input->name = acpi_device_name(device);
+	input->phys = button->phys;
+	input->id.bustype = BUS_HOST;
+	input->id.product = button->type;
 
 	switch (button->type) {
+	case ACPI_BUTTON_TYPE_POWER:
 	case ACPI_BUTTON_TYPE_POWERF:
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						     acpi_button_notify_fixed,
-						     button);
+		input->evbit[0] = BIT(EV_KEY);
+		set_bit(KEY_POWER, input->keybit);
 		break;
+
+	case ACPI_BUTTON_TYPE_SLEEP:
 	case ACPI_BUTTON_TYPE_SLEEPF:
-		status =
-		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						     acpi_button_notify_fixed,
-						     button);
+		input->evbit[0] = BIT(EV_KEY);
+		set_bit(KEY_SLEEP, input->keybit);
 		break;
-	default:
-		status = acpi_install_notify_handler(device->handle,
-						     ACPI_DEVICE_NOTIFY,
-						     acpi_button_notify,
-						     button);
+
+	case ACPI_BUTTON_TYPE_LID:
+		input->evbit[0] = BIT(EV_SW);
+		set_bit(SW_LID, input->swbit);
 		break;
 	}
 
-	if (ACPI_FAILURE(status)) {
-		result = -ENODEV;
-		goto end;
-	}
+	error = input_register_device(input);
+	if (error)
+		goto err_remove_handlers;
 
 	if (device->wakeup.flags.valid) {
 		/* Button's GPE is run-wake GPE */
@@ -372,13 +458,17 @@ static int acpi_button_add(struct acpi_d
 	printk(KERN_INFO PREFIX "%s [%s]\n",
 	       acpi_device_name(device), acpi_device_bid(device));
 
-      end:
-	if (result) {
-		acpi_button_remove_fs(device);
-		kfree(button);
-	}
+	return 0;
 
-	return result;
+ err_remove_handlers:
+	acpi_button_remove_notify_handlers(button);
+ err_remove_fs:
+	acpi_button_remove_fs(device);
+ err_free_input:
+	input_free_device(input);
+ err_free_button:
+	kfree(button);
+	return error;
 }
 
 static int acpi_button_remove(struct acpi_device *device, int type)
@@ -390,23 +480,9 @@ static int acpi_button_remove(struct acp
 
 	button = acpi_driver_data(device);
 
-	/* Unregister for device notifications. */
-	switch (button->type) {
-	case ACPI_BUTTON_TYPE_POWERF:
-		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						acpi_button_notify_fixed);
-		break;
-	case ACPI_BUTTON_TYPE_SLEEPF:
-		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						acpi_button_notify_fixed);
-		break;
-	default:
-		acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
-					   acpi_button_notify);
-		break;
-	}
-
+	acpi_button_remove_notify_handlers(button);
 	acpi_button_remove_fs(device);
+	input_unregister_device(button->input);
 	kfree(button);
 
 	return 0;
Index: work/drivers/acpi/Kconfig
===================================================================
--- work.orig/drivers/acpi/Kconfig
+++ work/drivers/acpi/Kconfig
@@ -97,6 +97,7 @@ config ACPI_BATTERY
 
 config ACPI_BUTTON
 	tristate "Button"
+	depends on INPUT
 	default y
 	help
 	  This driver handles events on the power, sleep and lid buttons.

--Boundary-00=_Gml/E7fGKBqdMad
Content-Type: text/x-diff;
  charset="utf-8";
  name="acpi-button-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="acpi-button-cleanup.patch"

Subject: ACPI: button - general cleanup

ACPI: button - general cleanup

Remove unnecessary casts and initializations, clean up formatting.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/acpi/button.c |   69 ++++++++++++++++----------------------------------
 1 files changed, 23 insertions(+), 46 deletions(-)

Index: work/drivers/acpi/button.c
===================================================================
--- work.orig/drivers/acpi/button.c
+++ work/drivers/acpi/button.c
@@ -62,7 +62,7 @@
 #define _COMPONENT		ACPI_BUTTON_COMPONENT
 ACPI_MODULE_NAME("acpi_button")
 
-    MODULE_AUTHOR("Paul Diefenbaugh");
+MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION(ACPI_BUTTON_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
@@ -78,7 +78,7 @@ static struct acpi_driver acpi_button_dr
 	.ops = {
 		.add = acpi_button_add,
 		.remove = acpi_button_remove,
-		},
+	},
 };
 
 struct acpi_button {
@@ -109,8 +109,7 @@ static struct proc_dir_entry *acpi_butto
 
 static int acpi_button_info_seq_show(struct seq_file *seq, void *offset)
 {
-	struct acpi_button *button = (struct acpi_button *)seq->private;
-
+	struct acpi_button *button = seq->private;
 
 	if (!button || !button->device)
 		return 0;
@@ -128,22 +127,17 @@ static int acpi_button_info_open_fs(stru
 
 static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
 {
-	struct acpi_button *button = (struct acpi_button *)seq->private;
+	struct acpi_button *button = seq->private;
 	acpi_status status;
 	unsigned long state;
 
-
 	if (!button || !button->device)
 		return 0;
 
 	status = acpi_evaluate_integer(button->device->handle, "_LID", NULL, &state);
-	if (ACPI_FAILURE(status)) {
-		seq_printf(seq, "state:      unsupported\n");
-	} else {
-		seq_printf(seq, "state:      %s\n",
-			   (state ? "open" : "closed"));
-	}
-
+	seq_printf(seq, "state:      %s\n",
+		   ACPI_FAILURE(status) ? "unsupported" :
+			(state ? "open" : "closed"));
 	return 0;
 }
 
@@ -159,8 +153,7 @@ static struct proc_dir_entry *acpi_lid_d
 static int acpi_button_add_fs(struct acpi_device *device)
 {
 	struct proc_dir_entry *entry = NULL;
-	struct acpi_button *button = NULL;
-
+	struct acpi_button *button;
 
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
@@ -228,10 +221,8 @@ static int acpi_button_add_fs(struct acp
 
 static int acpi_button_remove_fs(struct acpi_device *device)
 {
-	struct acpi_button *button = NULL;
-
+	struct acpi_button *button = acpi_driver_data(device);
 
-	button = acpi_driver_data(device);
 	if (acpi_device_dir(device)) {
 		if (button->type == ACPI_BUTTON_TYPE_LID)
 			remove_proc_entry(ACPI_BUTTON_FILE_STATE,
@@ -253,8 +244,7 @@ static int acpi_button_remove_fs(struct 
 
 static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_button *button = (struct acpi_button *)data;
-
+	struct acpi_button *button = data;
 
 	if (!button || !button->device)
 		return;
@@ -275,8 +265,7 @@ static void acpi_button_notify(acpi_hand
 
 static acpi_status acpi_button_notify_fixed(void *data)
 {
-	struct acpi_button *button = (struct acpi_button *)data;
-
+	struct acpi_button *button = data;
 
 	if (!button)
 		return AE_BAD_PARAMETER;
@@ -288,18 +277,16 @@ static acpi_status acpi_button_notify_fi
 
 static int acpi_button_add(struct acpi_device *device)
 {
-	int result = 0;
-	acpi_status status = AE_OK;
-	struct acpi_button *button = NULL;
-
+	int result;
+	acpi_status status;
+	struct acpi_button *button;
 
 	if (!device)
 		return -EINVAL;
 
-	button = kmalloc(sizeof(struct acpi_button), GFP_KERNEL);
+	button = kzalloc(sizeof(struct acpi_button), GFP_KERNEL);
 	if (!button)
 		return -ENOMEM;
-	memset(button, 0, sizeof(struct acpi_button));
 
 	button->device = device;
 	acpi_driver_data(device) = button;
@@ -396,9 +383,7 @@ static int acpi_button_add(struct acpi_d
 
 static int acpi_button_remove(struct acpi_device *device, int type)
 {
-	acpi_status status = 0;
-	struct acpi_button *button = NULL;
-
+	struct acpi_button *button;
 
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
@@ -408,24 +393,20 @@ static int acpi_button_remove(struct acp
 	/* Unregister for device notifications. */
 	switch (button->type) {
 	case ACPI_BUTTON_TYPE_POWERF:
-		status =
-		    acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
-						    acpi_button_notify_fixed);
+		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
+						acpi_button_notify_fixed);
 		break;
 	case ACPI_BUTTON_TYPE_SLEEPF:
-		status =
-		    acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
-						    acpi_button_notify_fixed);
+		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
+						acpi_button_notify_fixed);
 		break;
 	default:
-		status = acpi_remove_notify_handler(device->handle,
-						    ACPI_DEVICE_NOTIFY,
-						    acpi_button_notify);
+		acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+					   acpi_button_notify);
 		break;
 	}
 
 	acpi_button_remove_fs(device);
-
 	kfree(button);
 
 	return 0;
@@ -433,8 +414,7 @@ static int acpi_button_remove(struct acp
 
 static int __init acpi_button_init(void)
 {
-	int result = 0;
-
+	int result;
 
 	acpi_button_dir = proc_mkdir(ACPI_BUTTON_CLASS, acpi_root_dir);
 	if (!acpi_button_dir)
@@ -451,7 +431,6 @@ static int __init acpi_button_init(void)
 
 static void __exit acpi_button_exit(void)
 {
-
 	acpi_bus_unregister_driver(&acpi_button_driver);
 
 	if (acpi_power_dir)
@@ -461,8 +440,6 @@ static void __exit acpi_button_exit(void
 	if (acpi_lid_dir)
 		remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID, acpi_button_dir);
 	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
-
-	return;
 }
 
 module_init(acpi_button_init);

--Boundary-00=_Gml/E7fGKBqdMad--
