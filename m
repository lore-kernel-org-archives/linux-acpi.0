From: "Rockefeller, Harry" <harryr-qMhjF6E6u3VBDgjK7y7TUQ@public.gmane.org>
Subject: ACPI S3 wake howto was: RE: [BKPATCH] ACPI for 2.6
Date: Tue, 30 Mar 2004 11:33:48 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <7105F2BD9451D7479B4B3A99A2B72FAC062C08C7@exchange1.ssd.fsi.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4167D.28B8028C"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C4167D.28B8028C
Content-Type: text/plain

As a user, I'm stuck at first base.  With kernel 2.6.4
S3 is supposedly supported.  Entering S3 appears to work.
Exiting S3 (waking up?) the LCD screen comes back when a key is
depressed, but *nothing* brings my machine back to life.
The full few-seconds power-button reboot is all that works.

I admit that there may be a simple one-line web-link answer
pointing to some ACPI FAQ or How-to.  If that is the case 
just point me there and I'll read that.

Thanks.

-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Moore, Robert
Sent: Tuesday, March 30, 2004 10:58 AM
To: Li, Shaohua; Manpreet Singh; Brown, Len; Linus Torvalds
Cc: Kernel Mailing List; ACPI Developers; Grover, Andrew
Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6

The default behavior of the ACPI CA core subsystem is to leave all "wake"
GPEs disabled.  It is the responsibility of the upper OSPM
(OS-dependent) software to selectively enable the wake devices via the
AcpiEnableGpe external interface.

We could argue about whether the core should enable or disable all wake GPEs
by default, but the code to selectively pick wake GPEs is not and cannot be
part of the core ACPI CA code.

Bob


-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Li, Shaohua
Sent: Monday, March 29, 2004 5:23 PM
To: Manpreet Singh; Moore, Robert; Brown, Len; Linus Torvalds
Cc: Kernel Mailing List; ACPI Developers
Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6

Hi,
I think ACPI should provide user interface to enable 'Wake' GPE before
entering sleep. User can select which devices can wake up system. We have a
track http://bugme.osdl.org/show_bug.cgi?id=1415 for this issue.

