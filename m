From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/4] cpuidle: consolidate 2.6.22 cpuidle branch into one patch
Date: Wed, 10 Oct 2007 01:07:47 -0400
Message-ID: <1191992870-15009-2-git-send-email-lenb@kernel.org>
References: <1191992870-15009-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56647 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459AbXJJFHy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Oct 2007 01:07:54 -0400
In-Reply-To: <1191992870-15009-1-git-send-email-lenb@kernel.org>
Message-Id: <4f86d3a8e297205780cca027e974fd5f81064780.1191992618.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

=46rom: Len Brown <len.brown@intel.com>

commit e5a16b1f9eec0af7cfa0830304b41c1c0833cf9f
Author: Len Brown <len.brown@intel.com>
Date:   Tue Oct 2 23:44:44 2007 -0400

    cpuidle: shrink diff

    processor_idle.c |  440 +++++++++++++++++++++++++++++++++++++++++--
    1 file changed, 429 insertions(+), 11 deletions(-)

    Signed-off-by: Len Brown <len.brown@intel.com>

commit dfbb9d5aedfb18848a3e0d6f6e3e4969febb209c
Author: Len Brown <len.brown@intel.com>
Date:   Wed Sep 26 02:17:55 2007 -0400

    cpuidle: reduce diff size

    Reduces the cpuidle processor_idle.c diff vs 2.6.22 from this
     processor_idle.c | 2006 ++++++++++++++++++++++++++----------------=
-
     1 file changed, 1219 insertions(+), 787 deletions(-)

    to this:
     processor_idle.c |  502 +++++++++++++++++++++++++++++++++++++++---=
-
     1 file changed, 458 insertions(+), 44 deletions(-)

    ...for the purpose of making the cpuilde patch less invasive
    and easier to review.

    no functional changes.  build tested only.

    Signed-off-by: Len Brown <len.brown@intel.com>

commit 889172fc915f5a7fe20f35b133cbd205ce69bf6c
Author: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Thu Sep 13 13:40:05 2007 -0700

    cpuidle: Retain old ACPI policy for !CONFIG_CPU_IDLE

    Retain the old policy in processor_idle, so that when CPU_IDLE is n=
ot
    configured, old C-state policy will still be used. This provides a
    clean gradual migration path from old ACPI policy to new cpuidle
    based policy.

    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9544a8181edc7ecc33b3bfd69271571f98ed08bc
Author: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Thu Sep 13 13:39:17 2007 -0700

    cpuidle: Configure governors by default

    Quoting Len "Do not give an option to users to shoot themselves in =
the foot".

    Remove the configurability of ladder and menu governors as they are
    needed for default policy of cpuidle. That way users will not be ab=
le to
    have cpuidle without any policy loosing all C-state power savings.

    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8975059a2c1e56cfe83d1bcf031bcf4cb39be743
Author: Adam Belay <abelay@novell.com>
Date:   Tue Aug 21 18:27:07 2007 -0400

    CPUIDLE: load ACPI properly when CPUIDLE is disabled

    Change the registration return codes for when CPUIDLE
    support is not compiled into the kernel.  As a result, the ACPI
    processor driver will load properly even if CPUIDLE is unavailable.
    However, it may be possible to cleanup the ACPI processor driver fu=
rther
    and eliminate some dead code paths.

    Signed-off-by: Adam Belay <abelay@novell.com>
    Acked-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e0322e2b58dd1b12ec669bf84693efe0dc2414a8
Author: Adam Belay <abelay@novell.com>
Date:   Tue Aug 21 18:26:06 2007 -0400

    CPUIDLE: remove cpuidle_get_bm_activity()

    Remove cpuidle_get_bm_activity() and updates governors
    accordingly.

    Signed-off-by: Adam Belay <abelay@novell.com>
    Acked-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 18a6e770d5c82ba26653e53d240caa617e09e9ab
Author: Adam Belay <abelay@novell.com>
Date:   Tue Aug 21 18:25:58 2007 -0400

    CPUIDLE: max_cstate fix

    Currently max_cstate is limited to 0, resulting in no idle processo=
r
    power management on ACPI platforms.  This patch restores the value =
to
    the array size.

    Signed-off-by: Adam Belay <abelay@novell.com>
    Acked-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1fdc0887286179b40ce24bcdbde663172e205ef0
Author: Adam Belay <abelay@novell.com>
Date:   Tue Aug 21 18:25:40 2007 -0400

    CPUIDLE: handle BM detection inside the ACPI Processor driver

    Update the ACPI processor driver to detect BM activity and
    limit state entry depth internally, rather than exposing such
    requirements to CPUIDLE.  As a result, CPUIDLE can drop this
    ACPI-specific interface and become more platform independent.  BM
    activity is now handled much more aggressively than it was in the
    original implementation, so some testing coverage may be needed to
    verify that this doesn't introduce any DMA buffer under-run issues.

    Signed-off-by: Adam Belay <abelay@novell.com>
    Acked-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0ef38840db666f48e3cdd2b769da676c57228dd9
Author: Adam Belay <abelay@novell.com>
Date:   Tue Aug 21 18:25:14 2007 -0400

    CPUIDLE: menu governor updates

    Tweak the menu governor to more effectively handle non-timer
    break events.  Non-timer break events are detected by comparing the
    actual sleep time to the expected sleep time.  In future revisions,=
 it
    may be more reliable to use the timer data structures directly.

    Signed-off-by: Adam Belay <abelay@novell.com>
    Acked-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit bb4d74fca63fa96cf3ace644b15ae0f12b7df5a1
Author: Adam Belay <abelay@novell.com>
Date:   Tue Aug 21 18:24:40 2007 -0400

    CPUIDLE: fix 'current_governor' sysfs entry

    Allow the "current_governor" sysfs entry to properly handle
    input terminated with '\n'.

    Signed-off-by: Adam Belay <abelay@novell.com>
    Acked-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit df3c71559bb69b125f1a48971bf0d17f78bbdf47
Author: Len Brown <len.brown@intel.com>
Date:   Sun Aug 12 02:00:45 2007 -0400

    cpuidle: fix IA64 build (again)

    Signed-off-by: Len Brown <len.brown@intel.com>

commit a02064579e3f9530fd31baae16b1fc46b5a7bca8
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Sun Aug 12 01:39:27 2007 -0400

    cpuidle: Remove support for runtime changing of max_cstate

    Remove support for runtime changeability of max_cstate. Drivers can=
 use
    use latency APIs.

    max_cstate can still be used as a boot time option and dmi override=
=2E

    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0912a44b13adf22f5e3f607d263aed23b4910d7e
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Sun Aug 12 01:39:16 2007 -0400

    cpuidle: Remove ACPI cstate_limit calls from ipw2100

    ipw2100 already has code to use accetable_latency interfaces to lim=
it the
    C-state. Remove the calls to acpi_set_cstate_limit and acpi_get_cst=
ate_limit
    as they are redundant.

    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c649a76e76be6bff1fd770d0a775798813a3f6e0
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Sun Aug 12 01:35:39 2007 -0400

    cpuidle: compile fix for pause and resume functions

    Fix the compilation failure when cpuidle is not compiled in.

    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Acked-by: Adam Belay <adam.belay@novell.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2305a5920fb8ee6ccec1c62ade05aa8351091d71
Author: Adam Belay <abelay@novell.com>
Date:   Thu Jul 19 00:49:00 2007 -0400

    cpuidle: re-write

    Some portions have been rewritten to make the code cleaner and ligh=
ter
    weight.  The following is a list of changes:

    1.) the state name is now included in the sysfs interface
    2.) detection, hotplug, and available state modifications are handl=
ed by
    CPUIDLE drivers directly
    3.) the CPUIDLE idle handler is only ever installed when at least o=
ne
    cpuidle_device is enabled and ready
    4.) the menu governor BM code no longer overflows
    5.) the sysfs attributes are now printed as unsigned integers, avoi=
ding
    negative values
    6.) a variety of other small cleanups

    Also, Idle drivers are no longer swappable during runtime through t=
he
    CPUIDLE sysfs inteface.  On i386 and x86_64 most idle handlers (e.g=
=2E
    poll, mwait, halt, etc.) don't benefit from an infrastructure that
    supports multiple states, so I think using a more general case idle
    handler selection mechanism would be cleaner.

    Signed-off-by: Adam Belay <abelay@novell.com>
    Acked-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Acked-by: Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit df25b6b56955714e6e24b574d88d1fd11f0c3ee5
Author: Len Brown <len.brown@intel.com>
Date:   Tue Jul 24 17:08:21 2007 -0400

    cpuidle: fix IA64 buid

    Signed-off-by: Len Brown <len.brown@intel.com>

commit fd6ada4c14488755ff7068860078c437431fbccd
Author: Adrian Bunk <bunk@stusta.de>
Date:   Mon Jul 9 11:33:13 2007 -0700

    cpuidle: static

    make cpuidle_replace_governor() static

    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c1d4a2cebcadf2429c0c72e1d29aa2a9684c32e0
Author: Adrian Bunk <bunk@stusta.de>
Date:   Tue Jul 3 00:54:40 2007 -0400

    cpuidle: static

    This patch makes the needlessly global struct menu_governor static.

    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit dbf8780c6e8d572c2c273da97ed1cca7608fd999
Author: Andrew Morton <akpm@linux-foundation.org>
Date:   Tue Jul 3 00:49:14 2007 -0400

    export symbol tick_nohz_get_sleep_length

    ERROR: "tick_nohz_get_sleep_length" [drivers/cpuidle/governors/menu=
=2Eko] undefined!
    ERROR: "tick_nohz_get_idle_jiffies" [drivers/cpuidle/governors/menu=
=2Eko] undefined!

    And please be sure to get your changes to core kernel suitably revi=
ewed.

    Cc: Adam Belay <abelay@novell.com>
    Cc: Venki Pallipadi <venkatesh.pallipadi@intel.com>
    Cc: Ingo Molnar <mingo@elte.hu>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: john stultz <johnstul@us.ibm.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 29f0e248e7017be15f99febf9143a2cef00b2961
Author: Andrew Morton <akpm@linux-foundation.org>
Date:   Tue Jul 3 00:43:04 2007 -0400

    tick.h needs hrtimer.h

    It uses hrtimers.

    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e40cede7d63a029e92712a3fe02faee60cc38fb4
Author: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Tue Jul 3 00:40:34 2007 -0400

    cpuidle: first round of documentation updates

    Documentation changes based on Pavel's feedback.

    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 83b42be2efece386976507555c29e7773a0dfcd1
Author: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Tue Jul 3 00:39:25 2007 -0400

    cpuidle: add rating to the governors and pick the one with highest =
rating by default

    Introduce a governor rating scheme to pick the right governor by de=
fault.

    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d2a74b8c5e8f22def4709330d4bfc4a29209b71c
Author: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Tue Jul 3 00:38:08 2007 -0400

    cpuidle: make cpuidle sysfs driver governor switch off by default

    Make default cpuidle sysfs to show current_governor and current_dri=
ver in
    read-only mode.  More elaborate available_governors and available_d=
rivers with
    writeable current_governor and current_driver interface only appear=
 with
    "cpuidle_sysfs_switch" boot parameter.

    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1f60a0e80bf83cf6b55c8845bbe5596ed8f6307b
Author: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Tue Jul 3 00:37:00 2007 -0400

    cpuidle: menu governor: change the early break condition

    Change the C-state early break out algorithm in menu governor.

    We only look at early breakouts that result in wakeups shorter than=
 idle
    state's target_residency.  If such a breakout is frequent enough, e=
liminate
    the particular idle state upto a timeout period.

    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 45a42095cf64b003b4a69be3ce7f434f97d7af51
Author: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Tue Jul 3 00:35:38 2007 -0400

    cpuidle: fix uninitialized variable in sysfs routine

    Fix the uninitialized usage of ret.

    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 80dca7cdba3e6ee13eae277660873ab9584eb3be
Author: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Tue Jul 3 00:34:16 2007 -0400

    cpuidle: reenable /proc/acpi//power interface for the time being

    Keep /proc/acpi/processor/CPU*/power around for a while as powertop=
 depends
    on it. It will be marked deprecated and removed in future. powertop=
 can use
    cpuidle interfaces instead.

    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 589c37c2646c5e3813a51255a5ee1159cb4c33fc
Author: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Tue Jul 3 00:32:37 2007 -0400

    cpuidle: menu governor and hrtimer compile fix

    Compile fix for menu governor.

    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0ba80bd9ab3ed304cb4f19b722e4cc6740588b5e
Author: Len Brown <len.brown@intel.com>
Date:   Thu May 31 22:51:43 2007 -0400

    cpuidle: build fix - cpuidle vs ipw2100 module

    ERROR: "acpi_set_cstate_limit" [drivers/net/wireless/ipw2100.ko] un=
defined!

    Signed-off-by: Len Brown <len.brown@intel.com>

commit d7d8fa7f96a7f7682be7c6cc0cc53fa7a18c3b58
Author: Adam Belay <abelay@novell.com>
Date:   Sat Mar 24 03:47:07 2007 -0400

    cpuidle: add the 'menu' governor

    Here is my first take at implementing an idle PM governor that take=
s
    full advantage of NO_HZ.  I call it the 'menu' governor because it
    considers the full list of idle states before each entry.

    I've kept the implementation fairly simple.  It attempts to guess t=
he
    next residency time and then chooses a state that would meet at lea=
st
    the break-even point between power savings and entry cost.  To this=
 end,
    it selects the deepest idle state that satisfies the following
    constraints:
         1. If the idle time elapsed since bus master activity was dete=
cted
            is below a threshold (currently 20 ms), then limit the sele=
