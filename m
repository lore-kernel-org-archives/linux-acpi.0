From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Generic device properties framework update for v4.7-rc1
Date: Mon, 16 May 2016 23:21:24 +0200
Message-ID: <CAJZ5v0jGNXWrjzGme1ZppW48Q6Q0Rhzc276POtUViDV=RbYNKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35286 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbcEPVV0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 May 2016 17:21:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 device-properties-4.7-rc1

to receive an update of the generic device properties framework for
v4.7-rc1 with top-most commit dab2e29402f40431d2199e6faff48174204d2d06

 Merge back new device properties material for v4.7.

on top of commit 0224a4a30b57385a60065aa598181868881d8fc6

 device property: Avoid potential dereferences of invalid pointers

Just one commit reworking the handling of built-in properties
initialization and updating a few drivers in accordance with the
core framework changes.

Thanks!

---------------

Heikki Krogerus (1):
      device property: don't bother the drivers with struct property_set

---------------

 arch/arm/mach-pxa/raumfeld.c      | 12 ++++--------
 arch/arm/mach-tegra/board-paz00.c |  6 +-----
 drivers/base/platform.c           | 19 ++++++++++---------
 drivers/base/property.c           | 34 +++++++++++++++++++++-------------
 drivers/mfd/intel-lpss-acpi.c     | 12 ++----------
 drivers/mfd/intel-lpss-pci.c      | 20 ++++----------------
 drivers/mfd/intel-lpss.c          |  2 +-
 drivers/mfd/intel-lpss.h          |  4 ++--
 drivers/mfd/mfd-core.c            |  4 ++--
 include/linux/mfd/core.h          |  4 ++--
 include/linux/platform_device.h   |  6 +++---
 include/linux/property.h          | 15 +++------------
 12 files changed, 55 insertions(+), 83 deletions(-)
