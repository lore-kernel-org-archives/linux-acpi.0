From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.9-rc7
Date: Fri, 25 Nov 2016 22:48:00 +0100
Message-ID: <CAJZ5v0gNzC9XJmCGpwkc_VacLsPEix9hYNqkJ5dz+h+6Pzf6rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.9-rc7

with top-most commit 7e5c07af8693e72b23aefb70da88b31b30c35b22

 Merge branches 'acpi-sleep-fixes' and 'acpi-wdat-fixes'

on top of commit 9c763584b7c8911106bb77af7e648bef09af9d80

 Linux 4.9-rc6

to receive ACPI fixes for v4.9-rc7.

One of them reverts a recent ACPI commit that attempted to improve
reboot/power-off on some systems, but introduced problems elsewhere,
and the other one fixes kernel builds with the new WDAT watchdog
driver enabled in some configurations.

Specifics:

 - Revert the recent commit that caused the ACPI _PTS method to
   be executed in the power-off/reboot code path (as per the
   specification) in an attempt to improve things on some systems
   (apparently expecting _PTS to be executed in that code path),
   but broke power-off/reboot on at least one other machine (Rafael
   Wysocki).

 - Fix kernel builds with the new WDAT watchdog driver enabled in
   some configurations by explicitly selecting WATCHDOG_CORE when
   enabling the WDAT watchdog driver (Mika Westerberg).

Thanks!


---------------

Mika Westerberg (1):
      watchdog: wdat_wdt: Select WATCHDOG_CORE

Rafael J. Wysocki (1):
      Revert "ACPI: Execute _PTS before system reboot"

---------------

 drivers/acpi/sleep.c     | 29 ++++++-----------------------
 drivers/watchdog/Kconfig |  1 +
 2 files changed, 7 insertions(+), 23 deletions(-)
