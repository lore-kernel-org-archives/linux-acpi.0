From: Sven Wegener <sven.wegener@stealer.net>
Subject: Re: [PATCH] misc: Add dell-wmi driver for hotkey control
Date: Wed, 3 Dec 2008 22:17:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0812032149470.16637@titan.stealer.net>
References: <20081203195644.GC22560@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.stealer.net ([88.198.224.204]:36856 "EHLO
	smtp1.stealer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbYLCVRd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Dec 2008 16:17:33 -0500
In-Reply-To: <20081203195644.GC22560@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, greg@kroah.com

On Wed, 3 Dec 2008, Matthew Garrett wrote:

> Add a WMI driver for Dell laptops. Currently it does nothing but send a
> generic input event when a button with a picture of a battery on it is
> pressed, but maybe other uses will appear over time.

Some general notes below. I have no knowledge of the input layer, so I
can't verify the patch in terms of input layer correctness.

> [...]
> +void dell_wmi_notify(u32 value, void *context)

static

> +{
> +	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
> +	static struct key_entry *key;
> +	union acpi_object *obj;
> +
> +	wmi_get_event_data(value, &response);
> +
> +	obj = (union acpi_object *)response.pointer;
> +
> +	if (obj && obj->type == ACPI_TYPE_BUFFER) {
> +		int *buffer = (int *)obj->buffer.pointer;
> +		key = dell_wmi_get_entry_by_scancode(buffer[1]);
> +		if (key) {
> +			input_report_key(dell_wmi_input_dev, key->keycode, 1);
> +			input_sync(dell_wmi_input_dev);
> +			input_report_key(dell_wmi_input_dev, key->keycode, 0);
> +			input_sync(dell_wmi_input_dev);
> +		} else
> +			printk(KERN_INFO "dell-wmi: Unknown key %x pressed\n",
> +			       buffer[1]);
> +	}
> +	return;

No need to at the end of a function.

> +}
> +
> +static int __init dell_wmi_input_setup(void)
> +{
> +	struct key_entry *key;
> +	int err;
> +
> +	dell_wmi_input_dev = input_allocate_device();
> +
> +	dell_wmi_input_dev->name = "Dell WMI hotkeys";

Missing check for allocation failure.

> [...]
> +static int __init dell_wmi_init(void)
> +{
> +	int err;
> +
> +	if (wmi_has_guid(DELL_EVENT_GUID)) {
> +		err = wmi_install_notify_handler(DELL_EVENT_GUID,
> +						 dell_wmi_notify, NULL);
> +		if (!err)
> +			dell_wmi_input_setup();

Uhm, what if the notify handler gets called before the device has been set 
up? And looking at the function, the dell_wmi_input_setup() call can fail, 
which means you end up with invalid device handle.

Sven
