From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Shutting down PCI devices on suspend
Date: Sun, 12 Dec 2004 21:18:10 +0100
Message-ID: <20041212201810.GE6272@elf.ucw.cz>
References: <1102779460.5984.17.camel@tyrosine> <20041212164422.GD6286@elf.ucw.cz> <1102870863.5984.36.camel@tyrosine> <20041212171521.GC6272@elf.ucw.cz> <20041212192913.GB2661@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041212192913.GB2661-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Each PCI device is either:
> > 
> > * supported -- it has a driver, we are okay
> > 
> > * unsupported -- it should not be even turned on, right?
> > 
> > * legacy, like VGA or IDE -- okay, we need drivers for those. You need
> > to reinit them on resume, anyway, so....
> > 
> > ...yes, I think this is the best solution.
> 
> Not necessarily.  Most unsupported devices start in the on state.  Also I
> think it's difficult to see a consistent power management behavior/policy if
> each driver is controlling it's devices' power state.  I'd prefer to have
> drivers saving and restoring device state and then having the bus driver
> take care of the actual power state transitions.

Why?

Saving/restoring state is way more work than actual power state
transitions. Provide nice helpers so that power state transitions are
easy, but leave the work on the drivers, so that drivers may do
something special if required.

Ouch and btw linux-pm list exists where this stuff is debated...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
