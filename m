From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.10-rc6
Date: Fri, 27 Jan 2017 01:03:28 +0100
Message-ID: <CAJZ5v0i-uNTYir7CJCLTVHv424i-1q9z7K209oH-qV=5b9pJRQ@mail.gmail.com>
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
 acpi-4.10-rc6

with top-most commit 0389227dde3abae442521948caf5c173e696cdca

 Merge branches 'acpica' and 'acpi-video'

on top of commit 7a308bb3016f57e5be11a677d15b821536419d36

 Linux 4.10-rc5

to receive ACPI fixes for v4.10-rc6.

These fix two regressions introduced recently, one by reverting the
problematic commit and one by fixing up locking in the ACPICA core.

Specifics:

 - Revert a recent change that added an ACPI video blacklist entry
   for HP Pavilion dv6 as it turned to introduce backlight handling
   regressions on some systems (Hans de Goede).

 - Fix locking in the ACPICA core to avoid deadlocks related to table
   loading that were exposed by a recent change in that area (Lv Zheng).

Thanks!

---------------

Hans de Goede (1):
      Revert "ACPI / video: Add force_native quirk for HP Pavilion dv6"

Lv Zheng (1):
      ACPICA: Tables: Fix hidden logic related to
acpi_tb_install_standard_table()

---------------

 drivers/acpi/acpica/tbdata.c   |  9 ++-------
 drivers/acpi/acpica/tbinstal.c | 17 +++++++++++++++--
 drivers/acpi/video_detect.c    | 11 -----------
 3 files changed, 17 insertions(+), 20 deletions(-)
