From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI processor module enhancements
Date: 08 Oct 2004 16:51:59 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1097268718.2117.1302.camel@d845pe>
References: <F7DC2337C7631D4386A2DF6E8FB22B3001A19151@hdsmsx401.amr.corp.intel.com>
	 <20041008202612.GA10952@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041008202612.GA10952-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-10-08 at 16:26, Dominik Brodowski wrote:
> Len,
> 
> > Re: ACPI 3.0 features
> > I think the ACPI 3.0 features will be evolutional.
> > I'll be most comfortable with new ACPI 3.0 code when
> > there are systems available to test that we got it right.
> > I'm not very eager to ship Linux code written to the spec just to
> > discover
> > later that the BIOS writers read the spec a different way;
> > but I know that is a risk we need to take sometimes.
> 
> Agreed, though I'd want to take 3.0 into consideration when deciding
> on "big issues" like interfaces and so on.

Right.

> > >1.) utilize pstate_cnt to notify the BIOS that a P-State
> > >driver is present
> > >This has already been brought up on this list, last in this thread:
> > >http://marc.theaimsgroup.com/?l=acpi4linux&m=109428989121089&w=2
> >
> > Do you think we've reached the end of that discussion
> > and we should put the patch in the release for broader testing?
> 
> Hm, if you see need for discussion, I'd like to hear about the issues
> you see. Otherwise, I'd like it to get broader testing in a month or
> so when cpufreq-bk has stabilized again.

okay, i've put it into my acpi-mm tree where andrew will pick it up.
if no problems, later it will go into 2.6.10.

> > >3.) improved CPU power state selection algorithm
> > >Some ideas are in my patch
> > >http://bugme.osdl.org/show_bug.cgi?id=1958 , it
> > >needs adaption to TODO#2 and further evaluation, though.
> >
> > Do you refer to C-states or P-states here?
> C-States
> 
> > We have a couple of things we need to fix on C-states.
> > eg. Bob Moore is testing a patch to fix the bus-master activity
> part.
> 
> ipw2x00-users will love that. Other than that, I was thinking of a
> better algorithm which decides which C-State to implement at a given
> time.

yes, i expect we should use an algorithm that accounts for how busy the
system is, not just how idle it was.

> > >4.) _OSC / _PDC framework
> > >The _PDC / _OSC methods added in ACPI v. 3.0 are a bit tricky to
> handle
> > >because of the modularization in Linux. Basically we need a
> > >
> > >unsigned int acpi_processor_osc_update()
> > >
> > >which only adds something to a saved buffer. If the driver
> > >requests some
> > >"control" by calling acpi_processor_osc_update(), the latter
> > >should lock the
> > >driver by "try_module_get()".
> >
> > We do see _PDC in the field, but I haven't seen _OSC yet.
> 
> Well, if we do support CPU domain awareness in C- and T-States as
> well, we need some sort of coordination for _PDC == _OSC. And as _OSC
> seems to be the way to go in future, I'd name it after OSC and already
> provide capability for _OSC.
> 
> > >5.) _{P,T,C}SD groundwork
> > >some
> > >
> > >acpi_status acpi_processor_get_domain(..., cpumask_t *cpus, u8
> *type);
> > >
> > >is needed which a) determines the domain of the CPU passed as
> argument,
> > >b) walks through all detected processor objects and looks for
> > >the other CPUs
> > >in this domain [this asserts that all CPUs are initialized as
> > >required by
> > >ACPI spec v.3.0 p.273], c) converts the ACPI CPU numbers to
> > >Linux kernel CPU
> > >numbers, and d) converts this to a cpumask_t
> >
> > I think we'll only get this right when we can test it on hardware
> that
> > supports this.  I expect we'll see that hardware in 2005.
> 
> -> delayed.
> 
> > >7.) Support for C2-type sleep on multiprocessor systems.
> > >
> > >Already previous versions of the ACPI specification can support
> that in
> > >theory, though SMT awareness requires _CSD handling.
> >
> > I haven't seen any HT or MP systems that support C2.
> > Maybe those p4-based laptops do?  I agree that MP/MT
> > support is important.  However, I'm not sure that
> > software coordination of C-states is mandatory.
> 
> It's definitely something necessary for those dual-core Pentium Ms
> which have been announced by Intel.

I expect we'll do dual-core internally b/c we'll be able to get the
hardware before it is available on the market.

If anybody sees an HT-capable system that supports C2 in the mean-time,
I'd be interested to know about it.

> > >8.) Support for WBINVD-based C3
> > >
> > >Only enabled on UP if users explicitely requests it, but
> > >always available
> > >on multiprocessor systems.
> >
> > IIR Luming was looking into this area.
> 
> Excellent.
> 
> > >11.) [or maybe much much earlier?] split up
> drivers/acpi/processor.c in
> > >     individual files and modules:
> > >     - core
> > >     - C-States handling
> > >     - T-States handling
> > >     - ACPI perflib
> >
> > I agree with Venki that if this list is prioritized, that this one
> > should be at the top instead of the bottom -- it doesn't depend
> > on any new specs or any new hardware.
> > For a long time I've wanted processor.c to be split up into
> > separate source files, as different parts have nothing to do
> > with each other.  (I want "idle" to be in the file name for
> c-states;-)
> > I hadn't thought about splitting it into different modules.
> > On systems with broken c-states and working p-states it would
> > certainly be handy to be able to unload c-states w/o unloading
> > p-states...
> 
> ... but splitting it up in source files as a first step would be much
> easier. I'll prepare a patch which does exactly that over the weekend.
> Then it'll be easier and cleaner to handle this large list of updates
> and issues; though some patches will break in between...

great!

thanks,
-Len




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