ction
            to C2-type or above.
         2. Do not choose a state with a break-even residency that exce=
eds
            the expected time remaining until the next timer interrupt.
         3. Do not choose a state with a break-even residency that exce=
eds
            the elapsed time between the last pair of break events,
            excluding timer interrupts.

    This governor has an advantage over "ladder" governor because it
    proactively checks how much time remains until the next timer inter=
rupt
    using the tick infrastructure.  Also, it handles device interrupt
    activity more intelligently by not including timer interrupts in br=
eak
    event calculations.  Finally, it doesn't make policy decisions usin=
g the
    number of state entries, which can have variable residency times (N=
O_HZ
    makes these potentially very large), and instead only considers sle=
ep
    time deltas.

    The menu governor can be selected during runtime using the cpuidle =
sysfs
    interface like so:
    "echo "menu" > /sys/devices/system/cpu/cpuidle/current_governor"

    Signed-off-by: Adam Belay <abelay@novell.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit a4bec7e65aa3b7488b879d971651cc99a6c410fe
Author: Adam Belay <abelay@novell.com>
Date:   Sat Mar 24 03:47:03 2007 -0400

    cpuidle: export time until next timer interrupt using NO_HZ

    Expose information about the time remaining until the next
    timer interrupt expires by utilizing the dynticks infrastructure.
    Also modify the main idle loop to allow dynticks to handle
    non-interrupt break events (e.g. DMA).  Finally, expose sleep ticks
    information to external code.  Thomas Gleixner is responsible for m=
uch
    of the code in this patch.  However, I've made some additional chan=
ges,
    so I'm probably responsible if there are any bugs or oversights :)

    Signed-off-by: Adam Belay <abelay@novell.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 2929d8996fbc77f41a5ff86bb67cdde3ca7d2d72
Author: Adam Belay <abelay@novell.com>
Date:   Sat Mar 24 03:46:58 2007 -0400

    cpuidle: governor API changes

    This patch prepares cpuidle for the menu governor.  It adds an opti=
onal
    stage after idle state entry to give the governor an opportunity to
    check why the state was exited.  Also it makes sure the idle loop
    returns after each state entry, allowing the appropriate dynticks c=
ode
    to run.

    Signed-off-by: Adam Belay <abelay@novell.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 3a7fd42f9825c3b03e364ca59baa751bb350775f
Author: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Thu Apr 26 00:03:59 2007 -0700

    cpuidle: hang fix

    Prevent hang on x86-64, when ACPI processor driver is added as a mo=
dule on
    a system that does not support C-states.

    x86-64 expects all idle handlers to enable interrupts before return=
ing from
    idle handler.  This is due to enter_idle(), exit_idle() races.  Mak=
e
    cpuidle_idle_call() confirm to this when there is no pm_idle_old.

    Also, cpuidle look at the return values of attch_driver() and set
    current_driver to NULL if attach fails on all CPUs.

    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4893339a142afbd5b7c01ffadfd53d14746e858e
Author: Shaohua Li <shaohua.li@intel.com>
Date:   Thu Apr 26 10:40:09 2007 +0800

    cpuidle: add support for max_cstate limit

    With CPUIDLE framework, the max_cstate (to limit max cpu c-state)
    parameter is ingored. Some systems require it to ignore C2/C3
    and some drivers like ipw require it too.

    Signed-off-by: Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 43bbbbe1cb998cbd2df656f55bb3bfe30f30e7d1
Author: Shaohua Li <shaohua.li@intel.com>
Date:   Thu Apr 26 10:40:13 2007 +0800

    cpuidle: add cpuidle_fore_redetect_devices API

    add cpuidle_force_redetect_devices API,
    which forces all CPU redetect idle states.
    Next patch will use it.

    Signed-off-by: Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d1edadd608f24836def5ec483d2edccfb37b1d19
Author: Shaohua Li <shaohua.li@intel.com>
Date:   Thu Apr 26 10:40:01 2007 +0800

    cpuidle: fix sysfs related issue

    Fix the cpuidle sysfs issue.
    a. make kobject dynamicaly allocated
    b. fixed sysfs init issue to avoid suspend/resume issue

    Signed-off-by: Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 7169a5cc0d67b263978859672e86c13c23a5570d
Author: Randy Dunlap <randy.dunlap@oracle.com>
Date:   Wed Mar 28 22:52:53 2007 -0400

    cpuidle: 1-bit field must be unsigned

    A 1-bit bitfield has no room for a sign bit.
    drivers/cpuidle/governors/ladder.c:54:16: error: dubious bitfield w=
ithout explicit `signed' or `unsigned'

    Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
    Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 4658620158dc2fbd9e4bcb213c5b6fb5d05ba7d4
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Wed Mar 28 22:52:41 2007 -0400

    cpuidle: fix boot hang

    Patch for cpuidle boot hang reported by Larry Finger here.
    http://www.ussg.iu.edu/hypermail/linux/kernel/0703.2/2025.html

    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Cc: Larry Finger <larry.finger@lwfinger.net>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit c17e168aa6e5fe3851baaae8df2fbc1cf11443a9
Author: Len Brown <len.brown@intel.com>
Date:   Wed Mar 7 04:37:53 2007 -0500

    cpuidle: ladder does not depend on ACPI

    build fix for CONFIG_ACPI=3Dn

    In file included from drivers/cpuidle/governors/ladder.c:21:
    include/acpi/processor.h:88: error: expected specifier-qualifier-li=
st before =C3=A2=C2=80=C2=98acpi_integer=C3=A2=C2=80=C2=99
    include/acpi/processor.h:106: error: expected specifier-qualifier-l=
ist before =C3=A2=C2=80=C2=98acpi_integer=C3=A2=C2=80=C2=99
    include/acpi/processor.h:168: error: expected specifier-qualifier-l=
ist before =C3=A2=C2=80=C2=98acpi_handle=C3=A2=C2=80=C2=99

    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8c91d958246bde68db0c3f0c57b535962ce861cb
Author: Adrian Bunk <bunk@stusta.de>
Date:   Tue Mar 6 02:29:40 2007 -0800

    cpuidle: make code static

    This patch makes the following needlessly global code static:
    - driver.c: __cpuidle_find_driver()
    - governor.c: __cpuidle_find_governor()
    - ladder.c: struct ladder_governor

    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Cc: Adam Belay <abelay@novell.com>
    Cc: Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0c39dc3187094c72c33ab65a64d2017b21f372d2
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Wed Mar 7 02:38:22 2007 -0500

    cpu_idle: fix build break

    This patch fixes a build breakage with !CONFIG_HOTPLUG_CPU and
    CONFIG_CPU_IDLE.

    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 8112e3b115659b07df340ef170515799c0105f82
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Tue Mar 6 02:29:39 2007 -0800

    cpuidle: build fix for !CPU_IDLE

    Fix the compile issues when CPU_IDLE is not configured.

    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Cc: Adam Belay <abelay@novell.com>
    Cc: Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 1eb4431e9599cd25e0d9872f3c2c8986821839dd
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Thu Feb 22 13:54:57 2007 -0800

    cpuidle take2: Basic documentation for cpuidle

    Documentation for cpuidle infrastructure

    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Adam Belay <abelay@novell.com>
    Signed-off-by: Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit ef5f15a8b79123a047285ec2e3899108661df779
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Thu Feb 22 13:54:03 2007 -0800

    cpuidle take2: Hookup ACPI C-states driver with cpuidle

    Hookup ACPI C-states onto generic cpuidle infrastructure.

    drivers/acpi/procesor_idle.c is now a ACPI C-states driver that reg=
isters as
    a driver in cpuidle infrastructure and the policy part is removed f=
rom
    drivers/acpi/processor_idle.c. We use governor in cpuidle instead.

    Signed-off-by: Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Adam Belay <abelay@novell.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 987196fa82d4db52c407e8c9d5dec884ba602183
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Thu Feb 22 13:52:57 2007 -0800

    cpuidle take2: Core cpuidle infrastructure

    Announcing 'cpuidle', a new CPU power management infrastructure to =
manage
    idle CPUs in a clean and efficient manner.
    cpuidle separates out the drivers that can provide support for mult=
iple types
    of idle states and policy governors that decide on what idle state =
to use
    at run time.
    A cpuidle driver can support multiple idle states based on paramete=
rs like
    varying power consumption, wakeup latency, etc (ACPI C-states for e=
xample).
    A cpuidle governor can be usage model specific (laptop, server,
    laptop on battery etc).
    Main advantage of the infrastructure being, it allows independent d=
evelopment
    of drivers and governors and allows for better CPU power management=
=2E

    A huge thanks to Adam Belay and Shaohua Li who were part of this mi=
ni-project
    since its beginning and are greatly responsible for this patchset.

    This patch:

    Core cpuidle infrastructure.
    Introduces a new abstraction layer for cpuidle:
    * which manages drivers that can support multiple idles states. Dri=
vers
      can be generic or particular to specific hardware/platform
    * allows pluging in multiple policy governors that can take idle st=
ate policy
      decision
    * The core also has a set of sysfs interfaces with which administra=
to can know
      about supported drivers and governors and switch them at run time=
=2E

    Signed-off-by: Adam Belay <abelay@novell.com>
    Signed-off-by: Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/i386/Kconfig                  |    2 +
 arch/x86_64/Kconfig                |    2 +
 drivers/Makefile                   |    1 +
 drivers/acpi/osl.c                 |    8 -
 drivers/acpi/processor_core.c      |   22 ++-
 drivers/acpi/processor_idle.c      |  482 ++++++++++++++++++++++++++++=
+++++---
 drivers/cpuidle/Kconfig            |   20 ++
 drivers/cpuidle/Makefile           |    5 +
 drivers/cpuidle/cpuidle.c          |  295 ++++++++++++++++++++++
 drivers/cpuidle/cpuidle.h          |   33 +++
 drivers/cpuidle/driver.c           |   56 +++++
 drivers/cpuidle/governor.c         |  141 +++++++++++
 drivers/cpuidle/governors/Makefile |    6 +
 drivers/cpuidle/governors/ladder.c |  166 +++++++++++++
 drivers/cpuidle/governors/menu.c   |  137 ++++++++++
 drivers/cpuidle/sysfs.c            |  361 +++++++++++++++++++++++++++
 drivers/net/wireless/ipw2100.c     |   29 ---
 drivers/net/wireless/ipw2100.h     |    2 -
 include/acpi/processor.h           |    5 +
 include/linux/acpi.h               |   26 --
 include/linux/cpuidle.h            |  180 ++++++++++++++
 include/linux/tick.h               |    9 +
 kernel/time/tick-sched.c           |   16 ++
 23 files changed, 1895 insertions(+), 109 deletions(-)
 create mode 100644 drivers/cpuidle/Kconfig
 create mode 100644 drivers/cpuidle/Makefile
 create mode 100644 drivers/cpuidle/cpuidle.c
 create mode 100644 drivers/cpuidle/cpuidle.h
 create mode 100644 drivers/cpuidle/driver.c
 create mode 100644 drivers/cpuidle/governor.c
 create mode 100644 drivers/cpuidle/governors/Makefile
 create mode 100644 drivers/cpuidle/governors/ladder.c
 create mode 100644 drivers/cpuidle/governors/menu.c
 create mode 100644 drivers/cpuidle/sysfs.c
 create mode 100644 include/linux/cpuidle.h

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 97b64d7..3328e0a 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -1069,6 +1069,8 @@ endif # APM
=20
 source "arch/i386/kernel/cpu/cpufreq/Kconfig"
=20
+source "drivers/cpuidle/Kconfig"
+
 endmenu
=20
 menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index b4d9089..e8dbb37 100644
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -706,6 +706,8 @@ source "drivers/acpi/Kconfig"
=20
 source "arch/x86_64/kernel/cpufreq/Kconfig"
=20
+source "drivers/cpuidle/Kconfig"
+
 endmenu
=20
 menu "Bus options (PCI etc.)"
diff --git a/drivers/Makefile b/drivers/Makefile
index f0878b2..10a9c52 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_MCA)		+=3D mca/
 obj-$(CONFIG_EISA)		+=3D eisa/
 obj-$(CONFIG_LGUEST_GUEST)	+=3D lguest/
 obj-$(CONFIG_CPU_FREQ)		+=3D cpufreq/
+obj-$(CONFIG_CPU_IDLE)		+=3D cpuidle/
 obj-$(CONFIG_MMC)		+=3D mmc/
 obj-$(CONFIG_NEW_LEDS)		+=3D leds/
 obj-$(CONFIG_INFINIBAND)	+=3D infiniband/
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 12c09fa..5d14d4f 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1043,14 +1043,6 @@ static int __init acpi_wake_gpes_always_on_setup=
(char *str)
 __setup("acpi_wake_gpes_always_on", acpi_wake_gpes_always_on_setup);
