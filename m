From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 06/12] ACPI: button: re-scan lid state on resume
Date: Sun, 05 Aug 2007 17:11:39 +0200
Message-ID: <1186326699.3858.29.camel@fanta4.site>
References: <11861804251625-git-send-email-len.brown@intel.com>
	 <6c77088daa419b0bba83b0ce162e2f25a1a5e131.1186180370.git.len.brown@intel.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42879 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865AbXHEPOo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 5 Aug 2007 11:14:44 -0400
In-Reply-To: <6c77088daa419b0bba83b0ce162e2f25a1a5e131.1186180370.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Richard Hughes <richard@hughsie.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

Hi Len,

Could have another look at linux-acpi thread:
[patch] Refresh lid state on resume
http://marc.info/?t=118467309200008&r=1&w=2

It came out that moving GPE activation before _WAK is called, fixes the
problem. Not sure whether this one should still be added. IMO we should
try with the real fix (moving GPEs before _WAK) first. If there are
still machines having the problem, adding this one can still be added at
later time, it's harmless.
The patch to activate GPEs before _WAK is this one, can you take it pls:
http://marc.info/?l=linux-acpi&m=118587857102639&w=2
or do you think it's too risky?

Thanks,

     Thomas

On Fri, 2007-08-03 at 18:33 -0400, Len Brown wrote:
> From: Richard Hughes <richard@hughsie.com>
> 
> On resume we need to refresh the lid status as we will not get an event if
> the lid opening was what triggered the suspend.
> This manifests itself in users never getting a "lid open" event when a
> suspend happens because of lid close on hardware that supports wake on
> lid open. This makes userspace gets very confused indeed.
> 
> Signed-off-by: Richard Hughes <richard@hughsie.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/acpi/button.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 5405813..b3c88aa 100644
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
> @@ -497,6 +499,29 @@ static int acpi_button_remove(struct acpi_device *device, int type)
>  	return 0;
>  }
>  
> +/* this is needed to learn about changes made in suspended state */
> +static int acpi_button_resume(struct acpi_device *device)
> +{
> +	struct acpi_button *button;
> +	struct acpi_handle *handle;
> +	struct input_dev *input;
> +	unsigned long state;
> +
> +	button = device->driver_data;
> +	handle = button->device->handle;
> +	input = button->input;
> +
> +	/*
> +	 * On resume we send the state; if it matches to what input layer
> +	 * thinks then the event will not even reach userspace.
> +	 */
> +	if (!ACPI_FAILURE(acpi_evaluate_integer(handle, "_LID",
> +						NULL, &state)))
> +		input_report_switch(input, SW_LID, !state);
> +
> +	return 0;
> +}
> +
>  static int __init acpi_button_init(void)
>  {
>  	int result;

