From: ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org (Adam Belay)
Subject: Re: Shutting down PCI devices on suspend
Date: Sun, 12 Dec 2004 17:36:56 -0500
Message-ID: <20041212223655.GC2661@neo.rr.com>
References: <1102779460.5984.17.camel@tyrosine> <20041212164422.GD6286@elf.ucw.cz> <1102870863.5984.36.camel@tyrosine> <20041212171521.GC6272@elf.ucw.cz> <20041212192913.GB2661@neo.rr.com> <20041212201810.GE6272@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041212201810.GE6272-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

On Sun, Dec 12, 2004 at 09:18:10PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > Each PCI device is either:
> > > 
> > > * supported -- it has a driver, we are okay
> > > 
> > > * unsupported -- it should not be even turned on, right?
> > > 
> > > * legacy, like VGA or IDE -- okay, we need drivers for those. You need
> > > to reinit them on resume, anyway, so....
> > > 
> > > ...yes, I think this is the best solution.
> > 
> > Not necessarily.  Most unsupported devices start in the on state.  Also I
> > think it's difficult to see a consistent power management behavior/policy if
> > each driver is controlling it's devices' power state.  I'd prefer to have
> > drivers saving and restoring device state and then having the bus driver
> > take care of the actual power state transitions.
> 
> Why?

Because the power management design should be layered:

device power off request -->

(start)
|
| class - disable user space interfaces, stop timers etc
|
| driver - save hardware state, prepare hardware for poweroff
|
| bus - power off physical device
|
| firmware (ex ACPI) - additional power logic (ex external device components
|					       may need to be powered off.
|					       This will typically involve Dx
|					       states)
/
(finish)

Layering is one of the reasons the driver core was created.

We currently have this:

device power off request -->

(start)
|
| driver (*suspend) - tell class to stop logical device (often large amounts
|		      of duplicate code between drivers)
|		    
|		    - Save device state
|		    
|		    - Power off physical device
|		    
|		    - totally ignore ACPI firmware Dx states (how could we
|		      handle them, we don't know enough about the layers below
|		      us.  ACPI may not be compiled into the kernel, the device
|		      may not have ACPI extensions etc.)
|
\
(finish)

I think it would be better if every layer in the driver stack played a role in
device power state transitions.

> 
> Saving/restoring state is way more work than actual power state
> transitions. Provide nice helpers so that power state transitions are
> easy, but leave the work on the drivers, so that drivers may do
> something special if required.

Could you provide an example of a special case?  I'm not sure if we should
design our model around the least common denominator of standard compliance.

> 
> Ouch and btw linux-pm list exists where this stuff is debated...

Yes I'm aware of it.  This issue also applies to ACPI very directly.

Thanks,
Adam


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
