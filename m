From: Huw Rogers <count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>
Subject: S3/S4 doesn't work, no-one cares, it's a mess Re: ACPI S3 wake howto was: RE: [BKPATCH] ACPI for 2.6
Date: Tue, 30 Mar 2004 23:51:17 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040330233155.463A.COUNT0@localnet.com>
References: <7105F2BD9451D7479B4B3A99A2B72FAC062C08C7@exchange1.ssd.fsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <7105F2BD9451D7479B4B3A99A2B72FAC062C08C7-Lp/cVzEoVyYIbgCsDWxlK60bRtRcJeJQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Rockefeller, Harry" <harryr-qMhjF6E6u3VBDgjK7y7TUQ@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

There are 3 competing implementations of S3/S4. None of them work with
recent AGP ATI Mobility Radeons using ATI's drivers (the most popular
current video chipset for notebooks / the only driver set that supports
them properly in X). None of them work with hyperthreaded CPUs or SMP
(again, hardly exotic). Most USB, Ethernet and other drivers are
incompatible with S3/S4. The resume code is poorly tested, has race
conditions, doesn't enable/disable interrupts at the right junctures,
fails to restore PCI state and does nothing for AGP, USB etc. (left to
drivers that could care less about suspend/resume).

I was intent on getting my AGP ATI Radeon/P4 HT/SiS chipset notebook
working by hacking the code. BUT suspend/resume issues are in ACPI code,
in power mgmt code, in driver code, in AGP code, in suspend/resume code.
All owned by different people. Many with competing implementations.
No-one is a clear leader. The resume itself is near-impossible to debug
since nothing is alive at that point and the video chipset isn't up.

Many many people have the problem you describe (lockup on S3 resume,
need hard power cycle to restart). I have it, and have seen numerous
other people post on it all with dramatically different hardware. Only
common factors is that the hardware is recent (i.e. AGP video, typically
Mobility Radeon), and IT DOESN'T WORK.

The situation can't be helped by the hacker looking to contribute by
getting his own gear working (a massive consolidation, refactoring and
cleanup is required by someone with in-depth knowledge of both ACPI and
PC hardware). There are also probably deep implications for the Linux
x86 driver architecture to doing it "properly". Linux vendors put almost
no effort into supporting laptop hardware despite growing laptop adoption
in replacement of desktops since their strategy is to get Linux to the
point that the hardware vendors themselves are compelled to do such work
like they do for MS Windows. laptop-specific issues such as this receive
short shrift.

In short, it's a hopeless mess, no-one who could solve this problem
really cares about it enough to commission the team required, and it
requires a huge effort by a couple of gurus with buy-in from Linus & co.
for the kernel consequences to really fix this.

Not happening any time soon. Optimize your boot to make it fast instead
by fooling around with /etc/init.d and company. S3/S4? Bah. -Huw

