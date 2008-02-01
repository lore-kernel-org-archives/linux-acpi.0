From: Len Brown <lenb@kernel.org>
Subject: [GIT PATCH] suspend patches for 2.6.25-rc0
Date: Fri, 1 Feb 2008 18:20:56 -0500
Message-ID: <200802011820.56693.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60454 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759559AbYBAXVS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Feb 2008 18:21:18 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org

Hi Linus,

please pull from:=20

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git s=
uspend

This will update the files shown below.

thanks!

-Len

ps. individual patches are available on linux-acpi@vger.kernel.org
and a consolidated plain patch is available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/suspend/=
2.6.24/acpi-suspend-20070126-2.6.24.diff.gz

 Documentation/kernel-parameters.txt        |    5=20
 Documentation/power/basic-pm-debugging.txt |  216 ++++++++++++-----
 Documentation/power/devices.txt            |   49 ---
 Documentation/power/drivers-testing.txt    |   30 +-
 Documentation/power/notifiers.txt          |    8=20
 Documentation/power/userland-swsusp.txt    |   82 ++----
 arch/arm/Kconfig                           |    3=20
 arch/arm/mach-at91/pm.c                    |   17 +
 arch/blackfin/Kconfig                      |    4=20
 arch/frv/Kconfig                           |    5=20
 arch/mips/Kconfig                          |    4=20
 arch/powerpc/Kconfig                       |   22 +
 arch/powerpc/platforms/52xx/lite5200_pm.c  |   10=20
 arch/sh/Kconfig                            |    4=20
 arch/x86/Kconfig                           |    8=20
 arch/x86/kernel/suspend_64.c               |    8=20
 arch/x86/mm/init_32.c                      |   10=20
 drivers/acpi/hardware/hwsleep.c            |   79 ++++--
 drivers/acpi/sleep/main.c                  |  129 ++++++++--
 drivers/acpi/sleep/sleep.h                 |    2=20
 drivers/base/power/Makefile                |    2=20
 include/acpi/acpixf.h                      |    2=20
 include/linux/Kbuild                       |    1=20
 include/linux/notifier.h                   |    2=20
 include/linux/suspend.h                    |   56 ++--
 include/linux/suspend_ioctls.h             |   32 ++
 kernel/power/Kconfig                       |   65 ++---
 kernel/power/disk.c                        |  204 ++++++++++++----
 kernel/power/main.c                        |  171 +++++++++++--
 kernel/power/power.h                       |   90 ++++---
 kernel/power/snapshot.c                    |   31 +-
 kernel/power/swap.c                        |   33 +-
 kernel/power/swsusp.c                      |   48 ---
 kernel/power/user.c                        |  109 ++++++--
 34 files changed, 1034 insertions(+), 507 deletions(-)

through these commits:

Adrian Bunk (1):
      Hibernation: Move function prototypes to header

Alan Stern (2):
      Hibernation: Add PM_RESTORE_PREPARE and PM_POST_RESTORE notifiers=
 (rev. 2)
      PM: Convert PM notifiers to out-of-line code

Borislav Petkov (1):
      Suspend: Clean up suspend_64.c

David Brownell (1):
      PM: Remove obsolete /sys/devices/.../power/state docs

Johannes Berg (5):
      PM: Make PM_TRACE more architecture independent
      Hibernation: Clean up Kconfig (V2)
      Suspend: Clean up Kconfig (V2)
      Suspend: Add config option to disable the freezer if architecture=
 wants that
      Suspend: Invoke suspend notifications after console switch

Rafael J. Wysocki (27):
      Hibernation: Introduce SNAPSHOT_GET_IMAGE_SIZE ioctl
      Hibernation: Rework platform support ioctls (rev. 2)
      Hibernation: Mark SNAPSHOT_SET_SWAP_FILE ioctl as deprecated (rev=
=2E 2)
      Hibernation: Correct definitions of some ioctls (rev. 2)
      Hibernation: Introduce exportable suspend ioctls header (rev. 2)
      ACPI: Fix mismerge in acpi_hibernation_finish
      Suspend: Testing facility (rev. 2)
      suspend: build fix responding to 2.6.25 kset change
      Hibernation: New testing facility (rev. 2)
      PM: Suspend/hibernation debug documentation update (rev. 2)
      Suspend: Fix compilation warning for CONFIG_SUSPEND unset
      Hibernation: Move low level resume to disk.c
      Suspend: Fix comment in main.c
      Hibernation: Fix comment in disk.c
      Hibernation: Remove unnecessary variable declaration
      Suspend: Use common prefix in messages
      Hibernation: Update messages
      suspend: fix ia64 allmodconfig build
      Suspend: Introduce begin() and end() callbacks
      ACPI: Separate invocations of _GTS and _BFS from _PTS and _WAK
      ACPI: Separate disabling of GPEs from _PTS
      ACPI suspend: Call _PTS before suspending devices
      Hibernation: Introduce begin() and end() callbacks
      ACPI hibernation: Call _PTS before suspending devices
      ACPI: Print message before calling _PTS
      Hibernation: Invoke suspend notifications after console switch
      suspend: cleanup reference to swsusp_pg_dir[]

