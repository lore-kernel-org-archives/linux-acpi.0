From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.11-rc5
Date: Fri, 31 Mar 2017 23:34:32 +0200
Message-ID: <CAJZ5v0jasxCt-8iRLoqc-JUCdNZ_btGio+GO5o_y6Awb_+xTMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33035 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754289AbdCaVed (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Mar 2017 17:34:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.11-rc5

with top-most commit a07930662e3097144d6cbbc1b9211867fd1a173e

 Merge branches 'acpi-hotplug-fixes', 'acpi-build-fixes' and 'acpi-apei-fixes'

on top of commit c02ed2e75ef4c74e41e421acb4ef1494671585e8

 Linux 4.11-rc4

to receive ACPI fixes for v4.11-rc5.

These fix two issues related to IOAPIC hotplug, an overzealous build
optimization that prevents the function graph tracer from working with
the ACPI subsystem correctly and an RCU synchronization issue in the
ACPI APEI code.

Specifics:

 - Drop the unconditional setting of the '-Os' gcc flag from the ACPI
   Makefile to make the function graph tracer work correctly with the
   ACPI subsystem (Josh Poimboeuf).

 - Add missing synchronize_rcu() to ghes_remove() which removes an
   element from an RCU-protected list, but fails to synchronize it
   properly afterward (James Morse).

 - Fix two problems related to IOAPIC hotplug, a local variable
   initialization in setup_res() and the creation of platform
   device objects for IO(x)APICs which are (a) unused and (b) leaked
   on hot-removal (Joerg Roedel).

Thanks!

---------------

James Morse (1):
      ACPI / APEI: Add missing synchronize_rcu() on NOTIFY_SCI removal

Joerg Roedel (2):
      ACPI: ioapic: Clear on-stack resource before using it
      ACPI: Do not create a platform_device for IOAPIC/IOxAPIC

Josh Poimboeuf (1):
      ACPI: Fix incompatibility with mcount-based function graph tracing

---------------

 drivers/acpi/Makefile        | 1 -
 drivers/acpi/acpi_platform.c | 8 +++++---
 drivers/acpi/apei/ghes.c     | 1 +
 drivers/acpi/ioapic.c        | 6 ++++++
 4 files changed, 12 insertions(+), 4 deletions(-)
