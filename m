From: Len Brown <len.brown@intel.com>
Subject: [PATCH 6/28] ACPI: sbs: fix module_param() initializers
Date: Sat, 14 Oct 2006 04:05:47 -0400
Message-ID: <11608131752544-git-send-email-len.brown@intel.com>
References: <11608131691346-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:47917 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1752122AbWJNICy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Oct 2006 04:02:54 -0400
In-Reply-To: <11608131691346-git-send-email-len.brown@intel.com>
Message-Id: <3cd5b87d96db503f69a5892b8f5350d356d18969.1160812999.git.len.brown@intel.com>
In-Reply-To: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
References: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
Date: Tue, 5 Sep 2006 19:59:22 +0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lebedev@vger.kernel.org, Vladimir P <vladimir.p.lebedev@intel.com>, Len Brown <len.brown@intel.com>

From: Lebedev, Vladimir P <vladimir.p.lebedev@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sbs.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 79f38f0..8908a97 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -98,11 +98,11 @@ static int update_info_mode = UPDATE_INF
 static int update_time = UPDATE_TIME;
 static int update_time2 = UPDATE_TIME2;
 
-module_param(capacity_mode, int, CAPACITY_UNIT);
-module_param(update_mode, int, UPDATE_MODE);
-module_param(update_info_mode, int, UPDATE_INFO_MODE);
-module_param(update_time, int, UPDATE_TIME);
-module_param(update_time2, int, UPDATE_TIME2);
+module_param(capacity_mode, int, 0);
+module_param(update_mode, int, 0);
+module_param(update_info_mode, int, 0);
+module_param(update_time, int, 0);
+module_param(update_time2, int, 0);
 
 static int acpi_sbs_add(struct acpi_device *device);
 static int acpi_sbs_remove(struct acpi_device *device, int type);
-- 
1.4.3.rc2.g23bed-dirty
