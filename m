From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More ACPI updates for v4.8-rc1
Date: Fri, 5 Aug 2016 16:50:00 +0200
Message-ID: <CAJZ5v0hghMYOGO-OSPg4iDLc5uJPCMYmdieHEvaOCYsZppFLnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-extra-4.8-rc1

with top-most commit 4dc14b343d47426858f3fb1c8669059b7e3f98d4

 Merge branches 'acpi-ec' and 'acpi-button'

on top of commit e663107fa1edda4d8a0d5b8ce704d71f8e27de43

 Merge tag 'acpi-4.8-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional ACPI material for v4.8-rc1.

Two more fixes in ACPI drivers, one in the ACPI EC driver
(stable-candidate) and one in the ACPI button driver.

Specifics:

 - An ACPI EC driver fix from the 4.3 cycle may cause the ACPICA's
   method reentrancy limit to be exceeded for a _Qxx method due to a
   large number of concurrent EC operations, so prevent that from
   happening by moving the EC handling into a separate workqueue
   with a limit on the number of concurrently executed work items
   (Lv Zheng).

 - Fix the cleanup code in the ACPI button driver that forgets to
   clear two variables on exit which causes an error to occur on the
   next attmpt to load the driver (Benjamin Tissoires).

Thanks!

---------------

Benjamin Tissoires (1):
      ACPI / button: remove pointer to old lid_sysfs on unbind

Lv Zheng (1):
      ACPI / EC: Work around method reentrancy limit in ACPICA for _Qxx

---------------

 drivers/acpi/button.c |  4 ++++
 drivers/acpi/ec.c     | 41 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 41 insertions(+), 4 deletions(-)