> As a user, I'm stuck at first base.  With kernel 2.6.4
> S3 is supposedly supported.  Entering S3 appears to work.
> Exiting S3 (waking up?) the LCD screen comes back when a key is
> depressed, but *nothing* brings my machine back to life.
> The full few-seconds power-button reboot is all that works.
> 
> I admit that there may be a simple one-line web-link answer
> pointing to some ACPI FAQ or How-to.  If that is the case 
> just point me there and I'll read that.
> 
> Thanks.
> 
> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Moore, Robert
> Sent: Tuesday, March 30, 2004 10:58 AM
> To: Li, Shaohua; Manpreet Singh; Brown, Len; Linus Torvalds
> Cc: Kernel Mailing List; ACPI Developers; Grover, Andrew
> Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6
> 
> The default behavior of the ACPI CA core subsystem is to leave all "wake"
> GPEs disabled.  It is the responsibility of the upper OSPM
> (OS-dependent) software to selectively enable the wake devices via the
> AcpiEnableGpe external interface.
> 
> We could argue about whether the core should enable or disable all wake GPEs
> by default, but the code to selectively pick wake GPEs is not and cannot be
> part of the core ACPI CA code.
> 
> Bob
> 
> 
> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Li, Shaohua
> Sent: Monday, March 29, 2004 5:23 PM
> To: Manpreet Singh; Moore, Robert; Brown, Len; Linus Torvalds
> Cc: Kernel Mailing List; ACPI Developers
> Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6
> 
> Hi,
> I think ACPI should provide user interface to enable 'Wake' GPE before
> entering sleep. User can select which devices can wake up system. We have a
> track http://bugme.osdl.org/show_bug.cgi?id=1415 for this issue.
> 
> Thanks,
> David
> > -----Original Message-----
> > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel- 
> > admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Manpreet Singh
> > Sent: Tuesday, March 30, 2004 8:28 AM
> > To: Moore, Robert; Brown, Len; Linus Torvalds
> > Cc: Kernel Mailing List; ACPI Developers
> > Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6
> > 
> > Hi Bob,
> > 
> > What I mean is that I see that the system goes into S3 suspend with
> all
> > GPEs
> > being disabled. So the bitvector 'WakeEnable' has a value of 0. Now,
> on my
> > I/O controller, PME_EN: which enables PME#s to assert a wake-up event
> is
> > also
> > off which is what I'd like to see enabled for wake on LAN (etherwake)
> to
> > work.
> > 
> > How is WakeEnable initialized? Does it depend on certain BIOS table 
> > entries?
> > 
> > Forgive my n00b questions if they sound trivial.
> > 
> > Thanks,
> > Manpreet.
> > 
> > 
> > -----Original Message-----
> > From: Moore, Robert [mailto:robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> > Sent: Monday, March 29, 2004 9:33 AM
> > To: Manpreet Singh; Brown, Len; Linus Torvalds
> > Cc: Kernel Mailing List; ACPI Developers
> > Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6
> > 
> > 
> > 
> > What makes you think that *all* GPEs are disabled?
> > 
> > Here is the relevant code:
> > 
> >         /*
> >          * 1) Disable all runtime GPEs
> >          * 2) Enable all wakeup GPEs
> >          */
> >         Status = AcpiHwLowLevelWrite (8, GpeRegisterInfo->WakeEnable,
> >                 &GpeRegisterInfo->EnableAddress);
> > 
> > The "WakeEnable" field is setup such that only the WAKE GPEs are 
> > enabled.
> > 
> > Unless you are saying that "WakeEnable" is not initialized correctly.
> > 
> > Please clarify.
> > 
> > Bob
> > 
> > 
> > -----Original Message-----
> > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Manpreet 
> > Singh
> > Sent: Saturday, March 27, 2004 1:19 AM
> > To: Brown, Len; Linus Torvalds
> > Cc: Kernel Mailing List; ACPI Developers
> > Subject: RE: [ACPI] [BKPATCH] ACPI for 2.6
> > 
> > Hi Len,
> > 
> > This patch on 2.6.5-rc2 certainly helps with a "spurious" interrupt 
> > problem that I was seeing on a 2.6.4 kernel. It seems that we don't 
> > initialize GPEs unless they are needed for a resume.
> > 
> > But, in the function call "acpi_hw_prepare_gpes_for_sleep", it seems 
> > that currently *all* GPEs get disabled, some of which I would consider 
> > wake up events, like the PME enable bit that enables an S3 resume 
> > using a
> magic
> > packet. That doesn't allow wake on LAN to work properly. Is there way
> to
> > pick/specify the wake up events or does it come from the BIOS tables?
> > 
> > Also, if I have the console on a serial port, I don't get the console 
> > back after an S3 resume.
> > 
> > Actually, I am new to the ACPI list. If this is not the right place
> for
> > these
> > queries, please let me know.
> > 
> > Thanks,
> > Manpreet.
> > 
> > 
> > -----Original Message-----
> > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org]On Behalf Of Len Brown
> > Sent: Friday, March 26, 2004 4:59 PM
> > To: Linus Torvalds
> > Cc: Kernel Mailing List; ACPI Developers
> > Subject: [ACPI] [BKPATCH] ACPI for 2.6
> > 
> > 
> > Hi Linus, please do a
> > 
> > 	bk pull bk://linux-acpi.bkbits.net/linux-acpi-release-2.6.5
> > 
> > 	Three significant interrupt fixes.
> > 
> > thanks,
> > -Len
> > 
> > ps. a plain patch is also available here:
> >
> ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2
> > .6.5/
> > acpi-20040326-2.6.5.diff.gz
> > 
> > This will update the following files:
> > 
> >  arch/i386/kernel/acpi/boot.c      |   18 +
> >  drivers/acpi/ec.c                 |    4
> >  drivers/acpi/events/evgpe.c       |   11 -
> >  drivers/acpi/events/evgpeblk.c    |  242 ++++++++++++++++++++++----
> >  drivers/acpi/events/evmisc.c      |   43 ++--
> >  drivers/acpi/events/evxfevnt.c    |   25 ++
> >  drivers/acpi/executer/excreate.c  |   16 +
> >  drivers/acpi/executer/exdump.c    |    1
> >  drivers/acpi/executer/exresnte.c  |    5
> >  drivers/acpi/executer/exstoren.c  |    1
> >  drivers/acpi/hardware/hwgpe.c     |   98 ++++++----
> >  drivers/acpi/hardware/hwsleep.c   |   22 +-
> >  drivers/acpi/namespace/nsaccess.c |    9
> >  drivers/acpi/namespace/nsdump.c   |    1
> >  drivers/acpi/namespace/nseval.c   |    9
> >  drivers/acpi/namespace/nssearch.c |    6
> >  drivers/acpi/namespace/nsutils.c  |    2
> >  drivers/acpi/namespace/nsxfeval.c |   26 +-
> >  drivers/acpi/osl.c                |   21 ++
> >  drivers/acpi/pci_link.c           |   18 +
> >  drivers/acpi/resources/rsaddr.c   |   13 -
> >  drivers/acpi/utilities/utglobal.c |   42 ++--
> >  drivers/acpi/utilities/utmisc.c   |    5
> >  include/acpi/acconfig.h           |    2
> >  include/acpi/acglobal.h           |    2
> >  include/acpi/achware.h            |    4
> >  include/acpi/aclocal.h            |    7
> >  include/acpi/actypes.h            |   84 +++++----
> >  include/acpi/acutils.h            |    1
> >  29 files changed, 537 insertions(+), 201 deletions(-)
> > 
> > through these ChangeSets:
> > 
> > <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/26 1.1608.1.56)
> >    [ACPI] Linux specific updates from ACPICA 20040326
> >    "acpi_wake_gpes_always_on" boot flag for old GPE behaviour
> > 
> > <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/26 1.1608.1.55)
> >    [ACPI] ACPICA 20040326 from Bob Moore
> > 
> >    Implemented support for "wake" GPEs via interaction between
> >    GPEs and the _PRW methods.  Every GPE that is pointed to by
> >    one or more _PRWs is identified as a WAKE GPE and by default
> >    will no longer be enabled at runtime.  Previously, we were
> >    blindly enabling all GPEs with a corresponding _Lxx or _Exx
> >    method - but most of these turn out to be WAKE GPEs anyway.
> >    We believe this has been the cause of thousands of
> >    "spurious" GPEs on some systems.
> > 
> >    This new GPE behavior is can be reverted to the original
> >    behavior (enable ALL GPEs at runtime) via a runtime flag.
> > 
> >    Fixed a problem where aliased control methods could not
> >    access objects properly.  The proper scope within the
> >    namespace was not initialized (transferred to the target of
> >    the aliased method) before executing the target method.
> > 
> >    Fixed a potential race condition on internal object
> >    deletion on the return object in AcpiEvaluateObject.
> > 
> >    Integrated a fix for resource descriptors where both
> >    _MEM and _MTP were being extracted instead of just _MEM.
> >    (i.e. bitmask was incorrectly too wide, 0x0F instead of 0x03.)
> > 
> >    Added a special case for ACPI_ROOT_OBJECT in AcpiUtGetNodeName,
> >    preventing a fault in some cases.
> > 
> >    Updated Notify() values for debug statements in evmisc.c
> > 
> >    Return proper status from AcpiUtMutexInitialize,
> >    not just simply AE_OK.
> > 
> > <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/26 1.1608.1.54)
> >    [ACPI] proposed fix for non-identity-mapped SCI override
> >    http://bugme.osdl.org/show_bug.cgi?id=2366
> > 
> > <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (04/03/25 1.1608.1.53)
> >    [ACPI] PCI interrupt link routing (Luming Yu)
> >    use _PRS to determine resource type for _SRS
> >    fixes HP Proliant servers
> >    http://bugzilla.kernel.org/show_bug.cgi?id=1590
> > 
> > 
> > 
> > 
> > 
> > 
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: IBM Linux Tutorials Free Linux 
> > tutorial presented by Daniel Robbins, President and CEO of GenToo 
> > technologies. Learn everything from fundamentals to system 
> > administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> > 
> > 
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: IBM Linux Tutorials Free Linux 
> > tutorial presented by Daniel Robbins, President and CEO of GenToo 
> > technologies. Learn everything from fundamentals to system 
> > administration.http://ads.osdn.com/?ad_id70&alloc_id638&op=ick
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> > 
> > 
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: IBM Linux Tutorials Free Linux 
> > tutorial presented by Daniel Robbins, President and CEO of GenToo 
> > technologies. Learn everything from fundamentals to system 
> > administration.http://ads.osdn.com/?ad_id70&alloc_id638&op=ick
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials Free Linux tutorial
> presented by Daniel Robbins, President and CEO of GenToo technologies. Learn
> everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id70&alloc_id638&op=ick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials Free Linux tutorial
> presented by Daniel Robbins, President and CEO of GenToo technologies. Learn
> everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id70&alloc_id638&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

-- 
Huw Rogers <count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
