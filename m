From: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Subject: Re: Freezing more and more (Gericom Supersonic M6T)
Date: Fri, 7 Mar 2003 15:12:50 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030307141250.GB2674@schiggy.intern.quelltext.com>
References: <200303041529.11172.Pavel.Vondricka@ff.cuni.cz> <20030307095014.GA28237@schiggy.intern.quelltext.com> <20030307101310.GC28237@schiggy.intern.quelltext.com> <200303071351.38346.Pavel.Vondricka@ff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200303071351.38346.Pavel.Vondricka-1W7zqEVgo5LrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Vondricka <Pavel.Vondricka-1W7zqEVgo5LrBKCeMvbIDA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 07, 2003 at 01:51:38PM -0100, Pavel Vondricka wrote:
> Thanks,
> I also use KDE 3.1, but my system is based on RedHat 8.0. The computer really 
> behaves strange. I have two more questions:
> 
> Where can I get acpi 20030306? Some CVS download, you mean?

No, "abra.20030306" is the version number of my installed kernel, not
the ACPI patch (I am using acpi-20030228).

> Does it matter if patching the kernel shows messages like "Hunk XXXX suceeded 
> at position -235 ..."? Lately I can never patch any kernel without these 
> warnings. Does ACPI use another kind of kernel than vanilla to make patches 
> to?

The message "Hunk XXXX suceeded at position -235" is benign; you need to
worry only if hunks are rejected (well, actually you don't worry, but
apply the respective changes by hand).

The ACPI patches published on http://sf.net/projects/acpi are always
taken against the plain and vanilla kernel sources from www.kernel.org.
Many Linux distributions like RedHat, SuSE, Debian etc are known to
distribute altered sources, and the ACPI patch may not cleanly apply
against these.

> > that my Prism 3 based WLAN card does not longer work with this kernel
> > as the orinoco module has unresolved symbols (perhaps a problem with

I just found that this problem goes away if I use the kernel-supplied
PCMCIA support (before I was using the separate PCMCIA support from the
pcmcia-cs package).

> Personally, I use the hostap drivers (a prism 2.5 card), which is known to 
> generate lots of interreupts.

What driver is this? I haven't heard of "hostap".

> However, as I told you, the system often hangs even though I do not
> use the card.

Do you mean: Even though the card is not inserted?

> And independently on the system load!!! It 
> doesn't hang because of overload. It hangs also when I leave my computer for 
> a few minutes! Sometimes. Sometimes it works 20 hours without problems - I 
> managed to compile KDE 3.1 over night. The computer started hanging the next 
> day, when I tried to run it. Mainly when I played with transparency settings 
> of menus, aso. in KDE look&feel. Then I removed the processor.o module from 
> the kernel and it became stable again. But one or to days later it started 
> hanging again, even without the processor.o module.

I have always compiled all ACPI options directly into the kernel, i.e.
not as modules. Some people say that the ACPI stuff doesn't work as well
as modules, but don't know whether this is still true. But in any case,
compiling ACPI directly into the kernel is the safest choice.

> So, I think it would hardly mean anything if I managed to run my computer for 
> one week without problems without ACPI. This can happen even with ACPI. Could 
> the problem be some wrong way of handling interrupts at run-time? Then I 
> wouldn't find the problem anyway, because I couldn't use my modem, eth0, 
> pcmcia and sound without ACPI.Is there any way to find out if it is ACPI 
> software or hardware that handles these interrputs wrongly (if the problem 
> would be here)?

Don't know. Perhaps the problem is your WLAN card and/or its driver? Or
perhaps you do have a hardware problem. Is the machine stable under XP?

BTW, PCMCIA does work even without the ACPI patch, at least if you use
the external PCMCIA support. I have been able to use a PCMCIA network
card before I had the ACPI patch to enable my builtin NIC.

Good luck,
Arndt


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
