From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.11-rc7
Date: Fri, 14 Apr 2017 13:53:57 +0200
Message-ID: <CAJZ5v0gkmCBukp28d_sAiN7yhSFvrTkWq6bawmv6V9U4bkYPpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35429 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbdDNLx6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Apr 2017 07:53:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.11-rc7

with top-most commit f83e13f94e14d27c9610f917e40e23a6c2bbeaf0

 Merge branches 'acpi-scan-fixes' and 'acpica-fixes'

on top of commit 39da7c509acff13fc8cb12ec1bb20337c988ed36

 Linux 4.11-rc6

to receive ACPI fixes for v4.11-rc7.

These revert a recent ACPICA commit that turned out to be problematic
and fix a device enumeration breakage from the 4.8 cycle.

Specifics:

 - Revert a recent ACPICA commit targeted at catching firmware bugs
   which promptly did that and caused functional problems to appear
   (Rafael Wysocki).

 - Fix a device enumeration problem introduced in the 4.8 time frame
   which caused the ACPI docking station driver to report incorrect
   status via sysfs among other things (Rafael Wysocki).

Thanks!

---------------

Rafael J. Wysocki (2):
      ACPI / scan: Set the visited flag for all enumerated devices
      Revert "ACPICA: Resources: Not a valid resource if buffer length too long"

---------------

 drivers/acpi/acpica/utresrc.c | 17 +++++------------
 drivers/acpi/scan.c           | 19 ++++++++++++-------
 2 files changed, 17 insertions(+), 19 deletions(-)
