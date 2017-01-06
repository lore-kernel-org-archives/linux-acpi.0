From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.10-rc3
Date: Fri, 6 Jan 2017 15:37:05 +0100
Message-ID: <CAJZ5v0hpZs5h_SqFHLHKrnpO_wj3ofJP=r9PYTyLJZHToueLAA@mail.gmail.com>
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
 acpi-4.10-rc3

with top-most commit f1dabf0b0975f9e71344b5c8c0ab39c4d58d9274

 Merge branches 'acpi-scan', 'acpi-sysfs', 'acpi-wdat' and 'acpi-tables'

on top of commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88

 Linux 4.10-rc2

to receive ACPI fixes for v4.10-rc3.

They fix a device enumeration problem related to _ADR matching and
an IOMMU initialization issue related to the DMAR table missing,
remove an excessive function call from the core ACPI code, update
an error message in the ACPI WDAT watchdog driver and add a way to
work around problems with unhandled GPE notifications.

Specifics:

 - Fix a device enumeration issue leading to incorrect associations
   between ACPI device objects and platform device objects representing
   physical devices if the given device object has both _ADR and _HID
   (Rafael Wysocki).

 - Avoid passing NULL to acpi_put_table() during IOMMU initialization
   which triggers a (rightful) warning from ACPICA (Rafael Wysocki).

 - Drop an excessive call to acpi_dma_deconfigure() from the core
   code that binds ACPI device objects to device objects representing
   physical devices (Lorenzo Pieralisi).

 - Update an error message in the ACPI WDAT watchdog driver to make it
   provide more useful information (Mika Westerberg).

 - Add a mechanism to work around issues with unhandled GPE notifications
   that occur during system initialization and cannot be prevented by
   means of sysfs (Lv Zheng).

Thanks!

---------------

Lorenzo Pieralisi (1):
      ACPI: Drop misplaced acpi_dma_deconfigure() call from acpi_bind_one()

Lv Zheng (1):
      ACPI / sysfs: Provide quirk mechanism to prevent GPE flooding

Mika Westerberg (1):
      ACPI / watchdog: Print out error number when device creation fails

Rafael J. Wysocki (2):
      ACPI / scan: Prefer devices without _HID/_CID for _ADR matching
      ACPI / DMAR: Avoid passing NULL to acpi_put_table()

---------------

 Documentation/admin-guide/kernel-parameters.txt | 10 +++++
 drivers/acpi/acpi_watchdog.c                    |  2 +-
 drivers/acpi/glue.c                             | 11 ++++-
 drivers/acpi/internal.h                         |  1 +
 drivers/acpi/scan.c                             |  1 +
 drivers/acpi/sysfs.c                            | 56 +++++++++++++++++++++++++
 drivers/iommu/dmar.c                            |  6 ++-
 7 files changed, 82 insertions(+), 5 deletions(-)
