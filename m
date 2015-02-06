From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 0/5] ACPI / EC: Add reference counting for requests and cleans up the grace periods support.
Date: Fri,  6 Feb 2015 08:57:37 +0800
Message-ID: <cover.1423183647.git.lv.zheng@intel.com>
References: <20141119121615.GA2514@node.dhcp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:49676 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093AbbBFA54 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Feb 2015 19:57:56 -0500
In-Reply-To: <20141119121615.GA2514@node.dhcp.inet.fi>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patchset contains 3 cleanups related to the EC driver:
1. Command flushing (command grace period)
   This patchset flushes EC commands before suspending/resuming, so that
   there won't be timeout for the incomplete commands after resuming.
2. Query flushing (query grace period)
   This patchset flushes EC event queries before suspending/resuming, so
   that there won't be broken events remained in the firmware queue.
3. Command storming prevention
   This patchset corrects command storming prevention logic because of
   the GPE raw handler mode.
The request reference count debugging messages can be used to detect broken
EC transactions. It should always drop to 1 when the driver is idle during
the runtime.

Note that after flushing before suspending, EC GPE is still enabled to keep
the old behavior.

Lv Zheng (5):
  ACPI/EC: Introduce STARTED/STOPPED flags to replace BLOCKED flag.
  ACPI/EC: Add command flushing support.
  ACPI/EC: Refine command storm prevention support.
  ACPI/EC: Add query flushing support.
  ACPI/EC: Add GPE reference counting debugging messages.

 drivers/acpi/ec.c       |  295 ++++++++++++++++++++++++++++++++++++++++-------
 drivers/acpi/internal.h |    1 +
 2 files changed, 254 insertions(+), 42 deletions(-)

-- 
1.7.10

