From: Ka-shu Wong <kswong-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org>
Subject: Re: Re: [Swsusp-devel] ACPI A/C adaptor status not updated upon resume
Date: Sat, 19 Jul 2003 14:13:25 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030719041325.GA18250@donkey.nsw.optushome.com.au>
References: <F760B14C9561B941B89469F59BA3A8470255EE9D@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470255EE9D-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>, EricAltendorf-gZ4DH+Stb0k@public.gmane.org, swsusp-devel <swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 18, 2003 at 04:53:22PM -0700, Grover, Andrew wrote:
> > 000031bd:     Method _PSR (\_SB_.ADP1._PSR)
> > 000031c3:       ArgCount 0; NotSerialized
> > 000031c4:       Return
> > 000031c5:         \_SB_.MEM_.ACST (000002da)
...
> See, now your system is different from Eric's, which looks like this:
...
>             Method (_PSR, 0, NotSerialized)
>             {
>                 Return (\_SB.MEM.ACST)
>             }

That's strange, it looks the same to me.

> Basically, I am at a loss as to why Eric's machine would report the
> wrong thing. Whoever is setting that bit in memory isn't doing it
> properly, for some reason. (There could be a lot of reasons. Eric, you
> might try sticking a printk in the memory read function in
> drivers/acpi/osl.c and seeing that we are doing a read from 0x000EE8FF
> and what the value is.)

I believe what's happening is that software suspend is somehow saving 
the ACPI state on suspend, and after resume the state from before 
suspend (which is no longer valid) is restored.

If the ACPI state is stored in kernel memory, then this makes sense.

So, my question (to the swsusp people) is whether it is possible to stop
swsusp from restoring the old (invalid) ACPI state; and
(to the ACPI people) is whether it is possible to reset the ACPI
subsystem in some way.

- KS


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
