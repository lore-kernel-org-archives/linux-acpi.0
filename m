From: "Manpreet Singh" <Manpreet.Singh-IrU4XInhIXM@public.gmane.org>
Subject: RE: [BKPATCH] ACPI for 2.6
Date: Sat, 27 Mar 2004 01:18:47 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EB6B0A91B0F6AC44842492A8F6852CDE11AAB9@fcexmb01.efi.internal>
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
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Cc: Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Len,

This patch on 2.6.5-rc2 certainly helps with a "spurious" interrupt =
problem
that I was seeing on a 2.6.4 kernel. It seems that we don't initialize =
GPEs
unless they are needed for a resume.

But, in the function call "acpi_hw_prepare_gpes_for_sleep", it seems =
that
currently *all* GPEs get disabled, some of which I would consider wake =
up
events, like the PME enable bit that enables an S3 resume using a magic
packet. That doesn't allow wake on LAN to work properly. Is there way to
pick/specify the wake up events or does it come from the BIOS tables?

Also, if I have the console on a serial port, I don't get the console =
back
after an S3 resume.

Actually, I am new to the ACPI list. If this is not the right place for =
these
queries, please let me know.

Thanks,
Manpreet.


-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org]On Behalf Of Len Brown
Sent: Friday, March 26, 2004 4:59 PM
To: Linus Torvalds
Cc: Kernel Mailing List; ACPI Developers
Subject: [ACPI] [BKPATCH] ACPI for 2.6


Hi Linus, please do a=20

	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.5

	Three significant interrupt fixes.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.=
6.5/
acpi-20040326-2.6.5.diff.gz

This will update the following files:

 arch/i386/kernel/acpi/boot.c      |   18 +
 drivers/acpi/ec.c                 |    4=20
 drivers/acpi/events/evgpe.c       |   11 -
 drivers/acpi/events/evgpeblk.c    |  242 ++++++++++++++++++++++----
 drivers/acpi/events/evmisc.c      |   43 ++--
 drivers/acpi/events/evxfevnt.c    |   25 ++
 drivers/acpi/executer/excreate.c  |   16 +
 drivers/acpi/executer/exdump.c    |    1=20
 drivers/acpi/executer/exresnte.c  |    5=20
 drivers/acpi/executer/exstoren.c  |    1=20
 drivers/acpi/hardware/hwgpe.c     |   98 ++++++----
 drivers/acpi/hardware/hwsleep.c   |   22 +-
 drivers/acpi/namespace/nsaccess.c |    9=20
 drivers/acpi/namespace/nsdump.c   |    1=20
 drivers/acpi/namespace/nseval.c   |    9=20
 drivers/acpi/namespace/nssearch.c |    6=20
 drivers/acpi/namespace/nsutils.c  |    2=20
 drivers/acpi/namespace/nsxfeval.c |   26 +-
 drivers/acpi/osl.c                |   21 ++
 drivers/acpi/pci_link.c           |   18 +
 drivers/acpi/resources/rsaddr.c   |   13 -
 drivers/acpi/utilities/utglobal.c |   42 ++--
 drivers/acpi/utilities/utmisc.c   |    5=20
 include/acpi/acconfig.h           |    2=20
 include/acpi/acglobal.h           |    2=20
 include/acpi/achware.h            |    4=20
 include/acpi/aclocal.h            |    7=20
 include/acpi/actypes.h            |   84 +++++----
 include/acpi/acutils.h            |    1=20
 29 files changed, 537 insertions(+), 201 deletions(-)

through these ChangeSets:

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/26 1.1608.1.56)
   [ACPI] Linux specific updates from ACPICA 20040326
   "acpi_wake_gpes_always_on" boot flag for old GPE behaviour

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/26 1.1608.1.55)
   [ACPI] ACPICA 20040326 from Bob Moore
  =20
   Implemented support for "wake" GPEs via interaction between
   GPEs and the _PRW methods.  Every GPE that is pointed to by
   one or more _PRWs is identified as a WAKE GPE and by default
   will no longer be enabled at runtime.  Previously, we were
   blindly enabling all GPEs with a corresponding _Lxx or _Exx
   method - but most of these turn out to be WAKE GPEs anyway.
   We believe this has been the cause of thousands of
   "spurious" GPEs on some systems.
  =20
   This new GPE behavior is can be reverted to the original
   behavior (enable ALL GPEs at runtime) via a runtime flag.
  =20
   Fixed a problem where aliased control methods could not
   access objects properly.  The proper scope within the
   namespace was not initialized (transferred to the target of
   the aliased method) before executing the target method.
  =20
   Fixed a potential race condition on internal object
   deletion on the return object in AcpiEvaluateObject.=20
  =20
   Integrated a fix for resource descriptors where both
   _MEM and _MTP were being extracted instead of just _MEM.
   (i.e. bitmask was incorrectly too wide, 0x0F instead of 0x03.)
  =20
   Added a special case for ACPI_ROOT_OBJECT in AcpiUtGetNodeName,
   preventing a fault in some cases.
  =20
   Updated Notify() values for debug statements in evmisc.c
  =20
   Return proper status from AcpiUtMutexInitialize,
   not just simply AE_OK.

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/26 1.1608.1.54)
   [ACPI] proposed fix for non-identity-mapped SCI override
   http://bugme.osdl.org/show_bug.cgi?id=3D2366

<len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/25 1.1608.1.53)
   [ACPI] PCI interrupt link routing (Luming Yu)
   use _PRS to determine resource type for _SRS
   fixes HP Proliant servers
   http://bugzilla.kernel.org/show_bug.cgi?id=3D1590






-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