Thanks,
David
> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel- 
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Manpreet Singh
> Sent: Tuesday, March 30, 2004 8:28 AM
> To: Moore, Robert; Brown, Len; Linus Torvalds
> Cc: Kernel Mailing List; ACPI Developers
> Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6
> 
> Hi Bob,
> 
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
> 
> How is WakeEnable initialized? Does it depend on certain BIOS table 
> entries?
> 
> Forgive my n00b questions if they sound trivial.
> 
> Thanks,
> Manpreet.
> 
> 
> -----Original Message-----
> From: Moore, Robert [mailto:robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> Sent: Monday, March 29, 2004 9:33 AM
> To: Manpreet Singh; Brown, Len; Linus Torvalds
> Cc: Kernel Mailing List; ACPI Developers
> Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6
> 
> 
> 
> What makes you think that *all* GPEs are disabled?
> 
> Here is the relevant code:
> 
>         /*
>          * 1) Disable all runtime GPEs
>          * 2) Enable all wakeup GPEs
>          */
>         Status = AcpiHwLowLevelWrite (8, GpeRegisterInfo->WakeEnable,
>                 &GpeRegisterInfo->EnableAddress);
> 
> The "WakeEnable" field is setup such that only the WAKE GPEs are 
> enabled.
> 
> Unless you are saying that "WakeEnable" is not initialized correctly.
> 
> Please clarify.
> 
> Bob
> 
> 
> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Manpreet 
> Singh
> Sent: Saturday, March 27, 2004 1:19 AM
> To: Brown, Len; Linus Torvalds
> Cc: Kernel Mailing List; ACPI Developers
> Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6
> 
> Hi Len,
> 
> This patch on 2.6.5-rc2 certainly helps with a "spurious" interrupt 
> problem that I was seeing on a 2.6.4 kernel. It seems that we don't 
> initialize GPEs unless they are needed for a resume.
> 
> But, in the function call "acpi_hw_prepare_gpes_for_sleep", it seems 
> that currently *all* GPEs get disabled, some of which I would consider 
> wake up events, like the PME enable bit that enables an S3 resume 
> using a
magic
> packet. That doesn't allow wake on LAN to work properly. Is there way
to
> pick/specify the wake up events or does it come from the BIOS tables?
> 
> Also, if I have the console on a serial port, I don't get the console 
> back after an S3 resume.
> 
> Actually, I am new to the ACPI list. If this is not the right place
for
> these
> queries, please let me know.
> 
> Thanks,
> Manpreet.
> 
> 
> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org]On Behalf Of Len Brown
> Sent: Friday, March 26, 2004 4:59 PM
> To: Linus Torvalds
> Cc: Kernel Mailing List; ACPI Developers
> Subject: [ACPI] [BKPATCH] ACPI for 2.6
> 
> 
> Hi Linus, please do a
> 
> 	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.5
> 
> 	Three significant interrupt fixes.
> 
> thanks,
> -Len
> 
> ps. a plain patch is also available here:
>
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2
> .6.5/
> acpi-20040326-2.6.5.diff.gz
> 
> This will update the following files:
> 
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
> 
> through these ChangeSets:
> 
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/26 1.1608.1.56)
>    [ACPI] Linux specific updates from ACPICA 20040326
>    "acpi_wake_gpes_always_on" boot flag for old GPE behaviour
> 
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/26 1.1608.1.55)
>    [ACPI] ACPICA 20040326 from Bob Moore
> 
>    Implemented support for "wake" GPEs via interaction between
>    GPEs and the _PRW methods.  Every GPE that is pointed to by
>    one or more _PRWs is identified as a WAKE GPE and by default
>    will no longer be enabled at runtime.  Previously, we were
>    blindly enabling all GPEs with a corresponding _Lxx or _Exx
>    method - but most of these turn out to be WAKE GPEs anyway.
>    We believe this has been the cause of thousands of
>    "spurious" GPEs on some systems.
> 
>    This new GPE behavior is can be reverted to the original
>    behavior (enable ALL GPEs at runtime) via a runtime flag.
> 
>    Fixed a problem where aliased control methods could not
>    access objects properly.  The proper scope within the
>    namespace was not initialized (transferred to the target of
>    the aliased method) before executing the target method.
> 
>    Fixed a potential race condition on internal object
>    deletion on the return object in AcpiEvaluateObject.
> 
>    Integrated a fix for resource descriptors where both
>    _MEM and _MTP were being extracted instead of just _MEM.
>    (i.e. bitmask was incorrectly too wide, 0x0F instead of 0x03.)
> 
>    Added a special case for ACPI_ROOT_OBJECT in AcpiUtGetNodeName,
>    preventing a fault in some cases.
> 
>    Updated Notify() values for debug statements in evmisc.c
> 
>    Return proper status from AcpiUtMutexInitialize,
>    not just simply AE_OK.
> 
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/26 1.1608.1.54)
>    [ACPI] proposed fix for non-identity-mapped SCI override
>    http://bugme.osdl.org/show_bug.cgi?id=2366
> 
> <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/25 1.1608.1.53)
>    [ACPI] PCI interrupt link routing (Luming Yu)
>    use _PRS to determine resource type for _SRS
>    fixes HP Proliant servers
>    http://bugzilla.kernel.org/show_bug.cgi?id=1590
> 
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials Free Linux 
> tutorial presented by Daniel Robbins, President and CEO of GenToo 
> technologies. Learn everything from fundamentals to system 
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials Free Linux 
> tutorial presented by Daniel Robbins, President and CEO of GenToo 
> technologies. Learn everything from fundamentals to system 
> administration.http://ads.osdn.com/?ad_id70&alloc_id638&op=ick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials Free Linux 
> tutorial presented by Daniel Robbins, President and CEO of GenToo 
> technologies. Learn everything from fundamentals to system 
> administration.http://ads.osdn.com/?ad_id70&alloc_id638&op=ick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials Free Linux tutorial
presented by Daniel Robbins, President and CEO of GenToo technologies. Learn
everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id70&alloc_id638&op=ick
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials Free Linux tutorial
presented by Daniel Robbins, President and CEO of GenToo technologies. Learn
everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id70&alloc_id638&op=click
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel

------_=_NextPart_001_01C4167D.28B8028C
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DUS-ASCII">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2657.73">
<TITLE>ACPI S3 wake howto was: RE: [ACPI] [BKPATCH] ACPI for =
2.6</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>As a user, I'm stuck at first base.&nbsp; With kernel =
2.6.4</FONT>
<BR><FONT SIZE=3D2>S3 is supposedly supported.&nbsp; Entering S3 =
appears to work.</FONT>
<BR><FONT SIZE=3D2>Exiting S3 (waking up?) the LCD screen comes back =
when a key is</FONT>
<BR><FONT SIZE=3D2>depressed, but *nothing* brings my machine back to =
life.</FONT>
<BR><FONT SIZE=3D2>The full few-seconds power-button reboot is all that =
works.</FONT>
</P>

