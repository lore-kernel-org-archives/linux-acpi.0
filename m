From: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Subject: [Patch v1 0/8] platform/x86: intel_pmc_core: Add CFL/CNL Support
Date: Fri, 19 Jan 2018 14:28:19 +0530
Message-ID: <1516352307-20123-1-git-send-email-rajneesh.bhardwaj@intel.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: dvhart@infradead.org, andy@infradead.org, linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com, srinivas.pandruvada@linux.intel.com, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-acpi@vger.kernel.org

This series is the successor to
https://www.spinics.net/lists/platform-driver-x86/msg14524.html and adds
support for Intel Coffeelake and Cannonlake SoCs.

This also presents an alternative to https://lkml.org/lkml/2017/11/17/876
and introduces Cannonlake SoC to intel-family.h

The following patches,

 '0003-ACPI-LPIT-Export-lpit_read_residency_count_address.patch' and
 '0006-x86-cpu-Add-Cannonlake-to-Intel-family.patch' 

do not belong to platform-drivers-x86 subsystem but the other patches in the
series depend on them so, requesting the respective MAINTAINERS for their
review and ACK so that these two patches can also go through the
platform-drivers-x86 subsystem.


Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org

Tested on Coffeelake, Cannonlake and Kabylake with 4.15-rc8 kernel.

Rajneesh Bhardwaj (5):
  platform/x86: intel_pmc_core: Refactor debugfs entries
  platform/x86: intel_pmc_core: Convert to ICPU macro
  x86/cpu: Add Cannonlake to Intel family
  platform/x86: intel_pmc_core: Add CannonLake PCH support
  platform/x86: intel_pmc_core: Special case for Coffeelake

Srinivas Pandruvada (3):
  platform/x86: intel_pmc_core: Substitute PCI with CPUID enumeration
  ACPI / LPIT: Export lpit_read_residency_count_address()
  platform/x86: intel_pmc_core: Read base address from LPIT

 arch/x86/include/asm/intel-family.h   |   6 +
 drivers/acpi/acpi_lpit.c              |   1 +
 drivers/platform/x86/intel_pmc_core.c | 242 +++++++++++++++++++++-------------
 drivers/platform/x86/intel_pmc_core.h |  14 +-
 4 files changed, 174 insertions(+), 89 deletions(-)

-- 
2.7.4
