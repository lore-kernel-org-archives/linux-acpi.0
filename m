From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v4.7-rc5
Date: Sat, 25 Jun 2016 00:50:57 +0200
Message-ID: <CAJZ5v0hhxMnPAvnje+PKOrfebso5Uf8XAJQCUzYbi6zfNszAYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36554 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbcFXWu7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jun 2016 18:50:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.7-rc5

to receive an ACPI update for v4.7-rc5 with top-most commit
2605b98109100f70398115a473ea190ce93fda5e

 Merge branch 'acpica-fixes'

on top of commit 33688abb2802ff3a230bd2441f765477b94cc89e

 Linux 4.7-rc4

Stable-candidate fix for a deadlock in ACPICA introduced during the
4.5 development cycle by a commit attempting to improve the handling
of AML code that doesn't belong to any namespace objects in a given
definition block (Lv Zheng).

Thanks!

---------------

Lv Zheng (1):
      ACPICA: Namespace: Fix deadlock triggered by MLC support in
dynamic table loading

---------------

 drivers/acpi/acpica/exconfig.c | 2 ++
 drivers/acpi/acpica/nsparse.c  | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)
