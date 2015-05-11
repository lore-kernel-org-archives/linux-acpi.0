From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v3 0/7] minor cleanups for ACPI processor driver
Date: Mon, 11 May 2015 12:17:12 +0800
Message-ID: <1431317839-4584-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

This patch set is some minor cleanups for ACPI processor driver
to address the comments which raised by Rafael in ARM64 ACPI core
patches.

Boris and Konrad already reviewed the XEN/ACPI part, they seems are
ok with the changes for XEN [1] [2].

Sudeep, I didn't change the (int)phys_id < 0 to phys_id == PHYS_CPUID_INVALID
as they have the same effects and Rafael prefer the previous one
as he mentioned in ACPI core patch set comments, and PHYS_CPUID_INVALID
is still needed for typedef phys_cpuid_t in ACPI core, so if you are
not ok with it, please let me know.

v3:
 - Reorder the patches to let "Introduce invalid_logical_cpuid()"
   as the first one to avoid raising confusions.
 - Replace "return invalid_logical_cpuid(cpuid) ? false : true;"
   as "return !invalid_logical_cpuid(cpuid);"
 - Some updates to the patch subject and changelog
 - Rebase on top of 4.1-rc3

v2:
 - rebased on top of 4.1-rc2

[1]: https://lkml.org/lkml/2015/5/5/733
[2]: https://lkml.org/lkml/2015/5/9/222

Hanjun Guo (7):
  ACPI / processor: Introduce invalid_logical_cpuid()
  Xen / ACPI / processor: use invalid_logical_cpuid()
  Xen / ACPI / processor: Remove unneeded NULL check
  ACPI / processor: remove cpu_index in acpi_processor_get_info()
  ACPI / processor: remove phys_id in acpi_processor_get_info()
  ACPI / processor: return specific error instead of -1
  ACPI / processor: Introduce invalid_phys_cpuid()

 drivers/acpi/acpi_processor.c     | 20 +++++++++-----------
 drivers/acpi/processor_core.c     | 10 +++++-----
 drivers/acpi/processor_pdc.c      |  5 +----
 drivers/xen/xen-acpi-cpuhotplug.c | 12 +++---------
 include/linux/acpi.h              | 10 ++++++++++
 5 files changed, 28 insertions(+), 29 deletions(-)

-- 
1.9.1
