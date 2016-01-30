From: jono <lejono@gmail.com>
Subject: ibm-acpi developers not responding despite serious bugs and debuggers
Date: Sat, 30 Jan 2016 13:22:27 +0000
Message-ID: <CAJXMp+ozoeeca_WMKfDOKhbLuf1hE_-m-Cv2KhsztYVZ-OEYLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34351 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932244AbcA3NW1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 30 Jan 2016 08:22:27 -0500
Received: by mail-oi0-f47.google.com with SMTP id k206so64069047oia.1
        for <linux-acpi@vger.kernel.org>; Sat, 30 Jan 2016 05:22:27 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net

Dear Rafael,
Sorry to trouble you, but a number of us are having lots of grief
getting a response from ibm/lenovo regarding acpi bugs in newer models
like the Helix 2. The bugs make these machines difficult to use, and
there are various reports of this on the internet, along with people
willing to debug patches. But it's impossible to contact anyone on the
ibm-acpi team to help with this. Do you know who we can contact to
help sort these bugs out? Myself and others are polite, fairly tech
savy, and willing to help, so I'm a bit puzzled by the silence from
this team.

The example is the Helix 2, see:
https://bugzilla.kernel.org/show_bug.cgi?id=100171

and various repetitions of this...
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1424088
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1520965?comments=all

Best,
Jonathan

On Fri, Jan 29, 2016 at 9:51 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> Hi Linus,
>
> Please pull from
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  pm+acpi-4.5-rc2
>
> to receive the second batch of power management and ACPI updates for
> v4.5-rc2 with top-most commit ad1ac94767aa9d74c6533e33e768a14d2715162f
>
>  Merge branches 'pm-cpuidle', 'pm-cpufreq', 'pm-domains' and 'pm-sleep'
>
> on top of commit 92e963f50fc74041b5e9e744c330dca48e04f08d
>
>  Linux 4.5-rc1
>
> These are: cpuidle fixes (including one fix for a recent regression),
> cpufreq fixes (including fixes for two issues introduced during the
> 4.2 cycle), generic power domains framework fixes (two locking
> fixes and one cleanup), one locking fix in the ACPI-based PCI
> hotplug framework (ACPIPHP), removal of one ACPI backlight
> blacklist entry that isn't necessary any more and a PM Kconfig
> cleanup.
>
> Specifics:
>
>  - Fix a recent cpuidle core regression that broke suspend-to-idle
>    on all systems where cpuidle drivers don't provide ->enter_freeze
>    callbacks for any states (Sudeep Holla).
>
>  - Drop an unnecessary symbol definition from the cpuidle core code
>    handling coupled CPU cores (Anders Roxell).
>
>  - Fix a race condition related to governor initialization and removal
>    in the cpufreq core (Viresh Kumar).
>
>  - Clean up the cpufreq core to use list_is_last() for checking if
>    the given policy object is the last element of a list instead of
>    open coding that in a clumsy way (Gautham R Shenoy).
>
>  - Fix compiler warnings in the pxa2xx and cpufreq-dt cpufreq drivers
>    (Arnd Bergmann).
>
>  - Fix two locking issues and clean up a comment in the generic power
>    domains framework (Ulf Hansson, Marek Szyprowski, Moritz Fischer).
>
>  - Fix the error code path of one function in the ACPI-based PCI
>    hotplug framework (ACPIPHP) that forgets to release a lock
>    acquired previously (Insu Yun).
>
>  - Drop the ACPI backlight blacklist entry for Dell Inspiron 5737
>    that is not necessary any more (Hans de Goede).
>
>  - Clean up the top-level PM Kconfig to stop requiring APM emulation
>    to depend on PM which in fact isn't necessary (Arnd Bergmann).
>
> Thanks!
>
>
> ---------------
>
> Anders Roxell (1):
>       cpuidle: coupled: remove unused define cpuidle_coupled_lock
>
> Arnd Bergmann (3):
>       PM: APM_EMULATION does not depend on PM
>       cpufreq: pxa2xx: fix pxa_cpufreq_change_voltage prototype
>       cpufreq: cpufreq-dt: avoid uninitialized variable warnings:
>
> Gautham R Shenoy (1):
>       cpufreq: Use list_is_last() to check last entry of the policy list
>
> Hans de Goede (1):
>       ACPI: Revert "ACPI / video: Add Dell Inspiron 5737 to the blacklist"
>
> Insu Yun (1):
>       ACPI / PCI / hotplug: unlock in error path in acpiphp_enable_slot()
>
> Marek Szyprowski (1):
>       PM / domains: fix lockdep issue for all subdomains
>
> Moritz Fischer (1):
>       PM / Domains: Fix typo in comment
>
> Sudeep Holla (1):
>       cpuidle: fix fallback mechanism for suspend to idle in absence
> of enter_freeze
>
> Ulf Hansson (1):
>       PM / Domains: Fix potential deadlock while adding/removing subdomains
>
> Viresh Kumar (1):
>       cpufreq: Fix NULL reference crash while accessing policy->governor_data
>
> ---------------
>
>  drivers/acpi/video_detect.c        |  8 --------
>  drivers/base/power/domain.c        | 37 ++++++++++++++++++++-----------------
>  drivers/cpufreq/cpufreq-dt.c       | 15 +++++++--------
>  drivers/cpufreq/cpufreq.c          |  6 +++---
>  drivers/cpufreq/cpufreq_governor.c | 11 ++++++++---
>  drivers/cpufreq/pxa2xx-cpufreq.c   |  2 +-
>  drivers/cpuidle/coupled.c          |  1 -
>  drivers/cpuidle/cpuidle.c          |  2 +-
>  drivers/pci/hotplug/acpiphp_glue.c |  4 +++-
>  kernel/power/Kconfig               |  2 +-
>  kernel/sched/idle.c                |  2 +-
>  11 files changed, 45 insertions(+), 45 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