Shaohua Li (1):
      ACPI: clear GPE earily in resume to avoid warning

with this log:

commit a01da01d819ceb4c3f63d2aa7e1321c6a5e53fd8
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Fri Feb 1 15:28:16 2008 +0100

    suspend: cleanup reference to swsusp_pg_dir[]
   =20
    swsusp_pg_dir[] is used for suspend, but not for hibernation.
    clean-up the ifdefs which worked by accident, while implying the op=
posite.
    Delete the __nosavedata, which also implied the opposite.
   =20
    Some day we may optimize CONFIG_ACPI_SLEEP to build minimal kernels
    for just hibernate or just suspend but not both,
    but today isn't that day.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ee128c59cf30f5a013b309cf95c80f1561ca4388
Author: David Brownell <david-b@pacbell.net>
Date:   Fri Jan 11 01:26:57 2008 +0100

    PM: Remove obsolete /sys/devices/.../power/state docs
   =20
    The /sys/devices/.../power/state files have been gone for a while
    now, but I just noticed some documentation that still refers to
    them.  (Fortunately described as DEPRECATED and WILL REMOVE).
   =20
    Time to remove that obsolete documentation too ...
   =20
    Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6c6e1163d2b4833bf448f02aaf26e12053957078
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Fri Jan 11 01:25:21 2008 +0100

    Hibernation: Invoke suspend notifications after console switch
   =20
    Following the recent change in the suspend code path, switch consol=
es before
    calling PM notifiers during hibernation.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a7c630e98acfad228bd2b3bba59e163ad86ed6ee
Author: Johannes Berg <johannes@sipsolutions.net>
Date:   Fri Jan 11 01:22:23 2008 +0100

    Suspend: Invoke suspend notifications after console switch
   =20
    In order to fix APM emulation it is necessary to enable apm-emulati=
on
    notifications for suspends triggered in various ways via the suspen=
d
    notifiers.  However, this will cause the systems using APM emulatio=
n
    to lock up between X being needed to switch away from the VT and X
    already waiting for resume in the APM ioctl.
   =20
    This patch moves the console switch (if enabled) before the suspend
    notification (and after the resume notification) to avoid this issu=
e.
   =20
    Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 31210f178861d7584cab1bca12ccd5547194d9eb
Author: Borislav Petkov <bbpetkov@yahoo.de>
Date:   Mon Dec 17 00:30:22 2007 +0100

    Suspend: Clean up suspend_64.c
   =20
    There's a freakishly long comment in suspend_64.c, shorten it.
   =20
    Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 16a00d127d8162c859537bbd8cb3934603a7985a
Author: Johannes Berg <johannes@sipsolutions.net>
Date:   Tue Jan 15 23:17:00 2008 -0500

    Suspend: Add config option to disable the freezer if architecture w=
ants that
   =20
    This patch makes the freezer optional for suspend to allow the
    system to work (or not work) like the original PMU suspend.
   =20
    Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit fca1ac6dca20d23ae708b2bb85b1f4c1b7549f43
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Tue Jan 8 00:10:57 2008 +0100

    ACPI: Print message before calling _PTS
   =20
    Make acpi_sleep_prepare() static and cause it to print a message
    specifying the ACPI system sleep state to be entered (helpful for
    debugging the suspend/hibernation code).
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Acked-by: Pavel Machek <pavel@suse.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d629dee14e037644f4ddcd42f74674c782fb3ecf
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Tue Jan 8 00:09:58 2008 +0100

    ACPI hibernation: Call _PTS before suspending devices
   =20
    The ACPI 1.0 specification wants us to put devices into low power
    states after executing the _PTS global control method, while ACPI
    2.0 and later want us to do that in the reverse order.  The current
    hibernation code follows ACPI 2.0 in that respect which may cause s=
