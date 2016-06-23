From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 0/3] ACPI / gpe: Add GPE masking/unmasking mechanism
Date: Thu, 23 Jun 2016 14:20:10 +0800
Message-ID: <cover.1466662469.git.lv.zheng@intel.com>
References: <cover.1463389639.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50674 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbcFWGUP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jun 2016 02:20:15 -0400
In-Reply-To: <cover.1463389639.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patchset adds a new mechanism that can be used to mask/unmask GPEs.

Lv Zheng (3):
  ACPICA: Events: Introduce acpi_mask_gpe()/acpi_unmask_gpe() to
    implement GPE masking mechanism
  ACPI / sys: Update /sys/firmware/acpi/interrupts/gpexx using new GPE
    masking mechanism
  ACPI / sysfs: Provide quirk mechanism to prevent GPE flooding

 Documentation/kernel-parameters.txt |   10 ++++
 drivers/acpi/acpica/acevents.h      |    3 ++
 drivers/acpi/acpica/aclocal.h       |    2 +
 drivers/acpi/acpica/evgpe.c         |   57 ++++++++++++++++++++++
 drivers/acpi/acpica/evxfgpe.c       |   43 +++++++++++++++++
 drivers/acpi/acpica/hwgpe.c         |   23 +++++++--
 drivers/acpi/internal.h             |    1 +
 drivers/acpi/scan.c                 |    1 +
 drivers/acpi/sleep.c                |    2 +-
 drivers/acpi/sysfs.c                |   89 +++++++++++++++++++++++++++++++----
 include/acpi/acpixf.h               |    4 ++
 include/acpi/actypes.h              |   39 ++++++++-------
 12 files changed, 242 insertions(+), 32 deletions(-)

-- 
1.7.10

