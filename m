From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/03] Hotfixes in ACPICA 20130418 Release
Date: Wed,  8 May 2013 12:00:35 +0800
Message-ID: <cover.1367912853.git.lv.zheng@intel.com>
References: <cover.1367813690.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13932 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807Ab3EHEBY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 May 2013 00:01:24 -0400
In-Reply-To: <cover.1367813690.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, stable@vger.kernel.org, linux-acpi@vger.kernel.org

The 20130418 ACPICA kernel resident system updates is linuxized based on
the pm/linux-next branch.
This patch set includes hot fixes useful for -stable.

Bob Moore (1):
  ACPICA: Fix possible buffer overflow during a field unit read
    operation

Jung-uk Kim (1):
  ACPICA: _OSI support: Fix possible memory leak

Tomasz Nowicki (1):
  ACPICA: ACPICA: Fix for _INI regression

 drivers/acpi/acpica/exfldio.c |   14 +++++++++++++-
 drivers/acpi/acpica/nsinit.c  |    1 +
 drivers/acpi/acpica/utosi.c   |    3 ++-
 3 files changed, 16 insertions(+), 2 deletions(-)

-- 
1.7.10

