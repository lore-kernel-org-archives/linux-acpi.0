From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 04/13] Exit ACPI processor module gracefully if acpi is disabled
Date: Wed, 7 Mar 2007 03:00:55 -0500
Message-ID: <200703070300.55821.lenb@kernel.org>
References: <200702060010.l160ADKR003729@shell0.pdx.osdl.net> <200702090047.25044.lenb@kernel.org> <1171010060.25027.616.camel@d36.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58052 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964952AbXCGIDM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Mar 2007 03:03:12 -0500
In-Reply-To: <1171010060.25027.616.camel@d36.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de, cpufreq@lists.linux.org.uk
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org

On Friday 09 February 2007 03:34, Thomas Renninger wrote:
> On Fri, 2007-02-09 at 00:47 -0500, Len Brown wrote:
> > Why not simply check acpi_disabled, like other drivers do?
> > 
> See comment from Dominik when I sent something similar some time ago:
> http://marc.theaimsgroup.com/?l=linux-acpi&m=114563882012355&w=2

Dominik is right right driver registration should fail w/o
a check for acpi_disabled.  However, we use acpi_disabled all
over the place already when that is not sufficient, so if we
need it here, we can use it..

>> [Dominik wrote]
>> No. For example powernow-k8 and speedstep-centrino do have a dependency on a
>> function which is exported by processor_perflib.c. THis means you cannot
>> load these modules (which can run without ACPI support) if loading the
>> processor module fails. Therefore its init function must not fail.

Blech, so the drivers that can be either native or ACPI can't link
in native mode unless their ACPI processor driver symbols resolve?

Hmmm.  Perhaps we should delete the ACPI part of speedstep_centrino
now that it is deprecated by acpi-cpufreq?  That way it can be
just a native driver for folks who want to run
with hard-coded tables and no ACPI.
Or perhaps at this point we should delete speedstep_centrino entirely?

Looks like powernow-k7.c and powernow-k8.c have the same issue --
acpi_processor_register_performance() ain't gonna resolve if the acpi processor
driver isn't present.  Perhaps they can be split into native and ACPI drivers?

-Len


> > On Monday 05 February 2007 19:09, akpm@linux-foundation.org wrote:
> > > From: Thomas Renninger <trenn@suse.de>
> > > 
> > > Signed-off-by: Thomas Renninger <trenn@suse.de>
> > > Cc: Len Brown <lenb@kernel.org>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > ---
> > > 
> > >  drivers/acpi/processor_core.c |   13 +++++++++----
> > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > > 
> > > diff -puN drivers/acpi/processor_core.c~exit-acpi-processor-module-gracefully-if-acpi-is-disabled drivers/acpi/processor_core.c
> > > --- a/drivers/acpi/processor_core.c~exit-acpi-processor-module-gracefully-if-acpi-is-disabled
> > > +++ a/drivers/acpi/processor_core.c
> > > @@ -994,6 +994,8 @@ void acpi_processor_uninstall_hotplug_no
> > >   * ACPI, but needs symbols from this driver
> > >   */
> > >  
> > > +static int processor_driver_registered;
> > > +
> > >  static int __init acpi_processor_init(void)
> > >  {
> > >  	int result = 0;
> > > @@ -1019,6 +1021,8 @@ static int __init acpi_processor_init(vo
> > >  		return result;
> > >  	}
> > >  
> > > +	processor_driver_registered = 1;
> > > +
> > >  	acpi_processor_install_hotplug_notify();
> > >  
> > >  	acpi_thermal_cpufreq_init();
> > > @@ -1035,12 +1039,13 @@ static void __exit acpi_processor_exit(v
> > >  
> > >  	acpi_thermal_cpufreq_exit();
> > >  
> > > -	acpi_processor_uninstall_hotplug_notify();
> > > -
> > > -	acpi_bus_unregister_driver(&acpi_processor_driver);
> > > +	if (processor_driver_registered) {
> > > +		acpi_processor_uninstall_hotplug_notify();
> > >  
> > > -	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
> > > +		acpi_bus_unregister_driver(&acpi_processor_driver);
> > >  
> > > +		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
> > > +	}
> > >  	return;
> > >  }
> > >  
> > > _
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
