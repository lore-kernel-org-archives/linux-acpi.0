From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sbasto-n97bsLhj/YhQPh2TJV30h1aTQe2KTcn/@public.gmane.org>
Subject: Re: Thermal module errors
Date: 07 Feb 2003 12:12:06 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1044619958.1807.8.camel@darkstar.portugal>
References: <32774.192.168.10.204.1044602945.squirrel@benham.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <32774.192.168.10.204.1044602945.squirrel-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Darren Benham <dbenham-FG1iuTdj8bisTnJN9+BGXg@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>From what I know, shouldn't use modules, compiling with kernel have
better results.
so should be everything Y except CONFIG_ACPI_HT_ONLY and
CONFIG_ACPI_TOSHIBA that should be N


On Fri, 2003-02-07 at 07:29, Darren Benham wrote:
> I don't know if anyone's seen this but I haven't seen anything mentioned
> (easily) in the list archives.  Here's the output from a kernel log when
> trying to load the thermal module.  I've seen this with kernels 2.4.18,
> 2.4.20 , and 2.4.21pre4 (with the latest patch, which applied cleanly,
> BTW).
> Feb  6 23:04:37 ltdbenham kernel: dswstate-0251 [29]
> ds_result_pop_from_bot: No result objects! State=3Dc15d8828Feb  6 23:04:3=
7 ltdbenham kernel:  dsutils-0494 [29] ds_create_operand   =20
> : Missing or null operand, AE_AML_NO_RETURN_VALUEFeb  6 23:04:37 ltdbenha=
m kernel:  dsutils-0587 [28] ds_create_operands  =20
> : While creating Arg 1 - AE_AML_NO_RETURN_VALUEFeb  6 23:04:37 ltdbenham =
kernel:  psparse-1102: *** Error: Method
> execution failed [\_TZ_.C1F1] (Node c15ede08), AE_AML_NO_RETURN_VALUEFeb =
 6 23:04:37 ltdbenham kernel:  psparse-1102: *** Error: Method
> execution failed [\_TZ_.TZ1_._TMP] (Node c15ebce8), AE_AML_NO_RETURN_VALU=
E
> Here's the .config ACPI section...
>=20
> #
> # ACPI Support
> #
> CONFIG_ACPI=3Dy
> # CONFIG_ACPI_HT_ONLY is not set
> CONFIG_ACPI_BOOT=3Dy
> CONFIG_ACPI_BUS=3Dy
> CONFIG_ACPI_INTERPRETER=3Dy
> CONFIG_ACPI_EC=3Dy
> CONFIG_ACPI_POWER=3Dy
> CONFIG_ACPI_PCI=3Dy
> CONFIG_ACPI_SLEEP=3Dy
> CONFIG_ACPI_SYSTEM=3Dy
> CONFIG_ACPI_AC=3Dm

> CONFIG_ACPI_BATTERY=3Dm
> CONFIG_ACPI_BUTTON=3Dm
> CONFIG_ACPI_FAN=3Dm
> CONFIG_ACPI_PROCESSOR=3Dm
> CONFIG_ACPI_THERMAL=3Dm
> CONFIG_ACPI_TOSHIBA=3Dm
> CONFIG_ACPI_DEBUG=3Dy
>=20
> compiled with gcc 2.95.4
> and glibc 2.2.5
>=20
> --=20
> Darren
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld =3D Something 2 See!
> http://www.vasoftware.com
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
--=20
S=E9rgio Basto
Technology Project Manager
onevision design studios
Rua Prof. Mota Pinto
42F-S2.30
4100-353 PORTO
tel. + 351 22 532 0300
fax. + 351 22 616 0182
email: sbasto-n97bsLhj/YhQPh2TJV30h1aTQe2KTcn/@public.gmane.org
web: http://www.onevision-design.com



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
