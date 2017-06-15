From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.12-rc6
Date: Thu, 15 Jun 2017 02:36:04 +0200
Message-ID: <CAJZ5v0i81Egcp8=-bDCc8-9b0JcRV=k8zfmcsRfpz-bsDPxVvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33241 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbdFOAgG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jun 2017 20:36:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.12-rc6

with top-most commit 9522933454f4c4bd5bedf3d71c538708b7c5de5b

 Merge branch 'acpica-fixes'

on top of commit 32c1431eea4881a6b17bd7c639315010aeefa452

 Linux 4.12-rc5

to receive ACPI fixes for v4.12-rc6.

These revert an ACPICA commit from the 4.11 cycle that causes
problems to happen on some systems and add a protection against
possible kernel crashes due to table reference counter imbalance.

Specifics:

 - Revert a 4.11 ACPICA change that made assumptions which are not
   satisfied on some systems and caused the enumeration of resources
   to fail on them (Rafael Wysocki).

 - Add a mechanism to prevent tables from being unmapped prematurely
   due to reference counter overflows (Lv Zheng).

Thanks!


---------------

Lv Zheng (1):
      ACPICA: Tables: Mechanism to handle late stage acpi_get_table() imbalance

Rafael J. Wysocki (1):
      Revert "ACPICA: Disassembler: Enhance resource descriptor detection"

---------------

 drivers/acpi/acpica/tbutils.c | 34 +++++++++++++++++++++++++---------
 drivers/acpi/acpica/utresrc.c |  9 ---------
 include/acpi/actbl.h          | 14 ++++++++++++++
 3 files changed, 39 insertions(+), 18 deletions(-)
