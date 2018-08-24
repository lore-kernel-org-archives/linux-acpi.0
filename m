From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Urgent ACPI Kconfig fix for v4.19-rc1
Date: Fri, 24 Aug 2018 11:37:59 +0200
Message-ID: <CAJZ5v0iwVRX+MJ0O2yTDo-mjVaZqv0HzEF0o=TqYKKXr2+p4KA@mail.gmail.com>
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
 acpi-4.19-rc1-3

with top-most commit f5d707ede37a962bc3cb9b3f8531a870dae29e46

 ACPI: fix menuconfig presentation of ACPI submenu

on top of commit df2def49c57b4146520a1f4ca37bc3f494e2cd67

 Merge tag 'acpi-4.19-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive an urgent ACPI Kconfig fix for 4.19-rc1.

This fixes recent menuconfig breakage causing it to present
ACPI-specific options incorrectly (Arnd Bergmann).

Thanks!


---------------

Arnd Bergmann (1):
      ACPI: fix menuconfig presentation of ACPI submenu

---------------

 drivers/acpi/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
