From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fixes for v4.7-rc2
Date: Fri, 3 Jun 2016 23:40:55 +0200
Message-ID: <CAJZ5v0h7ZUts_V=qfL9MQr8g1dZ7b9X4ruTGcmaSUOfH3yTNng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36454 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161022AbcFCVk5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Jun 2016 17:40:57 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.7-rc2

to receive ACPI fixes for v4.7-rc2 with top-most commit
60c07f80b04698f6c054b675cb67ec5e7ee8db27

 Merge branches 'acpica-fixes', 'acpi-video' and 'acpi-processor'

on top of commit 1a695a905c18548062509178b98bc91e67510864

 Linux 4.7-rc1

Two fixes for problems introduced recently (ACPICA and the ACPI
backlight driver) and one fix for an older issue that prevents at
least one system from booting.

Specifics:

 - Fix an incorrect check introduced by recent ACPICA changes which
   causes problems with booting KVM guests to happen, among other
   things (Lv Zheng).

 - Fix a backlight issue introduced by recent changes to the ACPI
   video driver (Aaron Lu).

 - Fix the ACPI processor initialization which attempts to register
   an IO region without checking if that really is necessary and
   sometimes prevents drivers loaded subsequently from registering
   their resources which leads to boot issues (Rafael Wysocki).

Thanks!

---------------

Aaron Lu (1):
      ACPI / Thermal / video: fix max_level incorrect value

Lv Zheng (1):
      ACPICA / Hardware: Fix old register check in
acpi_hw_get_access_bit_width()

Rafael J. Wysocki (1):
      ACPI / processor: Avoid reserving IO regions too early

---------------

 drivers/acpi/acpi_processor.c                     |  9 ---------
 drivers/acpi/acpi_video.c                         |  9 ++++++---
 drivers/acpi/acpica/hwregs.c                      | 23 +++++++++--------------
 drivers/acpi/processor_throttling.c               |  9 +++++++++
 drivers/thermal/int340x_thermal/int3406_thermal.c |  2 +-
 include/acpi/video.h                              |  6 ++++--
 6 files changed, 29 insertions(+), 29 deletions(-)
