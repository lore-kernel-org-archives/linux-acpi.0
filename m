From: Santiago Garcia Mantinan <manty-gaW6/AuhO2xeoWH0uzbU5w@public.gmane.org>
Subject: Re: acpi breaking synaptics mouse support on Acer Travelmate 260
Date: Sat, 23 Aug 2003 20:47:18 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030823184718.GA3780@man.beta.es>
References: <20030820210235.GD5127@man.beta.es> <Pine.LNX.4.33.0308211034040.581-100000@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0308211034040.581-100000-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: Peter Osterlund <petero2-zq6IREYz3ykAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

I've been testing today with 2.6.0test4 to see if things were going any
better, the problem is still there but the mouse seems to recover faster of
the problem, which makes me think... could it be that this very same problem
was also happening on 2.4 but I wasn't noticing it because no errors were
appearing on dmesg as the driver is no in the kernel?

> maybe your interrupts are routed differently depending on acpi compiled in
> or not.

Yes, seems so.

> What does
>  cat /proc/interrupts
> differ for both setups?

The only diff I can see on the /proc/interrupts is that acpi, wich was
sharing irq 9 with the sound card and the cardbus adapter is not shown on
no-acpi system and the sound and carbus adapter are on irq 10 now, also eth0
is on irq 5 using acpi and on irq 11 without acpi.

However, if I look at lspci changing from acpi to noacpi I can see that:
vga & usb go from irq 9 to 11
the other usb port goes from 5 to 11
the ide goes from 255 to 11 (there is a message on dmesg about the 255 thing)
SMBus goes from 9 to 10
sound card/modem go from 9 to 10
ethernet goes from 5 to 11
cardbus goes from 9 to 10

Some things like the modem,usb,smbus, ... were not shown on interrupts
because I don't have a driver loaded for them. BTW, ide does appear on
/proc/interrupts at irqs 14 and 15 as usual.

> What are the respectively acpi-versions?
>  cat /proc/acpi/info |grep version

On 2.4.22, which works ok, we have 20030619 and on 2.6.0 all of them fail,
and I have tried up to test4 (20030813).

> Did you check the /var/log/boot.msg for error-messages, especially related
> to ACPI?

I suppose you mean the kernel messages log, if I look at dmesg or the kernel
messages log the only weird thing I can see is the message I said before
about the ide irq:

ACPI: No IRQ known for interrupt pin A of device 0000:00:1f.1 - using IRQ 255

I have tried running with pci=noacpi and the only change was that this
message about the ide irq is not there anymore, the irqs I get assigned this
way are the same I get without acpi, of course, but the problem is still
there. I guess this means that the problem is not the irq assignement.

I don't know what else I can say or try. If you need any more info just ask
for it.

Thanks for your help.

Regards...
-- 
Manty/BestiaTester -> http://manty.net


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
