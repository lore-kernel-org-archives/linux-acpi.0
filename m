From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 00/16] x86: remove paravirt_enabled()
Date: Wed, 13 Apr 2016 17:04:30 -0700
Message-ID: <1460592286-300-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36290 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932099AbcDNAEy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Apr 2016 20:04:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, jgross@suse.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, bigeasy@linutronix.de, ffainelli@freebox.fr, george.dunlap@citrix.com, julien.grall@linaro.org, mbizon@freebox.fr, tiwai@suse.de, "Luis R. Rodriguez" <mcgrof@kernel.org>

This v6 series addresses:

 - addresses the __init on xen_dom0_set_legacy_features()
   as Juergen asked, the reason the size impact doesn't
   changea as per 0-day is 0-day uses x86 tinyconfig but
   the gains should be there

 - I looked for stragglers on Reivewed-by / Acked-by tags,
   I could not find anything else missing. If I left your
   tag out it means the patch has changed since your last
   review and your blessings would be good to have. Seems
   the only ones missing were Rusty's for lguest stuff and
   Juergen Acked-by for the patch "x86/paravirt: remove
   paravirt_enabled()"

 - Folds the X86_SUBARCH_INTEL_MID and X86_SUBARCH_CE4100
   new uses of the quirks. As such it also adjusts the
   commit log for the X86_SUBARCH_INTEL_MID patch to
   account for the vmlinux size impact as per 0-day on
   tinyconfig.

This has been all tested by 0-day. This series is available
on git here:

https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linux-next.git/log/?h=20160413-pv-disabled-v6

Luis R. Rodriguez (16):
  x86/boot: enumerate documentation for the x86 hardware_subarch
  x86/xen: use X86_SUBARCH_XEN for PV guest boots
  tools/lguest: make lguest launcher use X86_SUBARCH_LGUEST explicitly
  x86/rtc: replace paravirt rtc check with platform legacy quirk
  x86, ACPI: move ACPI_FADT_NO_CMOS_RTC check to ACPI boot code
  x86/init: use a platform legacy quirk for ebda
  tools/lguest: force disable tboot and apm
  apm32: remove paravirt_enabled() use
  x86/tboot: remove paravirt_enabled()
  x86/cpu/intel: remove not needed paravirt_enabled() for f00f work
    around
  pnpbios: replace paravirt_enabled() check with legacy device check
  x86, ACPI: parse ACPI_FADT_LEGACY_DEVICES
  x86/init: rename ebda code file
  x86/paravirt: remove paravirt_enabled()
  x86/init: disable pnpbios for X86_SUBARCH_INTEL_MID
  x86/init: disable pnpbios and rtc for X86_SUBARCH_CE4100

 arch/x86/Makefile                     |  3 ++-
 arch/x86/include/asm/paravirt.h       | 11 --------
 arch/x86/include/asm/paravirt_types.h |  6 -----
 arch/x86/include/asm/processor.h      |  2 --
 arch/x86/include/asm/x86_init.h       | 50 +++++++++++++++++++++++++++++++++++
 arch/x86/include/uapi/asm/bootparam.h | 41 +++++++++++++++++++++++++++-
 arch/x86/kernel/Makefile              |  6 ++++-
 arch/x86/kernel/acpi/boot.c           |  9 +++++++
 arch/x86/kernel/apm_32.c              |  2 +-
 arch/x86/kernel/cpu/intel.c           |  2 +-
 arch/x86/kernel/{head.c => ebda.c}    |  2 +-
 arch/x86/kernel/head32.c              |  2 ++
 arch/x86/kernel/head64.c              |  1 +
 arch/x86/kernel/kvm.c                 |  8 ------
 arch/x86/kernel/paravirt.c            |  1 -
 arch/x86/kernel/platform-quirks.c     | 35 ++++++++++++++++++++++++
 arch/x86/kernel/rtc.c                 | 18 ++-----------
 arch/x86/kernel/tboot.c               |  6 -----
 arch/x86/lguest/boot.c                |  3 ---
 arch/x86/xen/enlighten.c              | 12 ++++++---
 drivers/pnp/pnpbios/core.c            |  3 ++-
 include/linux/pnp.h                   |  2 ++
 tools/lguest/lguest.c                 | 10 +++++--
 23 files changed, 169 insertions(+), 66 deletions(-)
 rename arch/x86/kernel/{head.c => ebda.c} (98%)
 create mode 100644 arch/x86/kernel/platform-quirks.c

-- 
2.7.2

