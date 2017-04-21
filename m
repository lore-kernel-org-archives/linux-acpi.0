From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for final v4.11
Date: Fri, 21 Apr 2017 13:02:35 +0200
Message-ID: <CAJZ5v0jwJOc52dPU55WEiZ8DyZer1=NifTORfHHca6HTxbjZFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32955 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1037959AbdDULCh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Apr 2017 07:02:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.11-final

with top-most commit fe8c470ab87d90e4b5115902dd94eced7e3305c3

 ACPI / power: Avoid maybe-uninitialized warning

on top of commit 4f7d029b9bf009fbee76bb10c0c4351a1870d2f3

 Linux 4.11-rc7

to receive a final ACPI fix for v4.11.

This avoids a false-positive build warning from the compiler.

Specifics:

 - Avoid a false-positive warning regarding a variable that may not
   be initialized that started to trigger after a previous general
   build fix (Arnd Bergmann).

Thanks!

---------------

Arnd Bergmann (1):
      ACPI / power: Avoid maybe-uninitialized warning

---------------

 drivers/acpi/power.c | 1 +
 1 file changed, 1 insertion(+)
