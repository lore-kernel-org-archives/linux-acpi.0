From: "Rockefeller, Harry" <harryr-qMhjF6E6u3VBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [ACPI-sppt] Problems with ACPI on SiS-powered laptop
Date: Thu, 5 Feb 2004 09:38:22 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <7105F2BD9451D7479B4B3A99A2B72FAC0544B1CB@exchange1.ssd.fsi.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C3EBFE.16760B22"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C3EBFE.16760B22
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Disclaimer:  I don't know what the problem is.
I don't know how to fix it.  All I can offer are
trial-and-error suggestions.  Maybe someone with
more knowledge will see this and be compelled to
answer correctly.
;-)

Take a look in /usr/src/linux/Documentation/kernel-parameters.txt
and try some different boot param options pertaining to
'acpi'.  This assumes your kernel documentation is up to date,
which is almost never the case. :-(

Rebuild your kernel without acpi power, ac, and battery options to see
if you can eliminate the error.  Then add them in one at a time to
see if you can isolate the error to one acpi configuration.

I presume your /proc/acpi/battery and /proc/acpi/ac_adapter 'files'
appear normal.

FWIW, my laptop shows:
 ACPI: AC Adapter [AC0] (on-line)
instead of your:
> ACPI: AC Adapter [AC] (on-line)

> -----Original Message-----
> From: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
> [mailto:acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf=20
> Of Andrej Prsa
> Sent: Thursday, February 05, 2004 3:20 AM
> To: ACPI Support
> Subject: [ACPI-sppt] Problems with ACPI on SiS-powered laptop
>=20
> Hi!
>=20
> I'm having difficulties with ACPI on my laptop; here's the=20
> excerpt from dmesg that is relevant to ACPI:
>=20
>  BIOS-e820: 000000000dff0000 - 000000000dffffc0 (ACPI data)
>  BIOS-e820: 000000000dffffc0 - 000000000e000000 (ACPI NVS)
> ACPI: have wakeup address 0xc0001000
> ACPI: RSDP (v000 OID_00                                    )=20
> @ 0x000e5010
> ACPI: RSDT (v001 INSYDE RSDT_000 0x00000001 =90& 0x00010007) @=20
> 0x0dfffbc0
> ACPI: FADT (v001 INSYDE FACP_000 0x00000100 =90& 0x00010007) @=20
> 0x0dfffac0
> ACPI: BOOT (v001 INSYDE ISC_BOOT 0x00000100 =90& 0x00010007) @=20
> 0x0dfffb50
> ACPI: DBGP (v001 INSYDE DBGP_000 0x00000001 =90& 0x00010007) @=20
> 0x0dfffb80
> ACPI: DSDT (v001 INSYDE     8575 0x00001002 INTL 0x02002025)=20
> @ 0x00000000
> ACPI: Subsystem revision 20040116
> ACPI: IRQ9 SCI: Edge set to Level Trigger.
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: System [ACPI] (supports S0 S3 S4 (swsusp) S5)
> ACPI: PCI Root Bridge [PCI0] (00:00)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: Embedded Controller [EC0] (gpe 25)
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 10 11)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 *6 10 11)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 10 11)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11)
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11)
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 *10 11)
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11)
> ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
> ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
> ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
> ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 6
> ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
> PCI: Using ACPI for IRQ routing
> ACPI: Processor [CPU0] (supports C1, 8 throttling states)
> ACPI: AC Adapter [AC] (on-line)
>     ACPI-0352: *** Error: Looking up [ACST] in namespace, =
AE_NOT_FOUND
>     ACPI-1120: *** Error: Method execution failed=20
> [\_SB_.BAT0._BTP] (Node cdf39500), AE_NOT_FOUND
> ACPI: Battery Slot [BAT0] (battery present)
> ACPI: Power Button (FF) [PWRF]
> ACPI: Sleep Button (CM) [SBTN]
> ACPI: Lid Switch [LID]
>=20
> Shutting the machine down works, but restarting hangs it; I=20
> already reported this problem awhile ago (along with acpi=20
> dump). Any idea how (and if at all) to get rid of this problem?
>=20
> I'm running kernel 2.4.24 along with ACPI patch 20040116.
>=20
> Thanks,
>=20
> Andrej
>=20
>=20
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004 Premiere=20
> Conference on Open Tools Development and Integration See the=20
> breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> ACPI-support mailing list
> ACPI-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-support
>=20

