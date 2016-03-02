From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/2] ACPI / OSL: Improve initrd override mechanism
Date: Wed,  2 Mar 2016 14:16:02 +0800
Message-ID: <cover.1456899242.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11320 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbcCBGQS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Mar 2016 01:16:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patchset improves initrd override mechanism.

Lv Zheng (2):
  ACPI / OSL: Cleanup initrd table override code
  ACPI / OSL: Add support to install tables via initrd

 drivers/acpi/internal.h |    1 +
 drivers/acpi/osl.c      |  158 +++++++++++++++++++++++++++++------------------
 drivers/acpi/tables.c   |    2 +
 3 files changed, 101 insertions(+), 60 deletions(-)

-- 
1.7.10

