From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: system slow since ~ 2.6.7
Date: 23 Nov 2004 00:04:52 -0500
Message-ID: <1101186291.20008.247.camel@d845pe>
References: <Pine.LNX.4.60.0411180115490.941@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.60.0411180115490.941-J+lI668vivfmY97RW1zN3Q@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-11-17 at 19:25, Guennadi Liakhovetski wrote:
> "Slow" means just running top alone in a vt it takes 1.6% CPU. Under
> 2.6.3 it takes 0.2% (Duron 900MHz). Another peculiarity with 2.6.7 and
> 2.6.9 is that the power LED is blinking with about 1Hz frequency. It's
> an ASUS A7VI-VM motherboard. In the manual there's nothing about
> error-codes. I played with various APIC settings - no change. Related
> or not - if running with LAPIC enabled (2.6.7), I get quite a few ERR
> in /proc/interrupts.

PCI: Disabling Via external APIC routing

Curiously, this line appears in 2.6.3, but not in 2.6.7 or 2.6.9 dmesg
-- even though all the configs build in IOAPIC support.

Can you forward the /proc/interrupts from 2.6.3, and from 2.6.9 with and
without acpi=off?  do you see a significant change in /proc/interrupts
before and after the sensor-provoked slowness starts?

if you build 2.6.9 w/o the CONFIG_ACPI_PROCESSOR and boot w/o cmdline
params, do you still see slowness?

if you boot 2.6.9 with these parameters, do you see any additional dmesg
lines?

acpi_dbg_level=0xF acpi_dbg_layer=0xFFFF3FFF


thanks,
-Len




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
