From: "DPR" <info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org>
Subject: RE: APIC, USB mouse and errors
Date: Sat, 1 Mar 2003 03:45:48 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000001c2df9c$ab20f030$0200a8c0@brutzler>
References: <C50AB9511EE59B49B2A503CB7AE1ABD10440E418@cceexc19.americas.cpqcorp.net>
Reply-To: <info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0001_01C2DFA5.0CE55830"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C50AB9511EE59B49B2A503CB7AE1ABD10440E418-Iar2LzuD2f6P0FQRY6S+e9kSKC0Mw0DFJ8am2ALHCgk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "'Cagle, John (ISS-Houston)'" <john.cagle-VXdhtT5mjnY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0001_01C2DFA5.0CE55830
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi John,

YOU GOT IT - GREAT JOB !!!
I made an ugly but working hack in "mp_config_acpi_legacy_irqs" - I simply forced the trigger
mode to "level" for my USB-IRQs. And now everything works fine !!! If you find another way to
fix it - let me know ;)

Besides, do you know why the high IRQs (>17) are not used at all ? I'm just wondering why M$
Windows produces such a different IRQ-mapping - take a look at the attached file (IRQs
0,1,4,6,8,9,13,15-19,21,23 are used).

Thanks for your professional help,

HOLGER


> Holger,
> 
> I think that your APIC IRQs (0..15) aren't getting programmed 
> properly.
> 
> PCI is using IRQs 10, 11, 12 & 14, but I think the kernel has made an
> incorrect assumption that these are ISA IRQs and set them to be
> edge-triggered.  PCI IRQs are always level-triggered.
> 
> Take a look at arch/i386/kernel/mpparse.c in the
> mp_config_acpi_legacy_irqs() routine.  It sets  interrupts 
> 0..15 to ISA
> bus conforming behavior (edge).
> 
> You might try forcing the kernel to do the right thing and see what
> happens.
> 
> Regards,
> John

------=_NextPart_000_0001_01C2DFA5.0CE55830
Content-Type: text/plain;
	name="I-O APIC.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="I-O APIC.txt"

I/O APIC=0A=
-------------------------------------------------------------------------=
-------=0A=
APIC ID                       : 2=0A=
Implementation Version        : 3=0A=
Arbitration ID                : 1=0A=
Base Address                  : FEC00000h=0A=
IRQ Assertion Register        : Supported=0A=
=0A=
+--------+-------------+----------+----------+---------+--------+--------=
--------------------------+=0A=
| APIC   | Interrupt   | Delivery | Polarity | Trigger | Remote | =
Destination                      |=0A=
| INTIN# | Vector      | Mode     | Active-  | Mode    | IRR    |        =
                          |=0A=
+--------+-------------+----------+----------+---------+--------+--------=
--------------------------+=0A=
|  00h   | FFh (Masked)| Fixed    | High     | Level   |   0    | APIC =
ID    =3D 0                   |=0A=
|  01h   | 93h         | Lowest   | High     | Level   |   0    | =
Processors =3D 0                   |=0A=
|  02h   | FFh (Masked)| Fixed    | High     | Level   |   0    | APIC =
ID    =3D 0                   |=0A=
|  03h   | FFh (Masked)| Fixed    | High     | Level   |   0    | APIC =
ID    =3D 0                   |=0A=
|  04h   | 92h         | Lowest   | High     | Level   |   0    | =
Processors =3D 0                   |=0A=
|  05h   | FFh (Masked)| Fixed    | High     | Level   |   0    | APIC =
ID    =3D 0                   |=0A=
|  06h   | B3h (Masked)| Lowest   | High     | Level   |   0    | =
Processors =3D 0                   |=0A=
|  07h   | FFh (Masked)| Fixed    | High     | Level   |   0    | APIC =
ID    =3D 0                   |=0A=
|  08h   | D1h         | Fixed    | High     | Level   |   0    | =
Processors =3D 0                   |=0A=
|  09h   | B1h         | Lowest   | Low      | Edge    |   0    | =
Processors =3D 0                   |=0A=
|  0Ah   | FFh (Masked)| Fixed    | High     | Level   |   0    | APIC =
ID    =3D 0                   |=0A=
|  0Bh   | FFh (Masked)| Fixed    | High     | Level   |   0    | APIC =
ID    =3D 0                   |=0A=
|  0Ch   | FFh (Masked)| Fixed    | High     | Level   |   0    | APIC =
ID    =3D 0                   |=0A=
|  0Dh   | FFh (Masked)| Fixed    | High     | Level   |   0    | APIC =
ID    =3D 0                   |=0A=
|  0Eh   | FFh (Masked)| Fixed    | High     | Level   |   0    | APIC =
ID    =3D 0                   |=0A=
|  0Fh   | 82h         | Lowest   | High     | Level   |   0    | =
Processors =3D 0                   |=0A=
|  10h   | 63h         | Lowest   | Low      | Edge    |   0    | =
Processors =3D 0                   |=0A=
|  11h   | 73h         | Lowest   | Low      | Edge    |   0    | =
Processors =3D 0                   |=0A=
|  12h   | B4h         | Lowest   | Low      | Edge    |   0    | =
Processors =3D 0                   |=0A=
|  13h   | 83h         | Lowest   | Low      | Edge    |   0    | =
Processors =3D 0                   |=0A=
|  14h   | FFh (Masked)| Fixed    | High     | Level   |   0    | APIC =
ID    =3D 0                   |=0A=
|  15h   | A4h         | Lowest   | Low      | Edge    |   0    | =
Processors =3D 0                   |=0A=
|  16h   | FFh (Masked)| Fixed    | High     | Level   |   0    | APIC =
ID    =3D 0                   |=0A=
|  17h   | 94h         | Lowest   | Low      | Edge    |   0    | =
Processors =3D 0                   |=0A=
+--------+-------------+----------+----------+---------+--------+--------=
--------------------------+=0A=
=0A=

------=_NextPart_000_0001_01C2DFA5.0CE55830--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
