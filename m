From: Bill Moseley <moseley-kv6DSSSScSo@public.gmane.org>
Subject: ACPI causes PCMCIA to fail with Toshiba Laptop
Date: Wed, 21 Apr 2004 11:11:04 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040421181104.GF4431@hank.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

(Sorry to anyone that already saw this post on the pcmcia list)

I seem to have a problem with ACPI and my CardBus bridge.  I know
very little about ACPI (I'm just trying to get wireless and ACPI
working), but it seems like interrupts are not getting set correctly for
the CardBus.

I'm not sure if I can fix my ACPI tables - if that's the problem (or how such a 
procedure is even done).

This is all I know at this point:

Toshiba 2805-S302 laptop running 2.6.5 kernel.  Upon boot I see:

    PCI: Enabling device 0000:00:0b.0 (0000 -> 0002)
    ACPI: No IRQ known for interrupt pin A of device 0000:00:0b.0 - using IRQ 255
    Yenta: CardBus bridge found at 0000:00:0b.0 [1179:0001]
    Yenta: ISA IRQ mask 0x0cb8, PCI irq 0


When my SMC2632W wireless card tries to install I see:

Apr 20 22:45:43 localhost cardmgr[345]: socket 1: Intersil PRISM2 11 Mbps Wireless Adapter
Apr 20 22:45:43 localhost cardmgr[345]: executing: 'modprobe orinoco_cs'
Apr 20 22:45:43 localhost kernel: orinoco.c 0.13e (David Gibson <hermes-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org> and others)
Apr 20 22:45:43 localhost kernel: orinoco_cs.c 0.13e (David Gibson <hermes-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org> and others)
Apr 20 22:45:43 localhost kernel: orinoco_cs: RequestIRQ: Resource in use
Apr 20 22:45:44 localhost cardmgr[345]: get dev info on socket 1 failed: Resource temporarily unavailable


And then if I pull the card the system hangs.

If I disable acpi it works, but I'd like to get acpi working, if at all
possible without resorting to pci=noacpi or acpi=off.

Any suggestions?


Thanks,




-- 
Bill Moseley
moseley-kv6DSSSScSo@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
