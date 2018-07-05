From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.18-rc4
Date: Thu, 5 Jul 2018 13:32:35 +0200
Message-ID: <CAJZ5v0jT8iYaPLmrHWshDppHhZr3sqhrtFeTVzD6S=dvTdZ+CA@mail.gmail.com>
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
 acpi-4.18-rc4

with top-most commit df958569dbaa398f525057729717e44809ac4306

 Merge branches 'acpi-tables' and 'acpica'

on top of commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063

 Linux 4.18-rc3

to receive ACPI fixes for 4.18-rc4.

These fix a recent ACPICA regression, fix a battery driver regression
introduced during the 4.17 cycle and fix up the recently added
support for the PPTT ACPI table.

Specifics:

 - Revert part of a recent ACPICA regression fix that added leading
   newlines to ACPICA error messages and made the kernel log look
   broken (Rafael Wysocki).

 - Fix an ACPI battery driver regression introduced during the 4.17
   cycle due to incorrect error handling that made Thinkpad 13
   laptops crash on boot (Jouke Witteveen).

 - Fix up the recently added PPTT ACPI table support by covering
   the case when a PPTT structure represents a processors group
   correctly (Sudeep Holla).

Thanks!


---------------

Jouke Witteveen (1):
      ACPI / battery: Safe unregistering of hooks

Rafael J. Wysocki (1):
      ACPICA: Drop leading newlines from error messages

Sudeep Holla (1):
      ACPI / PPTT: use ACPI ID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set

---------------

 drivers/acpi/acpica/uterror.c |  6 +++---
 drivers/acpi/battery.c        |  9 +++++----
 drivers/acpi/pptt.c           | 10 ++++++++--
 3 files changed, 16 insertions(+), 9 deletions(-)