------_=_NextPart_001_01C3EBFE.16760B22
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2657.73">
<TITLE>RE: [ACPI-sppt] Problems with ACPI on SiS-powered laptop</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Disclaimer:&nbsp; I don't know what the problem =
is.</FONT>
<BR><FONT SIZE=3D2>I don't know how to fix it.&nbsp; All I can offer =
are</FONT>
<BR><FONT SIZE=3D2>trial-and-error suggestions.&nbsp; Maybe someone =
with</FONT>
<BR><FONT SIZE=3D2>more knowledge will see this and be compelled =
to</FONT>
<BR><FONT SIZE=3D2>answer correctly.</FONT>
<BR><FONT SIZE=3D2>;-)</FONT>
</P>

<P><FONT SIZE=3D2>Take a look in =
/usr/src/linux/Documentation/kernel-parameters.txt</FONT>
<BR><FONT SIZE=3D2>and try some different boot param options pertaining =
to</FONT>
<BR><FONT SIZE=3D2>'acpi'.&nbsp; This assumes your kernel documentation =
is up to date,</FONT>
<BR><FONT SIZE=3D2>which is almost never the case. :-(</FONT>
</P>

<P><FONT SIZE=3D2>Rebuild your kernel without acpi power, ac, and =
battery options to see</FONT>
<BR><FONT SIZE=3D2>if you can eliminate the error.&nbsp; Then add them =
in one at a time to</FONT>
<BR><FONT SIZE=3D2>see if you can isolate the error to one acpi =
configuration.</FONT>
</P>

<P><FONT SIZE=3D2>I presume your /proc/acpi/battery and =
/proc/acpi/ac_adapter 'files'</FONT>
<BR><FONT SIZE=3D2>appear normal.</FONT>
</P>

<P><FONT SIZE=3D2>FWIW, my laptop shows:</FONT>
<BR><FONT SIZE=3D2>&nbsp;ACPI: AC Adapter [AC0] (on-line)</FONT>
<BR><FONT SIZE=3D2>instead of your:</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: AC Adapter [AC] (on-line)</FONT>
</P>

<P><FONT SIZE=3D2>&gt; -----Original Message-----</FONT>
<BR><FONT SIZE=3D2>&gt; From: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org =
</FONT>
<BR><FONT SIZE=3D2>&gt; [<A =
HREF=3D"mailto:acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">mailto:acpi-sup=
port-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</A>] On Behalf </FONT>
<BR><FONT SIZE=3D2>&gt; Of Andrej Prsa</FONT>
<BR><FONT SIZE=3D2>&gt; Sent: Thursday, February 05, 2004 3:20 =
AM</FONT>
<BR><FONT SIZE=3D2>&gt; To: ACPI Support</FONT>
<BR><FONT SIZE=3D2>&gt; Subject: [ACPI-sppt] Problems with ACPI on =
SiS-powered laptop</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Hi!</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; I'm having difficulties with ACPI on my laptop; =
here's the </FONT>
<BR><FONT SIZE=3D2>&gt; excerpt from dmesg that is relevant to =
ACPI:</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; BIOS-e820: 000000000dff0000 - =
000000000dffffc0 (ACPI data)</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; BIOS-e820: 000000000dffffc0 - =
000000000e000000 (ACPI NVS)</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: have wakeup address 0xc0001000</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: RSDP (v000 =
OID_00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ) </FONT>
<BR><FONT SIZE=3D2>&gt; @ 0x000e5010</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: RSDT (v001 INSYDE RSDT_000 0x00000001 =
=90&amp; 0x00010007) @ </FONT>
<BR><FONT SIZE=3D2>&gt; 0x0dfffbc0</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: FADT (v001 INSYDE FACP_000 0x00000100 =
=90&amp; 0x00010007) @ </FONT>
<BR><FONT SIZE=3D2>&gt; 0x0dfffac0</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: BOOT (v001 INSYDE ISC_BOOT 0x00000100 =
=90&amp; 0x00010007) @ </FONT>
<BR><FONT SIZE=3D2>&gt; 0x0dfffb50</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: DBGP (v001 INSYDE DBGP_000 0x00000001 =
=90&amp; 0x00010007) @ </FONT>
<BR><FONT SIZE=3D2>&gt; 0x0dfffb80</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: DSDT (v001 INSYDE&nbsp;&nbsp;&nbsp;&nbsp; =
8575 0x00001002 INTL 0x02002025) </FONT>
<BR><FONT SIZE=3D2>&gt; @ 0x00000000</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: Subsystem revision 20040116</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: IRQ9 SCI: Edge set to Level =
Trigger.</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: Interpreter enabled</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: Using PIC for interrupt routing</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: System [ACPI] (supports S0 S3 S4 (swsusp) =
S5)</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: PCI Root Bridge [PCI0] (00:00)</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: PCI Interrupt Routing Table =
[\_SB_.PCI0._PRT]</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: Embedded Controller [EC0] (gpe 25)</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 =
10 11)</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 =
11)</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 *6 =
10 11)</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 *6 =
10 11)</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 =
10 *11)</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 =
10 *11)</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 =
*10 11)</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 =
10 *11)</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: PCI Interrupt Link [LNKE] enabled at IRQ =
11</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: PCI Interrupt Link [LNKH] enabled at IRQ =
11</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: PCI Interrupt Link [LNKF] enabled at IRQ =
11</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: PCI Interrupt Link [LNKG] enabled at IRQ =
10</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: PCI Interrupt Link [LNKB] enabled at IRQ =
10</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: PCI Interrupt Link [LNKC] enabled at IRQ =
6</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: PCI Interrupt Link [LNKA] enabled at IRQ =
5</FONT>
<BR><FONT SIZE=3D2>&gt; PCI: Using ACPI for IRQ routing</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: Processor [CPU0] (supports C1, 8 =
throttling states)</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: AC Adapter [AC] (on-line)</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp; ACPI-0352: *** Error: =
Looking up [ACST] in namespace, AE_NOT_FOUND</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp; ACPI-1120: *** Error: =
Method execution failed </FONT>
<BR><FONT SIZE=3D2>&gt; [\_SB_.BAT0._BTP] (Node cdf39500), =
AE_NOT_FOUND</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: Battery Slot [BAT0] (battery =
present)</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: Power Button (FF) [PWRF]</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: Sleep Button (CM) [SBTN]</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI: Lid Switch [LID]</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Shutting the machine down works, but restarting =
hangs it; I </FONT>
<BR><FONT SIZE=3D2>&gt; already reported this problem awhile ago (along =
with acpi </FONT>
<BR><FONT SIZE=3D2>&gt; dump). Any idea how (and if at all) to get rid =
of this problem?</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; I'm running kernel 2.4.24 along with ACPI patch =
20040116.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Thanks,</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Andrej</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; =
-------------------------------------------------------</FONT>
<BR><FONT SIZE=3D2>&gt; The SF.Net email is sponsored by EclipseCon =
2004 Premiere </FONT>
<BR><FONT SIZE=3D2>&gt; Conference on Open Tools Development and =
Integration See the </FONT>
<BR><FONT SIZE=3D2>&gt; breadth of Eclipse activity. February 3-5 in =
Anaheim, CA.</FONT>
<BR><FONT SIZE=3D2>&gt; <A HREF=3D"http://www.eclipsecon.org/osdn" =
TARGET=3D"_blank">http://www.eclipsecon.org/osdn</A></FONT>
<BR><FONT SIZE=3D2>&gt; =
_______________________________________________</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI-support mailing list</FONT>
<BR><FONT SIZE=3D2>&gt; ACPI-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</FONT>
<BR><FONT SIZE=3D2>&gt; <A =
HREF=3D"https://lists.sourceforge.net/lists/listinfo/acpi-support" =
TARGET=3D"_blank">https://lists.sourceforge.net/lists/listinfo/acpi-supp=
ort</A></FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C3EBFE.16760B22--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
