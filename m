From: Andrej Prsa <andrej.prsa-zs/Xt9NzJtxxh+DGd0HQrg@public.gmane.org>
Subject: HP/Compaq NC6120 ACPI problems
Date: Thu, 17 Mar 2005 20:00:52 +0100
Message-ID: <20050317200052.686d683f.andrej.prsa@guest.arnes.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Support <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi all,

I recently bought a new HP/Compaq NC6120 laptop which doesn't play well
with Linux. It took me a while to figure out that the problems are
probably ACPI-related.

The symptoms are as follows: computer starts fine, but within 20-30
seconds it gradually slows down to the point where it can no longer be
used - it takes 5 minutes to start the terminal. The fan doesn't work,
so the machine overheats. Using 'top' shows that 55% of CPU power is
consumed by kacpid.

If on the other hand I pass 'acpi=off' option to GRUB command line, the
computer hangs. In a rare event that it doesn't hang (I still can't
figure out what causes this behavior) it works in full speed without any
problems! A totally unreliable and probably a misleading thought is that
PCI interrupts are messed up without ACPI; this assumption is based
on the fact that the system hangs prior to the statement:

ACPI: PCI interrupt 0000:02:06.2[C] -> GSI 22 (level, low) -> IRQ 217

in dmesg (which occurs if ACPI is left on). When ACPI is turned off,
the fan works normally and there is no overheating whatsoever.

I hope I'm not too cryptic and that all of this makes at least some
sense. I also tried recompiling the 2.6.11.4 kernel and fiddling with
ACPI settings, but the result is kernel panic with VFS related problem
(although I created ramdisk by hand and I'm sure everything else is ok).

Used configuration: Debian testing (Sarge), kernel 2.6.8

I'm posting the original DSDT table:

	http://www.fiz.uni-lj.si/~prsa/acpi/dsdt.aml

The disassembled DSDT table using iasl -d:

	http://www.fiz.uni-lj.si/~prsa/acpi/dsdt.dsl

The precompiled DSDT table using iasl -tc:

	http://www.fiz.uni-lj.si/~prsa/acpi/dsdt.hex

Although there are 0 errors and 2 warnings, I still tend to blame ACPI
for my problems.

Does anyone have any suggestions on how to proceed and what to do next?

Thanks,

Andrej


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