<P><FONT SIZE=3D2>I admit that there may be a simple one-line web-link =
answer</FONT>
<BR><FONT SIZE=3D2>pointing to some ACPI FAQ or How-to.&nbsp; If that =
is the case </FONT>
<BR><FONT SIZE=3D2>just point me there and I'll read that.</FONT>
</P>

<P><FONT SIZE=3D2>Thanks.</FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [<A =
HREF=3D"mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">mailto:acpi-devel=
-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</A>] On Behalf Of Moore, Robert</FONT>
<BR><FONT SIZE=3D2>Sent: Tuesday, March 30, 2004 10:58 AM</FONT>
<BR><FONT SIZE=3D2>To: Li, Shaohua; Manpreet Singh; Brown, Len; Linus =
Torvalds</FONT>
<BR><FONT SIZE=3D2>Cc: Kernel Mailing List; ACPI Developers; Grover, =
Andrew</FONT>
<BR><FONT SIZE=3D2>Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6</FONT>
</P>

<P><FONT SIZE=3D2>The default behavior of the ACPI CA core subsystem is =
to leave all &quot;wake&quot; GPEs disabled.&nbsp; It is the =
responsibility of the upper OSPM</FONT></P>

<P><FONT SIZE=3D2>(OS-dependent) software to selectively enable the =
wake devices via the AcpiEnableGpe external interface.</FONT>
</P>

<P><FONT SIZE=3D2>We could argue about whether the core should enable =
or disable all wake GPEs by default, but the code to selectively pick =
wake GPEs is not and cannot be part of the core ACPI CA =
code.</FONT></P>

<P><FONT SIZE=3D2>Bob</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</FONT>
<BR><FONT SIZE=3D2>[<A =
HREF=3D"mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">mailto:acpi-devel=
-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</A>] On Behalf Of Li, Shaohua</FONT>
<BR><FONT SIZE=3D2>Sent: Monday, March 29, 2004 5:23 PM</FONT>
<BR><FONT SIZE=3D2>To: Manpreet Singh; Moore, Robert; Brown, Len; Linus =
Torvalds</FONT>
<BR><FONT SIZE=3D2>Cc: Kernel Mailing List; ACPI Developers</FONT>
<BR><FONT SIZE=3D2>Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6</FONT>
</P>

<P><FONT SIZE=3D2>Hi,</FONT>
<BR><FONT SIZE=3D2>I think ACPI should provide user interface to enable =
'Wake' GPE before entering sleep. User can select which devices can =
wake up system. We have a track <A =
HREF=3D"http://bugme.osdl.org/show_bug.cgi?id=3D1415" =
TARGET=3D"_blank">http://bugme.osdl.org/show_bug.cgi?id=3D1415</A> for =
this issue.</FONT></P>

