From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI regression fixes for v4.7
Date: Tue, 12 Jul 2016 22:48:28 +0200
Message-ID: <CAJZ5v0i-jQG5bN8XkzRHb=qCKqGZfv18oGArY3ZNOPq=KQNudQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36836 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbcGLUsk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jul 2016 16:48:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-urgent-4.7

to receive ACPI regression fixes for v4.7 with top-most commit
d0420d20bacd1eef9f75a769ad48befd383ad190

 Merge branches 'acpica-fixes' and 'acpi-ec-fixes'

on top of commit 92d21ac74a9e3c09b0b01c764e530657e4c85c49

 Linux 4.7-rc7

One ACPI EC driver regression fix (code ordering) and three reverts
of ACPICA commits, one that introduced a problem and two unsuccessful
attempted fixes on top of it.

Specifics:

 - Fix a recent regression in the ACPI EC driver introduced by a fix
   of another problem that uncovered a latent code ordering issue in
   the driver (Lv Zheng).

 - Revert a recent ACPICA commit that attempted to address a lock
   ordering issue introduced by a previous fix, but caused Dell
   Precision 5510 to fail to boot, revert that previous fix too and
   finally revert the commit that caused the original problem (a
   deadlock in the ACPICA code) to happen (Rafael Wysocki).

Thanks!

---------------

Lv Zheng (1):
      ACPI / EC: Fix code ordering issue in ec_remove_handlers()

Rafael J. Wysocki (3):
      Revert "ACPICA: Namespace: Fix namespace/interpreter lock ordering"
      Revert "ACPICA: Namespace: Fix deadlock triggered by MLC support
in dynamic table loading"
      Revert "ACPI 2.0 / AML: Improve module level execution by moving
the If/Else/While execution to per-table basis"

---------------

 drivers/acpi/acpica/exconfig.c |  2 --
 drivers/acpi/acpica/nsload.c   |  7 +------
 drivers/acpi/ec.c              | 15 +++++++++++++--
 include/acpi/acpixf.h          |  2 +-
 4 files changed, 15 insertions(+), 11 deletions(-)
