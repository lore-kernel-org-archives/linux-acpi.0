From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sbasto-n97bsLhj/YhQPh2TJV30h1aTQe2KTcn/@public.gmane.org>
Subject: Re: Instability without ACPI
Date: 11 Jul 2003 19:17:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1057947446.1451.51.camel@darkstar.portugal>
References: <200307110022.29512.adq_dvb@lidskialf.net>
	<200307111356.22376.adq_dvb@lidskialf.net>
	<20030711140227.GF22636@poupinou.org>
	<200307111806.57883.adq_dvb@lidskialf.net>
	<20030711172639.GL22636@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030711172639.GL22636-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2003-07-11 at 18:26, Ducrot Bruno wrote:
>=20
> You probably need acpi due to power states for the cpu.  Common problem
> with laptop shipped with athlon in general (there is a tool called
> lvcool though if you do not have acpi).

sounds cool
I have one athlon 4 on one KT133.
but after reading=20
http://cip.uni-trier.de/nofftz/linux/Athlon-Powersaving-HOWTO.html

in 2.5
This is the only solution which does not use the ACPI system of the
Linux kernel.=20

in 3.1. Known Bugs/Problems
There could be following problems (caused by the bugs):
      skips during sound playback
      skips and slowdown during video playback
      slowdown of the ultra-DMA harddisk transfers
      system hangs

what could be worst ? :-)


2.1. The Command-line Hack
you can enable/disable the power-saving right from the command-line
without any need for rebooting.

on KT133/133A, KX133, KL/KLE133, KM/KN133, ...:
enable: setpci -v -H1 -s 0:0.0 52=3D$(printf %x $((0x$(setpci -H1 -s 0:0.0
52) | 0x80)))
disable: setpci -v -H1 -s 0:0.0 52=3D$(printf %x $((0x$(setpci -H1 -s
0:0.0 52) & 0x7f)))=20

How I know if it enable or disable ?
is it safe try this commands?

thanks in advance

>=20
>=20
> --=20
> Ducrot Bruno
>=20
> --  Which is worse:  ignorance or apathy?
> --  Don't know.  Don't care.
>=20

--=20
S=E9rgio Basto




-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
