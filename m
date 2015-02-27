From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/2] ACPI / EC: Enhance logging/debugging.
Date: Fri, 27 Feb 2015 14:48:07 +0800
Message-ID: <cover.1425019470.git.lv.zheng@intel.com>
References: <alpine.LNX.2.11.1502151932250.630@localhost>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41962 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750947AbbB0GsO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Feb 2015 01:48:14 -0500
In-Reply-To: <alpine.LNX.2.11.1502151932250.630@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patchset enhances logging/debugging support in EC driver.

Lv Zheng (2):
  ACPI / EC: Cleanup logging/debugging splitter support.
  ACPI / EC: Add GPE reference counting debugging messages.

 drivers/acpi/ec.c |  120 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 84 insertions(+), 36 deletions(-)

-- 
1.7.10