<P><FONT SIZE=3D2>Thanks,</FONT>
<BR><FONT SIZE=3D2>David</FONT>
<BR><FONT SIZE=3D2>&gt; -----Original Message-----</FONT>
<BR><FONT SIZE=3D2>&gt; From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org =
[<A HREF=3D"mailto:acpi-devel-">mailto:acpi-devel-</A> </FONT>
<BR><FONT SIZE=3D2>&gt; admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of =
Manpreet Singh</FONT>
<BR><FONT SIZE=3D2>&gt; Sent: Tuesday, March 30, 2004 8:28 AM</FONT>
<BR><FONT SIZE=3D2>&gt; To: Moore, Robert; Brown, Len; Linus =
Torvalds</FONT>
<BR><FONT SIZE=3D2>&gt; Cc: Kernel Mailing List; ACPI Developers</FONT>
<BR><FONT SIZE=3D2>&gt; Subject: RE: [ACPI] [BKPATCH] ACPI for =
2.6</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Hi Bob,</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; What I mean is that I see that the system goes =
into S3 suspend with</FONT>
<BR><FONT SIZE=3D2>all</FONT>
<BR><FONT SIZE=3D2>&gt; GPEs</FONT>
<BR><FONT SIZE=3D2>&gt; being disabled. So the bitvector 'WakeEnable' =
has a value of 0. Now,</FONT>
<BR><FONT SIZE=3D2>on my</FONT>
<BR><FONT SIZE=3D2>&gt; I/O controller, PME_EN: which enables PME#s to =
assert a wake-up event</FONT>
<BR><FONT SIZE=3D2>is</FONT>
<BR><FONT SIZE=3D2>&gt; also</FONT>
<BR><FONT SIZE=3D2>&gt; off which is what I'd like to see enabled for =
wake on LAN (etherwake)</FONT>
<BR><FONT SIZE=3D2>to</FONT>
<BR><FONT SIZE=3D2>&gt; work.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; How is WakeEnable initialized? Does it depend =
on certain BIOS table </FONT>
<BR><FONT SIZE=3D2>&gt; entries?</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Forgive my n00b questions if they sound =
trivial.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Thanks,</FONT>
<BR><FONT SIZE=3D2>&gt; Manpreet.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; -----Original Message-----</FONT>
<BR><FONT SIZE=3D2>&gt; From: Moore, Robert [<A =
HREF=3D"mailto:robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org">mailto:robert.moore@intel.com</A>=
]</FONT>
<BR><FONT SIZE=3D2>&gt; Sent: Monday, March 29, 2004 9:33 AM</FONT>
<BR><FONT SIZE=3D2>&gt; To: Manpreet Singh; Brown, Len; Linus =
Torvalds</FONT>
<BR><FONT SIZE=3D2>&gt; Cc: Kernel Mailing List; ACPI Developers</FONT>
<BR><FONT SIZE=3D2>&gt; Subject: RE: [ACPI] [BKPATCH] ACPI for =
2.6</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; What makes you think that *all* GPEs are =
disabled?</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Here is the relevant code:</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/*</FONT>
<BR><FONT =
SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * =
1) Disable all runtime GPEs</FONT>
<BR><FONT =
SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * =
2) Enable all wakeup GPEs</FONT>
<BR><FONT =
SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Status =3D AcpiHwLowLevelWrite (8, =
GpeRegisterInfo-&gt;WakeEnable,</FONT>
<BR><FONT =
SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&amp;GpeRegisterInfo-&gt;EnableAddress);</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; The &quot;WakeEnable&quot; field is setup such =
that only the WAKE GPEs are </FONT>
<BR><FONT SIZE=3D2>&gt; enabled.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Unless you are saying that =
&quot;WakeEnable&quot; is not initialized correctly.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Please clarify.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Bob</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; -----Original Message-----</FONT>
<BR><FONT SIZE=3D2>&gt; From: =
acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</FONT>
<BR><FONT SIZE=3D2>&gt; [<A =
HREF=3D"mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">mailto:acpi-devel=
-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</A>] On Behalf Of Manpreet </FONT>
<BR><FONT SIZE=3D2>&gt; Singh</FONT>
<BR><FONT SIZE=3D2>&gt; Sent: Saturday, March 27, 2004 1:19 AM</FONT>
<BR><FONT SIZE=3D2>&gt; To: Brown, Len; Linus Torvalds</FONT>
<BR><FONT SIZE=3D2>&gt; Cc: Kernel Mailing List; ACPI Developers</FONT>
<BR><FONT SIZE=3D2>&gt; Subject: RE: [ACPI] [BKPATCH] ACPI for =
2.6</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Hi Len,</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; This patch on 2.6.5-rc2 certainly helps with a =
&quot;spurious&quot; interrupt </FONT>
<BR><FONT SIZE=3D2>&gt; problem that I was seeing on a 2.6.4 kernel. It =
seems that we don't </FONT>
<BR><FONT SIZE=3D2>&gt; initialize GPEs unless they are needed for a =
resume.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; But, in the function call &quot;acpi_hw_prepare_=
gpes_for_sleep&quot;, it seems </FONT>
<BR><FONT SIZE=3D2>&gt; that currently *all* GPEs get disabled, some of =
which I would consider </FONT>
<BR><FONT SIZE=3D2>&gt; wake up events, like the PME enable bit that =
enables an S3 resume </FONT>
<BR><FONT SIZE=3D2>&gt; using a</FONT>
<BR><FONT SIZE=3D2>magic</FONT>
<BR><FONT SIZE=3D2>&gt; packet. That doesn't allow wake on LAN to work =
properly. Is there way</FONT>
<BR><FONT SIZE=3D2>to</FONT>
<BR><FONT SIZE=3D2>&gt; pick/specify the wake up events or does it come =
from the BIOS tables?</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Also, if I have the console on a serial port, I =
don't get the console </FONT>
<BR><FONT SIZE=3D2>&gt; back after an S3 resume.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Actually, I am new to the ACPI list. If this is =
not the right place</FONT>
<BR><FONT SIZE=3D2>for</FONT>
<BR><FONT SIZE=3D2>&gt; these</FONT>
<BR><FONT SIZE=3D2>&gt; queries, please let me know.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Thanks,</FONT>
<BR><FONT SIZE=3D2>&gt; Manpreet.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; -----Original Message-----</FONT>
<BR><FONT SIZE=3D2>&gt; From: =
acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</FONT>
<BR><FONT SIZE=3D2>&gt; [<A =
HREF=3D"mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org">mailto:acpi-devel=
-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</A>]On Behalf Of Len Brown</FONT>
<BR><FONT SIZE=3D2>&gt; Sent: Friday, March 26, 2004 4:59 PM</FONT>
<BR><FONT SIZE=3D2>&gt; To: Linus Torvalds</FONT>
<BR><FONT SIZE=3D2>&gt; Cc: Kernel Mailing List; ACPI Developers</FONT>
<BR><FONT SIZE=3D2>&gt; Subject: [ACPI] [BKPATCH] ACPI for 2.6</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Hi Linus, please do a</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bk pull =
bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.5</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Three =
significant interrupt fixes.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; thanks,</FONT>
<BR><FONT SIZE=3D2>&gt; -Len</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; ps. a plain patch is also available =
here:</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2><A =
HREF=3D"ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/r=
elease/2" =
TARGET=3D"_blank">ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi=
/patches/release/2</A></FONT>
<BR><FONT SIZE=3D2>&gt; .6.5/</FONT>
<BR><FONT SIZE=3D2>&gt; acpi-20040326-2.6.5.diff.gz</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; This will update the following files:</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
arch/i386/kernel/acpi/boot.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp; 18 +</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
drivers/acpi/ec.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 4</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
drivers/acpi/events/evgpe.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp; 11 -</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
drivers/acpi/events/evgpeblk.c&nbsp;&nbsp;&nbsp; |&nbsp; 242 =
++++++++++++++++++++++----</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
drivers/acpi/events/evmisc.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp; 43 ++--</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
drivers/acpi/events/evxfevnt.c&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 25 =
++</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; drivers/acpi/executer/excreate.c&nbsp; =
|&nbsp;&nbsp; 16 +</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
drivers/acpi/executer/exdump.c&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; =
1</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; drivers/acpi/executer/exresnte.c&nbsp; =
|&nbsp;&nbsp;&nbsp; 5</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; drivers/acpi/executer/exstoren.c&nbsp; =
|&nbsp;&nbsp;&nbsp; 1</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
drivers/acpi/hardware/hwgpe.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 98 =
++++++----</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
drivers/acpi/hardware/hwsleep.c&nbsp;&nbsp; |&nbsp;&nbsp; 22 +-</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; drivers/acpi/namespace/nsaccess.c =
|&nbsp;&nbsp;&nbsp; 9</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
drivers/acpi/namespace/nsdump.c&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; =
1</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
drivers/acpi/namespace/nseval.c&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; =
9</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; drivers/acpi/namespace/nssearch.c =
|&nbsp;&nbsp;&nbsp; 6</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; drivers/acpi/namespace/nsutils.c&nbsp; =
|&nbsp;&nbsp;&nbsp; 2</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; drivers/acpi/namespace/nsxfeval.c =
|&nbsp;&nbsp; 26 +-</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
drivers/acpi/osl.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 21 ++</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
drivers/acpi/pci_link.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 18 +</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
drivers/acpi/resources/rsaddr.c&nbsp;&nbsp; |&nbsp;&nbsp; 13 -</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; drivers/acpi/utilities/utglobal.c =
|&nbsp;&nbsp; 42 ++--</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
drivers/acpi/utilities/utmisc.c&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; =
5</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
include/acpi/acconfig.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 2</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
include/acpi/acglobal.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 2</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
include/acpi/achware.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 4</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
include/acpi/aclocal.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 7</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
include/acpi/actypes.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp; 84 +++++----</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; =
include/acpi/acutils.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 1</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp; 29 files changed, 537 insertions(+), 201 =
deletions(-)</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; through these ChangeSets:</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &lt;len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org&gt; (04/03/26 =
1.1608.1.56)</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; [ACPI] Linux specific updates =
from ACPICA 20040326</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; =
&quot;acpi_wake_gpes_always_on&quot; boot flag for old GPE =
behaviour</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &lt;len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org&gt; (04/03/26 =
1.1608.1.55)</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; [ACPI] ACPICA 20040326 from =
Bob Moore</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; Implemented support for =
&quot;wake&quot; GPEs via interaction between</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; GPEs and the _PRW =
methods.&nbsp; Every GPE that is pointed to by</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; one or more _PRWs is =
identified as a WAKE GPE and by default</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; will no longer be enabled at =
runtime.&nbsp; Previously, we were</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; blindly enabling all GPEs =
with a corresponding _Lxx or _Exx</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; method - but most of these =
turn out to be WAKE GPEs anyway.</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; We believe this has been the =
cause of thousands of</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; &quot;spurious&quot; GPEs on =
some systems.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; This new GPE behavior is can =
be reverted to the original</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; behavior (enable ALL GPEs at =
runtime) via a runtime flag.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; Fixed a problem where aliased =
control methods could not</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; access objects =
properly.&nbsp; The proper scope within the</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; namespace was not initialized =
(transferred to the target of</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; the aliased method) before =
executing the target method.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; Fixed a potential race =
condition on internal object</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; deletion on the return object =
in AcpiEvaluateObject.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; Integrated a fix for resource =
descriptors where both</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; _MEM and _MTP were being =
extracted instead of just _MEM.</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; (i.e. bitmask was incorrectly =
too wide, 0x0F instead of 0x03.)</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; Added a special case for =
ACPI_ROOT_OBJECT in AcpiUtGetNodeName,</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; preventing a fault in some =
cases.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; Updated Notify() values for =
debug statements in evmisc.c</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; Return proper status from =
AcpiUtMutexInitialize,</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; not just simply AE_OK.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &lt;len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org&gt; (04/03/26 =
1.1608.1.54)</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; [ACPI] proposed fix for =
non-identity-mapped SCI override</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; <A =
HREF=3D"http://bugme.osdl.org/show_bug.cgi?id=3D2366" =
TARGET=3D"_blank">http://bugme.osdl.org/show_bug.cgi?id=3D2366</A></FONT=
>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &lt;len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org&gt; (04/03/25 =
1.1608.1.53)</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; [ACPI] PCI interrupt link =
routing (Luming Yu)</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; use _PRS to determine =
resource type for _SRS</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; fixes HP Proliant =
servers</FONT>
<BR><FONT SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp; <A =
HREF=3D"http://bugzilla.kernel.org/show_bug.cgi?id=3D1590" =
TARGET=3D"_blank">http://bugzilla.kernel.org/show_bug.cgi?id=3D1590</A><=
/FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; =
-------------------------------------------------------</FONT>
<BR><FONT SIZE=3D2>&gt; This SF.Net email is sponsored by: IBM Linux =
Tutorials Free Linux </FONT>
<BR><FONT SIZE=3D2>&gt; tutorial presented by Daniel Robbins, President =
and CEO of GenToo </FONT>
<BR><FONT SIZE=3D2>&gt; technologies. Learn everything from =
fundamentals to system </FONT>
<BR><FONT SIZE=3D2>&gt; administration.<A =
HREF=3D"http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dclick" =
TARGET=3D"_blank">http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3D=
click</A></FONT>
<BR><FONT SIZE=3D2>&gt; =
_______________________________________________</FONT>
<BR><FONT SIZE=3D2>&gt; Acpi-devel mailing list</FONT>
<BR><FONT SIZE=3D2>&gt; Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</FONT>
<BR><FONT SIZE=3D2>&gt; <A =
HREF=3D"https://lists.sourceforge.net/lists/listinfo/acpi-devel" =
TARGET=3D"_blank">https://lists.sourceforge.net/lists/listinfo/acpi-deve=
l</A></FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; =
-------------------------------------------------------</FONT>
<BR><FONT SIZE=3D2>&gt; This SF.Net email is sponsored by: IBM Linux =
Tutorials Free Linux </FONT>
<BR><FONT SIZE=3D2>&gt; tutorial presented by Daniel Robbins, President =
and CEO of GenToo </FONT>
<BR><FONT SIZE=3D2>&gt; technologies. Learn everything from =
fundamentals to system </FONT>
<BR><FONT SIZE=3D2>&gt; administration.<A =
HREF=3D"http://ads.osdn.com/?ad_id" TARGET=3D"_blank">http://ads.osdn.co=
m/?ad_id</A>=1470&amp;alloc_id638&amp;op=3Dick</FONT>
<BR><FONT SIZE=3D2>&gt; =
_______________________________________________</FONT>
<BR><FONT SIZE=3D2>&gt; Acpi-devel mailing list</FONT>
<BR><FONT SIZE=3D2>&gt; Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</FONT>
<BR><FONT SIZE=3D2>&gt; <A =
HREF=3D"https://lists.sourceforge.net/lists/listinfo/acpi-devel" =
TARGET=3D"_blank">https://lists.sourceforge.net/lists/listinfo/acpi-deve=
l</A></FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; =
-------------------------------------------------------</FONT>
<BR><FONT SIZE=3D2>&gt; This SF.Net email is sponsored by: IBM Linux =
Tutorials Free Linux </FONT>
<BR><FONT SIZE=3D2>&gt; tutorial presented by Daniel Robbins, President =
and CEO of GenToo </FONT>
<BR><FONT SIZE=3D2>&gt; technologies. Learn everything from =
fundamentals to system </FONT>
<BR><FONT SIZE=3D2>&gt; administration.<A =
HREF=3D"http://ads.osdn.com/?ad_id" =
TARGET=3D"_blank">http://ads.osdn.com/?ad_id</A>=1470&amp;alloc_id638&am=
p;op=3Dick</FONT>
<BR><FONT SIZE=3D2>&gt; =
_______________________________________________</FONT>
<BR><FONT SIZE=3D2>&gt; Acpi-devel mailing list</FONT>
<BR><FONT SIZE=3D2>&gt; Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</FONT>
<BR><FONT SIZE=3D2>&gt; <A =
HREF=3D"https://lists.sourceforge.net/lists/listinfo/acpi-devel" =
TARGET=3D"_blank">https://lists.sourceforge.net/lists/listinfo/acpi-deve=
l</A></FONT>
</P>
<BR>

<P><FONT =
SIZE=3D2>-------------------------------------------------------</FONT>
<BR><FONT SIZE=3D2>This SF.Net email is sponsored by: IBM Linux =
Tutorials Free Linux tutorial presented by Daniel Robbins, President =
and CEO of GenToo technologies. Learn everything from fundamentals to =
system administration.<A HREF=3D"http://ads.osdn.com/?ad_id" =
TARGET=3D"_blank">http://ads.osdn.com/?ad_id</A>=1470&amp;alloc_id638&am=
p;op=3Dick</FONT></P>

<P><FONT =
SIZE=3D2>_______________________________________________</FONT>
<BR><FONT SIZE=3D2>Acpi-devel mailing list</FONT>
<BR><FONT SIZE=3D2>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</FONT>
<BR><FONT SIZE=3D2><A =
HREF=3D"https://lists.sourceforge.net/lists/listinfo/acpi-devel" =
TARGET=3D"_blank">https://lists.sourceforge.net/lists/listinfo/acpi-deve=
l</A></FONT>
</P>
<BR>

<P><FONT =
SIZE=3D2>-------------------------------------------------------</FONT>
<BR><FONT SIZE=3D2>This SF.Net email is sponsored by: IBM Linux =
Tutorials Free Linux tutorial presented by Daniel Robbins, President =
and CEO of GenToo technologies. Learn everything from fundamentals to =
system administration.<A HREF=3D"http://ads.osdn.com/?ad_id" =
TARGET=3D"_blank">http://ads.osdn.com/?ad_id</A>=1470&amp;alloc_id638&am=
p;op=3Dclick</FONT></P>

<P><FONT =
SIZE=3D2>_______________________________________________</FONT>
<BR><FONT SIZE=3D2>Acpi-devel mailing list</FONT>
<BR><FONT SIZE=3D2>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</FONT>
<BR><FONT SIZE=3D2><A =
HREF=3D"https://lists.sourceforge.net/lists/listinfo/acpi-devel" =
TARGET=3D"_blank">https://lists.sourceforge.net/lists/listinfo/acpi-deve=
l</A></FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C4167D.28B8028C--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
