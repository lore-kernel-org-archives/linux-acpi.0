From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Return package for WAK
Date: Thu, 22 Apr 2004 09:57:00 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE05579BA7D@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: emejia-EkmVulN54Sk@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The ACPI subsystem does not look at the return value at this time, so
the warning can be ignored.

I'm considering removing this warning anyway, since the spec seems to
imply that the return value is "optional".

Bob


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Emilio Mejia Fernandez de
> Velasco
> Sent: Monday, April 19, 2004 2:55 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] Return package for WAK
>=20
> Hello,
> I opened a thread this weekend, but I still haven't solved the
problems to
> install acpi in my laptop.
> I got a warning when compiling my dsdt, and it is a well known bug of
non
> returned value for the function WAK.
> In order to skip the warning message, I added a return value with a
> package
> containing two zeros, but this is not supposed to fix the real bug.
> So I don't know which value it should really return, and what is more
> important, I don't know if this can be the cause of the unstability of
the
> system.
> As I explained in last thread, after some minutes working the laptop
> freezes,
> and it doesn't respond to the keyboard nor trying to log in remotely
with
> ssh, so it makes me reboot with the power button.
> I have compiled the kernel with debug messages option, but nothing
> relevant is
> reported in /var/log/messages, only a periodic set of messages related
to
> the
> thermal zone, but they happen periodically before breaking down, I
can't
> tell
> the moment when it freezes.
> Here is the result of dmesg | grep ACPI:
>=20
> BIOS-e820: 0000000016ff0000 - 0000000016fffc00 (ACPI data)
> BIOS-e820: 0000000016fffc00 - 0000000017000000 (ACPI NVS)
> ACPI: RSDP (v000 PTLTD                                     ) @
0x000f7030
> ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @
0x16ffba62
> ACPI: FADT (v001 VT8603 TWISTER  0x06040000 PTL  0x000f4240) @
0x16fffb64
> ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @
0x16fffbd8
> ACPI: DSDT (v001  VIA   PTL_ACPI 0x06040000 MSFT 0x0100000b) @
0x00000000
> ACPI: Looking for DSDT in initrd ... found customized DSDT with 15240
> bytes!
> ACPI: Subsystem revision 20040326
> ACPI: Using customized DSDT
>  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully
> acquired
> ACPI Namespace successfully loaded at root c03b9ffc
> ACPI: IRQ9 SCI: Edge set to Level Trigger.
> evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
> successful
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (00:00)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
> ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 5)
> ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PPB_._PRT]
> ACPI: Power Resource [PFAN] (off)
> ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
> ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
> PCI: Using ACPI for IRQ routing
> [ACPI Debug] String: Length 0x22, "__________________________________"
> [ACPI Debug] String: Length 0x00, ""
> [ACPI Debug] String: Length 0x08, "ACAD_PSR"
> [ACPI Debug] String: Length 0x22, "__________________________________"
> [ACPI Debug] String: Length 0x22, "__________________________________"
> [ACPI Debug] String: Length 0x00, ""
> [ACPI Debug] String: Length 0x0F, "ACAD_PSR Return"
> [ACPI Debug] String: Length 0x22, "__________________________________"
> [ACPI Debug] String: Length 0x22, "__________________________________"
> [ACPI Debug] String: Length 0x00, ""
> [ACPI Debug] Integer: 0x0000000000000001
> [ACPI Debug] String: Length 0x22, "__________________________________"
> ACPI: AC Adapter [ACAD] (on-line)
> [ACPI Debug] String: Length 0x22, "__________________________________"
> [ACPI Debug] String: Length 0x00, ""
> [ACPI Debug] String: Length 0x10, "BAT0_BIF_RETURN:"
> [ACPI Debug] String: Length 0x22, "__________________________________"
> [ACPI Debug] String: Length 0x22, "__________________________________"
> [ACPI Debug] String: Length 0x00, ""
> [ACPI Debug] Package: Size 0x0D Elements Ptr - d6fecf48
> [ACPI Debug] String: Length 0x22, "__________________________________"
> ACPI: Battery Slot [BAT0] (battery present)
> ACPI: Power Button (FF) [PWRF]
> ACPI: Lid Switch [LID]
> ACPI: Fan [FAN] (on)
> ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
> [ACPI Debug] String: Length 0x22, "__________________________________"
> [ACPI Debug] String: Length 0x00, ""
> [ACPI Debug] String: Length 0x08, "THRM_TMP"
> [ACPI Debug] String: Length 0x22, "__________________________________"
> [ACPI Debug] String: Length 0x22, "__________________________________"
> [ACPI Debug] String: Length 0x00, ""
> [ACPI Debug] String: Length 0x08, "THRM_TMP"
> [ACPI Debug] String: Length 0x22, "__________________________________"
> ACPI: Thermal Zone [THRM] (73 C)
> [ACPI Debug] Integer: 0x0000000000000001
> [ACPI Debug] Integer: 0x000000000000004A
> [ACPI Debug] Integer: 0x0000000000000032
> [ACPI Debug] Integer: 0x0000000000000001
> [ACPI Debug] Integer: 0x000000000000004A
> [ACPI Debug] Integer: 0x0000000000000044
> [ACPI Debug] String: Length 0x22, "__________________________________"
> [ACPI Debug] String: Length 0x00, ""
> [ACPI Debug] String: Length 0x08, "THRM_TMP"
> [ACPI Debug] String: Length 0x22, "__________________________________"
> [ACPI Debug] String: Length 0x22, "__________________________________"
> [ACPI Debug] String: Length 0x00, ""
> [ACPI Debug] String: Length 0x08, "THRM_TMP"
> [ACPI Debug] String: Length 0x22, "__________________________________"
>=20
> These four last lines are the ones repeated periodically in
> the /var/log/messages file.
>=20
> Attached is the dsdt.asl file obtained with acpidump, which doesn't
> include
> the correction in the WAK function even though I modified it adding a
> returned package with two zeros. Anyway, the dsl file decodified with
iasl
> does recognize the changes.
> Can anybody please give me any clue about why can the laptop hang?
> Can the dsdt table be the problem?
> I start with this line in the menu file for grub:
> kernel		/boot/vmlinuz-2.6.4 root=3D/dev/hda2 ro acpi=3Dforce
noapic
> acpi_os_name=3D"Microsoft Windows XP"
> I have also tried with nolapic instead of noapic, but it still freezes
>=20
> Thank you
>=20
> Emilio Mejia


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
