From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: fan status not working with kernel 2.6.0-test11 for Acer Travelmate 803 LCI
Date: Wed, 3 Dec 2003 10:05:06 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA033867F2@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?Herv=E9_Eychenne?= <rv-tT0dJoOmRgdg9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Herv=E9 Eychenne [mailto:rv-tT0dJoOmRgdg9hUCZPvPmw@public.gmane.org]
> Sent: Wednesday, December 03, 2003 2:11 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] fan status not working with kernel=20
> 2.6.0-test11 for Acer
> Travelmate 803 LCI
>=20
>=20
>  Hi,
>=20
> I have acpi activated (as well as every acpi features) on my Acer
> Travelmate 803 LCI (it's a laptop), with linux kernel 2.6.0-test11.

I have a D600 on linux 2.4.23 and 2.4.22-ac4

>=20
> Everything works quite well, except that:
> - old ACPI interface for performance management
>   (/proc/acpi/processor/CPU0/performance) doesn't work: echoing a
>   state number in it causes a small kernel oops, often=20
> killing the "su"
>   session itself.

Any echoing to this interface does _nothing_ at all. Should it? I've =
been
using=20
cpufreq to lower the cpu frequency to 600mhz

> - the fan is reported to be off, even when it is functionning. I'm
>   currently developping a little program which ensures a "silent mode"
>   (no fan activation), so it would be very useful.

I have _no_ fan status at all. ls -lR /proc/acpi/fan yields only
> total 0

I currently have the fan on the whole time!! I think it's causing a batt
drain. I get only 2:30 hours using the laptop.

HELp?

OW


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
