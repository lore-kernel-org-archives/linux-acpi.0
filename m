From: 'Faye Pearson' <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Re: constant processor 0x80 events
Date: Wed, 1 Jan 2003 16:40:52 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030101164052.GA31172@clara.net>
References: <20021231211259.GA28810@clara.net> <000101c2b191$93b74130$2d2202d3@sayonara>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000101c2b191$93b74130$2d2202d3-F8JvWDuGsZU@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Adachi, Kenichi" <aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Adachi, Kenichi [aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org] wrote:
> Your system board triggers GPE upon some hardware condition (most likely
> thermal in your case) and GPE handler for that event (run by OS) issues
> Notify 0x80 on processor object. This eventually causes OS to reevaluate
> your _PPC object to flip the highest performance state (P-State) of your
> processor and update the supported P-State table.

So the OS should be switching the processor to the lower speedstep
setting?  It isn't AFAICS.  Also it is quite impossible to do so manually once
this situation has occurred.  I assume because the constant GPE handling
is holding onto a mutex which prevents its use - the downside of
threading this?

> I suspect that, on your machine, first current temperature crosses the
> trip point (not for passive/active cooling but for P-State update), the
> newly selected lower P-State cools down the box for a while, but sooner
> or later it starts to heat again, ending up under the "yo-yo" situation.
> This might bring about high CPU demand for repeated event handling.  

The P State is never changed from it's highest setting at least from
what I can see in proc/acpi/processor/CPU0/performance.

> > I added this CHTR call (it wasn't being called before) and 
> > that seems to stave off the problem for a while.. while 
> > programs are running, there isn't a steady rise in 
> > temperature, the temperature is seemingly all over the place. 
> >  It will get up to 82 and then suddenly drop to 59. Even when 
> > the load is going mad now, the fan is only on its high, not 
> > critical level.
> > 
> It looks to me like your CHTR ("CH"ange "TR"ip point?) method adjusts
> (enable/disable) trip point for P-State update depending on the passed
> Arg0 and the caller of this CHTR Method is expected to pass current
> temperature. If so, adding a call to CHTR in _TMP could make sense to
> some extent. It dynamically changes trip point for P-State update and
> somehow keeps box from overheating, resulting in the cooler and quiet
> environment. But we can't be sure unless we have input from BIOS writer.

It seems to update a couple of variables depending on what the
temperature is but their meaning isn't clear to me.  I haven't noticed
limit making any difference at all.
root@marmite faye # cat /proc/acpi/processor/CPU0/limit
active limit:            P0:T0
platform limit:          P0:T0
user limit:              P0:T0
thermal limit:           P0:T0

> BTW, your BIOS seemingly doesn't support active cooling, that possibly
> means the control of FAN is done by hardware modules and not exposed to
> OS. Which make/model is your machine?

That's correct.  The fan is managed in hardware, there is no acpi fan
control.  It's a Compaq Presario 2701EA.

Thanks for your suggestions, I'd love to solve this as it's the final
remaining problem.

I'm going to try to remove the GPE from the DSDT as you suggest.


Faye

"The Schizophrenic: An Unauthorized Autobiography"


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
