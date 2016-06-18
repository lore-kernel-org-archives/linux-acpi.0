From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v4.7-rc4
Date: Sat, 18 Jun 2016 02:28:58 +0200
Message-ID: <CAJZ5v0hgy_fF90FwHHtMiTiM1fcRV_SqMvRXQBjyq4AHe8EmDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34370 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932915AbcFRA3A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jun 2016 20:29:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.7-rc4

to receive an ACPI update for v4.7-rc4 with top-most commit
46577e6a052ff5add7577ac748fb8628b3c3c7c9

 Merge branch 'acpica-fixes'

on top of commit 5edb56491d4812c42175980759da53388e5d86f5

 Linux 4.7-rc3

Revert a recent ACPICA commit that introduced a suspend-to-RAM
regression on one system due to incorrect information in its ACPI
tables that had not been taken into consideration at all before (and
everything worked), but the commit in question started to use it.

Thanks!

---------------

Rafael J. Wysocki (1):
      Revert "ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset
support for acpi_hw_write()"

---------------

 drivers/acpi/acpica/hwregs.c | 146 +++----------------------------------------
 1 file changed, 9 insertions(+), 137 deletions(-)
