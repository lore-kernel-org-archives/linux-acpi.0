From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH v2 0/2] ACPI D3Cold state support
Date: Tue, 27 Mar 2012 15:50:22 +0800
Message-ID: <1332834624-29310-1-git-send-email-ming.m.lin@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64470 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883Ab2C0Hul (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Mar 2012 03:50:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Len,

This is the v2 patches to add ACPI D3Cold state support.

v2:
- _PR3 indicates D3Cold support
- allow all combinations of power resource and device

 drivers/acpi/power.c    |  166 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/acpi/scan.c     |    7 ++
 include/acpi/acpi_bus.h |    2 +
 3 files changed, 173 insertions(+), 2 deletions(-)

Thanks for any comments.
Lin Ming
