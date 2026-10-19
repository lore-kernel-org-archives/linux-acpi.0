Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430351;
	b=gYLfpUzGczN8FlUwfgLOUwjBFS8J646cGkbzvoQJKNlOp8BMjZp1vgKoq6dpueN4iW2j
	 niW85aZl0hsVwO8jGBkNQRFqye58K6lcDaHGH1551VJLdb/4LGrbWVAdMG4OMOdJCx6pZ
	 30G3LzA6+zUShDGv5a7rLAxZpWM7G3n8fz8NRSGfH7MsVXlb8mZ9TPH3MRV0gv/0xS/o6
	 BtUZRwzOPYWsB8/uEPuc2U88l5CpBwUvne45GlEOIBttpKX03sGd1PYr4Lemx1wVTVVKe
	 zK1JJ7ppsDAdVTDwX+uuY5Nu9C4HTIA6r84M3yVdsZi9yOpGiLGn8aXCd3NdpSjCiVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430351;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=HOGnm7X9nMlXyGl5n2SGeHSm4rPfGqodKOsi9mGsl6s=;
	b=JB2iz+sy8Na2kADJoH1hMOxEIyhR7MoPZXr2HY21lAKan6sJxLrHufOcaHMueKamxh13
	 Qr95CWrM9/5aWJ2pZfwe7QSTJmHLOzl4CUwtQbURz7UJNgIqqb+KXisJpQ6KLdgivHG/Y
	 9VeJg6yoLRWANMgDwbMqbIgXbk1HRhKxyugtGa0fVazz/C70OL+nltpwx48BRmDcMNF0V
	 FdM4y4TP3lv1ShVaq7q7vTARawyPjg7WSackLvzLG7cV790aohwHjInnOpihr4/Xk2VSP
	 p5U01Ga1jWn4K+sZ6FC70SWOg9stxmsgPU5weMIiKObM9QozXnCAqxB1VWJkE340JVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CoqUZAEn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57A1606A31E
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CoqUZAEn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2131F000C4
	for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 17:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792430350;
	bh=HOGnm7X9nMlXyGl5n2SGeHSm4rPfGqodKOsi9mGsl6s=;
	h=From:Date:Subject:To:Cc;
	b=CoqUZAEn8v9tNv4iJNFDOm/FmxFd7FMuhrDGbhecfdEgCFj3H+bVxoAPloz323qLi
	 jFH/usXrcSjlqm3LPZegCJ+UVrabuKwWSyvLma3pCCQFioACgAyz5ocsbihCbIbPMs
	 M8h9//XGmVPygX8f5gyDIQUSHvadhhhiGvzkcoW2NSPAfRJiJzi/jAv6wGDSq+/s9w
	 s89JB+MVIlfc6kRiB1zzk1mcZoTTHxbJe62xqiGlTQxfElM4h8N936B20ba0vvtmtr
	 VkDvdXHwCBcqK41by+/+fcMsO2FvnYSNPBM/LJyW8Ys/ysmcw41XNHGj92pAIv92RE
	 rUWB1CofxsJQw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b8f5e2ce5eso2441434e87.0
        for <linux-acpi@vger.kernel.org>; Mon, 19 Oct 2026 10:19:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwqu20mP4mOBdFXNfH/A4ZpUiZncmaRhUUVmnDvIhyhhGfVAdH0st7SOOpWoCb5ybpJoQRL0w/dya8u@vger.kernel.org
X-Gm-Message-State: AFq9FYK5AwEzlBRSKVvF18m24q8nHgpMqk4Vr4gkD5h5iZuFoHYWq0Ti
	TV61uETMHotuRE9OWmpvS9EBGDiyYQj+BcGAvIu8Rw8qmKx7xyPTvO6vhKg4GJYnti257q+pY1V
	V9ZCK2/MKarjMSvXDdLM27Bz2UZRkmBU=
X-Received: by 2002:a05:6512:10c1:b0:5ba:3d48:e47e with SMTP id
 2adb3069b0e04-5be50a4fff1mr2435955e87.37.1792430348950; Mon, 19 Oct 2026
 10:19:08 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 19 Oct 2026 19:16:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0igpXbgU7i0x87GZwhAOmMXeT4A4fnKC7y0MPB_CSv6eg@mail.gmail.com>
