From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/2] ACPI/EC: Improve EC driver's state machine to survive with firmware that refuses to respond QR_EC when SCI_EVT isn't set.
Date: Thu, 21 Aug 2014 14:40:52 +0800
Message-ID: <cover.1408601898.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:3069 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962AbaHUGlK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Aug 2014 02:41:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

It is reported for Acer Aspire V5-573G that the EC firmware on this
platform refuses to respond QR_EC when SCI_EVT isn't set.

This is basically a firmware issue, such firmware is not completely
compliant with current ACPI specification where the 0x00 return value for
QR_EC is mentioned. Thus Linux EC driver doesn't handle this and expects
firmware can always respond something (for example, 0x00 to indicate "no
outstanding events") even when SCI_EVT isn't set.

We can see delay issue on such platform. This is because the work item that
has issued QR_EC has to wait until timeout in this case, and the _Qxx
method evaluation work item queued after QR_EC one is delayed.

A previous race fix makes the occurrence rate of this issue higher than
before:
  Commit: c0d653412fc8450370167a3268b78fc772ff9c87
  Subject: ACPI / EC: Fix race condition in ec_transaction_completed()
But this is a seperate bug for the particular buggy firmware, and we are
not able to improve the race fix to fix it, we need to add new support code
to enhance our state machine to survive this situation.

This patchset implements required enhancements to fix this issue.

PATCH 1 is the required fix for this issue and PATCH 2 is a useful
improvement.

Lv Zheng (2):
  ACPI/EC: Add support to disallow QR_EC to be issued when SCI_EVT
    isn't set.
  ACPI/EC: Add support to disallow QR_EC to be issued before completing
    the previous QR_EC.

 drivers/acpi/ec.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

-- 
1.7.10

