From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: HP/Compaq NC6120 ACPI problems
Date: Thu, 17 Mar 2005 12:48:24 -0700
Message-ID: <1111088904.11380.36.camel@eeyore>
References: <20050317200052.686d683f.andrej.prsa@guest.arnes.si>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050317200052.686d683f.andrej.prsa-zs/Xt9NzJtxxh+DGd0HQrg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrej Prsa <andrej.prsa-zs/Xt9NzJtxxh+DGd0HQrg@public.gmane.org>
Cc: ACPI Support <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-03-17 at 20:00 +0100, Andrej Prsa wrote:
> The symptoms are as follows: computer starts fine, but within 20-30
> seconds it gradually slows down to the point where it can no longer be
> used - it takes 5 minutes to start the terminal. The fan doesn't work,
> so the machine overheats. Using 'top' shows that 55% of CPU power is
> consumed by kacpid.

Take a look at /proc/interrupts a couple times, and see if there's
a device that's spewing interrupts.

> A totally unreliable and probably a misleading thought is that
> PCI interrupts are messed up without ACPI; this assumption is based
> on the fact that the system hangs prior to the statement:
> 
> ACPI: PCI interrupt 0000:02:06.2[C] -> GSI 22 (level, low) -> IRQ 217
> 
> in dmesg (which occurs if ACPI is left on). When ACPI is turned off,
> the fan works normally and there is no overheating whatsoever.

Try booting with "pci=routeirq".  If that makes a difference,
please post the dmesg log and output of "lspci".  If you can
also capture the dmesg log without "pci=routeirq", that would
also be useful.

> I also tried recompiling the 2.6.11.4 kernel and fiddling with
> ACPI settings, but the result is kernel panic with VFS related problem
> (although I created ramdisk by hand and I'm sure everything else is ok).

You can avoid the hassle of a ramdisk by building the drivers
and filesystems you need static (instead of as modules).

Bjorn




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