X-Gm-Features: AclHuK8jHNDT0xYIiv-DmntIJkyG5ionc-8qiQX7w2p--t26cIUWuyToVOA7oAA
Message-ID: <CAJZ5v0igpXbgU7i0x87GZwhAOmMXeT4A4fnKC7y0MPB_CSv6eg@mail.gmail.com>
Subject: [GIT PULL] Power management updates for 7.4-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Mario Limonciello <superm1@kernel.org>, Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.4-rc1

with top-most commit 6c326a54b0738ec3b2cc89e1da953a3586c6a8c4

 Merge branches 'pm-sleep', 'pm-em', 'pm-cpu', 'pm-misc' and 'pm-tools'

on top of commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907

 Linux 7.3-rc7

to receive power management updates for 7.4-rc1.

This time, the most visible part are the ACPI CPPC updates from
Christian Loehle, including CPPC cpufreq driver changes, even though
updates of cpufreq drivers proper are still the largest topic group.
However, the updates of cpufreq drivers depend on the ACPI CPPC updates,
so they should really be counted together and that is well over 1/2 of
the total commit count.

Interestingly enough, almost all of the updates included here are fixes
or cleanups, with some new feature support in the amd-pstate cpufreq driver
and IPQ9650 support in the qcom-nvmem cpufreq driver.  The runtime PM
documentation improvements from Brian Norris can also be mostly regarded
as fixes, but a new kunit test goes along with them.

Specifics:

 - Fix multiple issues related to input validation, synchronization,
   access safety, memory layout and register field validation, and error
   handling in the ACPI CPPC library (Christian Loehle and Sumit Gupta)

 - Select the frequency-invariance callback per CPU in the CPPC cpufreq
   driver and create the FIE worker before enabling PCC callbacks in it
   to avoid queueing work through a missing worker and dereferencing a
   NULL pointer (Christian Loehle)

 - Update the CPPC cpufreq driver entry in MAINTAINERS and add a new
   entry for the ACPI CPPC library (Christian Loehle)

 - Minor fixes in various cpufreq drivers (Alexander Koskovich, Daniel
   Schwierzeck, Frank Zhang, Haotian Zhang, Kathiravan Thirumoorthy,
   Sumeet Pawnikar, and Xueqin Luo)

 - Fix wrong behaviors on multi-node servers in the Loongson cpufreq
   driver (Huacai Chen)

 - Reject NULL from cpufreq_cpu_get() in the Rust code (Mehmet Koseoglu)

 - Add suspend OPP to mediatek cpufreq driver and DT (Ryan Brue)

 - Fixups for a few bugs identified by Sashiko in the amd-pstate cpufreq
   driver (Mario Limoncielloi, Wentao Guan)

 - Initial support for maximum frequency capacity handling on Zen6
   client in amd-pstate (Mario Limonciello)

 - Fix for amd-pstate-ut with 'Requested CPU Min frequency' BIOS option
   (K Prateek Nayak)

 - New Zen6 tuning values for EPP in amd-pstate (Mario Limonciello,
   Vishal Badole)

 - amd-pstate documentation fix (Karl Mehltretter)

 - Restrict deferred downscaling to low load for shared policies in the
   conservative cpufreq governor to avoid undesirable CPU frequency
   reduction in some cases (Shengming Hu)

 - Serialize sugov_start() against rate limit updates in the schedutil
   cpufreq governor to avoid using a stale rate limit value (Hui Su)

 - Prevent cpuidle governors menu and teo from returning idle state 0
   after it has been disabled (Xueqin Luo)

 - Replace min_t() with the better alternatives in the intel_idle driver
   and make it use 2-argument strscpy() (Andy Shevchenko)

 - Fix two repeated phrase instances in cpuidle (Hemanth Selam, Syazwina
   Fazrul)

 - Add rugged Panther Lake support to the intel_rapl power capping
   driver and make it use %pe for printing error pointers (Srinivas
   Pandruvada and Sumeet Pawnikar)

 - Update and improve runtime PM documentation and add a kunit test for
   supplier idle/suspend (Brian Norris)

 - Add a pm_runtime_dont_use_autosuspend() call to pm_runtime_reinit()
   to ensure autosuspend disabling on driver teardown (Joshua Crofts)

 - Ignore page-zero RAM in E820 checksum during hibernation on x86 to
   avoid rejecting images created after kexec() (Matthias Goergens)

 - Add resume event mapping for PMSG_POWEROFF to the PM core to allow it
   to carry out device shutdown in the future (Mario Limonciello)

 - Add DPM watchdog to prepare/late/early/noirq/complete phases of
   device suspend and resume (Mayank Rungta)

 - Update swsusp.txt references to swsusp.rst in hibernation
   documentation (Li Jun)

 - Fix use-after-free of perf domain in netlink doit handlers for energy
   models (Fan Wu)

 - Add synchronize_rcu() back to cpu_pm_unregister_notifier() after it
   was removed inadvertently in previous development cycles to avoid
   use-after-free (Bradley Morgan)

 - Unregister CPU PM notifier outside the timer lock in the timer-ti-dm
   clocksource driver (Bradley Morgan)

 - Fix typo "sucessfully" in a comment in pm_clk_add_clk() kerneldoc
   comment and typo "hierachy" in a comment in pm-graph (Hemanth Selam)

 - Fix the return value in dev_pm_opp_get_of_node() kernel-doc (Karl
   Mehltretter)

