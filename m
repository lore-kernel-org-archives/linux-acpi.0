From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 0/6] ACPI/EC: Enhance EC driver state machine
Date: Fri, 19 Dec 2014 13:59:19 +0800
Message-ID: <cover.1418966602.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:17693 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751907AbaLSF7e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2014 00:59:34 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patchset fixes several small issues in current EC driver.
After applying this patchset, we can have all EC IRQ handling code
collected in advance_transaction() which is the core function of the EC
driver state machine.

These fixes are required by the EC GPE raw handler mode switch but not
dependent on the GPE raw handler mode. So I collect them to form this
small patchset.

Lv Zheng (6):
  ACPI/EC: Cleanup transaction wakeup code
  ACPI/EC: Add reference counting for query handlers
  ACPI/EC: Fix returning values in acpi_ec_sync_query()
  ACPI/EC: Fix a code path that global lock is not held
  ACPI/EC: Fix issues related to the SCI_EVT handling
  ACPI/EC: Cleanup QR_EC related code

 drivers/acpi/ec.c       |  183 +++++++++++++++++++++++------------------------
 drivers/acpi/internal.h |    1 +
 2 files changed, 92 insertions(+), 92 deletions(-)

-- 
1.7.10

