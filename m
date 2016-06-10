From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v4.7-rc3
Date: Fri, 10 Jun 2016 02:20:59 +0200
Message-ID: <CAJZ5v0iqvEYY4D2-eBUiPLxkos8Eiv_s6kp7zbm2M6oYHRn10Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36713 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbcFJAVA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jun 2016 20:21:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.7-rc3

to receive an ACPI update for v4.7-rc3 with top-most commit
bd6ac2abc9937eb7613aa194195fd98fe9312b38

 Merge branch 'acpi-ec'

on top of commit af8c34ce6ae32addda3788d54a7e340cad22516b

 Linux 4.7-rc2

A recently introduced boot regression related to the ACPI EC
initialization is addressed by restoring the previous behavior
(Lv Zheng).

Thanks!

---------------

Lv Zheng (1):
      ACPI / EC: Fix a boot EC regresion by restoring boot EC support
for the DSDT EC

---------------

 drivers/acpi/bus.c      |  2 +-
 drivers/acpi/ec.c       | 29 ++++++++++++++++++++++-------
 drivers/acpi/internal.h |  2 +-
 3 files changed, 24 insertions(+), 9 deletions(-)
