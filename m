From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / scan: Add a scan handler for PRP0001
Date: Wed, 22 Apr 2015 03:54:16 +0200
Message-ID: <1816071.3jMa2RA6JD@vostro.rjw.lan>
References: <3444888.xxxTREorHY@vostro.rjw.lan> <4530573.vsU6fqTbSL@vostro.rjw.lan> <1915841.HSgUQOmSYM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62040 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756772AbbDVB3h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Apr 2015 21:29:37 -0400
In-Reply-To: <1915841.HSgUQOmSYM@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tuesday, April 14, 2015 03:03:33 PM Rafael J. Wysocki wrote:
> On Tuesday, April 14, 2015 01:50:11 PM Rafael J. Wysocki wrote:
> > On Monday, April 13, 2015 07:04:14 PM Darren Hart wrote:
> > > On Sat, Apr 11, 2015 at 01:28:45AM +0200, Rafael Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > 
> > > > If the special PRP0001 device ID is present in the given device's list
> > > > of ACPI/PNP IDs and the device has a valid "compatible" property in
> > > > the _DSD, it should be enumerated using the default mechanism,
> > > > unless some scan handlers match the IDs preceding PRP0001 in the
> > > > device's list of ACPI/PNP IDs.  In particular, no scan handlers
> > > > matching the IDs following PRP0001 in that list should be attached
> > > > to the device.
> > > > 
> > > > To make that happen, define a scan handler that will match PRP0001
> > > > and trigger the default enumeration for the matching devices if the
> > > > "compatible" property is present for them.
> > > > 
> > > > Since that requires the check for platform_id and device->handler
> > > > to be removed from acpi_default_enumeration(), move the fallback
> > > > invocation of acpi_default_enumeration() to acpi_bus_attach()
> > > > (after it's checked if there's a matching ACPI driver for the
> > > > device), which is a better place to call it, and do the platform_id
> > > > check in there too (device->handler is guaranteed to be unset at
> > > > the point where the function is looking for a matching ACPI driver).
> > > > 
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/acpi/scan.c |   34 +++++++++++++++++++++++++++++-----
> > > >  1 file changed, 29 insertions(+), 5 deletions(-)
> > > > 
> > > > Index: linux-pm/drivers/acpi/scan.c
> > > > ===================================================================
> > > > --- linux-pm.orig/drivers/acpi/scan.c
> > > > +++ linux-pm/drivers/acpi/scan.c
> > > > @@ -2390,9 +2390,6 @@ static void acpi_default_enumeration(str
> > > >  	struct list_head resource_list;
> > > >  	bool is_spi_i2c_slave = false;
> > > >  
> > > > -	if (!device->pnp.type.platform_id || device->handler)
> > > > -		return;
> > > > -
> > > >  	/*
> > > >  	 * Do not enemerate SPI/I2C slaves as they will be enuerated by their
> > > >  	 * respective parents.
> > > > @@ -2405,6 +2402,30 @@ static void acpi_default_enumeration(str
> > > >  		acpi_create_platform_device(device);
> > > >  }
> > > >  
> > > > +static const struct acpi_device_id generic_device_ids[] = {
> > > > +	{"PRP0001", },
> > > > +	{"", },
> > > > +};
> > > > +
> > > > +static int acpi_generic_device_attach(struct acpi_device *adev,
> > > > +				      const struct acpi_device_id *not_used)
> > > > +{
> > > > +	/*
> > > > +	 * Since PRP0001 is the only ID handled here, the test below can be
> > > > +	 * unconditional.
> > > > +	 */
> > > > +	if (adev->data.of_compatible) {
> > > > +		acpi_default_enumeration(adev);
> > > > +		return 1;
> > > > +	}
> > > 
> > > Would a warning be appropriate here? PRP0001 should only appear when paired with
> > > a DSD of GUID Device Properties with a "compatible" entry. If not, it's an
> > > error, correct? I believe we warn on similarly malformed AML?
> > 
> > We don't do that as a rule as there would be too many warnings that are not
> > really useful.  Users can't do much about those things at this stage (buggy
> > firmware has shipped already) and for the firmware people it is better to
> > cover things like that in firmware test suites (which in theory may help to
> > avoid shipping buggy firmware in the first place).
> > 
> > That said we print a warning in acpi_init_of_compatible() if things are not
> > consistent (which doesn't cover the case when _DSD is missing entirely, though),
> > so IMO it'd be better to refine that one instead of adding a new one which
> > wouldn't cover all cases too (eg. if PRP0001 is not the first ID in the list
> > and a previous one is matched to a different scan handler).
> 
> Maybe something like the patch below.