Thanks!


---------------

Alexander Koskovich (1):
      cpufreq: Add Milos to cpufreq-dt-platdev blocklist

Andy Shevchenko (2):
      intel_idle: Replace min_t() with the better alternatives
      intel_idle: Use 2-argument strscpy()

Bradley Morgan (2):
      clocksource/drivers/timer-ti-dm: Unregister CPU PM notifier
outside of the timer lock
      PM: CPU: Restore synchronize_rcu() to cpu_pm_unregister_notifier()

Brian Norris (14):
      PM: runtime: Only queue an idle check for RPM-linked suppliers
      PM: runtime: Add kunit test for supplier idle/suspend
      PM: runtime: kerneldoc fixes
      PM: runtime: Improve set_{status,active,suspended} docs
      PM: runtime: kerneldoc wording improvements
      PM: runtime: Pull API docs from kerneldoc
      PM: core: Document struct dev_pm_info with kerneldoc
      PM: runtime: Correct pm_runtime_autosuspend_expiration() doc
      PM: runtime: More kerneldoc formatting
      PM: runtime: Misc improvements to runtime_pm.rst
      PM: runtime: Add "Section" hyperlinks
      PM: runtime: Clarify ->runtime_idle() callback return value handling
      PM: runtime: Clarify driver callback expectations and structure Section 2
      PM: runtime: Expand introduction with core concepts and structure

Christian Loehle (21):
      ACPI: CPPC: Validate the _CPC package header
      ACPI: CPPC: Validate _CPC entry and control semantics
      ACPI: CPPC: Propagate performance-control write errors
      ACPI: CPPC: Serialize PCC single-register payload updates
      ACPI: CPPC: Serialize PCC EPP payload updates
      ACPI: CPPC: Release CPC descriptors through kobject
      ACPI: CPPC: Release PCC data after probe failures
      ACPI: CPPC: Reject unsafe cross-CPU SystemMemory RMW
      ACPI: CPPC: Reject direct reads of write-only controls
      ACPI: CPPC: Validate and access PCC register layouts
      ACPI: CPPC: Validate SystemIO register layouts
      ACPI: CPPC: Validate PCC overlaps across processors
      ACPI: CPPC: Validate SystemIO overlaps across processors
      ACPI: CPPC: Clear Performance Limited without a stale read
      ACPI: CPPC: Validate FFH register fields before hardware access
      ACPI: CPPC: Propagate errors from cross-CPU FFH calls
      ACPI: CPPC: Accept requests to retain immutable autonomous selection
      cpufreq: CPPC: Select the frequency-invariance callback per CPU
      cpufreq: CPPC: Create the FIE worker before enabling PCC callbacks
      MAINTAINERS: cpufreq: Replace CPPC reviewer
      MAINTAINERS: ACPI: Add a separate CPPC entry

