From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Lid switch not waking machine
Date: Mon, 7 Jul 2003 14:12:44 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030707131244.GA31883@srcf.ucam.org>
References: <20030707011638.GA19894@srcf.ucam.org> <20030707022614.GA21195@srcf.ucam.org> <007301c34481$29864080$3746028e@bio.dfo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <007301c34481$29864080$3746028e-dP0OE4Ef7fWw5LPnMra/2Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 07, 2003 at 09:13:23AM -0300, Derek Broughton wrote:
> From: "Matthew Garrett" <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
> > The plot thickens. If I suspend with the lid switch and then release it,
> > I have to wake the system with the power button. The system resumes, but
> 
> This is normal.  Every laptop I've used (even in Windows) expects to be woken
> from sleep states with the power button - if your laptop had a dedicated sleep
> button, you might use that instead, but the lid switch is never, ime, used for
> wakeup.

Under Windows, opening the lid results in the system waking, so it seems 
that the hardware is capable of it. It'd be nice if the same were 
possible under Linux.

> > no more ACPI events are generated. If I suspend with the sleep button, I
> 
> This, however, seems wrong.  What you should get when you wake with the power
> button is a power button event immediately followed by a lid switch event - and
> then any other events.

Before suspending (I've stopped acpid so I can do this by hand):

mjg59@asparagine:/tmp$ sudo cat /proc/acpi/event
button/lid LID 00000080 00000001
button/lid LID 00000080 00000002
(once for down, once for up)
button/sleep SBTN 00000080 00000003
(pressing the sleep button) 

At this point, I do /etc/acpi/default.sh button SBTN and the machine
suspends. I can press the power button or (for some reason) the Fn key
and the machine resumes - my cat process has died with an Input/output
error. ACPI carries on working, as shown below.

mjg59@asparagine:/tmp$ sudo cat /proc/acpi/event
button/lid LID 00000080 00000003
button/lid LID 00000080 00000004
(lid button still works)
button/sleep SBTN 00000080 00000004
(sleep button still works)

Suspend again - this time I press the lid switch while the system is 
suspended. Power button and Fn key still wake the system, but from now 
on no ACPI events are generated. I can still do things like control the 
CPU throttling and fan state by hand. Removing the ac adapter leaves its 
state as "on-line". cat /proc/acpi/button/lid/LID/state shows "open" 
even when it's not. It's as if the hardware is waiting for something to 
deal with the lid up event and not doing anything else until that's 
happened.

I've stuck my DSDT at http://www.codon.org.uk/~mjg59/240x.dsdt if that's 
any use.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
