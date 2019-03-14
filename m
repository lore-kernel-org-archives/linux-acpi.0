From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More ACPI updates for v5.1-rc1
Date: Thu, 14 Mar 2019 12:36:13 +0100
Message-ID: <CAJZ5v0iLKAVM0Ftv8LhS0cS=XPHXRx7sCMMtRJ9PLymGhgh4uQ@mail.gmail.com>
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
 acpi-5.1-rc1-2

with top-most commit b6e88119f1edcdc1fa3fd3a168310ac2d433a873

 Merge branches 'acpi-tables', 'acpi-debug', 'acpi-doc' and 'acpi-misc'

on top of commit d276709ce6c90b9eceecdbd01a0c083ab04d3a52

 Merge tag 'acpi-5.1-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional ACPI updates for 5.1-rc1.

These fix a couple of issues and do some cleanups on top of the
previous ACPI changes for 5.1-rc1.

Specifics:

 - Fix a crash caused by unloading an SSDT overlay (Andy Shevchenko).

 - Prevent user space from getting confusing error values on failing
   ACPI sysfs accesses (Rafael Wysocki).

 - Simplify leaf node detection in the PPTT parsing code by using a
   new flag defined in ACPI 6.3 (Jeremy Linton).

 - Add missing "static" in some places in the ACPI configfs code
   (Andy Shevchenko).

 - Fix acpidbg tool path in the ACPI documentation (Flavio Suligoi).

Thanks!


---------------

Andy Shevchenko (3):
      ACPI / configfs: Mark local functions static
      ACPI / configfs: Mark local data structures static
      ACPI / device_sysfs: Avoid OF modalias creation for removed device

Flavio Suligoi (1):
      ACPI: Documentation: Fix path for acpidbg tool

Jeremy Linton (1):
      ACPI: tables: Simplify PPTT leaf node detection

Rafael J. Wysocki (1):
      ACPI: sysfs: Prevent get_status() from returning acpi_status

---------------

 Documentation/acpi/aml-debugger.txt |  4 ++--
 drivers/acpi/acpi_configfs.c        | 25 +++++++++++++------------
 drivers/acpi/device_sysfs.c         |  6 +++++-
 drivers/acpi/pptt.c                 |  3 +++
 drivers/acpi/sysfs.c                | 21 ++++++++++++---------
 5 files changed, 35 insertions(+), 24 deletions(-)
