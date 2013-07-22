From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/3] ACPI: _OSI debug/quirk facility enhancement
Date: Mon, 22 Jul 2013 16:08:03 +0800
Message-ID: <cover.1374474116.git.lv.zheng@intel.com>
References: <cover.1369380671.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55923 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255Ab3GVIIi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Jul 2013 04:08:38 -0400
In-Reply-To: <cover.1369380671.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patchset includes 1 ACPICA patches and 2 Linux patches to facilitate
Linux with the ability to disable _OSI vendor strings and _OSI feature
group strings.
This patchset has passed a unit test carried out by the codes ported from
Linux to ACPICA.

Lv Zheng (3):
  ACPICA: Add acpi_update_interfaces public interface
  ACPI: Add facility to disable all _OSI OS vendor strings
  ACPI: Add facility to remove all _OSI strings

 Documentation/kernel-parameters.txt |   55 ++++++++++++++++++++++++-
 drivers/acpi/acpica/aclocal.h       |    3 ++
 drivers/acpi/acpica/acutils.h       |    2 +
 drivers/acpi/acpica/utosi.c         |   77 +++++++++++++++++++++++++++++------
 drivers/acpi/acpica/utxface.c       |   29 +++++++++++++
 drivers/acpi/osl.c                  |   21 +++++++++-
 include/acpi/acpixf.h               |    2 +
 include/acpi/actypes.h              |   14 +++++++
 8 files changed, 187 insertions(+), 16 deletions(-)

-- 
1.7.10

