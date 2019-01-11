From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v5.0-rc2
Date: Fri, 11 Jan 2019 11:22:33 +0100
Message-ID: <CAJZ5v0jRxHZJW5aW5NPLx2pcD1g5dhYzdyUw_PUTRekhOsqeyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.0-rc2

with top-most commit 65a4f3a1efda8e0cc2516301fc3ad64e3eca716c

 Merge branches 'acpi-pci', 'acpi-power' and 'acpi-misc'

on top of commit bfeffd155283772bbe78c6a05dec7c0128ee500c

 Linux 5.0-rc1

to receive ACPI fixes for 5.0-rc2.

This fix a build failure introduced recently, fix the xpower PMIC
ACPI driver, clean up the handling of duplicate entries in _PRx
power resource lists and fix addresses in NUMA-related messages on
32-bit with PAE.

Specifics:

 - Fix build failures with both CONFIG_NLS and CONFIG_PCI unset that
   can occur since ACPI can be built without PCI now (Sinan Kaya).

 - Clean up the handling of duplicate entries in power resource lists
   returned by _PRx evaluation to avoid triggering WARN_ON() on
   attempts to add duplicate symlinks in sysfs (Hans de Goede).

 - Fix issues with the TS current-source switching on systems using
   the xpower PMIC by avoiding to update unrelated bits in the TS
   pin-ctrl register and avoiding to unconditionally enable TS
   current-source on systems where it is not used (Hans de Goede).

 - Fix addresses in NUMA-related messages on 32-bit with PAE which
   can be truncated due to integer type conversions (Chao Fan).

Thanks!


---------------

Chao Fan (1):
      ACPI: NUMA: Use correct type for printing addresses on i386-PAE

Hans de Goede (2):
      ACPI: power: Skip duplicate power resource references in _PRx
      ACPI / PMIC: xpower: Fix TS-pin current-source handling

Sinan Kaya (1):
      ACPI: Fix build failure when CONFIG_NLS is set to 'n'

---------------

 drivers/acpi/Kconfig                  |  1 +
 drivers/acpi/numa.c                   |  6 ++---
 drivers/acpi/pmic/intel_pmic_xpower.c | 41 ++++++++++++++++++++++++++++-------
 drivers/acpi/power.c                  | 22 +++++++++++++++++++
 4 files changed, 59 insertions(+), 11 deletions(-)
