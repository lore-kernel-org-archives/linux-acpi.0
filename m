From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi problem -- Error: Handler for [EmbeddedControl] returned AE_TIME
Date: Sun, 4 Sep 2005 17:24:01 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30047FA103@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: u15119-4pcC6BA0Z1GELgA04lAiVw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>ACPI: Embedded Controller [EC0] (gpe 3)
>    ACPI-0412: *** Error: Handler for [EmbeddedControl]=20
>returned AE_TIME
>    ACPI-0508: *** Error: Method execution failed=20
>[\_SB_.PCI0.LPC0.EC0_.BAT0._STA] (Node c18f2660), AE_TIME
>    ACPI-0156: *** Error: Method execution failed=20
>[\_SB_.PCI0.LPC0.EC0_.BAT0._STA] (Node c18f2660), AE_TIME

Christoph,
Sounds like you are running the latest.

What is the most recent kernel or patch where the battery
worked and you didn't get these messages?
Any difference if you boot the latest with "ec_burst=3D1"?

thanks,
-Len


>-----Original Message-----
>From: Christoph Thielecke [mailto:u15119-4pcC6BA0Z1GELgA04lAiVw@public.gmane.org]=20
>Sent: Saturday, September 03, 2005 8:56 PM
>To: Brown, Len
>Subject: acpi problem
>
>Hello Len,
>
>I have several problems with acpi on my acer aspire 5021wlmi.=20
>For some time it=20
>runs fine but after some newer kernels it wont work (no=20
>battery control,=20
>etc).
>
>Currently I use 2.6.13 with your acpi patch=20
>(acpi-20050902-2.6.13.diff.gz).
>
>At boot I got:
>
>--- snipp ---
>crissi@turion:~$ dmesg | grep ACPI
>ACPI: setting ELCR to 0200 (from 0c00)
>ACPI: bus type pci registered
>ACPI: Subsystem revision 20050902
>ACPI: Interpreter enabled
>ACPI: Using PIC for interrupt routing
>ACPI: PCI Root Bridge [PCI0] (0000:00)
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>ACPI: PCI Interrupt Link [LNKA] (IRQs *10 11)
>ACPI: PCI Interrupt Link [LNKB] (IRQs 10 *11)
>ACPI: PCI Interrupt Link [LNKC] (IRQs 10 *11)
>ACPI: PCI Interrupt Link [LNKD] (IRQs 10 *11)
>ACPI: PCI Interrupt Link [LNKE] (IRQs 10 *11), disabled.
>ACPI: PCI Interrupt Link [LNKF] (IRQs *10 11)
>ACPI: PCI Interrupt Link [LNKG] (IRQs 10 *11)
>ACPI: PCI Interrupt Link [LNKH] (IRQs 10 *11)
>ACPI: Embedded Controller [EC0] (gpe 3)
>    ACPI-0412: *** Error: Handler for [EmbeddedControl]=20
>returned AE_TIME
>    ACPI-0508: *** Error: Method execution failed=20
>[\_SB_.PCI0.LPC0.EC0_.BAT0._STA] (Node c18f2660), AE_TIME
>    ACPI-0156: *** Error: Method execution failed=20
>[\_SB_.PCI0.LPC0.EC0_.BAT0._STA] (Node c18f2660), AE_TIME
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB6_._PRT]
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PB7_._PRT]
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
>pnp: PnP ACPI init
>pnp: PnP ACPI: found 10 devices
>PnPBIOS: Disabled by ACPI PNP
>PCI: Using ACPI for IRQ routing
>ACPI: PCI Interrupt Link [LNKE] disabled and referenced, BIOS bug.
>ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
>ACPI: PCI Interrupt 0000:04:06.0[A] -> Link [LNKE] -> GSI 11=20
>(level, low) ->=20
>IRQ 11
>ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
>ACPI: PCI Interrupt 0000:00:14.1[A] -> Link [LNKA] -> GSI 10=20
>(level, low) ->=20
>IRQ 10
>ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
>ACPI: PCI Interrupt 0000:04:07.0[A] -> Link [LNKH] -> GSI 11=20
>(level, low) ->=20
>IRQ 11
>ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
>ACPI: PCI Interrupt 0000:00:13.0[A] -> Link [LNKD] -> GSI 11=20
>(level, low) ->=20
>IRQ 11
>ACPI: PCI Interrupt 0000:00:13.1[A] -> Link [LNKD] -> GSI 11=20
>(level, low) ->=20
>IRQ 11
>ACPI: PCI Interrupt 0000:00:13.2[A] -> Link [LNKD] -> GSI 11=20
>(level, low) ->=20
>IRQ 11
>ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
>ACPI: PCI Interrupt 0000:00:14.5[B] -> Link [LNKB] -> GSI 11=20
>(level, low) ->=20
>IRQ 11
>ACPI: PCI Interrupt 0000:00:14.6[B] -> Link [LNKB] -> GSI 11=20
>(level, low) ->=20
>IRQ 11
>ACPI: PCI interrupt for device 0000:00:14.6 disabled
>ACPI: PCI Interrupt 0000:00:14.6[B] -> Link [LNKB] -> GSI 11=20
>(level, low) ->=20
>IRQ 11
>ACPI: PCI Interrupt 0000:04:06.0[A] -> Link [LNKE] -> GSI 11=20
>(level, low) ->=20
>IRQ 11
>ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
>ACPI: PCI Interrupt 0000:04:06.2[C] -> Link [LNKG] -> GSI 11=20
>(level, low) ->=20
>IRQ 11
>    ACPI-0412: *** Error: Handler for [EmbeddedControl]=20
>returned AE_TIME
>    ACPI-0508: *** Error: Method execution failed=20
>[\_SB_.PCI0.LPC0.EC0_.BAT0._BIF] (Node c18f2640), AE_TIME
>ACPI: AC Adapter [ADP1] (on-line)
>ACPI: Power Button (FF) [PWRF]
>ACPI: Lid Switch [LID0]
>ACPI: Sleep Button (CM) [SLPB]
>    ACPI-0412: *** Error: Handler for [EmbeddedControl]=20
>returned AE_TIME
>    ACPI-0508: *** Error: Method execution failed=20
>[\_TZ_.TZS0._TMP] (Node=20
>c18ed4c0), AE_TIME
>ACPI: Thermal Zone [TZS0] (60 C)
>    ACPI-0412: *** Error: Handler for [EmbeddedControl]=20
>returned AE_TIME
>    ACPI-0508: *** Error: Method execution failed=20
>[\_TZ_.TZS1._TMP] (Node=20
>c18ed3c0), AE_TIME
>ACPI: Thermal Zone [TZS1] (50 C)
>    ACPI-0412: *** Error: Handler for [EmbeddedControl]=20
>returned AE_TIME
>    ACPI-0508: *** Error: Method execution failed=20
>[\_TZ_.TZSV._TMP] (Node=20
>c18ed2a0), AE_TIME
>ACPI: Thermal Zone [TZSV] (55 C)
>ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
>ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKC] -> GSI 11=20
>(level, low) ->=20
>IRQ 11
>ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKC] -> GSI 11=20
>(level, low) ->=20
>IRQ 11
>ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
>ACPI: PCI Interrupt 0000:04:05.0[A] -> Link [LNKF] -> GSI 10=20
>(level, low) ->=20
>IRQ 10
>--- snapp ---
>
>Info: kernel command line: ro noapic oapictimer pci=3Dassign-busses
>
>Do you have a idea whats going wrong?
>
>Best regards
>
>Christoph
>--=20
>Linux User Group Wernigerode
>http://www.lug-wr.de/
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
