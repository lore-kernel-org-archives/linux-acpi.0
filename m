From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPI / button: Avoid using broken _LID on Surface tablet
Date: Mon, 15 Feb 2016 03:34:05 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BB4B97D@SHSMSX101.ccr.corp.intel.com>
References: <1454497460-16803-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44412 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbcBODeJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Feb 2016 22:34:09 -0500
In-Reply-To: <1454497460-16803-1-git-send-email-yu.c.chen@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "bugzilla@hadess.net" <bugzilla@hadess.net>, "cwhuang@android-x86.org" <cwhuang@android-x86.org>, "Chen, Yu C" <yu.c.chen@intel.com>

Hi, Yu

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Chen Yu
> Subject: [PATCH] ACPI / button: Avoid using broken _LID on Surface tablet
> 
[Lv Zheng] 
The word 'broken' is not proper.
This just seems like an indication of a Linux gap.
Possibly just:
1. losses of GPEs;
2. lacking in the correct init value of lid driver state; and
3. lacking in the sense of lid capability

> Some platforms such as Surface 3, Surface Pro 1 have broken _LID
[Lv Zheng] 
Ditto, 'broken' is not correct.

> that, either _LID returns 'closed' during bootup, or _LID fails
> to return the up-to-date lid state to OSPM. This is because
> that, on these platforms _LID is implemented by returning a
> local variable, which can only be updated by lid events:
> 
> Device (LID)
> {
> 	Name (LIDB, Zero)
> 	Method (_LID, 0, NotSerialized)
> 	{
> 		Return (LIDB)
> 	}
> }
> 
> Method (_E4C, 0, Serialized)
> {
> 	If ((HELD == One))
> 	{
> 		^^LID.LIDB = One
> 	}
> 	Else
> 	{
> 		^^LID.LIDB = Zero
> 		Notify (LID, 0x80)
> 	}
> }
> 
> After the lid is closed, _E4C updates the LIDB to zero, then system
> falls asleep, however when lid is opened, there would be no interrupt
> triggered due to hardware design, we have to wake the system up by
> pressing power button, as a result, LIDB remains zero after resumed,
> thus _LID returns 'close' to systemd daemon(or does not return any
> value to systemd), as a result the system suspends again even though
> we do nothing.
> 
> This patch is to provide a possible workaround for these broken
> platforms, by introducing a 'cached' lid state, which is not
> based on evaluating _LID, but based on maintaining the lid
> state in a event-driven manner:
> 
> 1. lid cache state is assigned to 'open' explicitly during boot up.
> 2. lid cache state can only be changed during suspend/resume, or someone
>    notifies the lid device.
> 3. always return lid cache state instead of _LID to sysfs.
[Lv Zheng] 
According to my understanding, returning _LID isn't wrong.

In fact, some platforms rely on this behavior.
I know for sure there is a platform:
1. Only generates LID open notification, and doesn't generate LID close notification; and
2. _LID return correct state as it includes several EC accesses to obtain correct hardware status.
Changing this behavior could break such platform while it is apparently working by returning _LID from sysfs.

OTOH, if BIOS lid state has been correctly updated according to the notification, _LID is ensured to be correct by BIOS.

So could you stop changing this behavior?
I can sense regressions around this change.

