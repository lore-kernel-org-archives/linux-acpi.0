From: Rob Lee <rob.lee@linaro.org>
Subject: Re: [GIT PULL] ACPI & Power Management patches for Linux-3.4-merge
Date: Fri, 30 Mar 2012 11:48:17 -0500
Message-ID: <CAMXH7KFRFjFmossoxfJC2bP-dhwkG-H4Ct5b5mMuezJSjKy9Jg@mail.gmail.com>
References: <4F759B4A.5010807@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53576 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755427Ab2C3QsS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Mar 2012 12:48:18 -0400
Received: by obbeh20 with SMTP id eh20so1175706obb.19
        for <linux-acpi@vger.kernel.org>; Fri, 30 Mar 2012 09:48:17 -0700 (PDT)
In-Reply-To: <4F759B4A.5010807@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>

Hello Len,

On Fri, Mar 30, 2012 at 6:38 AM, Len Brown <lenb@kernel.org> wrote:
> Hi Linus,
>
> Please pull these ACPI & Power Management patches.
>
> ACPI 5.0 after-ripples, ACPICA/Linux divergence cleanup
> cpuidle evolving, more ARM use
> thermal sub-system evolving, ditto
> assorted other PM bits
>
> The top commit is a merge with your latest tree
> to address some cpuidle/ARM conflicts.
>
> Rob, Daniel,
>
> As you both modified at91_enter_idle(), and I don't know the semantic=
s
> of at91_standby(), I had to guess at the correct merge.
> Please double check it and correct as necessary.

See this link which I believe is the same conflict on linux-next and
Stephen's resolution is verified by me, Daniel, and Nicolas Ferre.

https://lkml.org/lkml/2012/3/9/47

Thanks,
Rob

>
> thanks!
> Len Brown, Intel Open Source Technology Center
>
> The following changes since commit f52b69f86e27903d6896ed5fa7cd280fec=
8de532:
>
> =A0Merge tag 'sh-for-linus' of git://github.com/pmundt/linux-sh (2012=
-03-30 00:09:17 -0700)
>
> are available in the git repository at:
>
>
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git relea=
se
>
> for you to fetch changes up to 14b5e206d755327ca176920ce2984c55191bbe=
1d:
>
> =A0Merge branch 'upstream' into release (2012-03-30 07:00:19 -0400)
>
> ----------------------------------------------------------------
>
> Alex He (1):
> =A0 =A0 =A0ACPI: Clean redundant codes in scan.c
>
> Amit Daniel Kachhap (1):
> =A0 =A0 =A0thermal: Fix for setting the thermal zone mode to enable/d=
isable
>
> Andi Kleen (3):
> =A0 =A0 =A0ACPI: ec: Do request_region outside WARN()
> =A0 =A0 =A0ACPI: Make ACPI interrupt threaded
> =A0 =A0 =A0Disable MCP limit exceeded messages from Intel IPS driver
>
> Bjorn Helgaas (1):
> =A0 =A0 =A0ACPI / PM: print physical addresses consistently with othe=
r parts of kernel
>
> Bob Moore (16):
> =A0 =A0 =A0ACPICA: Update _REV return value to 5
> =A0 =A0 =A0ACPICA: ACPI 5: Support for new FADT SleepStatus, SleepCon=
trol registers
> =A0 =A0 =A0ACPICA: Move ACPI timer prototypes to public acpixf file
> =A0 =A0 =A0ACPICA: Support for custom ACPICA build for ACPI 5 reduced=
 hardware
