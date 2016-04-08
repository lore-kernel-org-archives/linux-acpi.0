From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v5 00/14] x86: remove paravirt_enabled()
Date: Fri,  8 Apr 2016 16:40:11 -0700
Message-ID: <1460158825-13117-1-git-send-email-mcgrof@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39664 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752686AbcDHXko (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Apr 2016 19:40:44 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, joro@8bytes.org, tiwai@suse.de, "Luis R. Rodriguez" <mcgrof@kernel.org>

This v5 updates the subarch documentation to annotate that
X86_SUBARCH_XEN can be use for both Xen dom0 and domU, and
adds an optional x86_platform.set_legacy_features() in order
to deal with further platform legacy fine tunings when the
platform requires further semantics than what is currently
available generically, and we've determined we don't need
these semantics added in a generic form to x86. In this case
this was needed for Xen given X86_SUBARCH_XEN can be used for
both dom0 and domU and Xen needs to enable RTC for dom0.

I suspect the hook can possibly later be used for further
fine tunings for HVMLite as it will use X86_SUBARCH_PC, so
its placed towards the end of x86_early_init_platform_quirks()
to enable any platform to take advantage of this.

This also updates the commit logs a bit more to make some
clarifications, and lists the impact of vmlinux size as per
trusty good 'ol 0-day.

The total size impact on vmlinux using i386-tinyconfig:

TOTAL   TEXT   init.text   x86_early_init_platform_quirks()
+136    +125   +125        +96

In total that's only 11 byte overhead, 125 bytes are all .init.text
and that's all freed after boot.

Luis R. Rodriguez (14):
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

 arch/x86/Makefile                     |  3 ++-
 arch/x86/include/asm/paravirt.h       | 11 --------
 arch/x86/include/asm/paravirt_types.h |  6 -----
 arch/x86/include/asm/processor.h      |  2 --
 arch/x86/include/asm/x86_init.h       | 50 +++++++++++++++++++++++++++++++++++
 arch/x86/include/uapi/asm/bootparam.h | 37 +++++++++++++++++++++++++-
 arch/x86/kernel/Makefile              |  6 ++++-
 arch/x86/kernel/acpi/boot.c           |  9 +++++++
 arch/x86/kernel/apm_32.c              |  2 +-
 arch/x86/kernel/cpu/intel.c           |  2 +-
 arch/x86/kernel/{head.c => ebda.c}    |  2 +-
 arch/x86/kernel/head32.c              |  2 ++
 arch/x86/kernel/head64.c              |  1 +
 arch/x86/kernel/kvm.c                 |  8 ------
 arch/x86/kernel/paravirt.c            |  1 -
 arch/x86/kernel/platform-quirks.c     | 36 +++++++++++++++++++++++++
 arch/x86/kernel/rtc.c                 | 15 ++---------
 arch/x86/kernel/tboot.c               |  6 -----
 arch/x86/lguest/boot.c                |  3 ---
 arch/x86/xen/enlighten.c              | 12 ++++++---
 drivers/pnp/pnpbios/core.c            |  3 ++-
 include/linux/pnp.h                   |  2 ++
 tools/lguest/lguest.c                 | 10 +++++--
 23 files changed, 166 insertions(+), 63 deletions(-)
 rename arch/x86/kernel/{head.c => ebda.c} (98%)
 create mode 100644 arch/x86/kernel/platform-quirks.c

-- 
2.7.2

