From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 0/3] ACPI: sleep: mechanism to query wakeup reasons
Date: Thu, 14 Dec 2017 14:38:31 +0800
Message-ID: <cover.1513233415.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:25921 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750720AbdLNGie (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Dec 2017 01:38:34 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patchset adds a mechanism to query wakeup reasons (fixed events
and GPEs).

Chen Yu (1):
  ACPICA: Add new API to query wakeup reasons

Lv Zheng (2):
  ACPI: Add GPE number in wakeup device list
  ACPI: Add wakeup reason support

 drivers/acpi/acpica/acevents.h  |   2 +
 drivers/acpi/acpica/acglobal.h  |   1 +
 drivers/acpi/acpica/achware.h   |   4 ++
 drivers/acpi/acpica/aclocal.h   |   1 +
 drivers/acpi/acpica/evevent.c   |  25 ++++++++++
 drivers/acpi/acpica/hwgpe.c     | 102 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/hwsleep.c   |  38 +++++++++++++++
 drivers/acpi/acpica/hwxfsleep.c |  23 +++++++++
 drivers/acpi/proc.c             |   7 +--
 drivers/acpi/sleep.c            |   3 ++
 include/acpi/acpixf.h           |   1 +
 11 files changed, 204 insertions(+), 3 deletions(-)

-- 
2.7.4