> =A0 =A0 =A0ACPICA: Expand OSL memory read/write interfaces to 64 bits
> =A0 =A0 =A0ACPICA: ACPI 5: Update debug output for new notify values
> =A0 =A0 =A0ACPICA: Add acpi_os_physical_table_override interface
> =A0 =A0 =A0ACPICA: Distill multiple sleep method functions to a singl=
e function
> =A0 =A0 =A0ACPICA: Split sleep/wake functions into two files
> =A0 =A0 =A0ACPICA: Add table-driven dispatch for sleep/wake functions
> =A0 =A0 =A0ACPICA: Update to version 20120215
> =A0 =A0 =A0ACPICA: Clarify METHOD_NAME* defines for full-pathname cas=
es
> =A0 =A0 =A0ACPICA: Change exception code for invalid pathname in acpi=
_evaluate_object
> =A0 =A0 =A0ACPICA: Debugger: Add missing object info to namespace dum=
p
> =A0 =A0 =A0ACPICA: Object repair code: Support to add Package wrapper=
s
> =A0 =A0 =A0ACPICA: Update to version 20120320
>
> Boris Ostrovsky (2):
> =A0 =A0 =A0idle, x86: Allow off-lined CPU to enter deeper C states
> =A0 =A0 =A0cpuidle: power_usage should be declared signed integer
>
> Chen Gong (3):
> =A0 =A0 =A0ACPI, APEI, EINJ, limit the range of einj_param
> =A0 =A0 =A0ACPI, APEI, EINJ, new parameter to control trigger action
> =A0 =A0 =A0Update documentation for parameter *notrigger* in einj.txt
>
> Corentin Chary (1):
> =A0 =A0 =A0ACPI / Video: blacklist some samsung laptops
>
> Dan Carpenter (2):
> =A0 =A0 =A0thermal: spear13xx: checking for NULL instead of IS_ERR()
> =A0 =A0 =A0ACPI throttling: fix endian bug in acpi_read_throttling_st=
atus()
>
> Daniel Lezcano (3):
> =A0 =A0 =A0cpuidle: use the driver's state_count as default
> =A0 =A0 =A0cpuidle: remove useless array definition in cpuidle_struct=
ure
> =A0 =A0 =A0cpuidle: remove unused 'governor_data' field
>
> Fabio Estevam (1):
> =A0 =A0 =A0drivers/thermal/thermal_sys.c: fix build warning
>
> Gary Hade (1):
> =A0 =A0 =A0ACPI, APEI: Fix incorrect APEI register bit width check an=
d usage
>
> Jan Beulich (1):
> =A0 =A0 =A0ACPI: consistently use should_use_kmap()
>
> Jiang Liu (2):
> =A0 =A0 =A0ACPI, APEI, Fix ERST header length check
> =A0 =A0 =A0CPER failed to handle generic error records with multiple =
sections
>
> Joe Perches (4):
> =A0 =A0 =A0thermal_sys: remove unnecessary line continuations
> =A0 =A0 =A0thermal_sys: remove obfuscating used-once macros
> =A0 =A0 =A0thermal_sys: kernel style cleanups
> =A0 =A0 =A0thermal_sys: convert printks to pr_<level>
>
> Julia Lawall (1):
> =A0 =A0 =A0ACPI: processor_driver: add missing kfree
>
> Julian Anastasov (1):
> =A0 =A0 =A0ACPICA: Fix regression in FADT revision checks
>
> Konrad Rzeszutek Wilk (1):
> =A0 =A0 =A0tboot: Add return values for tboot_sleep
>
> Len Brown (11):
> =A0 =A0 =A0ACPI: ignore FADT reset-reg-sup flag
> =A0 =A0 =A0Merge branch 'stable/for-x86-for-3.4' of git://git.kernel.=
org/.../konrad/xen into tboot
> =A0 =A0 =A0tools turbostat: add summary option
> =A0 =A0 =A0tools turbostat: reduce measurement overhead due to IPIs
> =A0 =A0 =A0tools turbostat: harden against cpu online/offline
> =A0 =A0 =A0Merge branches 'acpica', 'bgrt', 'bz-11533', 'cpuidle', 'e=
c', 'hotplug', 'misc', 'thermal', 'turbostat' and 'video' into release
> =A0 =A0 =A0Merge branch 'apei' into release
> =A0 =A0 =A0Merge branch 'red-hat-bz-727865' into release
> =A0 =A0 =A0Merge branch 'd3' into release
> =A0 =A0 =A0Merge branch 'tboot' into release
> =A0 =A0 =A0Merge branch 'upstream' into release
>
> Lin Ming (4):
> =A0 =A0 =A0ACPICA: Sleep/Wake interfaces: optionally execute _GTS and=
 _BFS
> =A0 =A0 =A0ACPI: Move module parameter gts and bfs to sleep.c
> =A0 =A0 =A0ACPI: Add interface to register/unregister device to/from =
power resources
> =A0 =A0 =A0ACPI, PCI: Move acpi_dev_run_wake() to ACPI core
>
> Matthew Garrett (4):
> =A0 =A0 =A0ACPI: Evaluate thermal trip points before reading temperat=
ure
> =A0 =A0 =A0ACPI: Ensure thermal limits match CPU frequencies
> =A0 =A0 =A0ACPI: export acpi_kobj
> =A0 =A0 =A0ACPI: Add support for exposing BGRT data
>
> Myron Stowe (1):
> =A0 =A0 =A0ACPI: Fix logic for removing mappings in 'acpi_unmap'
>
> Paul E. McKenney (1):
> =A0 =A0 =A0ACPI: Fix unprotected smp_processor_id() in acpi_processor=
_cst_has_changed()
>
> Petr Vandrovec (1):
> =A0 =A0 =A0ACPI: Fix use-after-free in acpi_map_lsapic
>
> Robert Lee (9):
> =A0 =A0 =A0cpuidle: Add common time keeping and irq enabling
> =A0 =A0 =A0ARM: at91: Consolidate time keeping and irq enable
> =A0 =A0 =A0ARM: kirkwood: Consolidate time keeping and irq enable
> =A0 =A0 =A0ARM: davinci: Consolidate time keeping and irq enable
> =A0 =A0 =A0ARM: omap: Consolidate OMAP3 time keeping and irq enable
> =A0 =A0 =A0ARM: omap: Consolidate OMAP4 time keeping and irq enable
> =A0 =A0 =A0ARM: shmobile: Consolidate time keeping and irq enable
> =A0 =A0 =A0SH: shmobile: Consolidate time keeping and irq enable
> =A0 =A0 =A0ARM: davinci: Fix for cpuidle consolidation changes
>
> ShuoX Liu (1):
> =A0 =A0 =A0cpuidle: add a sysfs entry to disable specific C state for=
 debug purpose.