Any comments?

> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: ACPI / property: Refine consistency check for PRP0001
> 
> Refine the check for the presence of the "compatible" property
> if the PRP0001 device ID is present in the device's list of
> ACPI/PNP IDs to also print the message if _DSD is missing
> entirely or the format of it is incorrect.
> 
> While at it, reduce the log level of the message to "info"
> and reduce the log level of the "broken _DSD" message to
> "debug" (noise reduction).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/property.c |   50 ++++++++++++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> Index: linux-pm/drivers/acpi/property.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/property.c
> +++ linux-pm/drivers/acpi/property.c
> @@ -79,35 +79,15 @@ static bool acpi_properties_format_valid
>  static void acpi_init_of_compatible(struct acpi_device *adev)
>  {
>  	const union acpi_object *of_compatible;
> -	struct acpi_hardware_id *hwid;
> -	bool acpi_of = false;
>  	int ret;
>  
> -	/*
> -	 * Check if the special PRP0001 ACPI ID is present and in that
> -	 * case we fill in Device Tree compatible properties for this
> -	 * device.
> -	 */
> -	list_for_each_entry(hwid, &adev->pnp.ids, list) {
> -		if (!strcmp(hwid->id, "PRP0001")) {
> -			acpi_of = true;
> -			break;
> -		}
> -	}
> -
> -	if (!acpi_of)
> -		return;
> -
>  	ret = acpi_dev_get_property_array(adev, "compatible", ACPI_TYPE_STRING,
>  					  &of_compatible);
>  	if (ret) {
>  		ret = acpi_dev_get_property(adev, "compatible",
>  					    ACPI_TYPE_STRING, &of_compatible);
> -		if (ret) {
> -			acpi_handle_warn(adev->handle,
> -					 "PRP0001 requires compatible property\n");
> +		if (ret)
>  			return;
> -		}
>  	}
>  	adev->data.of_compatible = of_compatible;
>  }
> @@ -115,14 +95,27 @@ static void acpi_init_of_compatible(stru
>  void acpi_init_properties(struct acpi_device *adev)
>  {
>  	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
> +	bool acpi_of = false;
> +	struct acpi_hardware_id *hwid;
>  	const union acpi_object *desc;
>  	acpi_status status;
>  	int i;
>  
> +	/*
> +	 * Check if the special PRP0001 ACPI ID is present and in that case we
> +	 * fill in Device Tree compatible properties for this device.
> +	 */
> +	list_for_each_entry(hwid, &adev->pnp.ids, list) {
> +		if (!strcmp(hwid->id, "PRP0001")) {
> +			acpi_of = true;
> +			break;
> +		}
> +	}
> +
>  	status = acpi_evaluate_object_typed(adev->handle, "_DSD", NULL, &buf,
>  					    ACPI_TYPE_PACKAGE);
>  	if (ACPI_FAILURE(status))
> -		return;
> +		goto out;
>  
>  	desc = buf.pointer;
>  	if (desc->package.count % 2)
> @@ -156,13 +149,20 @@ void acpi_init_properties(struct acpi_de
>  		adev->data.pointer = buf.pointer;
>  		adev->data.properties = properties;
>  
> -		acpi_init_of_compatible(adev);
> -		return;
> +		if (acpi_of)
> +			acpi_init_of_compatible(adev);
> +
> +		goto out;
>  	}
>  
>   fail:
> -	dev_warn(&adev->dev, "Returned _DSD data is not valid, skipping\n");
> +	dev_dbg(&adev->dev, "Returned _DSD data is not valid, skipping\n");
>  	ACPI_FREE(buf.pointer);
> +
> + out:
> +	if (acpi_of && !adev->data.of_compatible)
> +		acpi_handle_info(adev->handle,
> +				 "PRP0001 requires 'compatible' property\n");
>  }
>  
>  void acpi_free_properties(struct acpi_device *adev)

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
