From: Thomas Renninger <trenn@suse.de>
Subject: Re: Exit ACPI drivers immediately if acpi is disabled
Date: Mon, 24 Apr 2006 17:57:09 +0200
Message-ID: <1145894230.3797.46.camel@queen.suse.de>
References: <200604211243.32276.trenn@suse.de>
	 <200604211918.13025.trenn@suse.de> <1145875957.3797.15.camel@queen.suse.de>
	 <200604240859.09012.bjorn.helgaas@hp.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40114 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750921AbWDXP44 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Apr 2006 11:56:56 -0400
In-Reply-To: <200604240859.09012.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>

On Mon, 2006-04-24 at 08:59 -0600, Bjorn Helgaas wrote:
> On Monday 24 April 2006 04:52, Thomas Renninger wrote:
> > Rethinking about this: driver_registered is a bit too general variable?
> > 
> > Is this OK, now?
> 
> It's static, so I don't care either way.
> 
> The powernow/speedstep/acpi code sharing seems a little strange, but
> I don't know anything about it.  And you're not changing that part
> of things anyway.
> 
> > @@ -943,12 +947,13 @@ static void __exit acpi_processor_exit(v
> >  
> >  	acpi_thermal_cpufreq_exit();
> >  
> > +	if (processor_driver_registered){
> >  	acpi_processor_uninstall_hotplug_notify();
> >  
> >  	acpi_bus_unregister_driver(&acpi_processor_driver);
> >  
> >  	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
> > -
> > +	}
> 
> Shouldn't the remove_proc_entry() be outside the "if (processor_driver_registered)"
> block?  The directory was created unconditionally, before the
> acpi_bus_register_driver() call.
That should be OK as it is conditionally created in the way that init
func returns,
if proc_mkdir returns NULL:

init():
	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
	if (!acpi_processor_dir)
/* -> proc_mkdir failed -> remove_proc_entry not needed */
		return_VALUE(0);

	acpi_processor_dir->owner = THIS_MODULE;

	result = acpi_bus_register_driver(&acpi_processor_driver);
	if (result < 0) {
		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
/* here it is already removed ... */
		return_VALUE(0);
	}
/*        else ... here it must be removed... */
	processor_driver_registered = 1;

Thanks,

         Thomas

