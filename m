From: Andrej Prsa <andrej.prsa-zs/Xt9NzJtxxh+DGd0HQrg@public.gmane.org>
Subject: Re: HP/Compaq NC6120 ACPI problems
Date: Thu, 17 Mar 2005 21:56:35 +0100
Message-ID: <20050317215635.1c788c09.andrej.prsa@guest.arnes.si>
References: <20050317200052.686d683f.andrej.prsa@guest.arnes.si>
	<1111088904.11380.36.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <1111088904.11380.36.camel@eeyore>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: ACPI Support <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

> > The symptoms are as follows: computer starts fine, but within 20-30
> > seconds it gradually slows down to the point where it can no longer
> > be used - it takes 5 minutes to start the terminal. The fan doesn't
> > work, so the machine overheats. Using 'top' shows that 55% of CPU
> > power is consumed by kacpid.
> 
> Take a look at /proc/interrupts a couple times, and see if there's
> a device that's spewing interrupts.

Observational update: it does *NOT* gradually slow down, it slows down
*instantly* after 2-3 minutes of running; the time of kacpid blowup is
somewhat arbitrary, it sometimes happens even before the boot-up is
complete. If I was to make another wild guess, it might be connected
with the fan - when the computer is cool, the blowup occurs later, if it
is warm, it occurs sooner. Is it possible that the call to turn the fan
on is triggering this kacpid blowup? How does one go about to test this?

For the first time I was now running 'top' from the moment a computer
came up to the moment kacpid boosted CPU consumption. Another erratum:
it is not 55% of CPU power for kacpid, it is 98%-99% of CPU power
reported in 'top'.

I did 'cat /proc/interrupts' before and after this discrete change in
behavior and I didn't notice anything out of the ordinary. For the sake
of completion I'm posting the contents 1-2 minutes after the kacpid
blowup here:

	http://www.fiz.uni-lj.si/~prsa/acpi/procint.txt

Also, I had 'tail -f /var/log/messages' and 'tail -f /var/log/syslog'
when the blowup occured - there were no outputs to those two files at
the time of blowup.

> > A totally unreliable and probably a misleading thought is that
> > PCI interrupts are messed up without ACPI; this assumption is based
> > on the fact that the system hangs prior to the statement:
> > 
> > ACPI: PCI interrupt 0000:02:06.2[C] -> GSI 22 (level, low) -> IRQ
> > 217
> > 
> > in dmesg (which occurs if ACPI is left on). When ACPI is turned off,
> > the fan works normally and there is no overheating whatsoever.
> 
> Try booting with "pci=routeirq".  If that makes a difference,
> please post the dmesg log and output of "lspci".  If you can
> also capture the dmesg log without "pci=routeirq", that would
> also be useful.

The option pci=routeirq doesn't help, hence I'm omitting the dmesg
output. If you find it useful, I could still put it to www.

This is the dmesg output of a standard boot:

	http://www.fiz.uni-lj.si/~prsa/acpi/dmesg.acpi_on.out

And here you may find the lspci outputs:

	http://www.fiz.uni-lj.si/~prsa/acpi/lspci.out
	http://www.fiz.uni-lj.si/~prsa/acpi/lspci-v.out
	http://www.fiz.uni-lj.si/~prsa/acpi/lspci-vv.out

> > I also tried recompiling the 2.6.11.4 kernel and fiddling with
> > ACPI settings, but the result is kernel panic with VFS related
> > problem (although I created ramdisk by hand and I'm sure everything
> > else is ok).
> 
> You can avoid the hassle of a ramdisk by building the drivers
> and filesystems you need static (instead of as modules).

I thought I needed initrd functionality to use the corrected DSDT tables
- that's what I did on my old laptop, because I recompile my kernel
often and I don't feel like constantly patching the kernel for
custom-made DSDT. But if you can suggest any better approach, I'd be
happy to hear about it! :)

Thanks,

Andrej


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
