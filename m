From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Shutting down PCI devices on suspend
Date: Mon, 13 Dec 2004 12:09:56 +0100
Message-ID: <20041213110956.GO6272@elf.ucw.cz>
References: <1102779460.5984.17.camel@tyrosine> <20041212164422.GD6286@elf.ucw.cz> <1102870863.5984.36.camel@tyrosine> <20041212171521.GC6272@elf.ucw.cz> <20041212192913.GB2661@neo.rr.com> <20041212201810.GE6272@elf.ucw.cz> <20041212223655.GC2661@neo.rr.com> <20041212230157.GH6272@elf.ucw.cz> <20041213001125.GD2661@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041213001125.GD2661-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
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

> > > | driver (*suspend) - tell class to stop logical device (often large amounts
> > > |		      of duplicate code between drivers)
> > 
> > Well, then feel free to move that duplicate code into helper
> > functions. I do think that I'd notice that large amounts of duplicate
> > code, but feel free to prove me wrong.

You did not show me that duplicated code...

> > > |		    - totally ignore ACPI firmware Dx states (how could we
> > > |		      handle them, we don't know enough about the layers below
> > > |		      us.  ACPI may not be compiled into the kernel, the device
> > > |		      may not have ACPI extensions etc.)
> > 
> > Helpers can do that, right?
> 
> Maybe, something really needs to be done about it in the short run.
> 
> 
> Why must the driver be in complete control?  We can't ensure every driver will
> behave consistently.  Why have a driver model at all if we can't break tasks
> into layers of responsibility?

Driver model is neccessary for suspending devices in right order. 

> Yes, layering has small losses in flexability, but the advantage of ensuring
> uniform behavior and capabilities is very important.  With layering, code
> repitition is minimal and everything in the kernel is all around more
> simplistic and easy to maintain.  I think we can have a higher average quality
> of functionality and stability with this approach.  Also less work
> will be

Maybe you'll have higher average quality, but I'm afraid that it will
also mean that few important drivers will no longer work that well
(see the loss of flexibility above).

Plus your solution is more complex and harder to understand.

> required when developing new drivers or adding new functionality.  For
> example, a developer could update class level code without breaking or needing
> to change driver and bus level code.

If you update class level without at least testing the drivers, you
are likely to cause problems. I'd rather have people test their
changes, and the way to do that is to leave the control at the driver
level.

> > Well, if you want your network card to do wake-on-lan, you need to
> > keep it powered on... And the driver is the piece of code that knows
> > if you want to do wake-on-lan, right?
> 
> Firmware like ACPI will tell us what wake-on-lan capabilities we have.  The
> bus layer also handles much of the physical aspects.  The user will say that
> he or she wants the logical device "eth1", as an example, to wake up the
> computer if any traffic is incoming.  So really all of the layers play some
> role in wake-on-lan, right?  Is a device useful for wake-on-lan without a
> corresponding logical ethernet device?

I do not think mapping between eth1, PCI device and ACPI device is
readily available in kernel somewhere. 
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
