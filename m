From: ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org (Adam Belay)
Subject: Re: Shutting down PCI devices on suspend
Date: Sun, 12 Dec 2004 19:11:25 -0500
Message-ID: <20041213001125.GD2661@neo.rr.com>
References: <1102779460.5984.17.camel@tyrosine> <20041212164422.GD6286@elf.ucw.cz> <1102870863.5984.36.camel@tyrosine> <20041212171521.GC6272@elf.ucw.cz> <20041212192913.GB2661@neo.rr.com> <20041212201810.GE6272@elf.ucw.cz> <20041212223655.GC2661@neo.rr.com> <20041212230157.GH6272@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041212230157.GH6272-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

Hi,

On Mon, Dec 13, 2004 at 12:01:57AM +0100, Pavel Machek wrote:
> Hi!
> 
> > Because the power management design should be layered:
> > 
> > device power off request -->
> > 
> > (start)
> > |
> > | class - disable user space interfaces, stop timers etc
> > |
> > | driver - save hardware state, prepare hardware for poweroff
> > |
> > | bus - power off physical device
> > |
> > | firmware (ex ACPI) - additional power logic (ex external device components
> > |					       may need to be powered off.
> > |					       This will typically involve Dx
> > |					       states)
> > /
> > (finish)
> 
> Driver needs to be in control. For every rule, there's exception
> (buggy hw?). It is fine if classes or buses provide helpers, but
> ultimately it needs to be driver's suspend using those helpers.
> 
> > | driver (*suspend) - tell class to stop logical device (often large amounts
> > |		      of duplicate code between drivers)
> 
> Well, then feel free to move that duplicate code into helper
> functions. I do think that I'd notice that large amounts of duplicate
> code, but feel free to prove me wrong.
> 
> > |		    - totally ignore ACPI firmware Dx states (how could we
> > |		      handle them, we don't know enough about the layers below
> > |		      us.  ACPI may not be compiled into the kernel, the device
> > |		      may not have ACPI extensions etc.)
> 
> Helpers can do that, right?

Maybe, something really needs to be done about it in the short run.


Why must the driver be in complete control?  We can't ensure every driver will
behave consistently.  Why have a driver model at all if we can't break tasks
into layers of responsibility?

Yes, layering has small losses in flexability, but the advantage of ensuring
uniform behavior and capabilities is very important.  With layering, code
repitition is minimal and everything in the kernel is all around more
simplistic and easy to maintain.  I think we can have a higher average quality
of functionality and stability with this approach.  Also less work will be
required when developing new drivers or adding new functionality.  For
example, a developer could update class level code without breaking or needing
to change driver and bus level code.

Basically each component in the stack should not know or care about what the
components above or below it are going to do.  Each should be autonomous and
only concerned with completing its own well defined goal along the chain of
the process.  This can apply to most problems, including power management.

> 
> > > Saving/restoring state is way more work than actual power state
> > > transitions. Provide nice helpers so that power state transitions are
> > > easy, but leave the work on the drivers, so that drivers may do
> > > something special if required.
> > 
> > Could you provide an example of a special case?  I'm not sure if we should
> > design our model around the least common denominator of standard
> > compliance.
> 
> Well, if you want your network card to do wake-on-lan, you need to
> keep it powered on... And the driver is the piece of code that knows
> if you want to do wake-on-lan, right?

Firmware like ACPI will tell us what wake-on-lan capabilities we have.  The
bus layer also handles much of the physical aspects.  The user will say that
he or she wants the logical device "eth1", as an example, to wake up the
computer if any traffic is incoming.  So really all of the layers play some
role in wake-on-lan, right?  Is a device useful for wake-on-lan without a
corresponding logical ethernet device?

Furthermore, it can be more complicated than just keeping it powered on.  A
device might need a seperate power domain to be used for wake-on-lan than
normal operation.  ACPI could help with this.
 
Thanks,
Adam


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
