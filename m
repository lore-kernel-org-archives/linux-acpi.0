From: "Manpreet Singh" <Manpreet.Singh-IrU4XInhIXM@public.gmane.org>
Subject: RE: [BKPATCH] ACPI for 2.6
Date: Mon, 29 Mar 2004 17:26:48 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EB6B0A91B0F6AC44842492A8F6852CDE0C4522@fcexmb01.efi.internal>
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
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Cc: Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

What is the current mechanism for enabling wake events? Or are there are =
a
set of defaults defined somewhere?

Thanks,
Manpreet.


-----Original Message-----
From: Li, Shaohua [mailto:shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
Sent: Monday, March 29, 2004 5:23 PM
To: Manpreet Singh; Moore, Robert; Brown, Len; Linus Torvalds
Cc: Kernel Mailing List; ACPI Developers
Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6


Hi,
I think ACPI should provide user interface to enable 'Wake' GPE before
entering sleep. User can select which devices can wake up system. We
have a track http://bugme.osdl.org/show_bug.cgi?id=3D1415 for this =
issue.

Thanks,
David
> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Manpreet Singh
> Sent: Tuesday, March 30, 2004 8:28 AM
> To: Moore, Robert; Brown, Len; Linus Torvalds
> Cc: Kernel Mailing List; ACPI Developers
> Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6
>=20
> Hi Bob,
>=20
> What I mean is that I see that the system goes into S3 suspend with
all
> GPEs
> being disabled. So the bitvector 'WakeEnable' has a value of 0. Now,
on my
> I/O controller, PME_EN: which enables PME#s to assert a wake-up event
is
> also
> off which is what I'd like to see enabled for wake on LAN (etherwake)
to
> work.
>=20
> How is WakeEnable initialized? Does it depend on certain BIOS table
> entries?
>=20
> Forgive my n00b questions if they sound trivial.
>=20
> Thanks,
> Manpreet.
>=20
>=20
> -----Original Message-----
> From: Moore, Robert [mailto:robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> Sent: Monday, March 29, 2004 9:33 AM
> To: Manpreet Singh; Brown, Len; Linus Torvalds
> Cc: Kernel Mailing List; ACPI Developers
> Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6
>=20
>=20
>=20
> What makes you think that *all* GPEs are disabled?
>=20
> Here is the relevant code:
>=20
>         /*
>          * 1) Disable all runtime GPEs
>          * 2) Enable all wakeup GPEs
>          */
>         Status =3D AcpiHwLowLevelWrite (8, =
GpeRegisterInfo->WakeEnable,
>                 &GpeRegisterInfo->EnableAddress);
>=20
> The "WakeEnable" field is setup such that only the WAKE GPEs are
> enabled.
>=20
> Unless you are saying that "WakeEnable" is not initialized correctly.
>=20
> Please clarify.
>=20
> Bob
>=20
>=20
> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Manpreet
> Singh
> Sent: Saturday, March 27, 2004 1:19 AM
> To: Brown, Len; Linus Torvalds
> Cc: Kernel Mailing List; ACPI Developers
> Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6
>=20
> Hi Len,
>=20
> This patch on 2.6.5-rc2 certainly helps with a "spurious" interrupt
> problem
> that I was seeing on a 2.6.4 kernel. It seems that we don't initialize
> GPEs
> unless they are needed for a resume.
>=20
> But, in the function call "acpi_hw_prepare_gpes_for_sleep", it seems
> that
> currently *all* GPEs get disabled, some of which I would consider wake
> up
> events, like the PME enable bit that enables an S3 resume using a
magic
> packet. That doesn't allow wake on LAN to work properly. Is there way
to
> pick/specify the wake up events or does it come from the BIOS tables?
>=20
> Also, if I have the console on a serial port, I don't get the console
> back
> after an S3 resume.
>=20
> Actually, I am new to the ACPI list. If this is not the right place
for
> these
> queries, please let me know.
>=20
> Thanks,
> Manpreet.
>=20
>=20
> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org]On Behalf Of Len Brown
> Sent: Friday, March 26, 2004 4:59 PM
> To: Linus Torvalds
> Cc: Kernel Mailing List; ACPI Developers
> Subject: [ACPI] [BKPATCH] ACPI for 2.6
>=20
>=20
> Hi Linus, please do a
>=20
> 	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.5
>=20
> 	Three significant interrupt fixes.
>=20
> thanks,
> -Len
>=20
> ps. a plain patch is also available here:
>
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2
> .6.5/
> acpi-20040326-2.6.5.diff.gz
>=20
> This will update the following files:
>=20
>  arch/i386/kernel/acpi/boot.c      |   18 +
>  drivers/acpi/ec.c                 |    4
>  drivers/acpi/events/evgpe.c       |   11 -
>  drivers/acpi/events/evgpeblk.c    |  242 ++++++++++++++++++++++----
>  drivers/acpi/events/evmisc.c      |   43 ++--
>  drivers/acpi/events/evxfevnt.c    |   25 ++
>  drivers/acpi/executer/excreate.c  |   16 +
>  drivers/acpi/executer/exdump.c    |    1
>  drivers/acpi/executer/exresnte.c  |    5
>  drivers/acpi/executer/exstoren.c  |    1
>  drivers/acpi/hardware/hwgpe.c     |   98 ++++++----
>  drivers/acpi/hardware/hwsleep.c   |   22 +-
>  drivers/acpi/namespace/nsaccess.c |    9
>  drivers/acpi/namespace/nsdump.c   |    1
>  drivers/acpi/namespace/nseval.c   |    9
>  drivers/acpi/namespace/nssearch.c |    6
>  drivers/acpi/namespace/nsutils.c  |    2
>  drivers/acpi/namespace/nsxfeval.c |   26 +-
>  drivers/acpi/osl.c                |   21 ++
>  drivers/acpi/pci_link.c           |   18 +
>  drivers/acpi/resources/rsaddr.c   |   13 -
>  drivers/acpi/utilities/utglobal.c |   42 ++--
>  drivers/acpi/utilities/utmisc.c   |    5
>  include/acpi/acconfig.h           |    2
>  include/acpi/acglobal.h           |    2
>  include/acpi/achware.h            |    4
>  include/acpi/aclocal.h            |    7
>  include/acpi/actypes.h            |   84 +++++----
>  include/acpi/acutils.h            |    1
>  29 files changed, 537 insertions(+), 201 deletions(-)
>=20
> through these ChangeSets:
>=20
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/26 1.1608.1.56)
>    [ACPI] Linux specific updates from ACPICA 20040326
>    "acpi_wake_gpes_always_on" boot flag for old GPE behaviour
>=20
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/26 1.1608.1.55)
>    [ACPI] ACPICA 20040326 from Bob Moore
>=20
>    Implemented support for "wake" GPEs via interaction between
>    GPEs and the _PRW methods.  Every GPE that is pointed to by
>    one or more _PRWs is identified as a WAKE GPE and by default
>    will no longer be enabled at runtime.  Previously, we were
>    blindly enabling all GPEs with a corresponding _Lxx or _Exx
>    method - but most of these turn out to be WAKE GPEs anyway.
>    We believe this has been the cause of thousands of
>    "spurious" GPEs on some systems.
>=20
>    This new GPE behavior is can be reverted to the original
>    behavior (enable ALL GPEs at runtime) via a runtime flag.
>=20
>    Fixed a problem where aliased control methods could not
>    access objects properly.  The proper scope within the
>    namespace was not initialized (transferred to the target of
>    the aliased method) before executing the target method.
>=20
>    Fixed a potential race condition on internal object
>    deletion on the return object in AcpiEvaluateObject.
>=20
>    Integrated a fix for resource descriptors where both
>    _MEM and _MTP were being extracted instead of just _MEM.
>    (i.e. bitmask was incorrectly too wide, 0x0F instead of 0x03.)
>=20
>    Added a special case for ACPI_ROOT_OBJECT in AcpiUtGetNodeName,
>    preventing a fault in some cases.
>=20
>    Updated Notify() values for debug statements in evmisc.c
>=20
>    Return proper status from AcpiUtMutexInitialize,
>    not just simply AE_OK.
>=20
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/26 1.1608.1.54)
>    [ACPI] proposed fix for non-identity-mapped SCI override
>    http://bugme.osdl.org/show_bug.cgi?id=3D2366
>=20
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/25 1.1608.1.53)
>    [ACPI] PCI interrupt link routing (Luming Yu)
>    use _PRS to determine resource type for _SRS
>    fixes HP Proliant servers
>    http://bugzilla.kernel.org/show_bug.cgi?id=3D1590
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
> =
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
