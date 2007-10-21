From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: button: send initial lid state after add and resume
Date: Sun, 21 Oct 2007 13:48:53 +0200
Message-ID: <200710211348.53605.rjw@sisk.pl>
References: <20071021094426.5025.54274.stgit@samsung>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:56549 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437AbXJULdD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Oct 2007 07:33:03 -0400
In-Reply-To: <20071021094426.5025.54274.stgit@samsung>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Sunday, 21 October 2007 11:44, Alexey Starikovskiy wrote:
> Input layer should know about initial state of lid switch,
> even before first notify.
> 
> Reference: https://bugzilla.novell.com/show_bug.cgi?id=326814
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/button.c |   40 ++++++++++++++++++++++++++++++----------
>  1 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 301e832..16418c3 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -78,6 +78,7 @@ MODULE_DEVICE_TABLE(acpi, button_device_ids);
>  
>  static int acpi_button_add(struct acpi_device *device);
>  static int acpi_button_remove(struct acpi_device *device, int type);
> +static int acpi_button_resume(struct acpi_device *device);
>  static int acpi_button_info_open_fs(struct inode *inode, struct file *file);
>  static int acpi_button_state_open_fs(struct inode *inode, struct file *file);
>  
> @@ -87,6 +88,7 @@ static struct acpi_driver acpi_button_driver = {
>  	.ids = button_device_ids,
>  	.ops = {
>  		.add = acpi_button_add,
> +		.resume = acpi_button_resume,
>  		.remove = acpi_button_remove,
>  	},
>  };
> @@ -253,6 +255,23 @@ static int acpi_button_remove_fs(struct acpi_device *device)
>  /* --------------------------------------------------------------------------
>                                  Driver Interface
>     -------------------------------------------------------------------------- */
> +static int acpi_button_send_state(struct acpi_button *button)
> +{
> +	unsigned long state;
> +	acpi_status status;
> +
> +	if (!button)
> +		return -EINVAL;
> +	if (button->type != ACPI_BUTTON_TYPE_LID)
> +		return 0;

Well, it looks like this function only does anything for _LID, so I'd call it
acpi_lid_button_send_state() and probably the callers should do the above
checks (for clarity).

> +	status = acpi_evaluate_integer(button->device->handle, "_LID", NULL,
> +					&state);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +	/* input layer checks if event is redundant */
> +	input_report_switch(button->input, SW_LID, !state);
> +	return 0;
> +}
>  
>  static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
>  {
> @@ -265,16 +284,8 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
>  	switch (event) {
>  	case ACPI_BUTTON_NOTIFY_STATUS:
>  		input = button->input;
> -
> -		if (button->type == ACPI_BUTTON_TYPE_LID) {
> -			struct acpi_handle *handle = button->device->handle;
> -			unsigned long state;
> -
> -			if (!ACPI_FAILURE(acpi_evaluate_integer(handle, "_LID",
> -								NULL, &state)))
> -				input_report_switch(input, SW_LID, !state);
> -
> -		} else {
> +		acpi_button_send_state(button);
> +		if (button->type != ACPI_BUTTON_TYPE_LID) {

The type check is done here anyway, for example, and if button is NULL, it will
oops.

>  			int keycode = test_bit(KEY_SLEEP, input->keybit) ?
>  						KEY_SLEEP : KEY_POWER;
>  
> @@ -336,6 +347,13 @@ static int acpi_button_install_notify_handlers(struct acpi_button *button)
>  	return ACPI_FAILURE(status) ? -ENODEV : 0;
>  }
>  
> +static int acpi_button_resume(struct acpi_device *device)
> +{
> +	if (!device)
> +		return -EINVAL;
> +	return acpi_button_send_state(acpi_driver_data(device));
> +}
> +
>  static void acpi_button_remove_notify_handlers(struct acpi_button *button)
>  {
>  	switch (button->type) {
> @@ -454,6 +472,8 @@ static int acpi_button_add(struct acpi_device *device)
>  	if (error)
>  		goto err_remove_handlers;
>  
> +	acpi_button_send_state(button);
> +

Also, button cannot be NULL here.

>  	if (device->wakeup.flags.valid) {
>  		/* Button's GPE is run-wake GPE */
>  		acpi_set_gpe_type(device->wakeup.gpe_device,
> 

Greetings,
Rafael