> 
> Linked: https://bugzilla.kernel.org/show_bug.cgi?id=89211
> Reported-and-tested-by: GiH <gih@maier.one>
> Reported-by: David J. Goehrig <dave@dloh.org>
> Reported-by: Stephen Just <stephenjust@gmail.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/acpi/button.c | 61
> ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 5c3b091..ec2a027 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -28,6 +28,7 @@
>  #include <linux/input.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> +#include <linux/dmi.h>
>  #include <acpi/button.h>
> 
>  #define PREFIX "ACPI: "
> @@ -53,6 +54,9 @@
>  #define ACPI_BUTTON_DEVICE_NAME_LID	"Lid Switch"
>  #define ACPI_BUTTON_TYPE_LID		0x05
> 
> +#define ACPI_LID_CACHE_OPEN			1
> +#define ACPI_LID_CACHE_CLOSE			0
> +
>  #define _COMPONENT		ACPI_BUTTON_COMPONENT
>  ACPI_MODULE_NAME("button");
> 
> @@ -101,8 +105,10 @@ struct acpi_button {
>  	char phys[32];			/* for input device */
>  	unsigned long pushed;
>  	bool suspended;
> +	unsigned long long cache_state;
>  };
> 
> +static int use_lid_cache_state;
>  static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
>  static struct acpi_device *lid_device;
> 
> @@ -118,8 +124,13 @@ static int acpi_button_state_seq_show(struct seq_file
> *seq, void *offset)
>  	struct acpi_device *device = seq->private;
>  	acpi_status status;
>  	unsigned long long state;
> +	struct acpi_button *button = acpi_driver_data(device);
> 
>  	status = acpi_evaluate_integer(device->handle, "_LID", NULL, &state);
> +
> +	if (use_lid_cache_state)
> +		state = button->cache_state;
> +
>  	seq_printf(seq, "state:      %s\n",
>  		   ACPI_FAILURE(status) ? "unsupported" :
>  			(state ? "open" : "closed"));
> @@ -233,15 +244,23 @@ int acpi_lid_open(void)
>  {
>  	acpi_status status;
>  	unsigned long long state;
> +	struct acpi_button *button;
> 
>  	if (!lid_device)
>  		return -ENODEV;
> 
> +	button = acpi_driver_data(lid_device);
> +	if (!button)
> +		return -ENODEV;
> +
>  	status = acpi_evaluate_integer(lid_device->handle, "_LID", NULL,
>  				       &state);
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
> 
> +	if (use_lid_cache_state)
> +		state = button->cache_state;
> +
>  	return !!state;
>  }
>  EXPORT_SYMBOL(acpi_lid_open);
> @@ -257,6 +276,9 @@ static int acpi_lid_send_state(struct acpi_device
> *device)
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
> 
> +	if (use_lid_cache_state)
> +		state = button->cache_state;
> +
>  	/* input layer checks if event is redundant */
>  	input_report_switch(button->input, SW_LID, !state);
>  	input_sync(button->input);
> @@ -290,6 +312,8 @@ static void acpi_button_notify(struct acpi_device
> *device, u32 event)
>  	case ACPI_BUTTON_NOTIFY_STATUS:
>  		input = button->input;
>  		if (button->type == ACPI_BUTTON_TYPE_LID) {
> +			if (use_lid_cache_state)
> +				button->cache_state = !button->cache_state;
>  			acpi_lid_send_state(device);
>  		} else {
>  			int keycode;
> @@ -325,6 +349,9 @@ static int acpi_button_suspend(struct device *dev)
>  	struct acpi_button *button = acpi_driver_data(device);
> 
>  	button->suspended = true;
> +	if (use_lid_cache_state)
> +		button->cache_state = ACPI_LID_CACHE_CLOSE;
> +
>  	return 0;
>  }
> 
> @@ -334,12 +361,41 @@ static int acpi_button_resume(struct device *dev)
>  	struct acpi_button *button = acpi_driver_data(device);
> 
>  	button->suspended = false;
> -	if (button->type == ACPI_BUTTON_TYPE_LID)
> +	if (button->type == ACPI_BUTTON_TYPE_LID) {
> +		if (use_lid_cache_state)
> +			button->cache_state = ACPI_LID_CACHE_OPEN;
>  		return acpi_lid_send_state(device);
> +	}
>  	return 0;
>  }
>  #endif
> 
> +static int switch_lid_mode(const struct dmi_system_id *d)
> +{
> +	use_lid_cache_state = 1;
> +	return 0;
> +}
> +
> +static struct dmi_system_id broken_lid_dmi_table[] = {
[Lv Zheng] 
'lid_dmi_table' could be better.
It is not a good idea to maintain quirks for 'broken' BIOS in the kernel source tree.
Quirks should be prepared by the kernel to work around issues that the kernel hasn't enough knowledge/isn't willing to handle.
For BIOS quirks, it is better to just provide boot parameters for the distribution vendors.

> +	{
> +	 .callback = switch_lid_mode,
> +	 .ident = "Surface Pro 1",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "Surface with Windows 8
> Pro"),
> +		},
> +	},
> +	{
> +	 .callback = switch_lid_mode,
> +	 .ident = "Surface 3",
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
> +		},
> +	},
> +	{}
> +};
> +
[Lv Zheng] 
They are all "connected standby" platforms.
And we can see there will be more and more such platforms manufactured from then on.
In order not to increase this quirk table unlimitedly, could you try to fix the 'GPE loss on s2i' issues for such kind of platforms?

Thanks and best regards
-Lv

>  static int acpi_button_add(struct acpi_device *device)
>  {
>  	struct acpi_button *button;
> @@ -380,6 +436,7 @@ static int acpi_button_add(struct acpi_device *device)
>  		strcpy(name, ACPI_BUTTON_DEVICE_NAME_LID);
>  		sprintf(class, "%s/%s",
>  			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
> +		dmi_check_system(broken_lid_dmi_table);
>  	} else {
>  		printk(KERN_ERR PREFIX "Unsupported hid [%s]\n", hid);
>  		error = -ENODEV;
> @@ -416,6 +473,8 @@ static int acpi_button_add(struct acpi_device *device)
>  	if (error)
>  		goto err_remove_fs;
>  	if (button->type == ACPI_BUTTON_TYPE_LID) {
> +		if (use_lid_cache_state)
> +			button->cache_state = ACPI_LID_CACHE_OPEN;
>  		acpi_lid_send_state(device);
>  		/*
>  		 * This assumes there's only one lid device, or if there are
> --
> 1.8.4.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
