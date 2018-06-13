From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More ACPI updates for v4.18-rc1
Date: Wed, 13 Jun 2018 13:03:39 +0200
Message-ID: <CAJZ5v0gp-g2EW1QXagwDQvmt55C14N6s+7or-8c7LebB2FK5LA@mail.gmail.com>
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
 acpi-4.18-rc1-2

with top-most commit 674455326ee397bc8334920533f71090b61fa594

 Merge branch 'acpica'

on top of commit f4fe74cc909bf811cd9cc7fd84f5a7514e06a7e1

 Merge tag 'acpi-4.18-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional ACPI updates for 4.18-rc1.

These update the ACPICA code in the kernel to upstream revision
20180531 including one important AML parser fix and updates
related to the IORT table, make the kernel recognize the
"Windows 2017.2" _OSI string and update the customized methods
documentation.

Specifics:

 - Update the ACPICA code in the kernel to upstream revision
   20180531 including:
   * AML parser fix to continue loading tables after detecting an AML
     error (Erik Schmauss).
   * AML parser debug option to dump parse trees (Bob Moore).
   * Debugger updates (Bob Moore).
   * Initial bits of Unload () operator deprecation (Bob Moore).
   * Updates related to the IORT table (Robin Murphy).

 - Make Linux respond to the "Windows 2017.2" _OSI string which
   allows native Thunderbolt enumeration to be used on Dell systems
   and was unsafe before recent changes in the PCI subsystem (Mario
   Limonciello).

 - Update the ACPI method customization feature documentation (Erik
   Schmauss).

Thanks!


---------------

Bob Moore (5):
      ACPICA: Debugger: Add count of namespace nodes after namespace dump
      ACPICA: AML Parser: Add debug option to dump parse trees
      ACPICA: Debugger: Reduce verbosity for module-level code errors.
      ACPICA: Interpreter: Begin deprecation of Unload operator
      ACPICA: Update version to 20180531

Erik Schmauss (2):
      ACPI / Documentation: update ACPI customize method feature docs
      ACPICA: AML parser: attempt to continue loading table after error

Mario Limonciello (1):
      ACPICA: Recognize the _OSI string "Windows 2017.2"

Robin Murphy (2):
      ACPICA: IORT: Update for revision D
      ACPICA: IORT: Add PMCG node supprt

---------------

 Documentation/acpi/method-customizing.txt | 10 +++---
 drivers/acpi/acpica/dbnames.c             |  1 +
 drivers/acpi/acpica/dbobject.c            | 23 +++++++++++++-
 drivers/acpi/acpica/dsdebug.c             | 12 ++++++--
 drivers/acpi/acpica/exconfig.c            | 11 +++++++
 drivers/acpi/acpica/nsdump.c              |  3 ++
 drivers/acpi/acpica/psloop.c              | 51 ++++++++++++++++++++++++++++++-
 drivers/acpi/acpica/psobject.c            | 30 ++++++++++++++++++
 drivers/acpi/acpica/pswalk.c              | 34 +++++++++++++++++++--
 drivers/acpi/acpica/uterror.c             | 10 +++---
 drivers/acpi/acpica/utosi.c               |  1 +
 include/acpi/acoutput.h                   |  4 ++-
 include/acpi/acpixf.h                     |  2 +-
 include/acpi/actbl2.h                     | 25 +++++++++++----
 include/acpi/actypes.h                    |  1 +
 15 files changed, 192 insertions(+), 26 deletions(-)
