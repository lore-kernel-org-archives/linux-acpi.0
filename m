From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: S3/S4 doesn't work, no-one cares, it's a mess Re: ACPI S3 wake howto was: RE: [BKPATCH] ACPI for 2.6
Date: Wed, 31 Mar 2004 12:58:51 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040331105851.GA11223@pc-math-vis1>
References: <7105F2BD9451D7479B4B3A99A2B72FAC062C08C7@exchange1.ssd.fsi.com> <20040330233155.463A.COUNT0@localnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040330233155.463A.COUNT0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>
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

I don't know much about S3 and how its suspend/resume cycle is related
to S4 but ...

What is usually referred to as S4 usually means software suspend unless
you have bios support which is very rare these days. Doing an echo 4 >
proc/acpi/sleep just calls one of three implementations in 2.6, don't
remember which one but IIRC its the very dead one (pmdisk).

The problem with 2.6 is that the power management (PM) code is only
partly implemented. It doesn't exist at all for agp and dri AFAIK it
doesn't exist for usb and is partial for the rest of the
stuff. Probably months before it will be fixed and if you want to hack
into things that is the first place to start in order to try and get
things working.

For software suspend there are two in-kernel implementations, swsusp(1)
which may work for you and pmdisk which is orphaned and has had no
changes for more then 6 months so you will be lucky if it will
work. There is a patch called swsusp2 (swsusp.sourceforge.net) which is
better then swsusp but still has problems with 2.6 besides lack of PM
(which means no suspend with dri among others), mainly with SMP support
(no hyperthreading) and highmem.

It is quite stable for 2.4, again, SMP (and HT) and highmem exists but
is still in development and will probably work but may have problems
(quite a few success stories and active development, so a good chance
there).

Your best bet to get some sort of suspend going is kernel 2.4 + swsusp2

On Tue, Mar 30, 2004 at 11:51:17PM -0500, Huw Rogers wrote:
> There are 3 competing implementations of S3/S4. None of them work with
> recent AGP ATI Mobility Radeons using ATI's drivers (the most popular
> current video chipset for notebooks / the only driver set that supports
> them properly in X). None of them work with hyperthreaded CPUs or SMP
> (again, hardly exotic). Most USB, Ethernet and other drivers are
> incompatible with S3/S4. The resume code is poorly tested, has race
> conditions, doesn't enable/disable interrupts at the right junctures,
> fails to restore PCI state and does nothing for AGP, USB etc. (left to
> drivers that could care less about suspend/resume).
>=20
> I was intent on getting my AGP ATI Radeon/P4 HT/SiS chipset notebook
> working by hacking the code. BUT suspend/resume issues are in ACPI code,
> in power mgmt code, in driver code, in AGP code, in suspend/resume code.
> All owned by different people. Many with competing implementations.
> No-one is a clear leader. The resume itself is near-impossible to debug
> since nothing is alive at that point and the video chipset isn't up.
>=20
> Many many people have the problem you describe (lockup on S3 resume,
> need hard power cycle to restart). I have it, and have seen numerous
> other people post on it all with dramatically different hardware. Only
> common factors is that the hardware is recent (i.e. AGP video, typically
> Mobility Radeon), and IT DOESN'T WORK.
>=20
> The situation can't be helped by the hacker looking to contribute by
> getting his own gear working (a massive consolidation, refactoring and
> cleanup is required by someone with in-depth knowledge of both ACPI and
> PC hardware). There are also probably deep implications for the Linux
> x86 driver architecture to doing it "properly". Linux vendors put almost
> no effort into supporting laptop hardware despite growing laptop adoption
> in replacement of desktops since their strategy is to get Linux to the
> point that the hardware vendors themselves are compelled to do such work
> like they do for MS Windows. laptop-specific issues such as this receive
> short shrift.
>=20
> In short, it's a hopeless mess, no-one who could solve this problem
> really cares about it enough to commission the team required, and it
> requires a huge effort by a couple of gurus with buy-in from Linus & co.
> for the kernel consequences to really fix this.
>=20
> Not happening any time soon. Optimize your boot to make it fast instead
> by fooling around with /etc/init.d and company. S3/S4? Bah. -Huw
>=20
> > As a user, I'm stuck at first base.  With kernel 2.6.4
> > S3 is supposedly supported.  Entering S3 appears to work.
> > Exiting S3 (waking up?) the LCD screen comes back when a key is
> > depressed, but *nothing* brings my machine back to life.
> > The full few-seconds power-button reboot is all that works.
> >=20
> > I admit that there may be a simple one-line web-link answer
> > pointing to some ACPI FAQ or How-to.  If that is the case=20
> > just point me there and I'll read that.
> >=20
> > Thanks.
> >=20
> > -----Original Message-----
> > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Moore, Rob=
ert
> > Sent: Tuesday, March 30, 2004 10:58 AM
> > To: Li, Shaohua; Manpreet Singh; Brown, Len; Linus Torvalds
> > Cc: Kernel Mailing List; ACPI Developers; Grover, Andrew
> > Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6
> >=20
> > The default behavior of the ACPI CA core subsystem is to leave all "wak=
e"
> > GPEs disabled.  It is the responsibility of the upper OSPM
> > (OS-dependent) software to selectively enable the wake devices via the
> > AcpiEnableGpe external interface.
> >=20
> > We could argue about whether the core should enable or disable all wake=
 GPEs