Daniel Schwierzeck (1):
      cpufreq: airoha: fix probe failure with correct error check

Fan Wu (1):
      PM: EM: Fix use-after-free of perf domain in netlink doit handlers

Frank Zhang (1):
      rust: rcpufreq_dt: add module alias

Haotian Zhang (1):
      cpufreq: qcom-cpufreq-hw: fix device node refcount leak in phandle parsing

Hemanth Selam (3):
      cpuidle: tegra: fix repeated word 'that' in comment
      tools: power: pm-graph: fix typo "hierachy" in comment
      PM: clk: fix typo "sucessfully" in comment

Huacai Chen (5):
      cpufreq: loongson3: Make this driver depend on MACH_LOONGSON64
      cpufreq: loongson3: Adjust the width of id and val in smc_message
      cpufreq: loongson3: Replace per-package mutex with per-node
      cpufreq: loongson3: Use global physical CPU ID in get/target callbacks
      cpufreq: loongson3: Replace IOCSR read/write with MMIO ones

Hui Su (1):
      cpufreq: schedutil: Serialize sugov_start() against rate limit updates

Joshua Crofts (1):
      PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()

K Prateek Nayak (1):
      cpufreq/amd-pstate-ut: Fix amd_pstate_ut_check_freq failure with
'Requested CPU Min frequency' BIOS option

Karl Mehltretter (2):
      cpufreq/amd-pstate: Remove obsolete amd_dynamic_epp documentation
      OPP: Fix the return value in dev_pm_opp_get_of_node() kernel-doc

Kathiravan Thirumoorthy (1):
      cpufreq: qcom-nvmem: Add IPQ9650 support

Li Jun (1):
      PM: hibernate: docs: update swsusp.txt references to swsusp.rst

Mario Limonciello (11):
      cpufreq/amd-pstate: Show a warning if missing EPP tunings
      cpufreq/amd-pstate: Fix TOCTOU when changing driver mode via sysfs
      ACPI: CPPC: Refactor boost ratio handling
      cpufreq/acpi-cpufreq: Use amd_get_boost_ratio()
      cpufreq/amd-pstate: Get Highest Freq for a CPU
      cpufreq: amd-pstate: Restore previous mode when changing driver mode fails
      cpufreq: amd-pstate: Propagate cppc_set_auto_sel() errors on mode change
      cpufreq: amd-pstate-ut: Fix max_freq and EPP test failures on Zen6
      cpufreq/amd-pstate: Add per SoC and per core type EPP tuning values
      cpufreq/amd-pstate: Add EPP tunings for Zen6 client platforms
      PM: sleep: Add resume event mapping for PMSG_POWEROFF

Matthias Goergens (1):
      x86/hibernate: Ignore page-zero RAM in E820 checksum

Mayank Rungta (1):
      PM: sleep: Add DPM watchdog to prepare/late/early/noirq/complete phases

Mehmet Koseoglu (1):
      rust: cpufreq: reject NULL from cpufreq_cpu_get()

Ryan Brue (2):
      cpufreq: mediatek: Enter system sleep at the suspend OPP
      arm64: dts: mediatek: mt8173: Mark the lowest CPU OPPs for suspend

Shengming Hu (1):
      cpufreq: conservative: Restrict deferred downscaling to low load

Srinivas Pandruvada (1):
      powercap: intel_rapl: Add rugged Panther Lake support

Sumeet Pawnikar (2):
      powercap: intel_rapl: Use %pe to print error pointers symbolically
      cpufreq: Use %pe to print error pointers symbolically

Sumit Gupta (1):
      ACPI: CPPC: Keep Performance Limited clearable on NVIDIA T41

Syazwina Fazrul (1):
      Documentation: power/cpuidle: Fix repeating phrase

Vishal Badole (1):
      cpufreq: amd-pstate: Update Zen6 client EPP tuning values

Wentao Guan (1):
      cpufreq/amd-pstate: Skip auto_sel write when it already matches the mode

