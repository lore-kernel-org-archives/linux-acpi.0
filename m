From: Michael Guntsche <mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>
Subject: Re: Network failures with ACPI enabled (kernel 2.4, 2.6)
 PROBLEM FOUND!!!!!!
Date: Tue, 30 Dec 2003 21:45:43 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031230214543.19252406.mike@it-loops.com>
References: <20031230010822.155c1466.mike@it-loops.com>
	<20031230165749.34ed607d.mike@it-loops.com>
	<1072806481.2364.201.camel@dhcppc4>
	<20031230192301.5d17d418.mike@it-loops.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031230192301.5d17d418.mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 30 Dec 2003 19:23:01 +0100
Michael Guntsche <mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org> wrote:

> On 30 Dec 2003 12:48:02 -0500
> Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> 
> > > Today I tried the same transfer with a XIRCOM PCMCIA network card
> > > and ACPI enabled. It worked without a problem.
> > > I am not sure what this means for ACPI <-> B44 though. ;)
> > 
> > Please note which IRQ each kind of ethernet NIC gets,
> > and if it shares an IRQ with any other device.
> > If the working and non-working NICs come up on different IRQs
> > then that may be a clue.
> 
> The broadcom card gets IRQ 5 and the Xircom card gets IRQ3.
> Both IRQ are non-shared. Well IRQ 5 was shared with USB, but for
> testing purposes I removed the USB modules.

Hia Len,

You won't believe me but I found out what was causing the problem.
Since I never use the parallel port on this notebook I turned it OFF in
the BIOS.
Setting it to AUTOMATIC mode solved my issues.
The Linux-ACPI still has a problem somewhere since I don't see the
network timeouts in WinXP, if I turn off the parport.
For me it looks like that the parport and the internal card share
something, either ACPI or hardware wise and by turning off the parport
the network card somehow changes too.

What do you think about that?

Michael


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
