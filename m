From: tianyu.lan@intel.com
Subject: [PATCH 0/3] ACPI: EC/Button drivers clean up and correct gpe's sysfs attribute
Date: Thu, 12 Sep 2013 03:32:02 -0400
Message-ID: <1378971125-8896-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53656 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599Ab3ILHcR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Sep 2013 03:32:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tianyu.lan@intel.com, lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

The patch 1-2 are to clean up EC/Button drivers' code.
The patch 3 is to correct the process of abnormal param for gpe sysfs attribute.

 drivers/acpi/button.c |  9 +++------
 drivers/acpi/ec.c     | 49 ++++++++++++++++++++++++-------------------------
 drivers/acpi/sysfs.c  |  9 +++++++--
 3 files changed, 34 insertions(+), 33 deletions(-)

[PATCH 1/3] ACPI/Button: Using input_set_capability() to mark
[PATCH 2/3] ACPI/EC: Convert all printk to dynamic debug function
[PATCH 3/3] ACPI/Sys: make gpe's sysfs attribute only accept correct
