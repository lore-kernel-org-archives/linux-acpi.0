From: Gregory Finch <Uberboxen-pVBOr+mkmsReoWH0uzbU5w@public.gmane.org>
Subject: Re: [RFC] ACPI power-off on P4 HT
Date: Wed, 25 Feb 2004 23:56:09 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040226075609.GA745@uberboxen>
References: <1076145024.8687.32.camel@dhcppc4> <20040208082059.GD29363@alpha.home.local> <20040208090854.GE29363@alpha.home.local> <20040214081726.GH29363@alpha.home.local> <1076824106.25344.78.camel@dhcppc4> <20040225070019.GA30971@alpha.home.local> <1077695701.5911.130.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1077695701.5911.130.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>, Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZQ39yzSjRtAkw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

My workstation has a problem with power-off as well. It is a dual P3
(Katmai) Epox motherboard with Intel 440BX chipset. About 50% of the
time I try powering off the system, the NMI watchdog fires detecting
CPU1 as locked up. I would be willing to try any patches that may fix
this, as I miss being able to let my workstation shutdown on it's own.

Thanks,
-Greg

On Wed, Feb 25, 2004 at 02:55:01AM -0500, Len Brown wrote:
> Willy,
> I do think we need a generic way to be sure that certain routines are
> run only on cpu0.
> 
> I don't see it in the ACPI spec, but it seems that on some platforms,
> some register accesses (such as writing to the sleep control reg) are
> reliable only when accessed from cpu0.
> 
> This issue has been with us for some time:
> http://bugzilla.kernel.org/show_bug.cgi?id=1141
> 
> I am hopeful that the prepare-shutdown sequence you suggest below will
> not be necessary.
> 
> thanks,
> -Len
> 
> 
> On Wed, 2004-02-25 at 02:00, Willy Tarreau wrote:
> > Hi Len & Marcelo,
> > 
> > as I previously said, the patch I sent which fixes the poweroff on my VAIO is
> > not enough to shut down the supermicro P4 HT. So I borrowed some code from
> > machine_restart() to try to :
> >   - disable APIC  => was not enough, but I must retry on the VAIO
> >   - stop the second CPU => was not enough either
> >   - bounce on boot_cpu and stop the others => it did work.
> > 
> > So I think that ACPI is not SMP-proof nor HT-proof on some hardware. My new
> > problem is that I feel like the code I have included in acpi_power_off() to
> > do this is a bit too much x86 specific, so I'd like to move this to
> > arch/i386/kernel/process.c with all the rest, but I don't know how to cut
> > this. I think that a general function such as machine_prepare_shutdown() or
> > something like this would be useful and could be shared by both ACPI and
> > machine_restart(). It would basically to everything that is needed in such
> > a case :
> >   - on SMP, bounce on boot_cpu, then halt the current CPU if != boot_cpu
> >   - on SMP, stop all other CPUs
> >   - on UP, disable IOAPIC
> >   - disable local APIC
> > 
> > I suspect that this function would be useful for some suspend cases, but I'm
> > not sure. My other problem is to know what we should do then with other
> > arches. Create an identical function for everyone, or just call it from
> > ACPI on CONFIG_X86, or even add a CONFIG_MACHINE_PREPARE_SHUTDOWN ?
> > 
> > I need some feedback here. Any suggestions ?
> > 
> > Regards,
> > Willy
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
