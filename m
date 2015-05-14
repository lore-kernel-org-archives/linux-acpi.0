From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for 4.1-rc4
Date: Fri, 15 May 2015 01:22:08 +0200
Message-ID: <CAJZ5v0iz=xk6migSGAXh+7rYtNZnk8E_ixgmoHKEQ1ZbBTQysg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34489 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933283AbbENXWJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 May 2015 19:22:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.1-rc4

to receive ACPI fixes for v4.1-rc4 with top-most commit 4de5167ee07f

 Merge branches 'acpi-init' and 'acpica'

on top of commit 030bbdbf4c833bc69f502eae58498bc5572db736

 Linux 4.1-rc3

Two fixes here, one revert of a recent ACPICA commit that broke
audio support on one Dell machine and a fix for a long-standing
issue that may cause systems to break randomly during boot.

Specifics:

 - The recent ACPICA commit that set the ACPI _REV return value to 2
   (which is the value always used by Windows and now mandated by the
   spec too) in order to prevent the firmware people from using it to
   play tricks with us caused a serious audio regression to happen on
   Dell XPS 13 (the AML on that machine uses the _REV return value to
   decide how to expose audio to the OS and does that to hide the
   lack of proper support for its I2S audio in Linux), so revert that
   commit for now and we'll revisit the issue in the next cycle.

 - Ensure that the ordering of acpi_reserve_resources() with respect
   to the rest of the ACPI initialization sequence will always be
   the same, or the IO or memory region occupied by the ACPI fixed
   registers may be assigned to a PCI host bridge as a result of
   a race and random breakage ensues going forward.

Thanks!


---------------

Rafael J. Wysocki (2):
      ACPI / init: Fix the ordering of acpi_reserve_resources()
      Revert "ACPICA: Permanently set _REV to the value '2'."

---------------

 drivers/acpi/acpica/utglobal.c | 13 +++----------
 drivers/acpi/osl.c             |  6 ++----
 2 files changed, 5 insertions(+), 14 deletions(-)
