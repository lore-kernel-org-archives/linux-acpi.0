From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [RFC Patch v1 0/6] Miscellaneous improvements for ACPI
Date: Mon, 17 Feb 2014 13:01:05 +0800
Message-ID: <1392613271-10912-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48065 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbaBQFAb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Feb 2014 00:00:31 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,
	This is a miscellaneous patch set to improve ACPI code. due to
resource limitation, I can't find hardware to test all patches.
So appreciate any help to these patches.

Thanks!
Gerry

Jiang Liu (6):
  acpi_pad: simplify notify handler by using acpi_drv_ops->notify
  ACPI: rename acpi_evaluate_hotplug_ost to acpi_evaluate_ost for reuse
  acpi_pad: use acpi_evaluate_pad() to replace open-coded version
  xen, acpi_pad: use acpi_evaluate_pad() to replace open-coded version
  acpi_processor: use acpi_evaluate_pad() to replace open-coded version
  ACPI: use device name LNXSYBUS.xx for ACPI \_SB and \_TZ objects

 drivers/acpi/acpi_pad.c          |   49 ++++++++------------------------------
 drivers/acpi/processor_perflib.c |   14 +++--------
 drivers/acpi/scan.c              |   20 ++++++++++++++--
 drivers/acpi/utils.c             |   14 ++++-------
 drivers/xen/xen-acpi-pad.c       |   26 ++++++--------------
 include/acpi/acpi_bus.h          |   10 +++++++-
 6 files changed, 51 insertions(+), 82 deletions(-)

-- 
1.7.10.4

