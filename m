From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: Re: PROBLEM: ACPI freezes 2.6.1 on boot
Date: Wed, 21 Jan 2004 23:29:51 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3ptddgckg.fsf@reason.gnu-hamburg>
References: <7F740D512C7C1046AB53446D3720017361885C@scsmsx402.sc.intel.com>
	<m3u12pgfpr.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m3u12pgfpr.fsf-glUV91rXKAHWIjgkaejU9x2eb7JE58TQ@public.gmane.org> (Georg C. F. Greve's
 message of "Wed, 21 Jan 2004 22:21:52 +0100")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Nakajima, Jun" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Martin Loschwitz <madkiss-R0iKqZn4BxJAfugRpC6u6w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

UPDATE:

Out of curiosity and because it seemed to be the interrupt handling
that was problematic, I disabled "Local APIC support on uniprocessors."

That convinced the machine to boot with ACPI.

Here is an excerpt from dmesg regarding ACPI only:

[...]
ACPI: RSDP (v000 ACPIAM                                    ) @ 0x000f4b60
ACPI: RSDT (v001 A M I  OEMRSDT  0x06000310 MSFT 0x00000097) @ 0x1f740000
ACPI: FADT (v002 A M I  OEMFACP  0x06000310 MSFT 0x00000097) @ 0x1f740200
ACPI: OEMB (v001 A M I  OEMBIOS  0x06000310 MSFT 0x00000097) @ 0x1f750040
ACPI: DSDT (v001  0ABBD 0ABBD001 0x00000001 MSFT 0x0100000d) @ 0x00000000
[...]
ACPI: Subsystem revision 20031002
ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
[...]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 *4 5 6 7 12)
ACPI: Power Resource [GFAN] (off)
[...]
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 4
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
[...]
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1600MHz": max frequency: 1600000kHz
[...]
ACPI: AC Adapter [AC0] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Fan [FN00] (off)
ACPI: Processor [CPU1] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THRM] (54 C)
Asus Laptop ACPI Extras version 0.26
  M2N model detected, supported
[...]
Resume Machine: resuming from /dev/hda8
Resuming from device hda8
Resume Machine: This is normal swap space
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S1 S3 S4 S5)
[...]


This looks pretty good, I think. Already checked some
funcionality. Suspend to RAM seems to work, although the display
remains dark on restart (but normal shutdown works, so the machine is
definitely back up).

So the problem we've been seeing seems to be related to the
interaction between local APIC support and ACPI.

I hope this helps tracking it down...

Regards,
Georg


P.S. Martin? Can you reproduce this?

-- 
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
