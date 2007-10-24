From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 10/12] ACPI: power: don't cache power resource state
Date: Wed, 24 Oct 2007 23:57:23 +0200
Message-ID: <200710242357.23344.rjw@sisk.pl>
References: <20071022101535.2937.79385.stgit@samsung> <20071022101909.2937.14958.stgit@samsung>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43715 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754984AbXJXV7X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Oct 2007 17:59:23 -0400
In-Reply-To: <20071022101909.2937.14958.stgit@samsung>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Monday, 22 October 2007 12:19, Alexey Starikovskiy wrote:
> ACPI may change power resource state behind our back, so don't
> keep our local copy, which may not be valid.
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/bus.c   |    6 ++---
>  drivers/acpi/power.c |   63 +++++++++++++++++++-------------------------------
>  2 files changed, 26 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index fb2cff9..fdee82d 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -198,11 +198,9 @@ int acpi_bus_set_power(acpi_handle handle, int state)
>  		return -ENODEV;
>  	}
>  	/*
> -	 * Get device's current power state if it's unknown
> -	 * This means device power state isn't initialized or previous setting failed
> +	 * Get device's current power state
>  	 */
> -	if ((device->power.state == ACPI_STATE_UNKNOWN) || device->flags.force_power_state)
> -		acpi_bus_get_power(device->handle, &device->power.state);
> +	acpi_bus_get_power(device->handle, &device->power.state);
>  	if ((state == device->power.state) && !device->flags.force_power_state) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device is already at D%d\n",
>  				  state));
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 57b9a29..af1769a 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -86,7 +86,6 @@ struct acpi_power_resource {
>  	acpi_bus_id name;
>  	u32 system_level;
>  	u32 order;
> -	int state;
>  	struct mutex resource_lock;
>  	struct list_head reference;
>  };
> @@ -128,33 +127,31 @@ acpi_power_get_context(acpi_handle handle,
>  	return 0;
>  }
>  
> -static int acpi_power_get_state(struct acpi_power_resource *resource)
> +static int acpi_power_get_state(struct acpi_power_resource *resource, int *state)
>  {
>  	acpi_status status = AE_OK;
>  	unsigned long sta = 0;
>  
>  
> -	if (!resource)
> +	if (!resource || !state)
>  		return -EINVAL;
>  
>  	status = acpi_evaluate_integer(resource->device->handle, "_STA", NULL, &sta);
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>  
> -	if (sta & 0x01)
> -		resource->state = ACPI_POWER_RESOURCE_STATE_ON;
> -	else
> -		resource->state = ACPI_POWER_RESOURCE_STATE_OFF;
> +	*state = (sta & 0x01)?ACPI_POWER_RESOURCE_STATE_ON:
> +			      ACPI_POWER_RESOURCE_STATE_OFF;
>  
>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] is %s\n",
> -			  resource->name, resource->state ? "on" : "off"));
> +			  resource->name, state ? "on" : "off"));
>  
>  	return 0;
>  }
>  
>  static int acpi_power_get_list_state(struct acpi_handle_list *list, int *state)
>  {
> -	int result = 0;
> +	int result = 0, state1;

This is a tiny bit inconsistent with the instances below where the local
variable is called "state" (ie. without the "1").  I'd just call the argument "state_p"
and the auxiliary variable "state".

>  	struct acpi_power_resource *resource = NULL;
>  	u32 i = 0;
>  
> @@ -168,11 +165,11 @@ static int acpi_power_get_list_state(struct acpi_handle_list *list, int *state)
>  		result = acpi_power_get_context(list->handles[i], &resource);
>  		if (result)
>  			return result;
> -		result = acpi_power_get_state(resource);
> +		result = acpi_power_get_state(resource, &state1);
>  		if (result)
>  			return result;
>  
> -		*state = resource->state;
> +		*state = state1;
>  
>  		if (*state != ACPI_POWER_RESOURCE_STATE_ON)
>  			break;
> @@ -186,7 +183,7 @@ static int acpi_power_get_list_state(struct acpi_handle_list *list, int *state)
>  
>  static int acpi_power_on(acpi_handle handle, struct acpi_device *dev)
>  {
> -	int result = 0;
> +	int result = 0, state;
>  	int found = 0;
>  	acpi_status status = AE_OK;
>  	struct acpi_power_resource *resource = NULL;
> @@ -224,20 +221,14 @@ static int acpi_power_on(acpi_handle handle, struct acpi_device *dev)
>  	}
>  	mutex_unlock(&resource->resource_lock);
>  
> -	if (resource->state == ACPI_POWER_RESOURCE_STATE_ON) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] already on\n",
> -				  resource->name));
> -		return 0;
> -	}
> -
>  	status = acpi_evaluate_object(resource->device->handle, "_ON", NULL, NULL);
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>  
> -	result = acpi_power_get_state(resource);
> +	result = acpi_power_get_state(resource, &state);
>  	if (result)
>  		return result;
> -	if (resource->state != ACPI_POWER_RESOURCE_STATE_ON)
> +	if (state != ACPI_POWER_RESOURCE_STATE_ON)
>  		return -ENOEXEC;
>  
>  	/* Update the power resource's _device_ power state */
> @@ -250,7 +241,7 @@ static int acpi_power_on(acpi_handle handle, struct acpi_device *dev)
>  
>  static int acpi_power_off_device(acpi_handle handle, struct acpi_device *dev)
>  {
> -	int result = 0;
> +	int result = 0, state;
>  	acpi_status status = AE_OK;
>  	struct acpi_power_resource *resource = NULL;
>  	struct list_head *node, *next;
> @@ -281,20 +272,14 @@ static int acpi_power_off_device(acpi_handle handle, struct acpi_device *dev)
>  	}
>  	mutex_unlock(&resource->resource_lock);
>  
> -	if (resource->state == ACPI_POWER_RESOURCE_STATE_OFF) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] already off\n",
> -				  resource->name));
> -		return 0;
> -	}
> -
>  	status = acpi_evaluate_object(resource->device->handle, "_OFF", NULL, NULL);
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>  
> -	result = acpi_power_get_state(resource);
> +	result = acpi_power_get_state(resource, &state);
>  	if (result)
>  		return result;
> -	if (resource->state != ACPI_POWER_RESOURCE_STATE_OFF)
> +	if (state != ACPI_POWER_RESOURCE_STATE_OFF)
>  		return -ENOEXEC;
>  
>  	/* Update the power resource's _device_ power state */
> @@ -494,7 +479,7 @@ static struct proc_dir_entry *acpi_power_dir;
>  static int acpi_power_seq_show(struct seq_file *seq, void *offset)
>  {
>  	int count = 0;
> -	int result = 0;
> +	int result = 0, state;
>  	struct acpi_power_resource *resource = NULL;
>  	struct list_head *node, *next;
>  	struct acpi_power_reference *ref;
> @@ -505,12 +490,12 @@ static int acpi_power_seq_show(struct seq_file *seq, void *offset)
>  	if (!resource)
>  		goto end;
>  
> -	result = acpi_power_get_state(resource);
> +	result = acpi_power_get_state(resource, &state);
>  	if (result)
>  		goto end;
>  
>  	seq_puts(seq, "state:                   ");
> -	switch (resource->state) {
> +	switch (state) {
>  	case ACPI_POWER_RESOURCE_STATE_ON:
>  		seq_puts(seq, "on\n");
>  		break;
> @@ -591,7 +576,7 @@ static int acpi_power_remove_fs(struct acpi_device *device)
>  
>  static int acpi_power_add(struct acpi_device *device)
>  {
> -	int result = 0;
> +	int result = 0, state;
>  	acpi_status status = AE_OK;
>  	struct acpi_power_resource *resource = NULL;
>  	union acpi_object acpi_object;
> @@ -622,11 +607,11 @@ static int acpi_power_add(struct acpi_device *device)
>  	resource->system_level = acpi_object.power_resource.system_level;
>  	resource->order = acpi_object.power_resource.resource_order;
>  
> -	result = acpi_power_get_state(resource);
> +	result = acpi_power_get_state(resource, &state);
>  	if (result)
>  		goto end;
>  
> -	switch (resource->state) {
> +	switch (state) {
>  	case ACPI_POWER_RESOURCE_STATE_ON:
>  		device->power.state = ACPI_STATE_D0;
>  		break;
> @@ -643,7 +628,7 @@ static int acpi_power_add(struct acpi_device *device)
>  		goto end;
>  
>  	printk(KERN_INFO PREFIX "%s [%s] (%s)\n", acpi_device_name(device),
> -	       acpi_device_bid(device), resource->state ? "on" : "off");
> +	       acpi_device_bid(device), state ? "on" : "off");
>  
>        end:
>  	if (result)
> @@ -680,7 +665,7 @@ static int acpi_power_remove(struct acpi_device *device, int type)
>  
>  static int acpi_power_resume(struct acpi_device *device)
>  {
> -	int result = 0;
> +	int result = 0, state;
>  	struct acpi_power_resource *resource = NULL;
>  	struct acpi_power_reference *ref;
>  
> @@ -689,12 +674,12 @@ static int acpi_power_resume(struct acpi_device *device)
>  
>  	resource = (struct acpi_power_resource *)acpi_driver_data(device);
>  
> -	result = acpi_power_get_state(resource);
> +	result = acpi_power_get_state(resource, &state);
>  	if (result)
>  		return result;
>  
>  	mutex_lock(&resource->resource_lock);
> -	if ((resource->state == ACPI_POWER_RESOURCE_STATE_OFF) &&
> +	if (state == ACPI_POWER_RESOURCE_STATE_OFF &&
>  	    !list_empty(&resource->reference)) {
>  		ref = container_of(resource->reference.next, struct acpi_power_reference, node);
>  		mutex_unlock(&resource->resource_lock);
> 
> 
> 

-- 
"Premature optimization is the root of all evil." - Donald Knuth
