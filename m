From: ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org (Adam Belay)
Subject: Re: Shutting down PCI devices on suspend
Date: Sun, 12 Dec 2004 14:29:13 -0500
Message-ID: <20041212192913.GB2661@neo.rr.com>
References: <1102779460.5984.17.camel@tyrosine> <20041212164422.GD6286@elf.ucw.cz> <1102870863.5984.36.camel@tyrosine> <20041212171521.GC6272@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041212171521.GC6272-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Dec 12, 2004 at 06:15:21PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > Please do it in the drivers. Anything else is likely to break
> > > currently working setups.

I agree.  However there may be other strategies to explore.

> > 
> > This requires a driver for every PCI device on the system. Is this the
> > best solution?
> 
> Each PCI device is either:
> 
> * supported -- it has a driver, we are okay
> 
> * unsupported -- it should not be even turned on, right?
> 
> * legacy, like VGA or IDE -- okay, we need drivers for those. You need
> to reinit them on resume, anyway, so....
> 
> ...yes, I think this is the best solution.
> 								Pavel
> -- 

Not necessarily.  Most unsupported devices start in the on state.  Also I
think it's difficult to see a consistent power management behavior/policy if
each driver is controlling it's devices' power state.  I'd prefer to have
drivers saving and restoring device state and then having the bus driver
take care of the actual power state transitions.

Thanks,
Adam


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
