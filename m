From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Sat, 21 Mar 2009 13:00:10 +0900
Message-ID: <20090321040010.GD3834@kamineko.org>
References: <20090319212123.GA24700@srcf.ucam.org> <20090320085213.GC4743@kamineko.org> <20090320140004.GA4882@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:49237
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbZCUEAP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Mar 2009 00:00:15 -0400
Content-Disposition: inline
In-Reply-To: <20090320140004.GA4882@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On Fri, Mar 20, 2009 at 02:00:04PM +0000, Matthew Garrett wrote:
> On Fri, Mar 20, 2009 at 05:52:14PM +0900, Mattia Dongili wrote:
> 
> > I'm more of the idea to provide a module option to force the setup
> > callback if the module is not in the DMI list.
> > Although for now all of the models that have SN07 and friends seem to
> > benefit from throwing some magic numbers at them.
> 
> I suspect that this is how new machines expect to be controlled.

agreed, but I need to figure out if the initialization sequence is
really the same for those new TT/Z models and the olders one (see also
below).

> > > calling the ECON method on the SNC since some codepaths in the tables 
> > > seem to depend on them - but I'm also worried to a certain extent on how 
> > > much that might change driver interactions with some machines.
> > 
> > My understanding about ECON is that it is always enabled if the embedded
> > controller is enabled. The SPIC device has the same kind of dependency
> > and as far as I could see ECON is always 1. So I don't think it makes
> > much of a difference.
> 
> I had one machine where ECON seemed to need to be called explicitly, but 
> I can't remember the details now. Calling it probably wouldn't hurt 
> anything.

seems to be a TT and Z specific thing though. The DSDT on other models
doesn't provide the ECON method.

...
> > > +	acpi_callsetfunc(sony_nc_acpi_handle, "SN07", 0x101, &result);
> > > +
> > > +	acpi_callsetfunc(sony_nc_acpi_handle, "SN07", 0xb03, &result);
> > 
> > hummm, this is very similar to the callback setup executed when matching
> > the snc dmi list.
> > On which vaio model did you get this numbers? Did you find the other
> > initialization path (the one dependent on the DMI list) any useful on
> > that model? i.e.: do you need both?
> 
> The numbers correspond to enabling all events. I couldn't think of any 
> reason why we'd only want to enable a subset. The current nc setup code 
> seems to enable some events and then disable them again, which I don't 
> really understand.

Well, the current sequence was taken from a trace in windows on a Vaio C
Type, then it demonstrated to be helpful on other models as well.
The SN07[1] method is very different from the Z and TT type to the AR, C,
FE, FZ and N so I'm starting to suspect that we're just seeing a new
generation of SNC based models. I'll see if some users with older models
can give the new sequence a go.

In the meantime can we make your sony_nc_function_setup less invasive
and depend on the DMI to match?

[1]: more dsdt tables here http://www.kamineko.org/dsdt-vaio/
-- 
mattia
:wq!
