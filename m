From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 1/2] thermal: add hwmon sys I/F for thermal device
Date: Thu, 13 Mar 2008 11:59:01 +0100
Message-ID: <1205405941.29877.341.camel@queen.suse.de>
References: <1204072670.10256.111.camel@acpi-hp-zz.sh.intel.com>
	 <200803120029.09505.lenb@kernel.org>  <200803130109.45531.lenb@kernel.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:50223 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491AbYCMK7E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Mar 2008 06:59:04 -0400
In-Reply-To: <200803130109.45531.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Hans de Goede <j.w.r.degoede@hhs.nl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

On Thu, 2008-03-13 at 01:09 -0400, Len Brown wrote:
> > On Tuesday 26 February 2008, Zhang, Rui wrote:
> > > 
> > > Add hwmon sys I/F for the generic thermal device.
> > > 
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > Cc: Hans de Geode <j.w.r.degoede@hhs.nl>
> > > ---
> > >  Documentation/thermal/sysfs-api.txt |   22 ++--
> > >  drivers/thermal/Kconfig             |    1 
> > >  drivers/thermal/thermal.c           |  169 ++++++++++++++++++++++++++++++------
> > >  3 files changed, 155 insertions(+), 37 deletions(-)
> > > 
> ...
> > >  {
> > >  	int result = 0;
> > > @@ -716,16 +829,20 @@ static int __init thermal_init(void)
> > >  		mutex_destroy(&thermal_idr_lock);
> > >  		mutex_destroy(&thermal_list_lock);
> > >  	}
> > > -	return result;
> > > -}
> > >  
> > > -static void __exit thermal_exit(void)
> > > -{
> > > -	class_unregister(&thermal_class);
> > > -	idr_destroy(&thermal_tz_idr);
> > > -	idr_destroy(&thermal_cdev_idr);
> > > -	mutex_destroy(&thermal_idr_lock);
> > > -	mutex_destroy(&thermal_list_lock);
> > > +	thermal_hwmon = hwmon_device_register(NULL);
> > > +	if (IS_ERR(thermal_hwmon)) {
> > > +		result = PTR_ERR(thermal_hwmon);
> > > +		thermal_hwmon = NULL;
> > > +		printk(KERN_ERR PREFIX
> > > +			"unable to register hwmon device\n");
> > > +		thermal_exit();
> 
> An __exit routine can not be called from an __init routine.
> this doesn't build on ia64, which discards .exit sections:
> 
> .exit.text' referenced in section `.init.text' of drivers/built-in.o: defined in discarded section `.exit.text' of drivers/built-in.o
This also happens in drivers/misc/thinkpad_acpi.c.
While this is not used on IA64, it should also be cleaned up on
long-term.

   Thomas


