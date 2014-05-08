From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 0/2] ACPI / LPSS: fix for a Baytrail PM issue
Date: Thu,  8 May 2014 17:33:49 +0300
Message-ID: <1399559631-24785-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31300 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753205AbaEHOeh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 May 2014 10:34:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Li Aubrey <aubrey.li@linux.intel.com>, linux-acpi@vger.kernel.org

Hi,

These will fix the issue with some BYT boards, where resuming from D3
fails. The root cause turned out to be because we loose the context of
the private registers.


Heikki Krogerus (2):
  ACPI / PM: Export rest of the subsys functions
  ACPI / LPSS: custom power domain for LPSS

 drivers/acpi/acpi_lpss.c | 133 ++++++++++++++++++++++++++++++++++++++++++++---
 drivers/acpi/device_pm.c |   2 +
 include/linux/acpi.h     |   4 ++
 3 files changed, 132 insertions(+), 7 deletions(-)

-- 
2.0.0.rc2

