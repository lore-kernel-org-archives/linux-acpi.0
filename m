From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/6] ACPI/EC: Enhance EC driver state machine
Date: Wed, 14 Jan 2015 19:28:14 +0800
Message-ID: <cover.1421234254.git.lv.zheng@intel.com>
References: <cover.1418966602.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39590 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbbAND2T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Jan 2015 22:28:19 -0500
In-Reply-To: <cover.1418966602.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patchset fixes several small issues in current EC driver.
After applying this patchset, we can have all EC IRQ handling code
collected in advance_transaction() which is the core function of the EC
driver state machine.

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

