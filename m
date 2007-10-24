From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 11/12] ACPI: Fan: fan device does not need own structure
Date: Wed, 24 Oct 2007 23:52:42 +0200
Message-ID: <200710242352.43189.rjw@sisk.pl>
References: <20071022101535.2937.79385.stgit@samsung> <20071022101915.2937.5590.stgit@samsung>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43706 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753700AbXJXV7R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Oct 2007 17:59:17 -0400
In-Reply-To: <20071022101915.2937.5590.stgit@samsung>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Monday, 22 October 2007 12:19, Alexey Starikovskiy wrote:
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

>  drivers/acpi/fan.c |   32 +++++++-------------------------
>  1 files changed, 7 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> index c81f6bd..a6e149d 100644
> --- a/drivers/acpi/fan.c
> +++ b/drivers/acpi/fan.c
> @@ -68,10 +68,6 @@ static struct acpi_driver acpi_fan_driver = {
>  		},
>  };
>  
> -struct acpi_fan {
> -	struct acpi_device * device;
> -};
> -
>  /* --------------------------------------------------------------------------
>                                FS Interface (/proc)
>     -------------------------------------------------------------------------- */
> @@ -80,12 +76,12 @@ static struct proc_dir_entry *acpi_fan_dir;
>  
>  static int acpi_fan_read_state(struct seq_file *seq, void *offset)
>  {
> -	struct acpi_fan *fan = seq->private;
> +	struct acpi_device *device = seq->private;
>  	int state = 0;
>  
>  
> -	if (fan) {
> -		if (acpi_bus_get_power(fan->device->handle, &state))
> +	if (device) {
> +		if (acpi_bus_get_power(device->handle, &state))
>  			seq_printf(seq, "status:                  ERROR\n");
>  		else
>  			seq_printf(seq, "status:                  %s\n",
> @@ -105,11 +101,10 @@ acpi_fan_write_state(struct file *file, const char __user * buffer,
>  {
>  	int result = 0;
>  	struct seq_file *m = file->private_data;
> -	struct acpi_fan *fan = m->private;
> +	struct acpi_device *device = m->private;
>  	char state_string[12] = { '\0' };
>  
> -
> -	if (!fan || (count > sizeof(state_string) - 1))
> +	if (count > sizeof(state_string) - 1)
>  		return -EINVAL;
>  
>  	if (copy_from_user(state_string, buffer, count))
> @@ -117,7 +112,7 @@ acpi_fan_write_state(struct file *file, const char __user * buffer,
>  
>  	state_string[count] = '\0';
>  
> -	result = acpi_bus_set_power(fan->device->handle,
> +	result = acpi_bus_set_power(device->handle,
>  				    simple_strtoul(state_string, NULL, 0));
>  	if (result)
>  		return result;
> @@ -158,7 +153,7 @@ static int acpi_fan_add_fs(struct acpi_device *device)
>  		return -ENODEV;
>  	else {
>  		entry->proc_fops = &acpi_fan_state_ops;
> -		entry->data = acpi_driver_data(device);
> +		entry->data = device;
>  		entry->owner = THIS_MODULE;
>  	}
>  
> @@ -191,14 +186,8 @@ static int acpi_fan_add(struct acpi_device *device)
>  	if (!device)
>  		return -EINVAL;
>  
> -	fan = kzalloc(sizeof(struct acpi_fan), GFP_KERNEL);
> -	if (!fan)
> -		return -ENOMEM;
> -
> -	fan->device = device;
>  	strcpy(acpi_device_name(device), "Fan");
>  	strcpy(acpi_device_class(device), ACPI_FAN_CLASS);
> -	acpi_driver_data(device) = fan;
>  
>  	result = acpi_bus_get_power(device->handle, &state);
>  	if (result) {
> @@ -227,18 +216,11 @@ static int acpi_fan_add(struct acpi_device *device)
>  
>  static int acpi_fan_remove(struct acpi_device *device, int type)
>  {
> -	struct acpi_fan *fan = NULL;
> -
> -
>  	if (!device || !acpi_driver_data(device))
>  		return -EINVAL;
>  
> -	fan = acpi_driver_data(device);
> -
>  	acpi_fan_remove_fs(device);
>  
> -	kfree(fan);
> -
>  	return 0;
>  }
>  
> 
> 
> 

-- 
"Premature optimization is the root of all evil." - Donald Knuth