=20
 /*
- * max_cstate is defined in the base kernel so modules can
- * change it w/o depending on the state of the processor module.
- */
-unsigned int max_cstate =3D ACPI_PROCESSOR_MAX_POWER;
-
-EXPORT_SYMBOL(max_cstate);
-
-/*
  * Acquire a spinlock.
  *
  * handle is a pointer to the spinlock_t.
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_cor=
e.c
index 9f11dc2..a735108 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -44,6 +44,7 @@
 #include <linux/seq_file.h>
 #include <linux/dmi.h>
 #include <linux/moduleparam.h>
+#include <linux/cpuidle.h>
=20
 #include <asm/io.h>
 #include <asm/system.h>
@@ -1049,11 +1050,13 @@ static int __init acpi_processor_init(void)
 		return -ENOMEM;
 	acpi_processor_dir->owner =3D THIS_MODULE;
=20
+	result =3D cpuidle_register_driver(&acpi_idle_driver);
+	if (result < 0)
+		goto out_proc;
+
 	result =3D acpi_bus_register_driver(&acpi_processor_driver);
-	if (result < 0) {
-		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-		return result;
-	}
+	if (result < 0)
+		goto out_cpuidle;
=20
 	acpi_processor_install_hotplug_notify();
=20
@@ -1062,11 +1065,18 @@ static int __init acpi_processor_init(void)
 	acpi_processor_ppc_init();
=20
 	return 0;
+
+out_cpuidle:
+	cpuidle_unregister_driver(&acpi_idle_driver);
+
+out_proc:
+	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
+
+	return result;
 }
=20
 static void __exit acpi_processor_exit(void)
 {
-
 	acpi_processor_ppc_exit();
=20
 	acpi_thermal_cpufreq_exit();
@@ -1075,6 +1085,8 @@ static void __exit acpi_processor_exit(void)
=20
 	acpi_bus_unregister_driver(&acpi_processor_driver);
=20
+	cpuidle_unregister_driver(&acpi_idle_driver);
+
 	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
=20
 	return;
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idl=
e.c
index f182613..99da6a7 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -40,6 +40,7 @@
 #include <linux/sched.h>	/* need_resched() */
 #include <linux/latency.h>
 #include <linux/clockchips.h>
+#include <linux/cpuidle.h>
=20
 /*
  * Include the apic definitions for x86 to have the APIC timer related=
 defines
@@ -64,14 +65,22 @@ ACPI_MODULE_NAME("processor_idle");
 #define ACPI_PROCESSOR_FILE_POWER	"power"
 #define US_TO_PM_TIMER_TICKS(t)		((t * (PM_TIMER_FREQUENCY/1000)) / 10=
00)
 #define PM_TIMER_TICK_NS		(1000000000ULL/PM_TIMER_FREQUENCY)
+#ifndef CONFIG_CPU_IDLE
 #define C2_OVERHEAD			4	/* 1us (3.579 ticks per us) */
 #define C3_OVERHEAD			4	/* 1us (3.579 ticks per us) */
 static void (*pm_idle_save) (void) __read_mostly;
-module_param(max_cstate, uint, 0644);
+#else
+#define C2_OVERHEAD			1	/* 1us */
+#define C3_OVERHEAD			1	/* 1us */
+#endif
+#define PM_TIMER_TICKS_TO_US(p)		(((p) * 1000)/(PM_TIMER_FREQUENCY/100=
0))
=20
+static unsigned int max_cstate __read_mostly =3D ACPI_PROCESSOR_MAX_PO=
WER;
+module_param(max_cstate, uint, 0000);
 static unsigned int nocst __read_mostly;
 module_param(nocst, uint, 0000);
=20
+#ifndef CONFIG_CPU_IDLE
 /*
  * bm_history -- bit-mask with a bit per jiffy of bus-master activity
  * 1000 HZ: 0xFFFFFFFF: 32 jiffies =3D 32ms
@@ -82,9 +91,10 @@ module_param(nocst, uint, 0000);
 static unsigned int bm_history __read_mostly =3D
     (HZ >=3D 800 ? 0xFFFFFFFF : ((1U << (HZ / 25)) - 1));
 module_param(bm_history, uint, 0644);
-/* -------------------------------------------------------------------=
-------
-                                Power Management
-   -------------------------------------------------------------------=
------- */
+
+static int acpi_processor_set_power_policy(struct acpi_processor *pr);
+
+#endif
=20
 /*
  * IBM ThinkPad R40e crashes mysteriously when going into C2 or C3.
@@ -177,6 +187,18 @@ static inline u32 ticks_elapsed(u32 t1, u32 t2)
 		return ((0xFFFFFFFF - t1) + t2);
 }
=20
+static inline u32 ticks_elapsed_in_us(u32 t1, u32 t2)
+{
+	if (t2 >=3D t1)
+		return PM_TIMER_TICKS_TO_US(t2 - t1);
+	else if (!(acpi_gbl_FADT.flags & ACPI_FADT_32BIT_TIMER))
+		return PM_TIMER_TICKS_TO_US(((0x00FFFFFF - t1) + t2) & 0x00FFFFFF);
+	else
+		return PM_TIMER_TICKS_TO_US((0xFFFFFFFF - t1) + t2);
+}
+
+#ifndef CONFIG_CPU_IDLE
+
 static void
 acpi_processor_power_activate(struct acpi_processor *pr,
 			      struct acpi_processor_cx *new)
@@ -248,6 +270,7 @@ static void acpi_cstate_enter(struct acpi_processor=
_cx *cstate)
 		unused =3D inl(acpi_gbl_FADT.xpm_timer_block.address);
 	}
 }
+#endif /* !CONFIG_CPU_IDLE */
=20
 #ifdef ARCH_APICTIMER_STOPS_ON_C3
=20
@@ -342,6 +365,7 @@ int acpi_processor_resume(struct acpi_device * devi=
ce)
 	return 0;
 }
=20
+#ifndef CONFIG_CPU_IDLE
 static void acpi_processor_idle(void)
 {
 	struct acpi_processor *pr =3D NULL;
@@ -439,7 +463,7 @@ static void acpi_processor_idle(void)
 	 * an SMP system. We do it here instead of doing it at _CST/P_LVL
 	 * detection phase, to work cleanly with logical CPU hotplug.
 	 */
-	if ((cx->type !=3D ACPI_STATE_C1) && (num_online_cpus() > 1) &&=20
+	if ((cx->type !=3D ACPI_STATE_C1) && (num_online_cpus() > 1) &&
 	    !pr->flags.has_cst && !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUP=
PORTED))
 		cx =3D &pr->power.states[ACPI_STATE_C1];
 #endif
@@ -739,6 +763,7 @@ static int acpi_processor_set_power_policy(struct a=
cpi_processor *pr)
=20
 	return 0;
 }
