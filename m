From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More ACPI updates for v4.9-rc1
Date: Fri, 14 Oct 2016 15:28:35 +0200
Message-ID: <CAJZ5v0h6CJiVU=untvcyWzcNStW=8oZyuLTgabRcuz9QAPMUoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-extra-4.9-rc1

with top-most commit 522533f338f38e15106d5f58901f38fe7bd6a7d8

 Merge branches 'acpi-fan', 'acpi-ec', 'acpi-drivers' and 'acpi-osl'

on top of commit 72d39926f098b0c4ad95e1461595a8d6d403c14d

 Merge tag 'acpi-4.9-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional ACPI updates for v4.9-rc1.

This includes a couple of fixes needed after recent changes, two ACPI
driver fixes (fan and "Processor Aggregator"), an update of the ACPI
device properties handling code and a new MAINTAINERS entry for ACPI
on ARM64.

Specifics:

 - Fix an unused function warning that started to appear after recent
   changes in the ACPI EC driver (Eric Biggers).

 - Fix the KERN_CONT usage in acpi_os_vprintf() that has become
   (particularly) annoying recently (Joe Perches).

 - Fix the fan status checking in the ACPI fan driver to avoid
   returning incorrect error codes sometimes (Srinivas Pandruvada).

 - Fix the ACPI Processor Aggregator driver (PAD) to always let the
   special processor aggregator driver from Xen take over when
   running as Xen dom0 (Juergen Gross).

 - Update the handling of reference device properties in ACPI by
   allowing empty rows ("holes") to appear in reference property
   lists (Mika Westerberg).

 - Add a new MAINTAINERS entry for ACPI on ARM64 (Lorenzo Pieralisi).

Thanks!

---------------

Eric Biggers (1):
      ACPI / EC: Fix unused function warning when CONFIG_PM_SLEEP=n

Joe Perches (1):
      acpi_os_vprintf: Use printk_get_level() to avoid unnecessary KERN_CONT

Juergen Gross (1):
      ACPI / PAD: don't register acpi_pad driver if running as Xen dom0

Lorenzo Pieralisi (1):
      MAINTAINERS: Add ARM64-specific ACPI maintainers entry

Mika Westerberg (1):
      ACPI / property: Allow holes in reference properties

Srinivas Pandruvada (1):
      ACPI / fan: Fix error reading cur_state

---------------

 MAINTAINERS             |   8 ++++
 drivers/acpi/acpi_pad.c |   5 +++
 drivers/acpi/ec.c       |   2 +
 drivers/acpi/fan.c      |  12 ++++-
 drivers/acpi/osl.c      |  13 ++++--
 drivers/acpi/property.c | 117 ++++++++++++++++++++++++++++--------------------
 include/linux/acpi.h    |  22 +++++++--
 7 files changed, 123 insertions(+), 56 deletions(-)