> > by default, but the code to selectively pick wake GPEs is not and canno=
t be
> > part of the core ACPI CA code.
> >=20
> > Bob
> >=20
> >=20
> > -----Original Message-----
> > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Li, Shaohua
> > Sent: Monday, March 29, 2004 5:23 PM
> > To: Manpreet Singh; Moore, Robert; Brown, Len; Linus Torvalds
> > Cc: Kernel Mailing List; ACPI Developers
> > Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6
> >=20
> > Hi,
> > I think ACPI should provide user interface to enable 'Wake' GPE before
> > entering sleep. User can select which devices can wake up system. We ha=
ve a
> > track http://bugme.osdl.org/show_bug.cgi?id=3D1415 for this issue.
> >=20
> > Thanks,
> > David
> > > -----Original Message-----
> > > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-=20
> > > admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Manpreet Singh
> > > Sent: Tuesday, March 30, 2004 8:28 AM
> > > To: Moore, Robert; Brown, Len; Linus Torvalds
> > > Cc: Kernel Mailing List; ACPI Developers
> > > Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6
> > >=20
> > > Hi Bob,
> > >=20
> > > What I mean is that I see that the system goes into S3 suspend with
> > all
> > > GPEs
> > > being disabled. So the bitvector 'WakeEnable' has a value of 0. Now,
> > on my
> > > I/O controller, PME_EN: which enables PME#s to assert a wake-up event
> > is
> > > also
> > > off which is what I'd like to see enabled for wake on LAN (etherwake)
> > to
> > > work.
> > >=20
> > > How is WakeEnable initialized? Does it depend on certain BIOS table=
=20
> > > entries?
> > >=20
> > > Forgive my n00b questions if they sound trivial.
> > >=20
> > > Thanks,
> > > Manpreet.
> > >=20
> > >=20
> > > -----Original Message-----
> > > From: Moore, Robert [mailto:robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> > > Sent: Monday, March 29, 2004 9:33 AM
> > > To: Manpreet Singh; Brown, Len; Linus Torvalds
> > > Cc: Kernel Mailing List; ACPI Developers
> > > Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6
> > >=20
> > >=20
> > >=20
> > > What makes you think that *all* GPEs are disabled?
> > >=20
> > > Here is the relevant code:
> > >=20
> > >         /*
> > >          * 1) Disable all runtime GPEs
> > >          * 2) Enable all wakeup GPEs
> > >          */
> > >         Status =3D AcpiHwLowLevelWrite (8, GpeRegisterInfo->WakeEnabl=
e,
> > >                 &GpeRegisterInfo->EnableAddress);
> > >=20
> > > The "WakeEnable" field is setup such that only the WAKE GPEs are=20
> > > enabled.
> > >=20
> > > Unless you are saying that "WakeEnable" is not initialized correctly.
> > >=20
> > > Please clarify.
> > >=20
> > > Bob
> > >=20
> > >=20
> > > -----Original Message-----
> > > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Manpreet=
=20
> > > Singh
> > > Sent: Saturday, March 27, 2004 1:19 AM
> > > To: Brown, Len; Linus Torvalds
> > > Cc: Kernel Mailing List; ACPI Developers
> > > Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6
> > >=20
> > > Hi Len,
> > >=20
> > > This patch on 2.6.5-rc2 certainly helps with a "spurious" interrupt=
=20
> > > problem that I was seeing on a 2.6.4 kernel. It seems that we don't=
=20
> > > initialize GPEs unless they are needed for a resume.
> > >=20
> > > But, in the function call "acpi_hw_prepare_gpes_for_sleep", it seems=
=20
> > > that currently *all* GPEs get disabled, some of which I would conside=
r=20
> > > wake up events, like the PME enable bit that enables an S3 resume=20
> > > using a
> > magic
> > > packet. That doesn't allow wake on LAN to work properly. Is there way
> > to
> > > pick/specify the wake up events or does it come from the BIOS tables?
> > >=20
> > > Also, if I have the console on a serial port, I don't get the console=
=20
> > > back after an S3 resume.
> > >=20
> > > Actually, I am new to the ACPI list. If this is not the right place
> > for
> > > these
> > > queries, please let me know.
> > >=20
> > > Thanks,
> > > Manpreet.
> > >=20
> > >=20
> > > -----Original Message-----
> > > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org]On Behalf Of Len Brown
> > > Sent: Friday, March 26, 2004 4:59 PM
> > > To: Linus Torvalds
> > > Cc: Kernel Mailing List; ACPI Developers
> > > Subject: [ACPI] [BKPATCH] ACPI for 2.6
> > >=20
> > >=20
> > > Hi Linus, please do a
> > >=20
> > > 	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.5
> > >=20
> > > 	Three significant interrupt fixes.
> > >=20
> > > thanks,
> > > -Len
> > >=20
> > > ps. a plain patch is also available here:
> > >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2
> > > .6.5/
> > > acpi-20040326-2.6.5.diff.gz
> > >=20
> > > This will update the following files:
> > >=20
> > >  arch/i386/kernel/acpi/boot.c      |   18 +
> > >  drivers/acpi/ec.c                 |    4
> > >  drivers/acpi/events/evgpe.c       |   11 -
> > >  drivers/acpi/events/evgpeblk.c    |  242 ++++++++++++++++++++++----
> > >  drivers/acpi/events/evmisc.c      |   43 ++--
> > >  drivers/acpi/events/evxfevnt.c    |   25 ++
> > >  drivers/acpi/executer/excreate.c  |   16 +
> > >  drivers/acpi/executer/exdump.c    |    1
> > >  drivers/acpi/executer/exresnte.c  |    5
> > >  drivers/acpi/executer/exstoren.c  |    1
> > >  drivers/acpi/hardware/hwgpe.c     |   98 ++++++----
> > >  drivers/acpi/hardware/hwsleep.c   |   22 +-
> > >  drivers/acpi/namespace/nsaccess.c |    9
> > >  drivers/acpi/namespace/nsdump.c   |    1
> > >  drivers/acpi/namespace/nseval.c   |    9
> > >  drivers/acpi/namespace/nssearch.c |    6
> > >  drivers/acpi/namespace/nsutils.c  |    2
> > >  drivers/acpi/namespace/nsxfeval.c |   26 +-
> > >  drivers/acpi/osl.c                |   21 ++
> > >  drivers/acpi/pci_link.c           |   18 +
> > >  drivers/acpi/resources/rsaddr.c   |   13 -
> > >  drivers/acpi/utilities/utglobal.c |   42 ++--
> > >  drivers/acpi/utilities/utmisc.c   |    5
> > >  include/acpi/acconfig.h           |    2
> > >  include/acpi/acglobal.h           |    2
> > >  include/acpi/achware.h            |    4
> > >  include/acpi/aclocal.h            |    7
> > >  include/acpi/actypes.h            |   84 +++++----
> > >  include/acpi/acutils.h            |    1
> > >  29 files changed, 537 insertions(+), 201 deletions(-)
> > >=20
> > > through these ChangeSets:
> > >=20
> > > <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/26 1.1608.1.56)
> > >    [ACPI] Linux specific updates from ACPICA 20040326
> > >    "acpi_wake_gpes_always_on" boot flag for old GPE behaviour
> > >=20
> > > <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/26 1.1608.1.55)
> > >    [ACPI] ACPICA 20040326 from Bob Moore
> > >=20
> > >    Implemented support for "wake" GPEs via interaction between
> > >    GPEs and the _PRW methods.  Every GPE that is pointed to by
> > >    one or more _PRWs is identified as a WAKE GPE and by default
> > >    will no longer be enabled at runtime.  Previously, we were
> > >    blindly enabling all GPEs with a corresponding _Lxx or _Exx
> > >    method - but most of these turn out to be WAKE GPEs anyway.
> > >    We believe this has been the cause of thousands of
> > >    "spurious" GPEs on some systems.
> > >=20
> > >    This new GPE behavior is can be reverted to the original
> > >    behavior (enable ALL GPEs at runtime) via a runtime flag.
> > >=20
> > >    Fixed a problem where aliased control methods could not
> > >    access objects properly.  The proper scope within the
> > >    namespace was not initialized (transferred to the target of
> > >    the aliased method) before executing the target method.
> > >=20
> > >    Fixed a potential race condition on internal object
> > >    deletion on the return object in AcpiEvaluateObject.
> > >=20
> > >    Integrated a fix for resource descriptors where both
> > >    _MEM and _MTP were being extracted instead of just _MEM.
> > >    (i.e. bitmask was incorrectly too wide, 0x0F instead of 0x03.)
> > >=20
> > >    Added a special case for ACPI_ROOT_OBJECT in AcpiUtGetNodeName,
> > >    preventing a fault in some cases.
> > >=20
> > >    Updated Notify() values for debug statements in evmisc.c
> > >=20
> > >    Return proper status from AcpiUtMutexInitialize,
> > >    not just simply AE_OK.
> > >=20
> > > <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/26 1.1608.1.54)
> > >    [ACPI] proposed fix for non-identity-mapped SCI override
> > >    http://bugme.osdl.org/show_bug.cgi?id=3D2366
> > >=20
> > > <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/25 1.1608.1.53)
> > >    [ACPI] PCI interrupt link routing (Luming Yu)
> > >    use _PRS to determine resource type for _SRS
> > >    fixes HP Proliant servers
> > >    http://bugzilla.kernel.org/show_bug.cgi?id=3D1590
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > > -------------------------------------------------------
> > > This SF.Net email is sponsored by: IBM Linux Tutorials Free Linux=20
> > > tutorial presented by Daniel Robbins, President and CEO of GenToo=20
> > > technologies. Learn everything from fundamentals to system=20
> > > administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=
=3Dclick
> > > _______________________________________________
> > > Acpi-devel mailing list
> > > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> > >=20
> > >=20
> > > -------------------------------------------------------
> > > This SF.Net email is sponsored by: IBM Linux Tutorials Free Linux=20
> > > tutorial presented by Daniel Robbins, President and CEO of GenToo=20
> > > technologies. Learn everything from fundamentals to system=20
> > > administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dick
> > > _______________________________________________
> > > Acpi-devel mailing list
> > > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> > >=20
> > >=20
> > > -------------------------------------------------------
> > > This SF.Net email is sponsored by: IBM Linux Tutorials Free Linux=20
> > > tutorial presented by Daniel Robbins, President and CEO of GenToo=20
> > > technologies. Learn everything from fundamentals to system=20
> > > administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dick
> > > _______________________________________________
> > > Acpi-devel mailing list
> > > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: IBM Linux Tutorials Free Linux tutor=
ial
> > presented by Daniel Robbins, President and CEO of GenToo technologies. =
Learn
> > everything from fundamentals to system
> > administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dick
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: IBM Linux Tutorials Free Linux tutor=
ial
> > presented by Daniel Robbins, President and CEO of GenToo technologies. =
Learn
> > everything from fundamentals to system
> > administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dclick
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20
> --=20
> Huw Rogers <count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>
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
> =20
>  +++++++++++++++++++++++++++++++++++++++++++
>  This Mail Was Scanned By Mail-seCure System
>  at the Tel-Aviv University CC.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