Xueqin Luo (6):
      cpuidle: menu: Do not return a disabled idle state
      cpuidle: teo: Do not return a disabled idle state
      cpufreq/amd-pstate: Restore previous EPP if profile_name allocation fails
      cpufreq: sparc-us2e: fix frequency table index copy-paste error
      cpufreq: tegra194: fix double-pointer error in get_cpu_ndiv
      cpufreq: sti: avoid NULL dereference in dev_err()

---------------

 Documentation/ABI/testing/sysfs-devices-system-cpu |   16 +-
 Documentation/admin-guide/kernel-parameters.txt    |    7 -
 Documentation/admin-guide/pm/amd-pstate.rst        |    6 -
 Documentation/admin-guide/pm/cpuidle.rst           |    2 +-
 Documentation/power/runtime_pm.rst                 |  595 ++----
 Documentation/power/userland-swsusp.rst            |    4 +-
 MAINTAINERS                                        |   13 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |    2 +
 arch/arm64/kernel/topology.c                       |   14 +-
 arch/x86/kernel/acpi/cppc.c                        |  180 +-
 arch/x86/power/hibernate.c                         |   51 +-
 drivers/acpi/cppc_acpi.c                           | 2209 +++++++++++++++++---
 drivers/acpi/riscv/cppc.c                          |   26 +-
 drivers/acpi/utils.c                               |   13 +-
 drivers/base/power/clock_ops.c                     |    2 +-
 drivers/base/power/main.c                          |   32 +-
 drivers/base/power/runtime-test.c                  |   57 +
 drivers/base/power/runtime.c                       |  109 +-
 drivers/clocksource/timer-ti-dm.c                  |    9 +-
 drivers/cpufreq/Kconfig                            |    1 +
 drivers/cpufreq/acpi-cpufreq.c                     |   17 +-
 drivers/cpufreq/airoha-cpufreq.c                   |    2 +-
 drivers/cpufreq/amd-pstate-ut.c                    |   77 +-
 drivers/cpufreq/amd-pstate.c                       |  347 ++-
 drivers/cpufreq/amd-pstate.h                       |   60 +
 drivers/cpufreq/bmips-cpufreq.c                    |    4 +-
 drivers/cpufreq/cppc_cpufreq.c                     |   74 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |    2 +
 drivers/cpufreq/cpufreq_conservative.c             |    8 +-
 drivers/cpufreq/cpufreq_governor.c                 |   29 +-
 drivers/cpufreq/cpufreq_governor.h                 |    2 +
 drivers/cpufreq/loongson3_cpufreq.c                |   73 +-
 drivers/cpufreq/mediatek-cpufreq.c                 |    2 +
 drivers/cpufreq/qcom-cpufreq-hw.c                  |    3 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c               |    9 +
 drivers/cpufreq/qoriq-cpufreq.c                    |    3 +-
 drivers/cpufreq/rcpufreq_dt.rs                     |    1 +
 drivers/cpufreq/s3c64xx-cpufreq.c                  |    5 +-
 drivers/cpufreq/sparc-us2e-cpufreq.c               |   11 +-
 drivers/cpufreq/sti-cpufreq.c                      |    4 +-
 drivers/cpufreq/tegra194-cpufreq.c                 |    2 +-
 drivers/cpuidle/cpuidle-tegra.c                    |    2 +-
 drivers/cpuidle/governors/menu.c                   |    8 +-
 drivers/cpuidle/governors/teo.c                    |   11 +
 drivers/idle/intel_idle.c                          |   12 +-
 drivers/opp/of.c                                   |    2 +-
 drivers/powercap/intel_rapl_msr.c                  |    5 +-
 include/acpi/cppc_acpi.h                           |   32 +-
 include/linux/pm.h                                 |   93 +
 include/linux/pm_runtime.h                         |  409 ++--
 kernel/cpu_pm.c                                    |    9 +-
 kernel/power/em_netlink.c                          |  122 +-
 kernel/power/em_netlink.h                          |    8 +-
 kernel/power/energy_model.c                        |    8 +-
 kernel/sched/cpufreq_schedutil.c                   |   14 +-
 rust/kernel/cpufreq.rs                             |   22 +-
 tools/power/pm-graph/sleepgraph.py                 |    2 +-
 57 files changed, 3470 insertions(+), 1372 deletions(-)