+#endif /* !CONFIG_CPU_IDLE */
=20
 static int acpi_processor_get_power_info_fadt(struct acpi_processor *p=
r)
 {
@@ -756,7 +781,7 @@ static int acpi_processor_get_power_info_fadt(struc=
t acpi_processor *pr)
 #ifndef CONFIG_HOTPLUG_CPU
 	/*
 	 * Check for P_LVL2_UP flag before entering C2 and above on
-	 * an SMP system.=20
+	 * an SMP system.
 	 */
 	if ((num_online_cpus() > 1) &&
 	    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
@@ -957,7 +982,12 @@ static void acpi_processor_power_verify_c2(struct =
acpi_processor_cx *cx)
 	 * Normalize the C2 latency to expidite policy
 	 */
 	cx->valid =3D 1;
+
+#ifndef CONFIG_CPU_IDLE
 	cx->latency_ticks =3D US_TO_PM_TIMER_TICKS(cx->latency);
+#else
+	cx->latency_ticks =3D cx->latency;
+#endif
=20
 	return;
 }
@@ -1037,7 +1067,12 @@ static void acpi_processor_power_verify_c3(struc=
t acpi_processor *pr,
 	 * use this in our C3 policy
 	 */
 	cx->valid =3D 1;
+
+#ifndef CONFIG_CPU_IDLE
 	cx->latency_ticks =3D US_TO_PM_TIMER_TICKS(cx->latency);
+#else
+	cx->latency_ticks =3D cx->latency;
+#endif
=20
 	return;
 }
@@ -1102,6 +1137,7 @@ static int acpi_processor_get_power_info(struct a=
cpi_processor *pr)
=20
 	pr->power.count =3D acpi_processor_power_verify(pr);
=20
+#ifndef CONFIG_CPU_IDLE
 	/*
 	 * Set Default Policy
 	 * ------------------
@@ -1113,6 +1149,7 @@ static int acpi_processor_get_power_info(struct a=
cpi_processor *pr)
 	result =3D acpi_processor_set_power_policy(pr);
 	if (result)
 		return result;
+#endif
=20
 	/*
 	 * if one state of type C2 or C3 is available, mark this
@@ -1129,35 +1166,6 @@ static int acpi_processor_get_power_info(struct =
acpi_processor *pr)
 	return 0;
 }
=20
-int acpi_processor_cst_has_changed(struct acpi_processor *pr)
-{
-	int result =3D 0;
-
-
-	if (!pr)
-		return -EINVAL;
-
-	if (nocst) {
-		return -ENODEV;
-	}
-
-	if (!pr->flags.power_setup_done)
-		return -ENODEV;
-
-	/* Fall back to the default idle loop */
-	pm_idle =3D pm_idle_save;
-	synchronize_sched();	/* Relies on interrupts forcing exit from idle. =
*/
-
-	pr->flags.power =3D 0;
-	result =3D acpi_processor_get_power_info(pr);
-	if ((pr->flags.power =3D=3D 1) && (pr->flags.power_setup_done))
-		pm_idle =3D acpi_processor_idle;
-
-	return result;
-}
-
-/* proc interface */
-
 static int acpi_processor_power_seq_show(struct seq_file *seq, void *o=
ffset)
 {
 	struct acpi_processor *pr =3D seq->private;
@@ -1239,6 +1247,35 @@ static const struct file_operations acpi_process=
or_power_fops =3D {
 	.release =3D single_release,
 };
=20
+#ifndef CONFIG_CPU_IDLE
+
+int acpi_processor_cst_has_changed(struct acpi_processor *pr)
+{
+	int result =3D 0;
+
+
+	if (!pr)
+		return -EINVAL;
+
+	if (nocst) {
+		return -ENODEV;
+	}
+
+	if (!pr->flags.power_setup_done)
+		return -ENODEV;
+
+	/* Fall back to the default idle loop */
+	pm_idle =3D pm_idle_save;
+	synchronize_sched();	/* Relies on interrupts forcing exit from idle. =
*/
+
+	pr->flags.power =3D 0;
+	result =3D acpi_processor_get_power_info(pr);
+	if ((pr->flags.power =3D=3D 1) && (pr->flags.power_setup_done))
+		pm_idle =3D acpi_processor_idle;
+
+	return result;
+}
+
 #ifdef CONFIG_SMP
 static void smp_callback(void *v)
 {
@@ -1261,7 +1298,360 @@ static int acpi_processor_latency_notify(struct=
 notifier_block *b,
 static struct notifier_block acpi_processor_latency_notifier =3D {
 	.notifier_call =3D acpi_processor_latency_notify,
 };
+
+#endif
+
+#else /* CONFIG_CPU_IDLE */
+
+/**
+ * acpi_idle_bm_check - checks if bus master activity was detected
+ */
+static int acpi_idle_bm_check(void)
+{
+	u32 bm_status =3D 0;
+
+	acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS, &bm_status);
+	if (bm_status)
+		acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS, 1);
+	/*
+	 * PIIX4 Erratum #18: Note that BM_STS doesn't always reflect
+	 * the true state of bus mastering activity; forcing us to
+	 * manually check the BMIDEA bit of each IDE channel.
+	 */
+	else if (errata.piix4.bmisx) {
+		if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
+		    || (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
+			bm_status =3D 1;
+	}
+	return bm_status;
+}
+
+/**
+ * acpi_idle_update_bm_rld - updates the BM_RLD bit depending on targe=
t state
+ * @pr: the processor
+ * @target: the new target state
+ */
+static inline void acpi_idle_update_bm_rld(struct acpi_processor *pr,
+					   struct acpi_processor_cx *target)
+{
+	if (pr->flags.bm_rld_set && target->type !=3D ACPI_STATE_C3) {
+		acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 0);
+		pr->flags.bm_rld_set =3D 0;
+	}
+
+	if (!pr->flags.bm_rld_set && target->type =3D=3D ACPI_STATE_C3) {
+		acpi_set_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
+		pr->flags.bm_rld_set =3D 1;
+	}
+}
+
+/**
+ * acpi_idle_do_entry - a helper function that does C2 and C3 type ent=
ry
+ * @cx: cstate data
+ */
+static inline void acpi_idle_do_entry(struct acpi_processor_cx *cx)
+{
+	if (cx->space_id =3D=3D ACPI_CSTATE_FFH) {
+		/* Call into architectural FFH based C-state */
+		acpi_processor_ffh_cstate_enter(cx);
+	} else {
+		int unused;
+		/* IO port based C-state */
+		inb(cx->address);
+		/* Dummy wait op - must do something useless after P_LVL2 read
+		   because chipsets cannot guarantee that STPCLK# signal
+		   gets asserted in time to freeze execution properly. */
+		unused =3D inl(acpi_gbl_FADT.xpm_timer_block.address);
+	}
+}
+
+/**
+ * acpi_idle_enter_c1 - enters an ACPI C1 state-type
+ * @dev: the target CPU
+ * @state: the state data
+ *
+ * This is equivalent to the HALT instruction.
+ */
+static int acpi_idle_enter_c1(struct cpuidle_device *dev,
+			      struct cpuidle_state *state)
+{
+	struct acpi_processor *pr;
+	struct acpi_processor_cx *cx =3D cpuidle_get_statedata(state);
+	pr =3D processors[smp_processor_id()];
+
+	if (unlikely(!pr))
+		return 0;
+
+	if (pr->flags.bm_check)
+		acpi_idle_update_bm_rld(pr, cx);
+
+	current_thread_info()->status &=3D ~TS_POLLING;
+	/*
+	 * TS_POLLING-cleared state must be visible before we test
+	 * NEED_RESCHED:
+	 */
+	smp_mb();
+	if (!need_resched())
+		safe_halt();
+	current_thread_info()->status |=3D TS_POLLING;
+
+	cx->usage++;
+
+	return 0;
+}
+
+/**
+ * acpi_idle_enter_simple - enters an ACPI state without BM handling
+ * @dev: the target CPU
+ * @state: the state data
+ */
+static int acpi_idle_enter_simple(struct cpuidle_device *dev,
+				  struct cpuidle_state *state)
+{
+	struct acpi_processor *pr;
+	struct acpi_processor_cx *cx =3D cpuidle_get_statedata(state);
+	u32 t1, t2;
+	pr =3D processors[smp_processor_id()];
+
+	if (unlikely(!pr))
+		return 0;
+
+	if (pr->flags.bm_check)
+		acpi_idle_update_bm_rld(pr, cx);
+
+	local_irq_disable();
+	current_thread_info()->status &=3D ~TS_POLLING;
+	/*
+	 * TS_POLLING-cleared state must be visible before we test
+	 * NEED_RESCHED:
+	 */
+	smp_mb();
+
+	if (unlikely(need_resched())) {
+		current_thread_info()->status |=3D TS_POLLING;
+		local_irq_enable();
+		return 0;
+	}
+
+	if (cx->type =3D=3D ACPI_STATE_C3)
+		ACPI_FLUSH_CPU_CACHE();
+
+	t1 =3D inl(acpi_gbl_FADT.xpm_timer_block.address);
+	acpi_state_timer_broadcast(pr, cx, 1);
+	acpi_idle_do_entry(cx);
+	t2 =3D inl(acpi_gbl_FADT.xpm_timer_block.address);
+
+#if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86_TSC)
+	/* TSC could halt in idle, so notify users */
+	mark_tsc_unstable("TSC halts in idle");;
+#endif
+
+	local_irq_enable();
+	current_thread_info()->status |=3D TS_POLLING;
+
+	cx->usage++;
+
+	acpi_state_timer_broadcast(pr, cx, 0);
+	cx->time +=3D ticks_elapsed(t1, t2);
+	return ticks_elapsed_in_us(t1, t2);
+}
+
+static int c3_cpu_count;
+static DEFINE_SPINLOCK(c3_lock);
+
+/**
+ * acpi_idle_enter_bm - enters C3 with proper BM handling
+ * @dev: the target CPU
+ * @state: the state data
+ *
+ * If BM is detected, the deepest non-C3 idle state is entered instead=
=2E
+ */
+static int acpi_idle_enter_bm(struct cpuidle_device *dev,
+			      struct cpuidle_state *state)
+{
+	struct acpi_processor *pr;
+	struct acpi_processor_cx *cx =3D cpuidle_get_statedata(state);
+	u32 t1, t2;
+	pr =3D processors[smp_processor_id()];
+
+	if (unlikely(!pr))
+		return 0;
+
+	local_irq_disable();
+	current_thread_info()->status &=3D ~TS_POLLING;
+	/*
+	 * TS_POLLING-cleared state must be visible before we test
+	 * NEED_RESCHED:
+	 */
+	smp_mb();
+
+	if (unlikely(need_resched())) {
+		current_thread_info()->status |=3D TS_POLLING;
+		local_irq_enable();
+		return 0;
+	}
+
+	/*
+	 * Must be done before busmaster disable as we might need to
+	 * access HPET !
+	 */
+	acpi_state_timer_broadcast(pr, cx, 1);
+
+	if (acpi_idle_bm_check()) {
+		cx =3D pr->power.bm_state;
+
+		acpi_idle_update_bm_rld(pr, cx);
+
+		t1 =3D inl(acpi_gbl_FADT.xpm_timer_block.address);
+		acpi_idle_do_entry(cx);
+		t2 =3D inl(acpi_gbl_FADT.xpm_timer_block.address);
+	} else {
+		acpi_idle_update_bm_rld(pr, cx);
+
+		spin_lock(&c3_lock);
+		c3_cpu_count++;
+		/* Disable bus master arbitration when all CPUs are in C3 */
+		if (c3_cpu_count =3D=3D num_online_cpus())
+			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1);
+		spin_unlock(&c3_lock);
+
+		t1 =3D inl(acpi_gbl_FADT.xpm_timer_block.address);
+		acpi_idle_do_entry(cx);
+		t2 =3D inl(acpi_gbl_FADT.xpm_timer_block.address);
+
+		spin_lock(&c3_lock);
+		/* Re-enable bus master arbitration */
+		if (c3_cpu_count =3D=3D num_online_cpus())
+			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0);
+		c3_cpu_count--;
+		spin_unlock(&c3_lock);
+	}
+
+#if defined (CONFIG_GENERIC_TIME) && defined (CONFIG_X86_TSC)
+	/* TSC could halt in idle, so notify users */
+	mark_tsc_unstable("TSC halts in idle");
+#endif
+
+	local_irq_enable();
+	current_thread_info()->status |=3D TS_POLLING;
+
+	cx->usage++;
+
+	acpi_state_timer_broadcast(pr, cx, 0);
+	cx->time +=3D ticks_elapsed(t1, t2);
+	return ticks_elapsed_in_us(t1, t2);
+}
+
+struct cpuidle_driver acpi_idle_driver =3D {
+	.name =3D		"acpi_idle",
+	.owner =3D	THIS_MODULE,
+};
+
+/**
+ * acpi_processor_setup_cpuidle - prepares and configures CPUIDLE
+ * @pr: the ACPI processor
+ */
+static int acpi_processor_setup_cpuidle(struct acpi_processor *pr)
+{
+	int i, count =3D 0;
+	struct acpi_processor_cx *cx;
+	struct cpuidle_state *state;
+	struct cpuidle_device *dev =3D &pr->power.dev;
+
+	if (!pr->flags.power_setup_done)
+		return -EINVAL;
+
+	if (pr->flags.power =3D=3D 0) {
+		return -EINVAL;
+	}
+
+	for (i =3D 1; i < ACPI_PROCESSOR_MAX_POWER && i <=3D max_cstate; i++)=
 {
+		cx =3D &pr->power.states[i];
+		state =3D &dev->states[count];
+
+		if (!cx->valid)
+			continue;
+
+#ifdef CONFIG_HOTPLUG_CPU
+		if ((cx->type !=3D ACPI_STATE_C1) && (num_online_cpus() > 1) &&
+		    !pr->flags.has_cst &&
+		    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
+			continue;
 #endif
+		cpuidle_set_statedata(state, cx);
+
+		snprintf(state->name, CPUIDLE_NAME_LEN, "C%d", i);
+		state->exit_latency =3D cx->latency;
+		state->target_residency =3D cx->latency * 6;
+		state->power_usage =3D cx->power;
+
+		state->flags =3D 0;
+		switch (cx->type) {
+			case ACPI_STATE_C1:
+			state->flags |=3D CPUIDLE_FLAG_SHALLOW;
+			state->enter =3D acpi_idle_enter_c1;
+			break;
+
+			case ACPI_STATE_C2:
+			state->flags |=3D CPUIDLE_FLAG_BALANCED;
+			state->flags |=3D CPUIDLE_FLAG_TIME_VALID;
+			state->enter =3D acpi_idle_enter_simple;
+			break;
+
+			case ACPI_STATE_C3:
+			state->flags |=3D CPUIDLE_FLAG_DEEP;
+			state->flags |=3D CPUIDLE_FLAG_TIME_VALID;
+			state->flags |=3D CPUIDLE_FLAG_CHECK_BM;
+			state->enter =3D pr->flags.bm_check ?
+					acpi_idle_enter_bm :
+					acpi_idle_enter_simple;
+			break;
+		}
+
+		count++;
+	}
+
+	dev->state_count =3D count;
+
+	if (!count)
+		return -EINVAL;
+
+	/* find the deepest state that can handle active BM */
+	if (pr->flags.bm_check) {
+		for (i =3D 1; i < ACPI_PROCESSOR_MAX_POWER && i <=3D max_cstate; i++=
)
+			if (pr->power.states[i].type =3D=3D ACPI_STATE_C3)
+				break;
+		pr->power.bm_state =3D &pr->power.states[i-1];
+	}
+
+	return 0;
+}
+
+int acpi_processor_cst_has_changed(struct acpi_processor *pr)
+{
+	int ret;
+
+	if (!pr)
+		return -EINVAL;
+
+	if (nocst) {
+		return -ENODEV;
+	}
+
+	if (!pr->flags.power_setup_done)
+		return -ENODEV;
+
+	cpuidle_pause_and_lock();
+	cpuidle_disable_device(&pr->power.dev);
+	acpi_processor_get_power_info(pr);
+	acpi_processor_setup_cpuidle(pr);
+	ret =3D cpuidle_enable_device(&pr->power.dev);
+	cpuidle_resume_and_unlock();
+
+	return ret;
+}
+
+#endif /* CONFIG_CPU_IDLE */
=20
 int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
 			      struct acpi_device *device)
@@ -1279,7 +1669,7 @@ int __cpuinit acpi_processor_power_init(struct ac=
pi_processor *pr,
 			       "ACPI: processor limited to max C-state %d\n",
 			       max_cstate);
 		first_run++;
-#ifdef CONFIG_SMP
+#if !defined (CONFIG_CPU_IDLE) && defined (CONFIG_SMP)
 		register_latency_notifier(&acpi_processor_latency_notifier);
 #endif
 	}
@@ -1297,6 +1687,7 @@ int __cpuinit acpi_processor_power_init(struct ac=
pi_processor *pr,
 	}
=20
 	acpi_processor_get_power_info(pr);
+	pr->flags.power_setup_done =3D 1;
=20
 	/*
 	 * Install the idle handler if processor power management is supporte=
d.
@@ -1304,6 +1695,13 @@ int __cpuinit acpi_processor_power_init(struct a=
cpi_processor *pr,
 	 * platforms that only support C1.
 	 */
 	if ((pr->flags.power) && (!boot_option_idle_override)) {
+#ifdef CONFIG_CPU_IDLE
+		acpi_processor_setup_cpuidle(pr);
+		pr->power.dev.cpu =3D pr->id;
+		if (cpuidle_register_device(&pr->power.dev))
+			return -EIO;
+#endif
+
 		printk(KERN_INFO PREFIX "CPU%d (power states:", pr->id);
 		for (i =3D 1; i <=3D pr->power.count; i++)
 			if (pr->power.states[i].valid)
@@ -1311,10 +1709,12 @@ int __cpuinit acpi_processor_power_init(struct =
acpi_processor *pr,
 				       pr->power.states[i].type);
 		printk(")\n");
=20
+#ifndef CONFIG_CPU_IDLE
 		if (pr->id =3D=3D 0) {
 			pm_idle_save =3D pm_idle;
 			pm_idle =3D acpi_processor_idle;
 		}
+#endif
 	}
=20
 	/* 'power' [R] */
@@ -1328,21 +1728,24 @@ int __cpuinit acpi_processor_power_init(struct =
acpi_processor *pr,
 		entry->owner =3D THIS_MODULE;
 	}
=20
-	pr->flags.power_setup_done =3D 1;
-
 	return 0;
 }
