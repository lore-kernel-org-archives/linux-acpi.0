From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.8-rc5
Date: Fri, 2 Sep 2016 23:44:11 +0200
Message-ID: <CAJZ5v0jHo3-HU+cReOFtFFZB+8PuG5t7vip2bMvguoVGL9mYFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34962 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932088AbcIBVoN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Sep 2016 17:44:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.8-rc5

to receive ACPI fixes for v4.8-rc5.

The top-most commit is 5331d9cab32ef640b4cd38a43b0858874fbb7168

 ACPI / drivers: replace acpi_probe_lock spinlock with mutex

and the base is commit 3eab887a55424fc2c27553b7bfe32330df83f7b8

 Linux 4.8-rc4

Included are two stable-candidate fixes for the ACPI early device
probing code added during the 4.4 cycle, one fixing a typo in a stub
macro used when CONFIG_ACPI is unset and one that prevents sleeping
functions from being called under a spinlock (Lorenzo Pieralisi).

Thanks!

---------------

Lorenzo Pieralisi (2):
      ACPI / drivers: fix typo in ACPI_DECLARE_PROBE_ENTRY macro
      ACPI / drivers: replace acpi_probe_lock spinlock with mutex

---------------

 drivers/acpi/scan.c  | 6 +++---
 include/linux/acpi.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
