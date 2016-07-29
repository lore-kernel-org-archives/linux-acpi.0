From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 0/2] ACPI / EC: Tune suspend/resume speed using PM operations
Date: Fri, 29 Jul 2016 18:05:38 +0800
Message-ID: <cover.1469785918.git.lv.zheng@intel.com>
References: <bd9df7ba491b33cfbaa46f4cc6a6325f74153e36.1469093001.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:62121 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbcG2KFq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Jul 2016 06:05:46 -0400
In-Reply-To: <bd9df7ba491b33cfbaa46f4cc6a6325f74153e36.1469093001.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

There are 2 improvements can be done to the EC driver to make system
suspend/resume faster:
1. Automatically use busy polling mode when noirq is entered
2. Disallow event handling (SCI_EVT/_Qxx) during suspend/resume period

This patchset achieves such performance tuning on top of a recent
workaround that creates ec_query_wq.

Lv Zheng (2):
  ACPI / EC: Add PM operations to tune polling mode efficiency
  ACPI / EC: Add PM operations to block event handling

 drivers/acpi/ec.c       |  199 ++++++++++++++++++++++++++++++++++++-----------
 drivers/acpi/internal.h |    3 +-
 drivers/acpi/sleep.c    |    4 +-
 3 files changed, 158 insertions(+), 48 deletions(-)

-- 
1.7.10

