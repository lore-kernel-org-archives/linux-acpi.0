From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] PNP updates for v4.16-rc1
Date: Sun, 21 Jan 2018 03:22:00 +0100
Message-ID: <CAJZ5v0gu8hEUkGTJMHKuFAs_1HCxu+UVG2qYm-gnLd_SO4n=dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:38892 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932362AbeAUCWB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Jan 2018 21:22:01 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

This goes early because of my LCA travel.

In case you decide to open the 4.16 merge window any time soon, please
pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pnp-4.16-rc1

with top-most commit 846583ce151644b8538ca6cdf3f0857a80787649

 PNP: pnpbios: Use PTR_ERR_OR_ZERO()

on top of commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36

 Linux 4.15-rc3

to receive PNP updates for 4.16-rc1.

These make pnpbios_thread_init() use PTR_ERR_OR_ZERO() and remove
an unnecessary kallsyms include from drivers/pnp/quirks.c (Vasyl
Gomonovych, Sergey Senozhatsky).

Thanks!


---------------

Sergey Senozhatsky (1):
      PNP: remove unneeded kallsyms include

Vasyl Gomonovych (1):
      PNP: pnpbios: Use PTR_ERR_OR_ZERO()

---------------

 drivers/pnp/pnpbios/core.c | 5 +----
 drivers/pnp/quirks.c       | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)
