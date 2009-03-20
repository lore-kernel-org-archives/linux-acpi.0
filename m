From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Fri, 20 Mar 2009 14:00:04 +0000
Message-ID: <20090320140004.GA4882@srcf.ucam.org>
References: <20090319212123.GA24700@srcf.ucam.org> <20090320085213.GC4743@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:53993 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbZCTOAJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Mar 2009 10:00:09 -0400
Content-Disposition: inline
In-Reply-To: <20090320085213.GC4743@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org

On Fri, Mar 20, 2009 at 05:52:14PM +0900, Mattia Dongili wrote:

> I'm more of the idea to provide a module option to force the setup
> callback if the module is not in the DMI list.
> Although for now all of the models that have SN07 and friends seem to
> benefit from throwing some magic numbers at them.

I suspect that this is how new machines expect to be controlled.

> > calling the ECON method on the SNC since some codepaths in the tables 
> > seem to depend on them - but I'm also worried to a certain extent on how 
> > much that might change driver interactions with some machines.
> 
> My understanding about ECON is that it is always enabled if the embedded
> controller is enabled. The SPIC device has the same kind of dependency
> and as far as I could see ECON is always 1. So I don't think it makes
> much of a difference.

I had one machine where ECON seemed to need to be called explicitly, but 
I can't remember the details now. Calling it probably wouldn't hurt 
anything.

> do we really need to unregister if registering failed?
> Looking at rfkill_{un,}register this seems unnecessary while an
> rfkill_free seems more appropriate.
> The same applies for the other rfkill setup functions.

Yeah, I'll fix that up.

> > +	acpi_callsetfunc(sony_nc_acpi_handle, "SN07", 0x101, &result);
> > +
> > +	acpi_callsetfunc(sony_nc_acpi_handle, "SN07", 0xb03, &result);
> 
> hummm, this is very similar to the callback setup executed when matching
> the snc dmi list.
> On which vaio model did you get this numbers? Did you find the other
> initialization path (the one dependent on the DMI list) any useful on
> that model? i.e.: do you need both?

The numbers correspond to enabling all events. I couldn't think of any 
reason why we'd only want to enable a subset. The current nc setup code 
seems to enable some events and then disable them again, which I don't 
really understand.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
