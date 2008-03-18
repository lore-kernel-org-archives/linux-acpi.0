From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/2] thermal: add hwmon sys I/F for thermal device
Date: Tue, 18 Mar 2008 00:59:39 -0400
Message-ID: <200803180059.40007.lenb@kernel.org>
References: <1204072670.10256.111.camel@acpi-hp-zz.sh.intel.com> <200803130109.45531.lenb@kernel.org> <1205398009.2240.75.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58901 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752431AbYCRFBp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Mar 2008 01:01:45 -0400
In-Reply-To: <1205398009.2240.75.camel@acpi-hp-zz.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Hans de Goede <j.w.r.degoede@hhs.nl>

On Thursday 13 March 2008, Zhang, Rui wrote:
> 
> On Thu, 2008-03-13 at 13:09 +0800, Len Brown wrote:
> > 
> > > On Tuesday 26 February 2008, Zhang, Rui wrote:
> > > >
> > > > Add hwmon sys I/F for the generic thermal device.
> > > >
> > > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > > Cc: Hans de Geode <j.w.r.degoede@hhs.nl>
> > > > ---
> > > >  Documentation/thermal/sysfs-api.txt |   22 ++--
> > > >  drivers/thermal/Kconfig             |    1
> > > >  drivers/thermal/thermal.c           |  169
> > ++++++++++++++++++++++++++++++------
> > > >  3 files changed, 155 insertions(+), 37 deletions(-)
> > > >
> > ...
> > > >  {
> > > >     int result = 0;
> > > > @@ -716,16 +829,20 @@ static int __init thermal_init(void)
> > > >             mutex_destroy(&thermal_idr_lock);
> > > >             mutex_destroy(&thermal_list_lock);
> > > >     }
> > > > -   return result;
> > > > -}
> > > > 
> > > > -static void __exit thermal_exit(void)
> > > > -{
> > > > -   class_unregister(&thermal_class);
> > > > -   idr_destroy(&thermal_tz_idr);
> > > > -   idr_destroy(&thermal_cdev_idr);
> > > > -   mutex_destroy(&thermal_idr_lock);
> > > > -   mutex_destroy(&thermal_list_lock);
> > > > +   thermal_hwmon = hwmon_device_register(NULL);
> > > > +   if (IS_ERR(thermal_hwmon)) {
> > > > +           result = PTR_ERR(thermal_hwmon);
> > > > +           thermal_hwmon = NULL;
> > > > +           printk(KERN_ERR PREFIX
> > > > +                   "unable to register hwmon device\n");
> > > > +           thermal_exit();
> > 
> > An __exit routine can not be called from an __init routine.
> > this doesn't build on ia64, which discards .exit sections:
> > 
> > .exit.text' referenced in section `.init.text' of drivers/built-in.o:
> > defined in discarded section `.exit.text' of drivers/built-in.o
> > 
> > -Len
> As I don't have an ia64 machine,
> len, could you please help me test this incremental patch? :)
> 
> From: Zhang Rui <rui.zhang@intel.com>
> 
> An __exit routine can not be called from an __init routine.
> this doesn't build on ia64, which discards .exit sections:
> ".exit.text' referenced in section `.init.text' of drivers/built-in.o:
> defined in discarded section `.exit.text' of drivers/built-in.o"
> 
> http://marc.info/?l=linux-acpi&m=120538509025142&w=2
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/thermal.c |   19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> Index: linux-2.6/drivers/thermal/thermal.c
> ===================================================================
> --- linux-2.6.orig/drivers/thermal/thermal.c
> +++ linux-2.6/drivers/thermal/thermal.c
> @@ -823,12 +823,8 @@ static int __init thermal_init(void)
>  	int result = 0;
>  
>  	result = class_register(&thermal_class);
> -	if (result) {
> -		idr_destroy(&thermal_tz_idr);
> -		idr_destroy(&thermal_cdev_idr);
> -		mutex_destroy(&thermal_idr_lock);
> -		mutex_destroy(&thermal_list_lock);
> -	}
> +	if (result)
> +		goto err;
>  
>  	thermal_hwmon = hwmon_device_register(NULL);
>  	if (IS_ERR(thermal_hwmon)) {
> @@ -836,13 +832,20 @@ static int __init thermal_init(void)
>  		thermal_hwmon = NULL;
>  		printk(KERN_ERR PREFIX
>  			"unable to register hwmon device\n");
> -		thermal_exit();
> -		return result;
> +		class_unregister(&thermal_class);
> +		goto err;
>  	}
>  
>  	result = device_create_file(thermal_hwmon, &dev_attr_name);
>  
>  	return result;
> +  err:
> +	idr_destroy(&thermal_tz_idr);
> +	idr_destroy(&thermal_cdev_idr);
> +	mutex_destroy(&thermal_idr_lock);
> +	mutex_destroy(&thermal_list_lock);
> +
> +	return result;
>  }
>  
>  subsys_initcall(thermal_init);
> 
> 

I already addressed this by modifying your patch that called thermal_exit() from __init
to simply remove the __exit from thermal_exit().

ie. as Henrique does in thinkpad_acpi.c -- we simply don't reward =y builds
by labeling anything with __exit for the tools to strip.

thanks,
-Len