=20
 int acpi_processor_power_exit(struct acpi_processor *pr,
 			      struct acpi_device *device)
 {
-
+#ifdef CONFIG_CPU_IDLE
+	if ((pr->flags.power) && (!boot_option_idle_override))
+		cpuidle_unregister_device(&pr->power.dev);
+#endif
 	pr->flags.power_setup_done =3D 0;
=20
 	if (acpi_device_dir(device))
 		remove_proc_entry(ACPI_PROCESSOR_FILE_POWER,
 				  acpi_device_dir(device));
=20
+#ifndef CONFIG_CPU_IDLE
+
 	/* Unregister the idle handler when processor #0 is removed. */
 	if (pr->id =3D=3D 0) {
 		pm_idle =3D pm_idle_save;
@@ -1357,6 +1760,7 @@ int acpi_processor_power_exit(struct acpi_process=
or *pr,
 		unregister_latency_notifier(&acpi_processor_latency_notifier);
 #endif
 	}
+#endif
=20
 	return 0;
 }
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
new file mode 100644
index 0000000..3bed412
--- /dev/null
+++ b/drivers/cpuidle/Kconfig
@@ -0,0 +1,20 @@
+
+config CPU_IDLE
+	bool "CPU idle PM support"
+	help
+	  CPU idle is a generic framework for supporting software-controlled
+	  idle processor power management.  It includes modular cross-platfor=
m
+	  governors that can be swapped during runtime.
+
+	  If you're using a mobile platform that supports CPU idle PM (e.g.
+	  an ACPI-capable notebook), you should say Y here.
+
+config CPU_IDLE_GOV_LADDER
+	bool
+	depends on CPU_IDLE
+	default y
+
+config CPU_IDLE_GOV_MENU
+	bool
+	depends on CPU_IDLE && NO_HZ
+	default y
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
new file mode 100644
index 0000000..5634f88
--- /dev/null
+++ b/drivers/cpuidle/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for cpuidle.
+#
+
+obj-y +=3D cpuidle.o driver.o governor.o sysfs.o governors/
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
new file mode 100644
index 0000000..fdf4106
--- /dev/null
+++ b/drivers/cpuidle/cpuidle.c
@@ -0,0 +1,295 @@
+/*
+ * cpuidle.c - core cpuidle infrastructure
+ *
+ * (C) 2006-2007 Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
+ *               Shaohua Li <shaohua.li@intel.com>
+ *               Adam Belay <abelay@novell.com>
+ *
+ * This code is licenced under the GPL.
+ */
+
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/notifier.h>
+#include <linux/latency.h>
+#include <linux/cpu.h>
+#include <linux/cpuidle.h>
+
+#include "cpuidle.h"
+
+DEFINE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
+EXPORT_PER_CPU_SYMBOL_GPL(cpuidle_devices);
+
+DEFINE_MUTEX(cpuidle_lock);
+LIST_HEAD(cpuidle_detected_devices);
+static void (*pm_idle_old)(void);
+
+static int enabled_devices;
+
+/**
+ * cpuidle_idle_call - the main idle loop
+ *
+ * NOTE: no locks or semaphores should be used here
+ */
+static void cpuidle_idle_call(void)
+{
+	struct cpuidle_device *dev =3D __get_cpu_var(cpuidle_devices);
+	struct cpuidle_state *target_state;
+	int next_state;
+
+	/* check if the device is ready */
+	if (!dev || !dev->enabled) {
+		if (pm_idle_old)
+			pm_idle_old();
+		else
+			local_irq_enable();
+		return;
+	}
+
+	/* ask the governor for the next state */
+	next_state =3D cpuidle_curr_governor->select(dev);
+	if (need_resched())
+		return;
+	target_state =3D &dev->states[next_state];
+
+	/* enter the state and update stats */
+	dev->last_residency =3D target_state->enter(dev, target_state);
+	dev->last_state =3D target_state;
+	target_state->time +=3D dev->last_residency;
+	target_state->usage++;
+
+	/* give the governor an opportunity to reflect on the outcome */
+	if (cpuidle_curr_governor->reflect)
+		cpuidle_curr_governor->reflect(dev);
+}
+
+/**
+ * cpuidle_install_idle_handler - installs the cpuidle idle loop handl=
er
+ */
+void cpuidle_install_idle_handler(void)
+{
+	if (enabled_devices && (pm_idle !=3D cpuidle_idle_call)) {
+		/* Make sure all changes finished before we switch to new idle */
+		smp_wmb();
+		pm_idle =3D cpuidle_idle_call;
+	}
+}
+
+/**
+ * cpuidle_uninstall_idle_handler - uninstalls the cpuidle idle loop h=
andler
+ */
+void cpuidle_uninstall_idle_handler(void)
+{
+	if (enabled_devices && (pm_idle !=3D pm_idle_old)) {
+		pm_idle =3D pm_idle_old;
+		cpu_idle_wait();
+	}
+}
+
+/**
+ * cpuidle_pause_and_lock - temporarily disables CPUIDLE
+ */
+void cpuidle_pause_and_lock(void)
+{
+	mutex_lock(&cpuidle_lock);
+	cpuidle_uninstall_idle_handler();
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_pause_and_lock);
+
+/**
+ * cpuidle_resume_and_unlock - resumes CPUIDLE operation
+ */
+void cpuidle_resume_and_unlock(void)
+{
+	cpuidle_install_idle_handler();
+	mutex_unlock(&cpuidle_lock);
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);
+
+/**
+ * cpuidle_enable_device - enables idle PM for a CPU
+ * @dev: the CPU
+ *
+ * This function must be called between cpuidle_pause_and_lock and
+ * cpuidle_resume_and_unlock when used externally.
+ */
+int cpuidle_enable_device(struct cpuidle_device *dev)
+{
+	int ret, i;
+
+	if (dev->enabled)
+		return 0;
+	if (!cpuidle_curr_driver || !cpuidle_curr_governor)
+		return -EIO;
+	if (!dev->state_count)
+		return -EINVAL;
+
+	if ((ret =3D cpuidle_add_state_sysfs(dev)))
+		return ret;
+
+	if (cpuidle_curr_governor->enable &&
+	    (ret =3D cpuidle_curr_governor->enable(dev)))
+		goto fail_sysfs;
+
+	for (i =3D 0; i < dev->state_count; i++) {
+		dev->states[i].usage =3D 0;
+		dev->states[i].time =3D 0;
+	}
+	dev->last_residency =3D 0;
+	dev->last_state =3D NULL;
+
+	smp_wmb();
+
+	dev->enabled =3D 1;
+
+	enabled_devices++;
+	return 0;
+
+fail_sysfs:
+	cpuidle_remove_state_sysfs(dev);
+
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_enable_device);
+
+/**
+ * cpuidle_disable_device - disables idle PM for a CPU
+ * @dev: the CPU
+ *
+ * This function must be called between cpuidle_pause_and_lock and
+ * cpuidle_resume_and_unlock when used externally.
+ */
+void cpuidle_disable_device(struct cpuidle_device *dev)
+{
+	if (!dev->enabled)
+		return;
+	if (!cpuidle_curr_driver || !cpuidle_curr_governor)
+		return;
+
+	dev->enabled =3D 0;
+
+	if (cpuidle_curr_governor->disable)
+		cpuidle_curr_governor->disable(dev);
+
+	cpuidle_remove_state_sysfs(dev);
+	enabled_devices--;
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_disable_device);
+
+/**
+ * cpuidle_register_device - registers a CPU's idle PM feature
+ * @dev: the cpu
+ */
+int cpuidle_register_device(struct cpuidle_device *dev)
+{
+	int ret;
+	struct sys_device *sys_dev =3D get_cpu_sysdev((unsigned long)dev->cpu=
);
+
+	if (!sys_dev)
+		return -EINVAL;
+	if (!try_module_get(cpuidle_curr_driver->owner))
+		return -EINVAL;
+
+	init_completion(&dev->kobj_unregister);
+
+	mutex_lock(&cpuidle_lock);
+
+	per_cpu(cpuidle_devices, dev->cpu) =3D dev;
+	list_add(&dev->device_list, &cpuidle_detected_devices);
+	if ((ret =3D cpuidle_add_sysfs(sys_dev))) {
+		mutex_unlock(&cpuidle_lock);
+		module_put(cpuidle_curr_driver->owner);
+		return ret;
+	}
+
+	cpuidle_enable_device(dev);
+	cpuidle_install_idle_handler();
+
+	mutex_unlock(&cpuidle_lock);
+
+	return 0;
+
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_register_device);
+
+/**
+ * cpuidle_unregister_device - unregisters a CPU's idle PM feature
+ * @dev: the cpu
+ */
+void cpuidle_unregister_device(struct cpuidle_device *dev)
+{
+	struct sys_device *sys_dev =3D get_cpu_sysdev((unsigned long)dev->cpu=
);
+
+	cpuidle_pause_and_lock();
+
+	cpuidle_disable_device(dev);
+
+	cpuidle_remove_sysfs(sys_dev);
+	list_del(&dev->device_list);
+	wait_for_completion(&dev->kobj_unregister);
+	per_cpu(cpuidle_devices, dev->cpu) =3D NULL;
+
+	cpuidle_resume_and_unlock();
+
+	module_put(cpuidle_curr_driver->owner);
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
+
+#ifdef CONFIG_SMP
+
+static void smp_callback(void *v)
+{
+	/* we already woke the CPU up, nothing more to do */
+}
+
+/*
+ * This function gets called when a part of the kernel has a new laten=
cy
+ * requirement.  This means we need to get all processors out of their=
 C-state,
+ * and then recalculate a new suitable C-state. Just do a cross-cpu IP=
I; that
+ * wakes them all right up.
+ */
+static int cpuidle_latency_notify(struct notifier_block *b,
+		unsigned long l, void *v)
+{
+	smp_call_function(smp_callback, NULL, 0, 1);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cpuidle_latency_notifier =3D {
+	.notifier_call =3D cpuidle_latency_notify,
+};
+
+#define latency_notifier_init(x) do { register_latency_notifier(x); } =
while (0)
+
+#else /* CONFIG_SMP */
+
+#define latency_notifier_init(x) do { } while (0)
+
+#endif /* CONFIG_SMP */
+
+/**
+ * cpuidle_init - core initializer
+ */
+static int __init cpuidle_init(void)
+{
+	int ret;
+
+	pm_idle_old =3D pm_idle;
+
+	ret =3D cpuidle_add_class_sysfs(&cpu_sysdev_class);
+	if (ret)
+		return ret;
+
+	latency_notifier_init(&cpuidle_latency_notifier);
+
+	return 0;
+}
+
+core_initcall(cpuidle_init);
diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
new file mode 100644
index 0000000..9476ba3
--- /dev/null
+++ b/drivers/cpuidle/cpuidle.h
@@ -0,0 +1,33 @@
+/*
+ * cpuidle.h - The internal header file
+ */
+
+#ifndef __DRIVER_CPUIDLE_H
+#define __DRIVER_CPUIDLE_H
+
+#include <linux/sysdev.h>
+
+/* For internal use only */
+extern struct cpuidle_governor *cpuidle_curr_governor;
+extern struct cpuidle_driver *cpuidle_curr_driver;
+extern struct list_head cpuidle_governors;
+extern struct list_head cpuidle_detected_devices;
+extern struct mutex cpuidle_lock;
+extern spinlock_t cpuidle_driver_lock;
+
+/* idle loop */
+extern void cpuidle_install_idle_handler(void);
+extern void cpuidle_uninstall_idle_handler(void);
+
+/* governors */
+extern int cpuidle_switch_governor(struct cpuidle_governor *gov);
+
+/* sysfs */
+extern int cpuidle_add_class_sysfs(struct sysdev_class *cls);
+extern void cpuidle_remove_class_sysfs(struct sysdev_class *cls);
+extern int cpuidle_add_state_sysfs(struct cpuidle_device *device);
+extern void cpuidle_remove_state_sysfs(struct cpuidle_device *device);
+extern int cpuidle_add_sysfs(struct sys_device *sysdev);
+extern void cpuidle_remove_sysfs(struct sys_device *sysdev);
+
+#endif /* __DRIVER_CPUIDLE_H */
diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
new file mode 100644
index 0000000..2257004
--- /dev/null
+++ b/drivers/cpuidle/driver.c
@@ -0,0 +1,56 @@
+/*
+ * driver.c - driver support
+ *
+ * (C) 2006-2007 Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
+ *               Shaohua Li <shaohua.li@intel.com>
+ *               Adam Belay <abelay@novell.com>
+ *
+ * This code is licenced under the GPL.
+ */
+
+#include <linux/mutex.h>
+#include <linux/module.h>
+#include <linux/cpuidle.h>
+
+#include "cpuidle.h"
+
+struct cpuidle_driver *cpuidle_curr_driver;
+DEFINE_SPINLOCK(cpuidle_driver_lock);
+
+/**
+ * cpuidle_register_driver - registers a driver
+ * @drv: the driver
+ */
+int cpuidle_register_driver(struct cpuidle_driver *drv)
+{
+	if (!drv)
+		return -EINVAL;
+
+	spin_lock(&cpuidle_driver_lock);
+	if (cpuidle_curr_driver) {
+		spin_unlock(&cpuidle_driver_lock);
+		return -EBUSY;
+	}
+	cpuidle_curr_driver =3D drv;
+	spin_unlock(&cpuidle_driver_lock);
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_register_driver);
+
+/**
+ * cpuidle_unregister_driver - unregisters a driver
+ * @drv: the driver
+ */
+void cpuidle_unregister_driver(struct cpuidle_driver *drv)
+{
+	if (!drv)
+		return;
+
+	spin_lock(&cpuidle_driver_lock);
+	cpuidle_curr_driver =3D NULL;
+	spin_unlock(&cpuidle_driver_lock);
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
new file mode 100644
index 0000000..bb699cb
--- /dev/null
+++ b/drivers/cpuidle/governor.c
@@ -0,0 +1,141 @@
+/*
+ * governor.c - governor support
+ *
+ * (C) 2006-2007 Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
+ *               Shaohua Li <shaohua.li@intel.com>
+ *               Adam Belay <abelay@novell.com>
+ *
+ * This code is licenced under the GPL.
+ */
+
+#include <linux/mutex.h>
+#include <linux/module.h>
+#include <linux/cpuidle.h>
+
+#include "cpuidle.h"
+
+LIST_HEAD(cpuidle_governors);
+struct cpuidle_governor *cpuidle_curr_governor;
+
+/**
+ * __cpuidle_find_governor - finds a governor of the specified name
+ * @str: the name
+ *
+ * Must be called with cpuidle_lock aquired.
+ */
+static struct cpuidle_governor * __cpuidle_find_governor(const char *s=
tr)
+{
+	struct cpuidle_governor *gov;
+
+	list_for_each_entry(gov, &cpuidle_governors, governor_list)
+		if (!strnicmp(str, gov->name, CPUIDLE_NAME_LEN))
+			return gov;
+
+	return NULL;
+}
+
+/**
+ * cpuidle_switch_governor - changes the governor
+ * @gov: the new target governor
+ *
+ * NOTE: "gov" can be NULL to specify disabled
+ * Must be called with cpuidle_lock aquired.
+ */
+int cpuidle_switch_governor(struct cpuidle_governor *gov)
+{
+	struct cpuidle_device *dev;
+
+	if (gov =3D=3D cpuidle_curr_governor)
+		return 0;
+
+	cpuidle_uninstall_idle_handler();
+
+	if (cpuidle_curr_governor) {
+		list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
+			cpuidle_disable_device(dev);
+		module_put(cpuidle_curr_governor->owner);
+	}
+
+	cpuidle_curr_governor =3D gov;
+
+	if (gov) {
+		if (!try_module_get(cpuidle_curr_governor->owner))
+			return -EINVAL;
+		list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
+			cpuidle_enable_device(dev);
+		cpuidle_install_idle_handler();
+		printk(KERN_INFO "cpuidle: using governor %s\n", gov->name);
+	}
+
+	return 0;
+}
+
+/**
+ * cpuidle_register_governor - registers a governor
+ * @gov: the governor
+ */
+int cpuidle_register_governor(struct cpuidle_governor *gov)
+{
+	int ret =3D -EEXIST;
+
+	if (!gov || !gov->select)
+		return -EINVAL;
+
+	mutex_lock(&cpuidle_lock);
+	if (__cpuidle_find_governor(gov->name) =3D=3D NULL) {
+		ret =3D 0;
+		list_add_tail(&gov->governor_list, &cpuidle_governors);
+		if (!cpuidle_curr_governor ||
+		    cpuidle_curr_governor->rating < gov->rating)
+			cpuidle_switch_governor(gov);
+	}
+	mutex_unlock(&cpuidle_lock);
+
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_register_governor);
+
+/**
+ * cpuidle_replace_governor - find a replacement governor
+ * @exclude_rating: the rating that will be skipped while looking for
+ * new governor.
+ */
+static struct cpuidle_governor *cpuidle_replace_governor(int exclude_r=
ating)
+{
+	struct cpuidle_governor *gov;
+	struct cpuidle_governor *ret_gov =3D NULL;
+	unsigned int max_rating =3D 0;
+
+	list_for_each_entry(gov, &cpuidle_governors, governor_list) {
+		if (gov->rating =3D=3D exclude_rating)
+			continue;
+		if (gov->rating > max_rating) {
+			max_rating =3D gov->rating;
+			ret_gov =3D gov;
+		}
+	}
+
+	return ret_gov;
+}
+
+/**
+ * cpuidle_unregister_governor - unregisters a governor
+ * @gov: the governor
+ */
+void cpuidle_unregister_governor(struct cpuidle_governor *gov)
+{
+	if (!gov)
+		return;
+
+	mutex_lock(&cpuidle_lock);
+	if (gov =3D=3D cpuidle_curr_governor) {
+		struct cpuidle_governor *new_gov;
+		new_gov =3D cpuidle_replace_governor(gov->rating);
+		cpuidle_switch_governor(new_gov);
+	}
+	list_del(&gov->governor_list);
+	mutex_unlock(&cpuidle_lock);
+}
+
+EXPORT_SYMBOL_GPL(cpuidle_unregister_governor);
diff --git a/drivers/cpuidle/governors/Makefile b/drivers/cpuidle/gover=
nors/Makefile
new file mode 100644
index 0000000..1b51272
--- /dev/null
+++ b/drivers/cpuidle/governors/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for cpuidle governors.
+#
+
+obj-$(CONFIG_CPU_IDLE_GOV_LADDER) +=3D ladder.o
+obj-$(CONFIG_CPU_IDLE_GOV_MENU) +=3D menu.o
diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/gover=
nors/ladder.c
new file mode 100644
index 0000000..eb666ec
--- /dev/null
+++ b/drivers/cpuidle/governors/ladder.c
@@ -0,0 +1,166 @@
+/*
+ * ladder.c - the residency ladder algorithm
+ *
+ *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
+ *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@inte=
l.com>
+ *  Copyright (C) 2004, 2005 Dominik Brodowski <linux@brodo.de>
+ *
+ * (C) 2006-2007 Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
+ *               Shaohua Li <shaohua.li@intel.com>
+ *               Adam Belay <abelay@novell.com>
+ *
+ * This code is licenced under the GPL.
+ */
+
+#include <linux/kernel.h>
+#include <linux/cpuidle.h>
+#include <linux/latency.h>
+#include <linux/moduleparam.h>
+#include <linux/jiffies.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+#define PROMOTION_COUNT 4
+#define DEMOTION_COUNT 1
+
+struct ladder_device_state {
+	struct {
+		u32 promotion_count;
+		u32 demotion_count;
+		u32 promotion_time;
+		u32 demotion_time;
+	} threshold;
+	struct {
+		int promotion_count;
+		int demotion_count;
+	} stats;
+};
+
+struct ladder_device {
+	struct ladder_device_state states[CPUIDLE_STATE_MAX];
+	int last_state_idx;
+};
+
+static DEFINE_PER_CPU(struct ladder_device, ladder_devices);
+
+/**
+ * ladder_do_selection - prepares private data for a state change
+ * @ldev: the ladder device
+ * @old_idx: the current state index
+ * @new_idx: the new target state index
+ */
+static inline void ladder_do_selection(struct ladder_device *ldev,
+				       int old_idx, int new_idx)
+{
+	ldev->states[old_idx].stats.promotion_count =3D 0;
+	ldev->states[old_idx].stats.demotion_count =3D 0;
+	ldev->last_state_idx =3D new_idx;
+}
+
+/**
+ * ladder_select_state - selects the next state to enter
+ * @dev: the CPU
+ */
+static int ladder_select_state(struct cpuidle_device *dev)
+{
+	struct ladder_device *ldev =3D &__get_cpu_var(ladder_devices);
+	struct ladder_device_state *last_state;
+	int last_residency, last_idx =3D ldev->last_state_idx;
+
+	if (unlikely(!ldev))
+		return 0;
+
+	last_state =3D &ldev->states[last_idx];
+
+	if (dev->states[last_idx].flags & CPUIDLE_FLAG_TIME_VALID)
+		last_residency =3D cpuidle_get_last_residency(dev) - dev->states[las=
t_idx].exit_latency;
+	else
+		last_residency =3D last_state->threshold.promotion_time + 1;
+
+	/* consider promotion */
+	if (last_idx < dev->state_count - 1 &&
+	    last_residency > last_state->threshold.promotion_time &&
+	    dev->states[last_idx + 1].exit_latency <=3D system_latency_constr=
aint()) {
+		last_state->stats.promotion_count++;
+		last_state->stats.demotion_count =3D 0;
+		if (last_state->stats.promotion_count >=3D last_state->threshold.pro=
motion_count) {
+			ladder_do_selection(ldev, last_idx, last_idx + 1);
+			return last_idx + 1;
+		}
+	}
+
+	/* consider demotion */
+	if (last_idx > 0 &&
+	    last_residency < last_state->threshold.demotion_time) {
+		last_state->stats.demotion_count++;
+		last_state->stats.promotion_count =3D 0;
+		if (last_state->stats.demotion_count >=3D last_state->threshold.demo=
tion_count) {
+			ladder_do_selection(ldev, last_idx, last_idx - 1);
+			return last_idx - 1;
+		}
+	}
+
+	/* otherwise remain at the current state */
+	return last_idx;
+}
+
+/**
+ * ladder_enable_device - setup for the governor
+ * @dev: the CPU
+ */
+static int ladder_enable_device(struct cpuidle_device *dev)
+{
+	int i;
+	struct ladder_device *ldev =3D &per_cpu(ladder_devices, dev->cpu);
+	struct ladder_device_state *lstate;
+	struct cpuidle_state *state;
+
+	ldev->last_state_idx =3D 0;
+
+	for (i =3D 0; i < dev->state_count; i++) {
+		state =3D &dev->states[i];
+		lstate =3D &ldev->states[i];
+
+		lstate->stats.promotion_count =3D 0;
+		lstate->stats.demotion_count =3D 0;
+
+		lstate->threshold.promotion_count =3D PROMOTION_COUNT;
+		lstate->threshold.demotion_count =3D DEMOTION_COUNT;
+
+		if (i < dev->state_count - 1)
+			lstate->threshold.promotion_time =3D state->exit_latency;
+		if (i > 0)
+			lstate->threshold.demotion_time =3D state->exit_latency;
+	}
+
+	return 0;
+}
+
+static struct cpuidle_governor ladder_governor =3D {
+	.name =3D		"ladder",
+	.rating =3D	10,
+	.enable =3D	ladder_enable_device,
+	.select =3D	ladder_select_state,
+	.owner =3D	THIS_MODULE,
+};
+
+/**
+ * init_ladder - initializes the governor
+ */
+static int __init init_ladder(void)
+{
+	return cpuidle_register_governor(&ladder_governor);
+}
+
+/**
+ * exit_ladder - exits the governor
+ */
+static void __exit exit_ladder(void)
+{
+	cpuidle_unregister_governor(&ladder_governor);
+}
+
+MODULE_LICENSE("GPL");
+module_init(init_ladder);
+module_exit(exit_ladder);
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governo=
rs/menu.c
new file mode 100644
index 0000000..299d45c
--- /dev/null
+++ b/drivers/cpuidle/governors/menu.c
@@ -0,0 +1,137 @@
+/*
+ * menu.c - the menu idle governor
+ *
+ * Copyright (C) 2006-2007 Adam Belay <abelay@novell.com>
+ *
+ * This code is licenced under the GPL.
+ */
+
+#include <linux/kernel.h>
+#include <linux/cpuidle.h>
+#include <linux/latency.h>
+#include <linux/time.h>
+#include <linux/ktime.h>
+#include <linux/hrtimer.h>
+#include <linux/tick.h>
+
+#define BREAK_FUZZ	4	/* 4 us */
+
+struct menu_device {
+	int		last_state_idx;
+
+	unsigned int	expected_us;
+	unsigned int	predicted_us;
+	unsigned int	last_measured_us;
+	unsigned int	elapsed_us;
+};
+
+static DEFINE_PER_CPU(struct menu_device, menu_devices);
+
+/**
+ * menu_select - selects the next idle state to enter
+ * @dev: the CPU
+ */
+static int menu_select(struct cpuidle_device *dev)
+{
+	struct menu_device *data =3D &__get_cpu_var(menu_devices);
+	int i;
+
+	/* determine the expected residency time */
+	data->expected_us =3D
+		(u32) ktime_to_ns(tick_nohz_get_sleep_length()) / 1000;
+
+	/* find the deepest idle state that satisfies our constraints */
+	for (i =3D 1; i < dev->state_count; i++) {
+		struct cpuidle_state *s =3D &dev->states[i];
+
+		if (s->target_residency > data->expected_us)
+			break;
+		if (s->target_residency > data->predicted_us)
+			break;
+		if (s->exit_latency > system_latency_constraint())
+			break;
+	}
+
+	data->last_state_idx =3D i - 1;
+	return i - 1;
+}
+
+/**
+ * menu_reflect - attempts to guess what happened after entry
+ * @dev: the CPU
+ *
+ * NOTE: it's important to be fast here because this operation will ad=
d to
+ *       the overall exit latency.
+ */
+static void menu_reflect(struct cpuidle_device *dev)
+{
+	struct menu_device *data =3D &__get_cpu_var(menu_devices);
+	int last_idx =3D data->last_state_idx;
+	unsigned int measured_us =3D
+		cpuidle_get_last_residency(dev) + data->elapsed_us;
+	struct cpuidle_state *target =3D &dev->states[last_idx];
+
+	/*
+	 * Ugh, this idle state doesn't support residency measurements, so we
+	 * are basically lost in the dark.  As a compromise, assume we slept
+	 * for one full standard timer tick.  However, be aware that this
+	 * could potentially result in a suboptimal state transition.
+	 */
+	if (!(target->flags & CPUIDLE_FLAG_TIME_VALID))
+		measured_us =3D USEC_PER_SEC / HZ;
+
+	/* Predict time remaining until next break event */
+	if (measured_us + BREAK_FUZZ < data->expected_us - target->exit_laten=
cy) {
+		data->predicted_us =3D max(measured_us, data->last_measured_us);
+		data->last_measured_us =3D measured_us;
+		data->elapsed_us =3D 0;
+	} else {
+		if (data->elapsed_us < data->elapsed_us + measured_us)
+			data->elapsed_us =3D measured_us;
+		else
+			data->elapsed_us =3D -1;
+		data->predicted_us =3D max(measured_us, data->last_measured_us);
+	}
+}
+
+/**
+ * menu_enable_device - scans a CPU's states and does setup
+ * @dev: the CPU
+ */
+static int menu_enable_device(struct cpuidle_device *dev)
+{
+	struct menu_device *data =3D &per_cpu(menu_devices, dev->cpu);
+
+	memset(data, 0, sizeof(struct menu_device));
+
+	return 0;
+}
+
+static struct cpuidle_governor menu_governor =3D {
+	.name =3D		"menu",
+	.rating =3D	20,
+	.enable =3D	menu_enable_device,
+	.select =3D	menu_select,
+	.reflect =3D	menu_reflect,
+	.owner =3D	THIS_MODULE,
+};
+
+/**
+ * init_menu - initializes the governor
+ */
+static int __init init_menu(void)
+{
+	return cpuidle_register_governor(&menu_governor);
+}
+
+/**
+ * exit_menu - exits the governor
+ */
+static void __exit exit_menu(void)
+{
+	cpuidle_unregister_governor(&menu_governor);
+}
+
+MODULE_LICENSE("GPL");
+module_init(init_menu);
+module_exit(exit_menu);
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
new file mode 100644
index 0000000..0f3515e
--- /dev/null
+++ b/drivers/cpuidle/sysfs.c
@@ -0,0 +1,361 @@
+/*
+ * sysfs.c - sysfs support
+ *
+ * (C) 2006-2007 Shaohua Li <shaohua.li@intel.com>
+ *
+ * This code is licenced under the GPL.
+ */
+
+#include <linux/kernel.h>
+#include <linux/cpuidle.h>
+#include <linux/sysfs.h>
+#include <linux/cpu.h>
+
+#include "cpuidle.h"
+
+static unsigned int sysfs_switch;
+static int __init cpuidle_sysfs_setup(char *unused)
+{
+	sysfs_switch =3D 1;
+	return 1;
+}
+__setup("cpuidle_sysfs_switch", cpuidle_sysfs_setup);
+
+static ssize_t show_available_governors(struct sys_device *dev, char *=
buf)
+{
+	ssize_t i =3D 0;
+	struct cpuidle_governor *tmp;
+
+	mutex_lock(&cpuidle_lock);
+	list_for_each_entry(tmp, &cpuidle_governors, governor_list) {
+		if (i >=3D (ssize_t) ((PAGE_SIZE/sizeof(char)) - CPUIDLE_NAME_LEN - =
2))
+			goto out;
+		i +=3D scnprintf(&buf[i], CPUIDLE_NAME_LEN, "%s ", tmp->name);
+	}
+
+out:
+	i+=3D sprintf(&buf[i], "\n");
+	mutex_unlock(&cpuidle_lock);
+	return i;
+}
+
+static ssize_t show_current_driver(struct sys_device *dev, char *buf)
+{
+	ssize_t ret;
+
+	spin_lock(&cpuidle_driver_lock);
+	if (cpuidle_curr_driver)
+		ret =3D sprintf(buf, "%s\n", cpuidle_curr_driver->name);
+	else
+		ret =3D sprintf(buf, "none\n");
+	spin_unlock(&cpuidle_driver_lock);
+
+	return ret;
+}
+
+static ssize_t show_current_governor(struct sys_device *dev, char *buf=
)
+{
+	ssize_t ret;
+
+	mutex_lock(&cpuidle_lock);
+	if (cpuidle_curr_governor)
+		ret =3D sprintf(buf, "%s\n", cpuidle_curr_governor->name);
+	else
+		ret =3D sprintf(buf, "none\n");
+	mutex_unlock(&cpuidle_lock);
+
+	return ret;
+}
+
+static ssize_t store_current_governor(struct sys_device *dev,
+	const char *buf, size_t count)
+{
+	char gov_name[CPUIDLE_NAME_LEN];
+	int ret =3D -EINVAL;
+	size_t len =3D count;
+	struct cpuidle_governor *gov;
+
+	if (!len || len >=3D sizeof(gov_name))
+		return -EINVAL;
+
+	memcpy(gov_name, buf, len);
+	gov_name[len] =3D '\0';
+	if (gov_name[len - 1] =3D=3D '\n')
+		gov_name[--len] =3D '\0';
+
+	mutex_lock(&cpuidle_lock);
+
+	list_for_each_entry(gov, &cpuidle_governors, governor_list) {
+		if (strlen(gov->name) =3D=3D len && !strcmp(gov->name, gov_name)) {
+			ret =3D cpuidle_switch_governor(gov);
+			break;
+		}
+	}
+
+	mutex_unlock(&cpuidle_lock);
+
+	if (ret)
+		return ret;
+	else
+		return count;
+}
+
+static SYSDEV_ATTR(current_driver, 0444, show_current_driver, NULL);
+static SYSDEV_ATTR(current_governor_ro, 0444, show_current_governor, N=
ULL);
+
+static struct attribute *cpuclass_default_attrs[] =3D {
+	&attr_current_driver.attr,
+	&attr_current_governor_ro.attr,
+	NULL
+};
+
+static SYSDEV_ATTR(available_governors, 0444, show_available_governors=
, NULL);
+static SYSDEV_ATTR(current_governor, 0644, show_current_governor,
+	store_current_governor);
+
+static struct attribute *cpuclass_switch_attrs[] =3D {
+	&attr_available_governors.attr,
+	&attr_current_driver.attr,
+	&attr_current_governor.attr,
+	NULL
+};
+
+static struct attribute_group cpuclass_attr_group =3D {
+	.attrs =3D cpuclass_default_attrs,
+	.name =3D "cpuidle",
+};
+
+/**
+ * cpuidle_add_class_sysfs - add CPU global sysfs attributes
+ */
+int cpuidle_add_class_sysfs(struct sysdev_class *cls)
+{
+	if (sysfs_switch)
+		cpuclass_attr_group.attrs =3D cpuclass_switch_attrs;
+
+	return sysfs_create_group(&cls->kset.kobj, &cpuclass_attr_group);
+}
+
+/**
+ * cpuidle_remove_class_sysfs - remove CPU global sysfs attributes
+ */
+void cpuidle_remove_class_sysfs(struct sysdev_class *cls)
+{
+	sysfs_remove_group(&cls->kset.kobj, &cpuclass_attr_group);
+}
+
+struct cpuidle_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct cpuidle_device *, char *);
+	ssize_t (*store)(struct cpuidle_device *, const char *, size_t count)=
;
+};
+
+#define define_one_ro(_name, show) \
+	static struct cpuidle_attr attr_##_name =3D __ATTR(_name, 0444, show,=
 NULL)
