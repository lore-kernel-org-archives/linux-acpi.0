From: Thomas Renninger <trenn@suse.de>
Subject: Re: [patch 04/13] Exit ACPI processor module gracefully if acpi is
	disabled
Date: Fri, 09 Feb 2007 09:34:20 +0100
Message-ID: <1171010060.25027.616.camel@d36.suse.de>
References: <200702060010.l160ADKR003729@shell0.pdx.osdl.net>
	 <200702090047.25044.lenb@kernel.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57608 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946220AbXBIIeV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Feb 2007 03:34:21 -0500
In-Reply-To: <200702090047.25044.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org

On Fri, 2007-02-09 at 00:47 -0500, Len Brown wrote:
> Why not simply check acpi_disabled, like other drivers do?
> 
See comment from Dominik when I sent something similar some time ago:
http://marc.theaimsgroup.com/?l=linux-acpi&m=114563882012355&w=2

     Thomas

> thanks,
> -Len
> 
> On Monday 05 February 2007 19:09, akpm@linux-foundation.org wrote:
> > From: Thomas Renninger <trenn@suse.de>
> > 
> > Signed-off-by: Thomas Renninger <trenn@suse.de>
> > Cc: Len Brown <lenb@kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> > 
> >  drivers/acpi/processor_core.c |   13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff -puN drivers/acpi/processor_core.c~exit-acpi-processor-module-gracefully-if-acpi-is-disabled drivers/acpi/processor_core.c
> > --- a/drivers/acpi/processor_core.c~exit-acpi-processor-module-gracefully-if-acpi-is-disabled
> > +++ a/drivers/acpi/processor_core.c
> > @@ -994,6 +994,8 @@ void acpi_processor_uninstall_hotplug_no
> >   * ACPI, but needs symbols from this driver
> >   */
> >  
> > +static int processor_driver_registered;
> > +
> >  static int __init acpi_processor_init(void)
> >  {
> >  	int result = 0;
> > @@ -1019,6 +1021,8 @@ static int __init acpi_processor_init(vo
> >  		return result;
> >  	}
> >  
> > +	processor_driver_registered = 1;
> > +
> >  	acpi_processor_install_hotplug_notify();
> >  
> >  	acpi_thermal_cpufreq_init();
> > @@ -1035,12 +1039,13 @@ static void __exit acpi_processor_exit(v
> >  
> >  	acpi_thermal_cpufreq_exit();
> >  
> > -	acpi_processor_uninstall_hotplug_notify();
> > -
> > -	acpi_bus_unregister_driver(&acpi_processor_driver);
> > +	if (processor_driver_registered) {
> > +		acpi_processor_uninstall_hotplug_notify();
> >  
> > -	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
> > +		acpi_bus_unregister_driver(&acpi_processor_driver);
> >  
> > +		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
> > +	}
> >  	return;
> >  }
> >  
> > _
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 

