From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI / button: add support for tablet mode switch
Date: Wed, 31 Aug 2016 16:01:22 +0800
Message-ID: <1472630482.2273.4.camel@intel.com>
References: <1472628817-3145-1-git-send-email-wnhuang@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22127 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753144AbcHaIBe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 Aug 2016 04:01:34 -0400
In-Reply-To: <1472628817-3145-1-git-send-email-wnhuang@google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wei-Ning Huang <wnhuang@chromium.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wei-Ning Huang <wnhuang@google.com>

On 三, 2016-08-31 at 15:33 +0800, Wei-Ning Huang wrote:
> From: Wei-Ning Huang <wnhuang@chromium.org>
> 
> ACPI PNP device HID 'PNP0C60' is a device that indicates tablet mode
> status. Add support for mapping this device to the SW_TABLET_MODE
> input
> event.
> 
> Signed-off-by: Wei-Ning Huang <wnhuang@chromium.org>
> ---
>  drivers/acpi/button.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 148f4e5..50e9de6 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -53,6 +53,11 @@
>  #define ACPI_BUTTON_DEVICE_NAME_LID	"Lid Switch"
>  #define ACPI_BUTTON_TYPE_LID		0x05
>  
> +#define ACPI_BUTTON_SUBCLASS_TABLET	"tablet"
> +#define ACPI_BUTTON_HID_TABLET		"PNP0C60"
> +#define ACPI_BUTTON_DEVICE_NAME_TABLET	"Tablet Mode Switch"
> +#define ACPI_BUTTON_TYPE_TABLET		0x07
> +
>  #define ACPI_BUTTON_LID_INIT_IGNORE	0x00
>  #define ACPI_BUTTON_LID_INIT_OPEN	0x01
>  #define ACPI_BUTTON_LID_INIT_METHOD	0x02
> @@ -70,6 +75,7 @@ static const struct acpi_device_id
> button_device_ids[] = {
>  	{ACPI_BUTTON_HID_SLEEPF, 0},
>  	{ACPI_BUTTON_HID_POWER,  0},
>  	{ACPI_BUTTON_HID_POWERF, 0},
> +	{ACPI_BUTTON_HID_TABLET, 0},
>  	{"", 0},
>  };
>  MODULE_DEVICE_TABLE(acpi, button_device_ids);
> @@ -305,6 +311,23 @@ static void acpi_lid_initialize_state(struct
> acpi_device *device)
>  	}
>  }
>  
> +static int acpi_tablet_send_state(struct acpi_device *device)
> +{
> +	struct acpi_button *button = acpi_driver_data(device);
> +	unsigned long long state;
> +	acpi_status status;
> +
> +	status = acpi_evaluate_integer(device->handle, "_TBL", NULL,
> &state);

Control methods with prefix "_" suggests this is an ACPI predefined
control method, but I can not find it in ACPI spec 6.1.
Can you illustrate me where I can find the definition of _TBL?

thanks,
rui
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	/* input layer checks if event is redundant */
> +	input_report_switch(button->input, SW_TABLET_MODE, state);
> +	input_sync(button->input);
> +
> +	return 0;
> +}
> +
>  static void acpi_button_notify(struct acpi_device *device, u32
> event)
>  {
>  	struct acpi_button *button = acpi_driver_data(device);
> @@ -318,6 +341,8 @@ static void acpi_button_notify(struct acpi_device
> *device, u32 event)
>  		input = button->input;
>  		if (button->type == ACPI_BUTTON_TYPE_LID) {
>  			acpi_lid_update_state(device);
> +		} else if (button->type == ACPI_BUTTON_TYPE_TABLET)
> {
> +			acpi_tablet_send_state(device);
>  		} else {
>  			int keycode;
>  
> @@ -407,6 +432,11 @@ static int acpi_button_add(struct acpi_device
> *device)
>  		strcpy(name, ACPI_BUTTON_DEVICE_NAME_LID);
>  		sprintf(class, "%s/%s",
>  			ACPI_BUTTON_CLASS,
> ACPI_BUTTON_SUBCLASS_LID);
> +	} else if (!strcmp(hid, ACPI_BUTTON_HID_TABLET)) {
> +		button->type = ACPI_BUTTON_TYPE_TABLET;
> +		strcpy(name, ACPI_BUTTON_DEVICE_NAME_TABLET);
> +		sprintf(class, "%s/%s",
> +			ACPI_BUTTON_CLASS,
> ACPI_BUTTON_SUBCLASS_TABLET);
>  	} else {
>  		printk(KERN_ERR PREFIX "Unsupported hid [%s]\n",
> hid);
>  		error = -ENODEV;
> @@ -437,6 +467,10 @@ static int acpi_button_add(struct acpi_device
> *device)
>  	case ACPI_BUTTON_TYPE_LID:
>  		input_set_capability(input, EV_SW, SW_LID);
>  		break;
> +
> +	case ACPI_BUTTON_TYPE_TABLET:
> +		input_set_capability(input, EV_SW, SW_TABLET_MODE);
> +		break;
>  	}
>  
>  	error = input_register_device(input);
> @@ -450,6 +484,8 @@ static int acpi_button_add(struct acpi_device
> *device)
>  		 */
>  		lid_device = device;
>  	}
> +	if (button->type == ACPI_BUTTON_TYPE_TABLET)
> +		acpi_tablet_send_state(device);
>  
>  	printk(KERN_INFO PREFIX "%s [%s]\n", name,
> acpi_device_bid(device));
>  	return 0;
