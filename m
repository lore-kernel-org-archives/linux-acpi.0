From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v4.9-rc3
Date: Sat, 12 Nov 2016 00:54:03 +0100
Message-ID: <CAJZ5v0iDZk4YTPMZHEdWyLzG6OOdE5pmY+E=iKbjahi4dX+WAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34025 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934770AbcKKXyF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Nov 2016 18:54:05 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.9-rc5

with top-most commit 66f5854c6894dc028fc13345838c6f82bfcfef0c

 Merge branch 'device-properties'

on top of commit bc33b0ca11e3df467777a4fa7639ba488c9d4911

 Linux 4.9-rc4

to receive an ACPI fix for v4.9-rc5.

Fix a recent regression in the 8250_dw serial driver introduced by
adding a quirk for the APM X-Gene SoC to it which uncovered an issue
related to the handling of built-in device properties in the core
ACPI device enumeration code (Heikki Krogerus).

Thanks!


---------------

Heikki Krogerus (1):
      ACPI / platform: Add support for build-in properties

---------------

 drivers/acpi/acpi_apd.c             | 10 ++--------
 drivers/acpi/acpi_lpss.c            | 10 ++--------
 drivers/acpi/acpi_platform.c        |  5 ++++-
 drivers/acpi/dptf/int340x_thermal.c |  4 ++--
 drivers/acpi/scan.c                 |  2 +-
 drivers/platform/x86/intel-hid.c    |  2 +-
 drivers/platform/x86/intel-vbtn.c   |  2 +-
 include/linux/acpi.h                |  3 ++-
 8 files changed, 15 insertions(+), 23 deletions(-)