ome
    ACPI 1.0x systems to hang during hibernation (ref.
    http://bugzilla.kernel.org/show_bug.cgi?id=3D9528).
   =20
    Make the hibernation code execute _PTS before putting devices into
    low power states (ie. in accordance with ACPI 1.0x) with the
    possibility to override that using the 'acpi_new_pts_ordering' kern=
el
    command line option.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 07f44315b9cfad180296df99bcd38879f063f092
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Tue Jan 8 00:08:44 2008 +0100

    Hibernation: Introduce begin() and end() callbacks
   =20
    Introduce global hibernation callback .end() and rename global
    hibernation callback .start() to .begin(), in analogy with the
    recent modifications of the global suspend callbacks.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c833a830b4926ea04d190524966874d061397900
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Tue Jan 8 00:07:39 2008 +0100

    ACPI suspend: Call _PTS before suspending devices
   =20
    The ACPI 1.0 specification wants us to put devices into low power
    states after executing the _PTS global control method, while ACPI
    2.0 and later want us to do that in the reverse order.  The current
    suspend code follows ACPI 2.0 in that respect which causes some
    ACPI 1.0x systems to hang during suspend (ref.
    http://bugzilla.kernel.org/show_bug.cgi?id=3D9528).
   =20
    Make the suspend code execute _PTS before putting devices into low
    power states (ie. in accordance with ACPI 1.0x) and provide a comma=
nd
    line option to override the default if need be.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit aedf9a8ff25f5890eb416d95520afdc5d40e539b
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Tue Jan 8 00:06:16 2008 +0100

    ACPI: Separate disabling of GPEs from _PTS
   =20
    The preparation to enter an ACPI system sleep state is now tied to
    the disabling of GPEs, but the GPEs should not be disabled before
    suspending devices.  Since on ACPI 1.0x systems the _PTS global
    control method should be executed before suspending devices, we
    need to disable GPEs separately.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Acked-by: Pavel Machek <pavel@suse.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4e1bc50b0e083b4d990f6eb54a6a098565bd5197
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Tue Jan 8 00:05:21 2008 +0100

    ACPI: Separate invocations of _GTS and _BFS from _PTS and _WAK
   =20
    The execution of ACPI global control methods _GTS and _BFS is
    currently tied to the preparation to enter a sleep state and to the
    leaving of the sleep state, respectively.  However, these functions
    are called before disabling the nonboot CPUs and after enabling
    them, respectively (in fact, on ACPI 1.0x systems the first of them
    ought to be called before suspending devices), while according to t=
he
    ACPI specification, _GTS is to be executed right prior to entering
    the system sleep state and _BFS is to be executed right after the
    platfor firmware has returned control to the OS on wake up.
   =20
    Move the execution of _GTS and _BFS to the right places.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Acked-by: Pavel Machek <pavel@suse.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 68db114effdf54dd7fc0c724ab2aef5bc98d9c79
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Tue Jan 8 00:04:17 2008 +0100

    Suspend: Introduce begin() and end() callbacks
   =20
    On ACPI systems the target state set by acpi_pm_set_target() is
    reset by acpi_pm_finish(), but that need not be called if the
    suspend fails. =C2=A0All platforms that use the .set_target() globa=
l
    suspend callback are affected by analogous issues.
   =20
    For this reason, we need an additional global suspend callback that
    will reset the target state regardless of whether or not the suspen=
d
    is successful. =C2=A0Also, it is reasonable to rename the .set_targ=
et()
    callback, since it will be used for a different purpose on ACPI
    systems (due to ACPI 1.0x code ordering requirements).
   =20
    Introduce the global suspend callback .end() to be executed at the
    end of the suspend sequence and rename the .set_target() global
    suspend callback to .begin().
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit fbfe034f5ef51cdd8338a868a2101608f8c45757
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Fri Dec 14 01:07:13 2007 +0100

    suspend: fix ia64 allmodconfig build
   =20
    kernel/power/main.c:488: error: =E2=80=98pm_test_attr=E2=80=99 unde=
clared here (not in a function)
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4e29bddd1bc13fe78da1d1a11dcb335f7fe36f6e
Author: Shaohua Li <shaohua.li@intel.com>
Date:   Wed Jun 20 09:17:58 2007 +0800

    ACPI: clear GPE earily in resume to avoid warning
   =20
    Wakeup GPE hasn't a handler. If system is waked up by such GPE like=
 a
    USB hotplug, I saw a lot of error reporting the GPE hasn't handler.
    acpi_leave_sleep_state will clear the GPE but it's too late, we sho=
uld
    do it before interrupt is re-enabled.
   =20
    Signed-off-by: Shaohua Li <shaohua.li@intel.com>
    Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9a72d19a83ff28dd65eae54e210a9141ad993e88
Author: Johannes Berg <johannes@sipsolutions.net>
Date:   Sat Dec 8 02:14:00 2007 +0100

    Suspend: Clean up Kconfig (V2)
   =20
    This cleans up the suspend Kconfig and removes the need to
    declare centrally which architectures support suspend. All
    architectures that currently support suspend are modified
    accordingly.
   =20
    Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
    Acked-by: Russell King <rmk@arm.linux.org.uk>
    Acked-by: Paul Mackerras <paulus@samba.org>
    Acked-by: Ralf Baechle <ralf@linux-mips.org>
    Acked-by: Paul Mundt <lethal@linux-sh.org>
    Cc: Pavel Machek <pavel@suse.cz>
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 03f5cd73a5b5b30f6f3bcf8d68b3b79afb8cb880
Author: Johannes Berg <johannes@sipsolutions.net>
Date:   Sat Dec 8 02:12:39 2007 +0100

    Hibernation: Clean up Kconfig (V2)
   =20
    This cleans up the hibernation Kconfig and removes the need to
    declare centrally which architectures support hibernation. All
    architectures that currently support hibernation are modified
    accordingly.
   =20
    Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
    Acked-by: Paul Mackerras <paulus@samba.org>
    Cc: Pavel Machek <pavel@suse.cz>
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5c54eb7f956ad54ecb2ffb7933f26831a3b83bb4
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Sat Dec 8 02:09:43 2007 +0100

    Hibernation: Update messages
   =20
    Make hibernation messages start with one common prefix "PM: " and u=
se
    the word "hibernation" in the messages as a synonym of "suspend to
    disk".
   =20
    Turn some KERN_INFO messages into debug ones.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ee4d64cfc351e1d33a43a62c072228a8d633f9e4
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Sat Dec 8 02:08:38 2007 +0100

    Suspend: Use common prefix in messages
   =20
    Make suspend messages start with one common prefix "PM: ".
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5521e77e047321aa77c606d275093e24897c0fa2
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Sat Dec 8 02:07:40 2007 +0100

    Hibernation: Remove unnecessary variable declaration
   =20
    Remove the unnecessary extern declaration of resume_file[]
    from kernel/power/swap.c .
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9248efd164497b06c942e1c38d51a90c268265ef
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Sat Dec 8 02:06:57 2007 +0100

    Hibernation: Fix comment in disk.c
   =20
    Fix a comment in kernel/power/disk.c so that it doesn't contain lin=
es
    longer that 80 characters.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 531ca296b97439089a9976c3344e4e2eaa0381a6
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Sat Dec 8 02:06:00 2007 +0100

    Suspend: Fix comment in main.c
   =20
    Fix a comment in kernel/power/main.c so that it doesn't contain lin=
es
    longer that 80 characters.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d2fdea0305f2b5c6887eff954d1cabb304a376ae
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Sat Dec 8 02:04:21 2007 +0100

    Hibernation: Move low level resume to disk.c
   =20
    Move the low level restore code to kernel/power/disk.c , since the
    corresponding low level hibernation code is already there.
   =20
    Make restore fail if device_power_down(PMSG_PRETHAW) returns an
    error.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2006b470bbc77e4d6b46a7bbb5b68119e1a8db3f
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Sat Dec 8 02:03:26 2007 +0100

    Suspend: Fix compilation warning for CONFIG_SUSPEND unset
   =20
    Suspend: Make debug facility depend on CONFIG_SUSPEND
   =20
    Make the new suspend debug facility code depend on CONFIG_SUSPEND,
    as appropriate, to remove the compiler warning printed when CONFIG_=
PM is set
    and CONFIG_SUSPEND is not set.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8ff7d174bef41a219ea7a2d4e99cfd4e8aae0c8c
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Mon Nov 19 23:49:18 2007 +0100

    PM: Convert PM notifiers to out-of-line code
   =20
    This patch (as1008b) converts the PM notifier routines from inline
    calls to out-of-line code.  It also prevents pm_chain_head from
    being created when CONFIG_PM_SLEEP isn't enabled, and EXPORTs the
    notifier registration and unregistration routines.
   =20
    Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 76eb98a092c3481b3c1f1b9c67c97e77b8cdcea0
Author: Johannes Berg <johannes@sipsolutions.net>
Date:   Mon Nov 19 23:46:16 2007 +0100

    PM: Make PM_TRACE more architecture independent
   =20
    When trying to debug a suspend failure I started implementing
    PM_TRACE for powerpc. I then noticed that I'm debugging a suspend
    failure and so PM_TRACE isn't useful at all, but thought that
    nonetheless this could be useful in the future.
   =20
    Basically, to support PM_TRACE, you add a Kconfig option that
    selects PM_TRACE and provides the infrastructure as per the
    help text of PM_TRACE.
   =20
    Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 5c93d7a4578d187f9a529f986626cd37ab6e3e83
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Mon Nov 19 23:43:34 2007 +0100

    PM: Suspend/hibernation debug documentation update (rev. 2)
   =20
    Update the suspend/hibernation debugging and testing documentation =
to describe
    the newly introduced testing facilities.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 460db5c6402b5a4e362b564bdfa436dfa4e3b661
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Mon Nov 19 23:42:31 2007 +0100

    Hibernation: New testing facility (rev. 2)
   =20
    Make it possible to test the hibernation core code with the help of=
 the
    /sys/power/pm_test attribute introduced for suspend testing in the =
previous
    patch.
   =20
    Writing an appropriate string to this file causes the hibernation c=
ode to work
    in one of the test modes defined as follows:
   =20
    freezer
    - test the freezing of processes
   =20
    devices
    - test the freezing of processes and suspending of devices
   =20
    platform
    - test the freezing of processes, suspending of devices and platfor=
m global
    =C2=A0 control methods(*)
   =20
    processors
    - test the freezing of processes, suspending of devices, platform g=
lobal
    =C2=A0 control methods(*) and the disabling of nonboot CPUs
   =20
    core
    - test the freezing of processes, suspending of devices, platform g=
lobal
    =C2=A0 control methods(*), the disabling of nonboot CPUs and suspen=
ding of
    =C2=A0 platform/system devices
   =20
    (*) - the platform global control methods are only available on ACP=
I systems
    =C2=A0 =C2=A0 =C2=A0 and are only tested if the hibernation mode is=
 set to "platform"
   =20
    Then, if a hibernation is started by normal means, the hibernation =
core will
    perform its normal operations up to the point indicated by given te=
st level.
    Next, it will wait for 5 seconds and carry out the resume operation=
s needed to
    transition the system back to the fully functional state.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 21779c8de31b1c9e749af676a033109f70156678
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Tue Jan 29 00:29:06 2008 +0100

    suspend: build fix responding to 2.6.25 kset change
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 73b3b8a6d123c77888caa9acfb5938fc784e7732
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Mon Nov 19 23:41:19 2007 +0100

    Suspend: Testing facility (rev. 2)
   =20
    Introduce sysfs attribute /sys/power/pm_test allowing one to test t=
he suspend
    core code. =C2=A0Namely, writing one of the strings:
   =20
    freezer
    devices
    platform
    processors
    core
   =20
    to this file causes the suspend code to work in one of the test mod=
es defined as
    follows:
   =20
    freezer
    - test the freezing of processes
   =20
    devices
    - test the freezing of processes and suspending of devices
   =20
    platform
    - test the freezing of processes, suspending of devices and platfor=
m global
    =C2=A0 control methods(*)
   =20
    processors
    - test the freezing of processes, suspending of devices, platform g=
lobal
    =C2=A0 control methods and the disabling of nonboot CPUs
   =20
    core
    - test the freezing of processes, suspending of devices, platform g=
lobal
    =C2=A0 control methods, the disabling of nonboot CPUs and suspendin=
g of
    =C2=A0 platform/system devices
   =20
    (*) These are ACPI global control methods on ACPI systems
   =20
    Then, if a suspend is started by normal means, the suspend core wil=
l perform
    its normal operations up to the point indicated by given test level=
=2E =C2=A0Next, it
    will wait for 5 seconds and carry out the resume operations needed =
to transition
    the system back to the fully functional state.
   =20
    Writing "none" to /sys/power/pm_test turns the testing off.
   =20
    When open for reading, /sys/power/pm_test contains a space-separate=
d list of all
    available tests (including "none" that represents the normal functi=
onality) in
    which the current test level is indicated by square brackets.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f0c5038e08f04af6f6aa0536c7efed6e128520fe
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Mon Nov 19 23:38:25 2007 +0100

    Hibernation: Add PM_RESTORE_PREPARE and PM_POST_RESTORE notifiers (=
rev. 2)
   =20
    Add PM_RESTORE_PREPARE and PM_POST_RESTORE notifiers to the PM core=
, to be used
    in analogy with the existing PM_HIBERNATION_PREPARE and PM_POST_HIB=
ERNATION
    notifiers.
   =20
    Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: "Rafael J. Wysocki" <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d7b47cc8a4c8dbb1a4a05f4ee48304fb4a4e0099
Author: Adrian Bunk <bunk@kernel.org>
Date:   Mon Nov 19 23:36:20 2007 +0100

    Hibernation: Move function prototypes to header
   =20
    This patch moves the prototypes of count_highmem_pages() and
    restore_highmem() to kernel/power/power.h
   =20
    Signed-off-by: Adrian Bunk <bunk@kernel.org>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0122b99e0414205d1f3c1f4bf80f2082f6f1c8b0
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Mon Nov 19 23:33:59 2007 +0100

    ACPI: Fix mismerge in acpi_hibernation_finish
   =20
    Some code in acpi_hibernation_finish() was moved to acpi_hibernatio=
n_leave(),
    but the old copy had been left (it's harmless, but also useless).  =
Remove it.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f07d2c9078e140323301a72140c6caeb372448dc
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Fri Oct 26 01:05:05 2007 +0200

    Hibernation: Introduce exportable suspend ioctls header (rev. 2)
   =20
    Move the definitions of hibernation ioctls to a separate header fil=
e in
    include/linux, which can be exported to the user space.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit f5147875db58350b7c29856b83ef1e38e88a387b
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Fri Oct 26 01:03:33 2007 +0200

    Hibernation: Correct definitions of some ioctls (rev. 2)
   =20
    Three ioctl numbers belonging to the hibernation userland interface=
,
    SNAPSHOT_ATOMIC_SNAPSHOT, SNAPSHOT_AVAIL_SWAP, SNAPSHOT_GET_SWAP_PA=
GE,
    are defined in a wrong way (eg. not portable).  Provide new ioctl n=
umbers for
    these ioctls and mark the existing ones as deprecated.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit dbb027badbbd8ae51e914eca50774755d207826a
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Fri Oct 26 01:02:15 2007 +0200

    Hibernation: Mark SNAPSHOT_SET_SWAP_FILE ioctl as deprecated (rev. =
2)
   =20
    Mark the SNAPSHOT_SET_SWAP_FILE ioctl belonging to the hibernation =
userland
    interface as deprecated.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6ef4bd5a2709f3f8d28e0ce83c911ed2a8af5afe
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Fri Oct 26 01:01:10 2007 +0200

    Hibernation: Rework platform support ioctls (rev. 2)
   =20
    Modify the hibernation userland interface by adding two new ioctls =
to it,
    SNAPSHOT_PLATFORM_SUPPORT and SNAPSHOT_POWER_OFF, that can be used,
    respectively, to switch the hibernation platform support on/off and=
 to make the
    kernel transition the system to the hibernation state (eg. ACPI S4)=
 using the
    platform (eg. ACPI) driver.
   =20
    These ioctls are intended to replace the misdesigned SNAPSHOT_PMOPS=
 ioctl,
    which from now is regarded as obsolete and will be removed in the f=
uture.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit edae89f5d1eb1fbe1cab74333db5a8e29776900e
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Fri Oct 26 00:59:31 2007 +0200

    Hibernation: Introduce SNAPSHOT_GET_IMAGE_SIZE ioctl
   =20
    Add a new ioctl, SNAPSHOT_GET_IMAGE_SIZE, returning the size of the=
 (just
    created) hibernation image, to the hibernation userland interface.
   =20
    This ioctl is necessary so that the userland utilities using the in=
terface need
    not access the hibernation image header, owned by the kernel, in or=
der to obtain
    the size of the image.
   =20
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Len Brown <len.brown@intel.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