+#define define_one_rw(_name, show, store) \
+	static struct cpuidle_attr attr_##_name =3D __ATTR(_name, 0644, show,=
 store)
+
+#define kobj_to_cpuidledev(k) container_of(k, struct cpuidle_device, k=
obj)
+#define attr_to_cpuidleattr(a) container_of(a, struct cpuidle_attr, at=
tr)
+static ssize_t cpuidle_show(struct kobject * kobj, struct attribute * =
attr ,char * buf)
+{
+	int ret =3D -EIO;
+	struct cpuidle_device *dev =3D kobj_to_cpuidledev(kobj);
+	struct cpuidle_attr * cattr =3D attr_to_cpuidleattr(attr);
+
+	if (cattr->show) {
+		mutex_lock(&cpuidle_lock);
+		ret =3D cattr->show(dev, buf);
+		mutex_unlock(&cpuidle_lock);
+	}
+	return ret;
+}
+
+static ssize_t cpuidle_store(struct kobject * kobj, struct attribute *=
 attr,
+		     const char * buf, size_t count)
+{
+	int ret =3D -EIO;
+	struct cpuidle_device *dev =3D kobj_to_cpuidledev(kobj);
+	struct cpuidle_attr * cattr =3D attr_to_cpuidleattr(attr);
+
+	if (cattr->store) {
+		mutex_lock(&cpuidle_lock);
+		ret =3D cattr->store(dev, buf, count);
+		mutex_unlock(&cpuidle_lock);
+	}
+	return ret;
+}
+
+static struct sysfs_ops cpuidle_sysfs_ops =3D {
+	.show =3D cpuidle_show,
+	.store =3D cpuidle_store,
+};
+
+static void cpuidle_sysfs_release(struct kobject *kobj)
+{
+	struct cpuidle_device *dev =3D kobj_to_cpuidledev(kobj);
+
+	complete(&dev->kobj_unregister);
+}
+
+static struct kobj_type ktype_cpuidle =3D {
+	.sysfs_ops =3D &cpuidle_sysfs_ops,
+	.release =3D cpuidle_sysfs_release,
+};
+
+struct cpuidle_state_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct cpuidle_state *, char *);
+	ssize_t (*store)(struct cpuidle_state *, const char *, size_t);
+};
+
+#define define_one_state_ro(_name, show) \
+static struct cpuidle_state_attr attr_##_name =3D __ATTR(_name, 0444, =
show, NULL)
+
+#define define_show_state_function(_name) \
+static ssize_t show_state_##_name(struct cpuidle_state *state, char *b=
uf) \
+{ \
+	return sprintf(buf, "%u\n", state->_name);\
+}
+
+static ssize_t show_state_name(struct cpuidle_state *state, char *buf)
+{
+	return sprintf(buf, "%s\n", state->name);
+}
+
+define_show_state_function(exit_latency)
+define_show_state_function(power_usage)
+define_show_state_function(usage)
+define_show_state_function(time)
+define_one_state_ro(name, show_state_name);
+define_one_state_ro(latency, show_state_exit_latency);
+define_one_state_ro(power, show_state_power_usage);
+define_one_state_ro(usage, show_state_usage);
+define_one_state_ro(time, show_state_time);
+
+static struct attribute *cpuidle_state_default_attrs[] =3D {
+	&attr_name.attr,
+	&attr_latency.attr,
+	&attr_power.attr,
+	&attr_usage.attr,
+	&attr_time.attr,
+	NULL
+};
+
+#define kobj_to_state_obj(k) container_of(k, struct cpuidle_state_kobj=
, kobj)
+#define kobj_to_state(k) (kobj_to_state_obj(k)->state)
+#define attr_to_stateattr(a) container_of(a, struct cpuidle_state_attr=
, attr)
+static ssize_t cpuidle_state_show(struct kobject * kobj,
+	struct attribute * attr ,char * buf)
+{
+	int ret =3D -EIO;
+	struct cpuidle_state *state =3D kobj_to_state(kobj);
+	struct cpuidle_state_attr * cattr =3D attr_to_stateattr(attr);
+
+	if (cattr->show)
+		ret =3D cattr->show(state, buf);
+
+	return ret;
+}
+
+static struct sysfs_ops cpuidle_state_sysfs_ops =3D {
+	.show =3D cpuidle_state_show,
+};
+
+static void cpuidle_state_sysfs_release(struct kobject *kobj)
+{
+	struct cpuidle_state_kobj *state_obj =3D kobj_to_state_obj(kobj);
+
+	complete(&state_obj->kobj_unregister);
+}
+
+static struct kobj_type ktype_state_cpuidle =3D {
+	.sysfs_ops =3D &cpuidle_state_sysfs_ops,
+	.default_attrs =3D cpuidle_state_default_attrs,
+	.release =3D cpuidle_state_sysfs_release,
+};
+
+static void inline cpuidle_free_state_kobj(struct cpuidle_device *devi=
ce, int i)
+{
+	kobject_unregister(&device->kobjs[i]->kobj);
+	wait_for_completion(&device->kobjs[i]->kobj_unregister);
+	kfree(device->kobjs[i]);
+	device->kobjs[i] =3D NULL;
+}
+
+/**
+ * cpuidle_add_driver_sysfs - adds driver-specific sysfs attributes
+ * @device: the target device
+ */
+int cpuidle_add_state_sysfs(struct cpuidle_device *device)
+{
+	int i, ret =3D -ENOMEM;
+	struct cpuidle_state_kobj *kobj;
+
+	/* state statistics */
+	for (i =3D 0; i < device->state_count; i++) {
+		kobj =3D kzalloc(sizeof(struct cpuidle_state_kobj), GFP_KERNEL);
+		if (!kobj)
+			goto error_state;
+		kobj->state =3D &device->states[i];
+		init_completion(&kobj->kobj_unregister);
+
+		kobj->kobj.parent =3D &device->kobj;
+		kobj->kobj.ktype =3D &ktype_state_cpuidle;
+		kobject_set_name(&kobj->kobj, "state%d", i);
+		ret =3D kobject_register(&kobj->kobj);
+		if (ret) {
+			kfree(kobj);
+			goto error_state;
+		}
+		device->kobjs[i] =3D kobj;
+	}
+
+	return 0;
+
+error_state:
+	for (i =3D i - 1; i >=3D 0; i--)
+		cpuidle_free_state_kobj(device, i);
+	return ret;
+}
+
+/**
+ * cpuidle_remove_driver_sysfs - removes driver-specific sysfs attribu=
tes
+ * @device: the target device
+ */
+void cpuidle_remove_state_sysfs(struct cpuidle_device *device)
+{
+	int i;
+
+	for (i =3D 0; i < device->state_count; i++)
+		cpuidle_free_state_kobj(device, i);
+}
+
+/**
+ * cpuidle_add_sysfs - creates a sysfs instance for the target device
+ * @sysdev: the target device
+ */
+int cpuidle_add_sysfs(struct sys_device *sysdev)
+{
+	int cpu =3D sysdev->id;
+	struct cpuidle_device *dev;
+
+	dev =3D per_cpu(cpuidle_devices, cpu);
+	dev->kobj.parent =3D &sysdev->kobj;
+	dev->kobj.ktype =3D &ktype_cpuidle;
+	kobject_set_name(&dev->kobj, "%s", "cpuidle");
+	return kobject_register(&dev->kobj);
+}
+
+/**
+ * cpuidle_remove_sysfs - deletes a sysfs instance on the target devic=
e
+ * @sysdev: the target device
+ */
+void cpuidle_remove_sysfs(struct sys_device *sysdev)
+{
+	int cpu =3D sysdev->id;
+	struct cpuidle_device *dev;
+
+	dev =3D per_cpu(cpuidle_devices, cpu);
+	kobject_unregister(&dev->kobj);
+}
diff --git a/drivers/net/wireless/ipw2100.c b/drivers/net/wireless/ipw2=
100.c
index 8990585..e8a94b7 100644
--- a/drivers/net/wireless/ipw2100.c
+++ b/drivers/net/wireless/ipw2100.c
@@ -1858,14 +1858,6 @@ static void ipw2100_down(struct ipw2100_priv *pr=
iv)
=20
 	modify_acceptable_latency("ipw2100", INFINITE_LATENCY);
