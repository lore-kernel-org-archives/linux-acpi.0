From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] PNP update for v4.9-rc1
Date: Mon, 3 Oct 2016 00:57:07 +0200
Message-ID: <CAJZ5v0hmCE0EVExxe=DSa4F+4ERVifBxN7H8yeXmJhq3wKxVMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36317 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbcJBW5J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Oct 2016 18:57:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi Linus,

This goes early as I will be traveling for a good part of the next week.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pnp-4.9-rc1

with top-most commit e4dca0febfb213d01466c400f54b01a556372120

 PNP: isapnp: make core more explicitly non-modular

on top of commit 694d0d0bb2030d2e36df73e2d23d5770511dbc8d

 Linux 4.8-rc2

to receive a PNP update for v4.9-rc1.

This more PNP core code explicitly non-modular (Paul Gortmaker).

Thanks!

---------------

Paul Gortmaker (1):
      PNP: isapnp: make core more explicitly non-modular

---------------

 drivers/pnp/isapnp/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)
