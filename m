From: Luc Saillard <luc.saillard-A5NNTvo2L0pl57MIdRCFDg@public.gmane.org>
Subject: Re: ACPI Link device suspend/resume
Date: Thu, 4 Nov 2004 10:55:37 +0100
Message-ID: <20041104095537.GA16315@hottah.alcove-fr>
References: <16A54BF5D6E14E4D916CE26C9AD30575745E99@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575745E99-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>, ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 02, 2004 at 03:12:03PM +0800, Li, Shaohua wrote:
> Oops, should add irq_disabled. Please try.
> Actually every laptop in PIC mode will oops when resume ACPI link
> device, if 'CONFIG_DEBUG_SPINLOCK_SLEEP' enabled.

I've try the patch, and no problem with it. Thanks for your patch, here my
dmesg (i've resume 3 times to be sure).

Luc

PM: Preparing system for suspend
Stopping tasks: ======================================|
eth1: Going into suspend...
PM: Entering state.
Back to C!
sonypi: unknown event port1=0x0e,port2=0x05
PM: Finishing up.
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ACPI: PCI interrupt 0000:00:1f.1[A]: no GSI
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ACPI: PCI interrupt 0000:02:05.1[B] -> GSI 9 (level, low) -> IRQ 9
eth1: Coming out of suspend...
e100: eth0: e100_watchdog: link up, 10Mbps, half-duplex
eth1: Radio is disabled by RF switch
Restarting tasks...<6>usb 2-1: USB disconnect, address 2 
done
usb 2-1: new low speed USB device using address 3
input: USB HID v1.10 Mouse [Genius NetScroll + Mini Traveler] on usb-0000:00:1d.                                  1-1
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 1: f200000000000185


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