=20
-#ifdef ACPI_CSTATE_LIMIT_DEFINED
-	if (priv->config & CFG_C3_DISABLED) {
-		IPW_DEBUG_INFO(": Resetting C3 transitions.\n");
-		acpi_set_cstate_limit(priv->cstate_limit);
-		priv->config &=3D ~CFG_C3_DISABLED;
-	}
-#endif
-
 	/* We have to signal any supplicant if we are disassociating */
 	if (associated)
 		wireless_send_event(priv->net_dev, SIOCGIWAP, &wrqu, NULL);
@@ -2088,14 +2080,6 @@ static void isr_indicate_rf_kill(struct ipw2100_=
priv *priv, u32 status)
 	/* RF_KILL is now enabled (else we wouldn't be here) */
 	priv->status |=3D STATUS_RF_KILL_HW;
=20
-#ifdef ACPI_CSTATE_LIMIT_DEFINED
-	if (priv->config & CFG_C3_DISABLED) {
-		IPW_DEBUG_INFO(": Resetting C3 transitions.\n");
-		acpi_set_cstate_limit(priv->cstate_limit);
-		priv->config &=3D ~CFG_C3_DISABLED;
-	}
-#endif
-
 	/* Make sure the RF Kill check timer is running */
 	priv->stop_rf_kill =3D 0;
 	cancel_delayed_work(&priv->rf_kill);
