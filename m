From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: [PATCH 1/4] ACPI / EC: Cleanup first_ec/boot_ec code
Date: Tue, 6 Sep 2016 11:35:36 +0200
Message-ID: <20160906093536.GA5696@al>
References: <cover.1472802172.git.lv.zheng@intel.com>
 <329458b814b546daf26e058d303729fdc936730f.1472802172.git.lv.zheng@intel.com>
 <20160903162142.GA5252@al>
 <1AE640813FDE7649BE1B193DEA596E886A17F533@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:47252 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933143AbcIFJft (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Sep 2016 05:35:49 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886A17F533@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Luya Tshimbalanga <luya@fedoraproject.org>

On Mon, Sep 05, 2016 at 05:57:47AM +0000, Zheng, Lv wrote:
> Hi, Peter
> 
> > From: Peter Wu [mailto:peter@lekensteyn.nl]
> > Subject: Re: [PATCH 1/4] ACPI / EC: Cleanup first_ec/boot_ec code
> > 
> > On Fri, Sep 02, 2016 at 03:46:31PM +0800, Lv Zheng wrote:
> > > In order to support full ECDT (driving the ECDT EC after probing the
> > > namespace EC), we need to change our EC device alloc/free algorithm, ensure
> > > not to free old boot EC before qualifying new boot EC.
> > > This patch achieves this by cleaning up first_ec/boot_ec logic:
> > > 1. first_ec: used to perform transactions, so it is assigned in new
> > >    acpi_ec_setup() function.
> > > 2. boot_ec: used to track early EC device, so it is assigned in new
> > >    acpi_config_boot_ec() function which explictly tells the driver to save
> > >    the EC device as early EC device.
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=115021
> > > Reported-and-tested-by: Luya Tshimbalanga <luya@fedoraproject.org>
> > > Suggested-by: Peter Wu <peter@lekensteyn.nl>
> > > Cc: Peter Wu <peter@lekensteyn.nl>
> > > Cc: Luya Tshimbalanga <luya@fedoraproject.org>
> > > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > 
> > Good idea, the previous acpi_ec_alloc function contained an implicit
> > assumption which was slightly harder to follow. See below for one
> > concern.
> > 
> > > ---
> > >  drivers/acpi/ec.c |   96 +++++++++++++++++++++++++++++++++++------------------
> > >  1 file changed, 63 insertions(+), 33 deletions(-)
> > >
> > > diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> > > index e7bd57c..4a5f3ab 100644
> > > --- a/drivers/acpi/ec.c
> > > +++ b/drivers/acpi/ec.c
> > > @@ -179,6 +179,7 @@ static void acpi_ec_event_processor(struct work_struct *work);
> > >
> > >  struct acpi_ec *boot_ec, *first_ec;
> > >  EXPORT_SYMBOL(first_ec);
> > > +static bool boot_ec_is_ecdt = false;
> > >  static struct workqueue_struct *ec_query_wq;
> > >
> > >  static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs acpi_ec_clear() on boot/resume */
> > > @@ -1228,7 +1229,16 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
> > >  static acpi_status
> > >  ec_parse_io_ports(struct acpi_resource *resource, void *context);
> > >
> > > -static struct acpi_ec *make_acpi_ec(void)
> > > +static void acpi_ec_free(struct acpi_ec *ec)
> > > +{
> > > +	if (first_ec == ec)
> > > +		first_ec = NULL;
> > > +	if (boot_ec == ec)
> > > +		boot_ec = NULL;
> > > +	kfree(ec);
> > > +}
> > > +
> > > +static struct acpi_ec *acpi_ec_alloc(void)
> > >  {
> > >  	struct acpi_ec *ec = kzalloc(sizeof(struct acpi_ec), GFP_KERNEL);
> > >
> > > @@ -1290,6 +1300,11 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
> > >  	return AE_CTRL_TERMINATE;
> > >  }
> > >
> > > +/*
> > > + * Note: This function returns an error code only when the address space
> > > + *       handler is not installed, which means "not able to handle
> > > + *       transactions".
> > > + */
> > >  static int ec_install_handlers(struct acpi_ec *ec)
> > >  {
> > >  	acpi_status status;
> > > @@ -1365,21 +1380,49 @@ static void ec_remove_handlers(struct acpi_ec *ec)
> > >  	}
> > >  }
> > >
> > > -static struct acpi_ec *acpi_ec_alloc(void)
> > > +static int acpi_ec_setup(struct acpi_ec *ec)
> > >  {
> > > -	struct acpi_ec *ec;
> > > +	int ret;
> > >
> > > -	/* Check for boot EC */
> > > -	if (boot_ec) {
> > > -		ec = boot_ec;
> > > -		boot_ec = NULL;
> > > -		ec_remove_handlers(ec);
> > > -		if (first_ec == ec)
> > > -			first_ec = NULL;
> > > -	} else {
> > > -		ec = make_acpi_ec();
> > > +	ret = ec_install_handlers(ec);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* First EC capable of handling transactions */
> > > +	if (!first_ec) {
> > > +		first_ec = ec;
> > > +		acpi_handle_info(first_ec->handle, "Used as first EC\n");
> > >  	}
> > > -	return ec;
> > > +
> > > +	acpi_handle_info(ec->handle,
> > > +			 "GPE=0x%lx, EC_CMD/EC_SC=0x%lx, EC_DATA=0x%lx\n",
> > > +			 ec->gpe, ec->command_addr, ec->data_addr);
> > > +	return ret;
> > > +}
> > > +
> > > +static int acpi_config_boot_ec(struct acpi_ec *ec, bool is_ecdt)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (boot_ec)
> > > +		ec_remove_handlers(boot_ec);
> > > +
> > > +	/* Unset old boot EC */
> > > +	if (boot_ec != ec)
> > > +		acpi_ec_free(boot_ec);
> > > +
> > > +	ret = acpi_ec_setup(ec);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Set new boot EC */
> > > +	if (!boot_ec) {
> > > +		boot_ec = ec;
> > > +		boot_ec_is_ecdt = is_ecdt;
> > > +		acpi_handle_info(boot_ec->handle, "Used as boot %s EC\n",
> > > +				 is_ecdt ? "ECDT" : "DSDT");
> > > +	}
> > > +	return ret;
> > >  }
> > >
> > >  static int acpi_ec_add(struct acpi_device *device)
> > > @@ -1395,7 +1438,7 @@ static int acpi_ec_add(struct acpi_device *device)
> > >  		return -ENOMEM;
> > >  	if (ec_parse_device(device->handle, 0, ec, NULL) !=
> > >  		AE_CTRL_TERMINATE) {
> > > -			kfree(ec);
> > > +			acpi_ec_free(ec);
> > >  			return -EINVAL;
> > >  	}
> > >
> > > @@ -1403,8 +1446,6 @@ static int acpi_ec_add(struct acpi_device *device)
> > >  	acpi_walk_namespace(ACPI_TYPE_METHOD, ec->handle, 1,
> > >  			    acpi_ec_register_query_methods, NULL, ec, NULL);
> > >
> > > -	if (!first_ec)
> > > -		first_ec = ec;
> > >  	device->driver_data = ec;
> > >
> > >  	ret = !!request_region(ec->data_addr, 1, "EC data");
> > > @@ -1412,10 +1453,7 @@ static int acpi_ec_add(struct acpi_device *device)
> > >  	ret = !!request_region(ec->command_addr, 1, "EC cmd");
> > >  	WARN(!ret, "Could not request EC cmd io port 0x%lx", ec->command_addr);
> > >
> > > -	pr_info("GPE = 0x%lx, I/O: command/status = 0x%lx, data = 0x%lx\n",
> > > -			  ec->gpe, ec->command_addr, ec->data_addr);
> > > -
> > > -	ret = ec_install_handlers(ec);
> > > +	ret = acpi_config_boot_ec(ec, false);
> > >
> > >  	/* Reprobe devices depending on the EC */
> > >  	acpi_walk_dep_device_list(ec->handle);
> > > @@ -1442,9 +1480,7 @@ static int acpi_ec_remove(struct acpi_device *device)
> > >  	release_region(ec->data_addr, 1);
> > >  	release_region(ec->command_addr, 1);
> > >  	device->driver_data = NULL;
> > > -	if (ec == first_ec)
> > > -		first_ec = NULL;
> > > -	kfree(ec);
> > > +	acpi_ec_free(ec);
> > >  	return 0;
> > >  }
> > >
> > > @@ -1496,13 +1532,10 @@ int __init acpi_ec_dsdt_probe(void)
> > >  		ret = -ENODEV;
> > >  		goto error;
> > >  	}
> > > -	ret = ec_install_handlers(ec);
> > > -
> > > +	ret = acpi_config_boot_ec(ec, false);
> > >  error:
> > >  	if (ret)
> > > -		kfree(ec);
> > > -	else
> > > -		first_ec = boot_ec = ec;
> > > +		acpi_ec_free(ec);
> > >  	return ret;
> > >  }
> > >
> > > @@ -1600,7 +1633,6 @@ int __init acpi_ec_ecdt_probe(void)
> > >  		goto error;
> > >  	}
> > >
> > > -	pr_info("EC description table is found, configuring boot EC\n");
> > >  	if (EC_FLAGS_CORRECT_ECDT) {
> > >  		ec->command_addr = ecdt_ptr->data.address;
> > >  		ec->data_addr = ecdt_ptr->control.address;
> > > @@ -1610,12 +1642,10 @@ int __init acpi_ec_ecdt_probe(void)
> > >  	}
> > >  	ec->gpe = ecdt_ptr->gpe;
> > >  	ec->handle = ACPI_ROOT_OBJECT;
> > > -	ret = ec_install_handlers(ec);
> > > +	ret = acpi_config_boot_ec(ec, true);
> > 
> > acpi_ec_ecdt_probe is called very early, so boot_ec, etc. are NULL and
> > it will invoke acpi_ec_setup. This calls acpi_ec_start, but since no GPE
> > handler is yet registered, it will have no effect. Next it will try to
> > register an address space handler, given the root handle. Does this
> > work?
> > 
> > There is no \_REG method, so I would have expected "Fail in evaluating
> > the _REG object of EC device. Broken bios is suspected", but this
> > message was not shown (perhaps it returned AE_BAD_PARAMETER or
> > something?).
> > 
> > Assuming that the handler registration failed (AE_BAD_PARAMETER), then
> > acpi_config_boot_ec will have no effect. If it actually did register a
> > handler, I would expect messages like "\: Used as boot ECDT to handle
> > transactions" which is a bit strange.
> 
> Your ECDT understanding is very different from mine.
> I actually think there is an "early operation region" concept in ACPI.
> The early operation region can be accessed during the table loading.
> It means:
> If (SREG == One)
> {
> 	Name(OBJ1, One)
> }
> Can be executed during the table loading.
> This brought a great convenience to the BIOS configurable options.
> 
> So what kind of operation regions can be accessed during the table loading?
> Actually they are:
> 1. SystemPort/SystemMemory
> 2. PCI_Config brought by the PCI root bridge
> 2. any other early operation regions made available by the data tables.
> ECDT is a kind of such data table.
> There are spec words in _REG section talking about this.
> 
> So if ECDT is not invented for this purpose, why it will be useful?
> If the namespace has been initialized, OSPM ACPI core should always be able to use the namespace EC.
> Like what we do in acpi_ec_dsdt_probe().
> 
> Since ECDT is used before table loading, we'll put acpi_ec_ecdt_probe() before acpi_load_tables().
> At that time, the namespace is empty, it is not possible to use any handle other than ACPI_ROOT_OBJECT.

I see, thanks for the detailed explanation. Originally I was concerned
about the slightly misleading kernel log messages that would refer to
"\" as the EC handle (which is bogus), but this seems unavoidable at
this stage.

For example, initially it would print:

    \: GPE=0x15, EC_CMD/EC_....

instead of something like:

    \_SB.PCI0.SBRG.EC0: GPE=0x15, EC_CMD/EC_....

Kind regards,
Peter

> Thanks and best regards
> Lv
> 
> > 
> > Other than that it looks good to me.
> > 
> > (Aside, I think there is also an implicit assumption that
> > acpi_ec_submit_query never submits work during enumeration, I suspect a
> > possible use-after-free of ec->work is possible otherwise when
> > acpi_ec_free is called.)
> > 
> > Peter
> > 
> > >  error:
> > >  	if (ret)
> > > -		kfree(ec);
> > > -	else
> > > -		first_ec = boot_ec = ec;
> > > +		acpi_ec_free(ec);
> > >  	return ret;
> > >  }
> > >
> > > --
> > > 1.7.10
> > >
