From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Exit ACPI drivers immediately if acpi is disabled
Date: Fri, 21 Apr 2006 18:58:42 +0200
Message-ID: <20060421165842.GA20625@isilmar.linta.de>
References: <200604211243.32276.trenn@suse.de> <200604210918.47337.bjorn.helgaas@hp.com> <200604211853.47117.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.239.214.66]:45453 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932420AbWDUQ6n (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Apr 2006 12:58:43 -0400
Content-Disposition: inline
In-Reply-To: <200604211853.47117.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>

On Fri, Apr 21, 2006 at 06:53:46PM +0200, Thomas Renninger wrote:
> On Friday 21 April 2006 17:18, Bjorn Helgaas wrote:
> > On Friday 21 April 2006 04:43, Thomas Renninger wrote:
> > > If booting with acpi=off and loading the processor module, it
> > > may happen that the kernel oopses when trying to unload the module again.
> > > Better exit all ACPI modules immediately if booted with acpi=off.
> > > ... 
> > > @@ -289,31 +289,28 @@ static int __init acpi_ac_init(void)
> > >  {
> > >  	int result = 0;
> > >  
> > > -	ACPI_FUNCTION_TRACE("acpi_ac_init");
> > > +	if (acpi_disabled)
> > > +		return -ENODEV;
> > 
> > This doesn't feel like the right solution to me.
> > acpi_bus_register_driver() already returns -ENODEV
> > if acpi_disabled, and that ought to be enough so the
> > drivers can handle this correctly.
> > 
> > I don't think we should clutter every ACPI driver with
> > the same check for acpi_disabled.
> Yes, you are right.
> > 
> > Did you investigate the oops when unloading the processor module?
> It's in unregister_driver.
> > I wonder if that driver has a bug there.  It has a mysterious
> > comment that "we keep the driver loaded even when ACPI is not
> > running" for powernow-k8.   I don't understand that at all, but
> > it sounds like it requires extra care to make sure everything
> > works right.
> AFAIK processor module has no functions if acpi=off.
> Some cpufreq drivers still work. The ones which have the steps
> for each CPU model compiled in and that should still work.
> 
> There should be no functions missing when booting acpi=off and processor
> module cannot be loaded.
> But I might be wrong here...
> 
> Hmm, as even proc is deleted, the module probably should not be loaded...
> 
> I think this one should go in then:
> 
> Subject: Exit ACPI processor module if acpi is disabled

No. For example powernow-k8 and speedstep-centrino do have a dependency on a
function which is exported by processor_perflib.c. THis means you cannot
load these modules (which can run without ACPI support) if loading the
processor module fails. Therefore its init function must not fail.

	Dominik
