From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: [BKPATCH] ACPI for 2.4
Date: Sun, 14 Mar 2004 16:31:49 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1079281909.10228.21.camel@darkstar>
References: <1079244088.2173.134.camel@dhcppc4>
Reply-To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1079244088.2173.134.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Len
I had test this last release and I don't have any problem,
but the suggested patch of
http://bugme.osdl.org/show_bug.cgi?id=3D2109#c6, hasn't been applied,=20

hgfelger and Ortwin Gl=FCck says that resolved his problems.
So after a revision of all patches around power-off, maybe this one can
be applied.

thanks=20

On Sun, 2004-03-14 at 06:01, Len Brown wrote:
> Hi Marcelo, please do a=20
>=20
> 	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.4.26
>=20
> thanks,
> -Len
>=20
> ps. a plain patch is also available here:
> ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.=
4.26/acpi-20040311-2.4.26.diff.gz
>=20
> This will update the following files:
>=20
>  Documentation/kernel-parameters.txt |    4 +
>  arch/i386/kernel/acpi.c             |    3=20
>  drivers/acpi/dispatcher/dsmethod.c  |   85 ++++++++++++++++--------
>  drivers/acpi/events/evgpe.c         |    5 +
>  drivers/acpi/executer/excreate.c    |   20 +++--
>  drivers/acpi/executer/exmutex.c     |   28 ++++---
>  drivers/acpi/namespace/nsaccess.c   |   30 ++++++--
>  drivers/acpi/namespace/nsalloc.c    |    7 +
>  drivers/acpi/namespace/nseval.c     |   15 +++-
>  drivers/acpi/osl.c                  |   36 ++++++++++
>  drivers/acpi/parser/psparse.c       |   44 +++++++++++-
>  drivers/acpi/parser/psscope.c       |    9 --
>  drivers/acpi/system.c               |    3=20
>  drivers/acpi/utilities/uteval.c     |   56 +++++++++++++++
>  drivers/acpi/utilities/utglobal.c   |   28 ++++---
>  include/acpi/acconfig.h             |    6 +
>  include/acpi/acglobal.h             |   11 ++-
>  include/acpi/acmacros.h             |    3=20
>  include/acpi/acobject.h             |    7 +
>  include/acpi/actypes.h              |    5 -
>  include/acpi/acutils.h              |    6 +
>  include/acpi/amlcode.h              |   14 ++-
>  include/asm-i386/acpi.h             |   51 +++++++-------
>  include/asm-x86_64/acpi.h           |   59 +++++++---------
>  24 files changed, 379 insertions(+), 156 deletions(-)
>=20
> through these ChangeSets:
>=20
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/13 1.1063.46.83)
>    [ACPI] add boot parameters "acpi_osi=3D" and "acpi_serialize"
>      acpi_osi=3D will disable the _OSI method -- which by default
>    	tells the BIOS to behave as if Windows is the OS.
>      acpi_serialize is for debugging AE_ALREADY_EXISTS failures
>   =20
>=20
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/13 1.1063.46.82)
>    [ACPI] ACPICA 20040311 from Bob Moore
>   =20
>    Fixed a problem where errors occurring during the parse phase of
> control
>    method execution did not abort cleanly.  For example, objects created
>    and installed in the namespace were not deleted.  This caused all
>    subsequent invocations of the method to return the AE_ALREADY_EXISTS
>    exception.
>   =20
>    Implemented a mechanism to force a control method to "Serialized"
>    execution if the method attempts to create namespace objects.
>    (The root of the AE_ALREADY_EXISTS problem.)
>   =20
>    Implemented support for the predefined _OSI "internal" control
> method.
>    Initial supported strings are "Linux", "Windows 2000", "Windows
> 2001",
>    and "Windows 2001.1", and can be easily upgraded for new strings as
>    necessary.  This feature allows Linux to execute
>    the fully tested, "Windows" code path through the ASL code
>   =20
>    Global Lock Support:  Now allows multiple acquires and releases with
> any
>    internal thread.  Removed concept of "owning thread" for this special
>    mutex.
>   =20
>    Fixed two functions that were inappropriately declaring large objects
> on
>    the CPU stack: ps_parse_loop() and ns_evaluate_relative().
>    Reduces the stack usage during method execution considerably.
>   =20
>    Fixed a problem in the ACPI 2.0 FACS descriptor (actbl2.h) where the
>    S4Bios_f field was incorrectly defined as UINT32 instead of
> UINT32_BIT.
>   =20
>    Fixed a problem where acpi_ev_gpe_detect() would fault
>    if there were no GPEs defined on the machine.
>   =20
>    Implemented two runtime options:  One to force all control method
>    execution to "Serialized" to mimic Windows behavior, another to
> disable
>    _OSI support if it causes problems on a given machine.
>=20
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/13 1.1063.46.81)
>    [ACPI] SMP poweroff (David Shaohua Li)
>    http://bugzilla.kernel.org/show_bug.cgi?id=3D1141
>=20
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/05 1.1063.46.80)
>    [ACPI] global lock macro fixes (Paul Menage, Luming Yu)
>      http://bugzilla.kernel.org/show_bug.cgi?id=3D1669
>=20
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/05 1.1063.46.79)
>    [ACPI] acpi_wakeup_address - print only when broken
>=20
>=20
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
--=20
S=E9rgio M. B.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
