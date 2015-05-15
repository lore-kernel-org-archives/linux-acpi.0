From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 0/6] ACPI / EC: Update due to recent changes.
Date: Fri, 15 May 2015 14:16:05 +0800
Message-ID: <cover.1431670199.git.lv.zheng@intel.com>
References: <3b6064b23b148a9c3eed58566e9361a852618556.1430900840.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34076 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753638AbbEOGQ3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 May 2015 02:16:29 -0400
In-Reply-To: <3b6064b23b148a9c3eed58566e9361a852618556.1430900840.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patchset tries to cleanup the EC driver to reflect the recent changes.
There is a small fix in the patchset to use time_before() instead of
time_after().
The last patch removes all non-root-caused MSI quirks so that we may be
able to identify their root cause if regressions are reported against this
removal and generate new quirks based on the new code base.

Lv Zheng (6):
  ACPI / EC: Update acpi_ec_is_gpe_raised() with new GPE status flag.
  ACPI / EC: Remove storming threashold enlarging quirk.
  ACPI / EC: Remove irqs_disabled() check.
  ACPI / EC: Fix and clean up register access guarding logics.
  ACPI / EC: Add module params for polling modes.
  ACPI / EC: Remove non-root-caused busy polling quirks.

 drivers/acpi/ec.c       |  148 ++++++++++++++++++++++-------------------------
 drivers/acpi/internal.h |    1 +
 2 files changed, 69 insertions(+), 80 deletions(-)

-- 
1.7.10

