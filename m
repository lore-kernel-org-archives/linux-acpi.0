From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: Re: acpi_processor_get_per: Unsupported address space
Date: 23 Jul 2003 01:07:42 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1058918863.1431.13.camel@darkstar.portugal>
References: <m2oezpghjy.fsf@tnuctip.rychter.com>
	<20030722121119.GA1964@brodo.de>  <m2znj677jv.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m2znj677jv.fsf-dTJq59+VGzkkCw8IV3R6h0EOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2003-07-22 at 19:14, Jan Rychter wrote:
> >>>>> "Dominik" =3D=3D Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org> writes:
>  Dominik> On Sun, Jul 20, 2003 at 11:49:05AM -0700, Jan Rychter wrote:
>  >> On a Toshiba Dynabook SS S7/290LNKW (Centrino-based), kernel
>  >> 2.4.22-pre7 (also tested with pre5).
>  >>
>  >> I am getting the following message at bootup:
>  >>
>  >> acpi_processor-0899 [31] acpi_processor_get_per: Unsupported address
>  >> space [127] (control_register) ACPI: Processor [CPU0] (supports C1
>  >> C2 C3) ACPI: Thermal Zone [THRM] (44 C)
>  >>
>  >> What does this mean? Does it indicate problems?

I can live with it :).
>=20
> The binary-only driver is for 2.4.21-rc1 only, so it's of no use to me
> (I have 2.4.22-pre7 and have to follow the -pre series because of USB
> bugs).
you have cpu-freq in 2.4.22-pre6-ac1 .
I try it, my self this kernel with acpi-20030714 patch, to and=20

 powernow: AMD K7 CPU detected.
 powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
 powernow: Found PSB header at c00f6b40
 powernow: Table version: 0x12
 powernow: Flags: 0x0 (Mobile voltage regulator)
 powernow: Settling Time: 100 microseconds.
 powernow: Has 36 PST tables. (Only dumping ones relevant to this CPU).
 powernow: PST:8 (@c00f6bc2)
 powernow:  cpuid: 0x762^Ifsb: 100^ImaxFID: 0xe^Istartvid: 0xc
 powernow:    FID: 0x4 (5.0x [500MHz])^IVID: 0xe (1.300V)
 powernow:    FID: 0x8 (7.0x [700MHz])^IVID: 0xe (1.300V)
 powernow:    FID: 0xe (10.0x [1000MHz])^IVID: 0xc (1.400V)

 powernow: Minimum speed 500 MHz. Maximum speed 1000 MHz.
 Starting kswapd
 Journalled Block Device driver loaded
 [ACPI Debug] String: ---------------------------- AC _PSR
 [ACPI Debug] String: ---------------------------- AC _FLPA
 [ACPI Debug] String: ---------------------------- AC on line
 ACPI: AC Adapter [AC] (on-line)
 [ACPI Debug] String: --------- VIA SOFTWARE SMI PMIO 2Fh ------------
 [ACPI Debug] String: ---------------- NABT < 6
 [ACPI Debug] String: ---------------- Li Battery
 [ACPI Debug] String: --------------------- DC >=3D 3000
 ACPI: Battery Slot [BAT0] (battery present)
 ACPI: Power Button (FF) [PWRF]
 ACPI: Sleep Button (CM) [SLPB]
 ACPI: Lid Switch [LID]
 acpi_processor-0897 [17] acpi_processor_get_per: Unsupported address space=
 [127] (control_register)
 ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)

>=20
> I have to say I feel kind of silly playing this hide and seek game with
> Intel. On one hand Intel says they support Linux
> (http://news.com.com/2100-1006-993896.html). On the other hand we get no
> support for speedstep (what on earth do you lose by telling people how
> to program your hardware?), no support for Centrino wireless LAN. I find
> it both ridiculous and sad.
>=20
> --J.
--=20
S=E9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
