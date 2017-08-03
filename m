From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.13-rc4
Date: Thu, 3 Aug 2017 21:14:47 +0200
Message-ID: <CAJZ5v0jbqZGAvBVOxOj3V7C+CEu15QfQc6LiFyDYBivstDdOXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:36105 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbdHCTOs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2017 15:14:48 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.13-rc4

with top-most commit 3de559d4df546442e28fab91e1c9cab3f19ca24f

 Merge branches 'acpi-soc', 'acpi-wdat' and 'acpi-cppc'

on top of commit 16f73eb02d7e1765ccab3d2018e0bd98eb93d973

 Linux v4.13-rc3

to receive ACPI fixes for v4.13-rc4.

These fix two issues in the ACPI SoC drivers (Intel LPSS and AMD
APD), a crash in the PCC mailbox initialization code and a WDAT
watchdog initialization failure.

Specifics:

 - Fix a device ID of Hisilicon Hip07/08 in the ACPI APD (AMD SoC)
   driver (Hanjun Guo).

 - Fix list corruption (introduced during the 4.11 cycle) in the ACPI
   LPSS (Intel SoC) driver (Hans de Goede).

 - Fix PCC mailbox handling code crash during initialization when
   PCCT is not present and PCC channel 0 is requested (Hoan Tran).

 - Fix a WDAT watchdog initialization issue causing platform device
   creation to fail due to partially overlapping address ranges in
   resources (Ryan Kennedy).

Thanks!


---------------

Hanjun Guo (1):
      ACPI: APD: Fix HID for Hisilicon Hip07/08

Hans de Goede (1):
      ACPI / LPSS: Only call pwm_add_table() for the first PWM controller

Hoan Tran (1):
      mailbox: pcc: Fix crash when request PCC channel 0

Ryan Kennedy (1):
      ACPI / watchdog: Fix init failure with overlapping register regions

---------------

 drivers/acpi/acpi_apd.c      |  4 ++--
 drivers/acpi/acpi_lpss.c     | 14 ++++++++++++++
 drivers/acpi/acpi_watchdog.c |  7 ++++++-
 drivers/mailbox/pcc.c        |  2 +-
 4 files changed, 23 insertions(+), 4 deletions(-)
