From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v4.17-rc6
Date: Fri, 18 May 2018 10:03:15 +0200
Message-ID: <CAJZ5v0gzh68Y3TwONGkGrCNGt8WY+f1rtjeEw0hgFyRr1sFyDQ@mail.gmail.com>
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
 acpi-4.17-rc6

with top-most commit 7b34c0fb1b51a6377752fc971e57577eeb102d60

 ACPICA: Add deferred package support for the Load and loadTable operators

on top of commit 67b8d5c7081221efa252e111cd52532ec6d4266f

 Linux 4.17-rc5

to receive an ACPI fix for 4.17-rc6.

This fixes an ACPICA regression introduced in this cycle and related
to the handling of package objects loaded by the Load and loadTable
AML operators that are not initialized properly after recent changes
(Bob Moore).

Thanks!


---------------

Bob Moore (1):
      ACPICA: Add deferred package support for the Load and loadTable operators

---------------

 drivers/acpi/acpica/acnamesp.h |  4 +++
 drivers/acpi/acpica/exconfig.c | 14 ++++++++
 drivers/acpi/acpica/nsinit.c   | 76 +++++++++++++++++++++++++++++++-----------
 3 files changed, 74 insertions(+), 20 deletions(-)
