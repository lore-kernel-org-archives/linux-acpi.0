From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/5] ACPI/EC: Cleanup debugging messages and coding styles.
Date: Tue, 14 Oct 2014 14:23:33 +0800
Message-ID: <cover.1413267704.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17450 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754652AbaJNGXi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Oct 2014 02:23:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patchset contains trivial cleanup code to make it easier to search in
the EC debugging messages.
It also includes a patch to correct coding style issues that detected by
recent scripts/checkpatch.pl.

No functional changes. This patchset can only make remote debugging more
efficient.

Lv Zheng (5):
  ACPI/EC: Add CPU ID to debugging messages.
  ACPI/EC: Enhance the logs to apply to QR_EC transactions.
  ACPI/EC: Add detailed command/query debugging information.
  ACPI/EC: Refine event/query debugging messages.
  ACPI/EC: Cleanup coding style.

 drivers/acpi/ec.c |  109 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 70 insertions(+), 39 deletions(-)

-- 
1.7.10

