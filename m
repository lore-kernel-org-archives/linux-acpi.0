From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 0/4] ACPI / LPSS: clock improvements
Date: Tue,  2 Sep 2014 10:55:06 +0300
Message-ID: <1409644510-26397-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13203 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903AbaIBHzO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Sep 2014 03:55:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

Minor improvements mainly related to how the clocks are handled.


Heikki Krogerus (4):
  ACPI / LPSS: introduce flags
  ACPI / LPSS: drop clkdev_name member from lpss_device_desc
  ACPI / LPSS: support for 133MHz I2C source clock on Baytrail
  ACPI / LPSS: remove struct lpss_shared_clock

 drivers/acpi/acpi_lpss.c | 145 ++++++++++++++---------------------------------
 1 file changed, 43 insertions(+), 102 deletions(-)

-- 
2.1.0

