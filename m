From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.13-rc7
Date: Thu, 24 Aug 2017 22:54:19 +0200
Message-ID: <CAJZ5v0jG8+KcYfjXK+CK6pX0787ZPBd4zbOZ9MTixNzUBxzgmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.13-rc7

with top-most commit d5d6c1ddb93a7225915cd7e89f35944878d667f9

 Merge branches 'acpica-fix', 'acpi-ec-fix' and 'acpi-properties-fix'

on top of commit 14ccee78fc82f5512908f4424f541549a5705b89

 Linux v4.13-rc6

to receive ACPI fixes for v4.13-rc7.

These fix two recent regressions (in ACPICA and in the ACPI EC driver)
and one bug in code introduced during the 4.12 cycle (ACPI device
properties library routine).

Specifics:

 - Fix a regression in the ACPI EC driver causing a kernel to crash
   during initialization on some systems due to a code ordering issue
   exposed by a recent change (Lv Zheng).

 - Fix a recent regression in ACPICA due to a change of the behavior
   of a library function in a way that is not backwards compatible
   with some existing callers of it (Rafael Wysocki).

 - Fix a coding mistake in a library function related to the handling
   of ACPI device properties introduced during the 4.12 cycle (Sakari
   Ailus).

Thanks!


---------------

Lv Zheng (1):
      ACPI: EC: Fix regression related to wrong ECDT initialization order

Rafael J. Wysocki (1):
      ACPICA: Fix acpi_evaluate_object_typed()

Sakari Ailus (1):
      ACPI: device property: Fix node lookup in
acpi_graph_get_child_prop_value()

---------------

 drivers/acpi/acpica/nsxfeval.c | 10 +++++++---
 drivers/acpi/ec.c              | 17 +++++++----------
 drivers/acpi/internal.h        |  1 -
 drivers/acpi/property.c        |  2 +-
 drivers/acpi/scan.c            |  1 -
 5 files changed, 15 insertions(+), 16 deletions(-)
