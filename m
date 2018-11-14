From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v4.20-rc3
Date: Wed, 14 Nov 2018 21:17:37 +0100
Message-ID: <CAJZ5v0h04bhHbvL3gZ2L5JpnwjGVoFWc_A5YMm4Z5Eid+WQ4oQ@mail.gmail.com>
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
 acpi-4.20-rc3

with top-most commit 017ce359a7187192df5222a00fa3c9055eb3736d

 ACPI / PMIC: xpower: fix IOSF_MBI dependency

on top of commit 651022382c7f8da46cb4872a545ee1da6d097d2a

 Linux 4.20-rc1

to receive an ACPI fix for 4.20-rc3.

This fixes a recently introduced build issue in the xpower PMIC
driver (Arnd Bergmann).

Thanks!


---------------

Arnd Bergmann (1):
      ACPI / PMIC: xpower: fix IOSF_MBI dependency

---------------

 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