>
> Tang Liang (1):
> =A0 =A0 =A0x86, acpi, tboot: Have a ACPI os prepare sleep instead of =
calling tboot_sleep.
>
> Toshi Kani (1):
> =A0 =A0 =A0ACPI: Add CPU hotplug support for processor device objects
>
> Vincenzo Frascino (1):
> =A0 =A0 =A0thermal: add support for thermal sensor present on SPEAr13=
xx machines
>
> Viresh Kumar (1):
> =A0 =A0 =A0thermal/spear_thermal: replace readl/writel with lighter _=
relaxed variants
>
> Yinghai Lu (1):
> =A0 =A0 =A0PNPACPI: Fix device ref leaking in acpi_pnp_match
>
> Zhang Rui (1):
> =A0 =A0 =A0ACPI: Introduce ACPI D3_COLD state support
>
> =A0Documentation/ABI/testing/sysfs-firmware-acpi =A0 =A0| =A0 20 +
> =A0Documentation/acpi/apei/einj.txt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A08 +
> =A0Documentation/cpuidle/sysfs.txt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A05 +
> =A0arch/arm/include/asm/cpuidle.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 29 ++
> =A0arch/arm/kernel/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A02 +-
> =A0arch/arm/kernel/cpuidle.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 21 ++
> =A0arch/arm/mach-at91/cpuidle.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 63 ++--
> =A0arch/arm/mach-davinci/cpuidle.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 83 ++--
> =A0arch/arm/mach-kirkwood/cpuidle.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 72 ++--
> =A0arch/arm/mach-omap2/cpuidle34xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 42 +--
> =A0arch/arm/mach-omap2/cpuidle44xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 21 +-
> =A0arch/arm/mach-shmobile/cpuidle.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 31 +-
> =A0arch/sh/kernel/cpu/shmobile/cpuidle.c =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 10 +-
> =A0arch/x86/kernel/acpi/boot.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A03 +-
> =A0arch/x86/kernel/smpboot.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A04 +-
> =A0arch/x86/kernel/tboot.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A09 +-
> =A0drivers/acpi/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A09 +
> =A0drivers/acpi/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 =A01 +
> =A0drivers/acpi/acpica/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A04 +-
> =A0drivers/acpi/acpica/accommon.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A01 -
> =A0drivers/acpi/acpica/acdebug.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A08 +-
> =A0drivers/acpi/acpica/acevents.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 21 +-
> =A0drivers/acpi/acpica/acglobal.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 11 +-
> =A0drivers/acpi/acpica/achware.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 32 +-
> =A0drivers/acpi/acpica/aclocal.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A01 +
> =A0drivers/acpi/acpica/acmacros.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A06 +
> =A0drivers/acpi/acpica/acnamesp.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A05 +-
> =A0drivers/acpi/acpica/actables.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A05 +
> =A0drivers/acpi/acpica/evevent.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A04 +-
> =A0drivers/acpi/acpica/evglock.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A04 +-
> =A0drivers/acpi/acpica/evgpe.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A04 +-
> =A0drivers/acpi/acpica/evgpeblk.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A04 +-
> =A0drivers/acpi/acpica/evgpeinit.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A04 +-
> =A0drivers/acpi/acpica/evgpeutil.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A03 +
> =A0drivers/acpi/acpica/evmisc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 26 +-
> =A0drivers/acpi/acpica/evsci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A04 +-
> =A0drivers/acpi/acpica/evxface.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0436 +++++++++++-----------
> =A0drivers/acpi/acpica/evxfevnt.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A02 +
> =A0drivers/acpi/acpica/evxfgpe.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A02 +
> =A0drivers/acpi/acpica/hwacpi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A03 +
> =A0drivers/acpi/acpica/hwesleep.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0247 ++++++++++++
> =A0drivers/acpi/acpica/hwgpe.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 =A04 +-
> =A0drivers/acpi/acpica/hwregs.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 16 +-
> =A0drivers/acpi/acpica/hwsleep.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0401 ++++----------------
> =A0drivers/acpi/acpica/hwtimer.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A02 +
> =A0drivers/acpi/acpica/hwxface.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 50 +--
> =A0drivers/acpi/acpica/hwxfsleep.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0431 +++++++++++++++++++++
> =A0drivers/acpi/acpica/nsdump.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 15 +-
> =A0drivers/acpi/acpica/nsdumpdv.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A02 +-
> =A0drivers/acpi/acpica/nspredef.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A04 +-
> =A0drivers/acpi/acpica/nsrepair.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0159 +++-----
> =A0drivers/acpi/acpica/nsutils.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A02 +-
> =A0drivers/acpi/acpica/tbfadt.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A08 +-
> =A0drivers/acpi/acpica/tbinstal.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0117 +++++-
> =A0drivers/acpi/acpica/tbutils.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 95 ++---
> =A0drivers/acpi/acpica/utdecode.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 34 +-
> =A0drivers/acpi/acpica/utglobal.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A09 +-
> =A0drivers/acpi/acpica/utinit.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 37 +-
> =A0drivers/acpi/acpica/utxface.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A06 +-
> =A0drivers/acpi/apei/apei-base.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 61 +--
> =A0drivers/acpi/apei/cper.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A02 +
> =A0drivers/acpi/apei/einj.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 17 +-
> =A0drivers/acpi/apei/erst.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A02 +-
> =A0drivers/acpi/bgrt.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| =A0175 +++++++++
> =A0drivers/acpi/bus.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/acpi/ec.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| =A0 =A08 +-
> =A0drivers/acpi/nvs.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 =A04 +-
> =A0drivers/acpi/osl.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0124 ++----
> =A0drivers/acpi/power.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0166 +++++++-
> =A0drivers/acpi/processor_driver.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 62 ++-
> =A0drivers/acpi/processor_idle.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 34 +-
> =A0drivers/acpi/processor_thermal.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 45 ++-
> =A0drivers/acpi/processor_throttling.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A05 +-
> =A0drivers/acpi/reboot.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 =A03 +-
> =A0drivers/acpi/scan.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| =A0 12 +-
> =A0drivers/acpi/sleep.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 76 +++-
> =A0drivers/acpi/thermal.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A08 +-
> =A0drivers/acpi/video_detect.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 49 +++
> =A0drivers/cpuidle/cpuidle.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 97 ++++-
> =A0drivers/cpuidle/driver.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A02 +-
> =A0drivers/cpuidle/governors/menu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A07 +-
> =A0drivers/cpuidle/sysfs.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 40 ++
> =A0drivers/pci/pci-acpi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 40 +-
> =A0drivers/platform/x86/intel_ips.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 13 +-
> =A0drivers/pnp/pnpacpi/core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A07 +-
> =A0drivers/thermal/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A08 +
> =A0drivers/thermal/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A01 +
> =A0drivers/thermal/spear_thermal.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0206 ++++++++++
> =A0drivers/thermal/thermal_sys.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 94 ++---
> =A0{drivers/acpi/acpica =3D> include/acpi}/acconfig.h | =A0 19 +-
> =A0include/acpi/acexcep.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A07 +-
> =A0include/acpi/acnames.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 12 +-
> =A0include/acpi/acpi_bus.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A07 +
> =A0include/acpi/acpiosxf.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 13 +-
> =A0include/acpi/acpixf.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0229 ++++++++----
> =A0include/acpi/actbl.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A07 +
> =A0include/acpi/actypes.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 22 +-
> =A0include/linux/acpi.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 10 +
> =A0include/linux/cpuidle.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 22 +-
> =A0include/linux/platform_data/spear_thermal.h =A0 =A0 =A0| =A0 26 ++
> =A0include/linux/tboot.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 =A01 -
> =A0tools/power/x86/turbostat/turbostat.8 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 99 +++--
> =A0tools/power/x86/turbostat/turbostat.c =A0 =A0 =A0 =A0 =A0 =A0| =A0=
245 ++++++++----
> =A0103 files changed, 3205 insertions(+), 1545 deletions(-)
> =A0create mode 100644 arch/arm/include/asm/cpuidle.h
> =A0create mode 100644 arch/arm/kernel/cpuidle.c
> =A0create mode 100644 drivers/acpi/acpica/hwesleep.c
> =A0create mode 100644 drivers/acpi/acpica/hwxfsleep.c
> =A0create mode 100644 drivers/acpi/bgrt.c
> =A0create mode 100644 drivers/thermal/spear_thermal.c
> =A0rename {drivers/acpi/acpica =3D> include/acpi}/acconfig.h (92%)
> =A0create mode 100644 include/linux/platform_data/spear_thermal.h
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