@@ -2326,23 +2310,10 @@ static void ipw2100_corruption_detected(struct =
ipw2100_priv *priv, int i)
 	u32 match, reg;
 	int j;
 #endif
-#ifdef ACPI_CSTATE_LIMIT_DEFINED
-	int limit;
-#endif
=20
 	IPW_DEBUG_INFO(": PCI latency error detected at 0x%04zX.\n",
 		       i * sizeof(struct ipw2100_status));
=20
-#ifdef ACPI_CSTATE_LIMIT_DEFINED
-	IPW_DEBUG_INFO(": Disabling C3 transitions.\n");
-	limit =3D acpi_get_cstate_limit();
-	if (limit > 2) {
-		priv->cstate_limit =3D limit;
-		acpi_set_cstate_limit(2);
-		priv->config |=3D CFG_C3_DISABLED;
-	}
-#endif
-
 #ifdef IPW2100_DEBUG_C3
 	/* Halt the fimrware so we can get a good image */
 	write_register(priv->net_dev, IPW_REG_RESET_REG,
diff --git a/drivers/net/wireless/ipw2100.h b/drivers/net/wireless/ipw2=
100.h
index de7d384..2b8be24 100644
--- a/drivers/net/wireless/ipw2100.h
+++ b/drivers/net/wireless/ipw2100.h
@@ -479,7 +479,6 @@ enum {
 #define CFG_ASSOCIATE           (1<<6)
 #define CFG_FIXED_RATE          (1<<7)
 #define CFG_ADHOC_CREATE        (1<<8)
-#define CFG_C3_DISABLED         (1<<9)
 #define CFG_PASSIVE_SCAN        (1<<10)
 #ifdef CONFIG_IPW2100_MONITOR
 #define CFG_CRC_CHECK           (1<<11)
@@ -508,7 +507,6 @@ struct ipw2100_priv {
 	u8 bssid[ETH_ALEN];
 	u8 channel;
 	int last_mode;
-	int cstate_limit;
=20
 	unsigned long connect_start;
 	unsigned long last_reset;
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 99934a9..26d79f6 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -3,6 +3,7 @@
=20
 #include <linux/kernel.h>
 #include <linux/cpu.h>
+#include <linux/cpuidle.h>
=20
 #include <asm/acpi.h>
=20
@@ -75,7 +76,9 @@ struct acpi_processor_cx {
 };
=20
 struct acpi_processor_power {
+	struct cpuidle_device dev;
 	struct acpi_processor_cx *state;
+	struct acpi_processor_cx *bm_state;
 	unsigned long bm_check_timestamp;
 	u32 default_state;
 	u32 bm_activity;
@@ -199,6 +202,7 @@ struct acpi_processor_flags {
 	u8 bm_check:1;
 	u8 has_cst:1;
 	u8 power_setup_done:1;
+	u8 bm_rld_set:1;
 };
=20
 struct acpi_processor {
@@ -322,6 +326,7 @@ int acpi_processor_power_exit(struct acpi_processor=
 *pr,
 			      struct acpi_device *device);
 int acpi_processor_suspend(struct acpi_device * device, pm_message_t s=
tate);
 int acpi_processor_resume(struct acpi_device * device);
+extern struct cpuidle_driver acpi_idle_driver;
=20
 /* in processor_thermal.c */
 int acpi_processor_get_limit_info(struct acpi_processor *pr);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index bf5e000..8ccedf7 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -189,32 +189,6 @@ extern int ec_transaction(u8 command,
 extern int acpi_blacklisted(void);
 extern void acpi_bios_year(char *s);
=20
-#define	ACPI_CSTATE_LIMIT_DEFINED	/* for driver builds */
-#ifdef	CONFIG_ACPI
-
-/*
- * Set highest legal C-state
- * 0: C0 okay, but not C1
- * 1: C1 okay, but not C2
- * 2: C2 okay, but not C3 etc.
- */
-
-extern unsigned int max_cstate;
-
-static inline unsigned int acpi_get_cstate_limit(void)
-{
-	return max_cstate;
-}
-static inline void acpi_set_cstate_limit(unsigned int new_limit)
-{
-	max_cstate =3D new_limit;
-	return;
-}
-#else
-static inline unsigned int acpi_get_cstate_limit(void) { return 0; }
-static inline void acpi_set_cstate_limit(unsigned int new_limit) { ret=
urn; }
-#endif
-
 #ifdef CONFIG_ACPI_NUMA
 int acpi_get_pxm(acpi_handle handle);
 int acpi_get_node(acpi_handle *handle);
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
new file mode 100644
index 0000000..16a5154
--- /dev/null
+++ b/include/linux/cpuidle.h
@@ -0,0 +1,180 @@
+/*
+ * cpuidle.h - a generic framework for CPU idle power management
+ *
+ * (C) 2007 Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
+ *          Shaohua Li <shaohua.li@intel.com>
+ *          Adam Belay <abelay@novell.com>
+ *
+ * This code is licenced under the GPL.
+ */
+
+#ifndef _LINUX_CPUIDLE_H
+#define _LINUX_CPUIDLE_H
+
+#include <linux/percpu.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/kobject.h>
+#include <linux/completion.h>
+
+#define CPUIDLE_STATE_MAX	8
+#define CPUIDLE_NAME_LEN	16
+
+struct cpuidle_device;
+
+
+/****************************
+ * CPUIDLE DEVICE INTERFACE *
+ ****************************/
+
+struct cpuidle_state {
+	char		name[CPUIDLE_NAME_LEN];
+	void		*driver_data;
+
+	unsigned int	flags;
+	unsigned int	exit_latency; /* in US */
+	unsigned int	power_usage; /* in mW */
+	unsigned int	target_residency; /* in US */
+
+	unsigned int	usage;
+	unsigned int	time; /* in US */
+
+	int (*enter)	(struct cpuidle_device *dev,
+			 struct cpuidle_state *state);
+};
+
+/* Idle State Flags */
+#define CPUIDLE_FLAG_TIME_VALID	(0x01) /* is residency time measurable=
? */
+#define CPUIDLE_FLAG_CHECK_BM	(0x02) /* BM activity will exit state */
+#define CPUIDLE_FLAG_SHALLOW	(0x10) /* low latency, minimal savings */
+#define CPUIDLE_FLAG_BALANCED	(0x20) /* medium latency, moderate savin=
gs */
+#define CPUIDLE_FLAG_DEEP	(0x40) /* high latency, large savings */
+
+#define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
+
+/**
+ * cpuidle_get_statedata - retrieves private driver state data
+ * @state: the state
+ */
+static inline void * cpuidle_get_statedata(struct cpuidle_state *state=
)
+{
+	return state->driver_data;
+}
+
+/**
+ * cpuidle_set_statedata - stores private driver state data
+ * @state: the state
+ * @data: the private data
+ */
+static inline void
+cpuidle_set_statedata(struct cpuidle_state *state, void *data)
+{
+	state->driver_data =3D data;
+}
+
+struct cpuidle_state_kobj {
+	struct cpuidle_state *state;
+	struct completion kobj_unregister;
+	struct kobject kobj;
+};
+
+struct cpuidle_device {
+	int			enabled:1;
+	unsigned int		cpu;
+
+	int			last_residency;
+	int			state_count;
+	struct cpuidle_state	states[CPUIDLE_STATE_MAX];
+	struct cpuidle_state_kobj *kobjs[CPUIDLE_STATE_MAX];
+	struct cpuidle_state	*last_state;
+
+	struct list_head 	device_list;
+	struct kobject		kobj;
+	struct completion	kobj_unregister;
+	void			*governor_data;
+};
+
+DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
+
+/**
+ * cpuidle_get_last_residency - retrieves the last state's residency t=
ime
+ * @dev: the target CPU
+ *
+ * NOTE: this value is invalid if CPUIDLE_FLAG_TIME_VALID isn't set
+ */
+static inline int cpuidle_get_last_residency(struct cpuidle_device *de=
v)
+{
+	return dev->last_residency;
+}
+
+
+/****************************
+ * CPUIDLE DRIVER INTERFACE *
+ ****************************/
+
+struct cpuidle_driver {
+	char			name[CPUIDLE_NAME_LEN];
+	struct module 		*owner;
+};
+
+#ifdef CONFIG_CPU_IDLE
+
+extern int cpuidle_register_driver(struct cpuidle_driver *drv);
+extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
+extern int cpuidle_register_device(struct cpuidle_device *dev);
+extern void cpuidle_unregister_device(struct cpuidle_device *dev);
+
+extern void cpuidle_pause_and_lock(void);
+extern void cpuidle_resume_and_unlock(void);
+extern int cpuidle_enable_device(struct cpuidle_device *dev);
+extern void cpuidle_disable_device(struct cpuidle_device *dev);
+
+#else
+
+static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
+{return 0;}
+static inline void cpuidle_unregister_driver(struct cpuidle_driver *dr=
v) { }
+static inline int cpuidle_register_device(struct cpuidle_device *dev)
+{return 0;}
+static inline void cpuidle_unregister_device(struct cpuidle_device *de=
v) { }
+
+static inline void cpuidle_pause_and_lock(void) { }
+static inline void cpuidle_resume_and_unlock(void) { }
+static inline int cpuidle_enable_device(struct cpuidle_device *dev)
+{return 0;}
+static inline void cpuidle_disable_device(struct cpuidle_device *dev) =
{ }
+
+#endif
+
+/******************************
+ * CPUIDLE GOVERNOR INTERFACE *
+ ******************************/
+
+struct cpuidle_governor {
+	char			name[CPUIDLE_NAME_LEN];
+	struct list_head 	governor_list;
+	unsigned int		rating;
+
+	int  (*enable)		(struct cpuidle_device *dev);
+	void (*disable)		(struct cpuidle_device *dev);
+
+	int  (*select)		(struct cpuidle_device *dev);
+	void (*reflect)		(struct cpuidle_device *dev);
+
+	struct module 		*owner;
+};
+
+#ifdef CONFIG_CPU_IDLE
+
+extern int cpuidle_register_governor(struct cpuidle_governor *gov);
+extern void cpuidle_unregister_governor(struct cpuidle_governor *gov);
+
+#else
+
+static inline int cpuidle_register_governor(struct cpuidle_governor *g=
ov)
+{return 0;}
+static inline void cpuidle_unregister_governor(struct cpuidle_governor=
 *gov) { }
+
+#endif
+
+#endif /* _LINUX_CPUIDLE_H */
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 9a7252e..f4a1395 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -40,6 +40,7 @@ enum tick_nohz_mode {
  * @idle_sleeps:	Number of idle calls, where the sched tick was stoppe=
d
  * @idle_entrytime:	Time when the idle call was entered
  * @idle_sleeptime:	Sum of the time slept in idle with sched tick stop=
ped
+ * @sleep_length:	Duration of the current idle sleep
  */
 struct tick_sched {
 	struct hrtimer			sched_timer;
@@ -52,6 +53,7 @@ struct tick_sched {
 	unsigned long			idle_sleeps;
 	ktime_t				idle_entrytime;
 	ktime_t				idle_sleeptime;
+	ktime_t				sleep_length;
 	unsigned long			last_jiffies;
 	unsigned long			next_jiffies;
 	ktime_t				idle_expires;
@@ -100,10 +102,17 @@ static inline int tick_check_oneshot_change(int a=
llow_nohz) { return 0; }
 extern void tick_nohz_stop_sched_tick(void);
 extern void tick_nohz_restart_sched_tick(void);
 extern void tick_nohz_update_jiffies(void);
+extern ktime_t tick_nohz_get_sleep_length(void);
 # else
 static inline void tick_nohz_stop_sched_tick(void) { }
 static inline void tick_nohz_restart_sched_tick(void) { }
 static inline void tick_nohz_update_jiffies(void) { }
+static inline ktime_t tick_nohz_get_sleep_length(void)
+{
+	ktime_t len =3D { .tv64 =3D NSEC_PER_SEC/HZ };
+
+	return len;
+}
 # endif /* !NO_HZ */
=20
 #endif
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 8c3fef1..637519a 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -153,6 +153,7 @@ void tick_nohz_stop_sched_tick(void)
 	unsigned long seq, last_jiffies, next_jiffies, delta_jiffies, flags;
 	struct tick_sched *ts;
 	ktime_t last_update, expires, now, delta;
+	struct clock_event_device *dev =3D __get_cpu_var(tick_cpu_device).evt=
dev;
 	int cpu;
=20
 	local_irq_save(flags);
@@ -302,11 +303,26 @@ void tick_nohz_stop_sched_tick(void)
 out:
 	ts->next_jiffies =3D next_jiffies;
 	ts->last_jiffies =3D last_jiffies;
+	ts->sleep_length =3D ktime_sub(dev->next_event, now);
 end:
 	local_irq_restore(flags);
 }
=20
 /**
+ * tick_nohz_get_sleep_length - return the length of the current sleep
+ *
+ * Called from power state control code with interrupts disabled
+ */
+ktime_t tick_nohz_get_sleep_length(void)
+{
+	struct tick_sched *ts =3D &__get_cpu_var(tick_cpu_sched);
+
+	return ts->sleep_length;
+}
+
+EXPORT_SYMBOL_GPL(tick_nohz_get_sleep_length);
+
+/**
  * nohz_restart_sched_tick - restart the idle tick from the idle task
  *
  * Restart the idle tick when the CPU is woken up from idle
--=20
1.5.3.4.206.g58ba4
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
