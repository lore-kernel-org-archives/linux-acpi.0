From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [BUG 2.6.5-rc2-bk5 and 2.6.5-rc2-mm3] ACPI seems to be broken
Date: 26 Mar 2004 02:33:32 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080286412.756.182.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615F6523@hdsmsx402.hd.intel.com>
	 <1080278805.755.157.camel@dhcppc4>
	 <1080284583.2439.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1080284583.2439.8.camel-SyLVLa/KEI9HwK5hSS5vWB2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Trond Myklebust <trond.myklebust-41N18TsMXrtuMpJDpNschA@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low level)

yes, you're blessed with a system with non-identity SCI over-ride;-)

> evgpeblk-0747 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs
at 0000000000008020 on int 9
> evevent-0133: *** Error: Unable to install System Control Interrupt
Handler, AE_NOT_ACQUIRED
> evxfevnt-0139 [06] acpi_disable          : ACPI mode disabled

and it gets AE_NOT_ACQUIRED as expected and goes downhill from there...

if you can apply the patch and try IOAPIC mode again, that would be
great.

thanks,
-Len

ps

--------
not sure what is the matter with "noapic" mode.  This might be a
different problem.  may need to back out the latest ACPICA to see if the
"Handle is NULL" thingie is new.

ACPI: Using PIC for interrupt routing
Mar 26 01:36:41 lade kernel: nsxfeval-0241 [07] acpi_evaluate_object  :
Handle is NULL and Pathname is relative
...
Call Trace:
[__report_bad_irq+43/140] __report_bad_irq+0x2b/0x8c
[note_interrupt+105/153] note_interrupt+0x69/0x99
[do_IRQ+317/361] do_IRQ+0x13d/0x169
[common_interrupt+24/32] common_interrupt+0x18/0x20
[do_softirq+68/154] do_softirq+0x44/0x9a
[do_IRQ+282/361] do_IRQ+0x11a/0x169
[common_interrupt+24/32] common_interrupt+0x18/0x20
[acpi_processor_idle+194/482] acpi_processor_idle+0xc2/0x1e2
[cpu_idle+47/56] cpu_idle+0x2f/0x38
[start_kernel+411/472] start_kernel+0x19b/0x1d8
[unknown_bootoption+0/264] unknown_bootoption+0x0/0x108




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
