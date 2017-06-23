From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v4.12-rc7
Date: Fri, 23 Jun 2017 15:43:40 +0200
Message-ID: <CAJZ5v0jQXgZtKEecgVK2_fQtuf-3WCdL4Dv=cOURm0GMayAJXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33817 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752564AbdFWNnm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Jun 2017 09:43:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.12-rc7

with top-most commit e4330d8bf669139a983255d1801733b64c2ae841

 ACPI / scan: Fix enumeration for special SPI and I2C devices

on top of commit 41f1830f5a7af77cf5c86359aba3cbd706687e52

 Linux 4.12-rc6

to receive an ACPI regression fix for v4.12-rc7.

This fixes the ACPI-based enumeration of some I2C and SPI devices
broken in 4.11.

Specifics:

 - I2C and SPI devices are expected to be enumerated by the
   I2C and SPI subsystems, respectively, but due to a change made
   during the 4.11 cycle, in some cases the ACPI core marks them
   as already enumerated which causes the I2C and SPI subsystems
   to overlook them, so fix that (Jarkko Nikula).

Thanks!


---------------

Jarkko Nikula (1):
      ACPI / scan: Fix enumeration for special SPI and I2C devices

---------------

 drivers/acpi/scan.c     | 67 +++++++++++++++++++++++++++----------------------
 include/acpi/acpi_bus.h |  3 ++-
 2 files changed, 39 insertions(+), 31 deletions(-)
