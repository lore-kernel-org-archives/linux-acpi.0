From: Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH] acpi: Change 1 to true for bool type variables.
Date: Tue, 26 May 2015 01:32:46 +0530
Message-ID: <1432584167-5206-1-git-send-email-shailendra.capricorn@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34380 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbbEYUC7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 May 2015 16:02:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shailendra Verma <shailendra.capricorn@gmail.com>

The variables immediate_undock and brightness_switch_enabled are bool type.
Hence initializing with true instead of 1.

Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/acpi/dock.c  |    2 +-
 drivers/acpi/video.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index a688aa2..d3724b4 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -44,7 +44,7 @@ MODULE_AUTHOR("Kristen Carlson Accardi");
 MODULE_DESCRIPTION(ACPI_DOCK_DRIVER_DESCRIPTION);
 MODULE_LICENSE("GPL");
 
-static bool immediate_undock = 1;
+static bool immediate_undock = true;
 module_param(immediate_undock, bool, 0644);
 MODULE_PARM_DESC(immediate_undock, "1 (default) will cause the driver to "
 	"undock immediately when the undock button is pressed, 0 will cause"
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index cc79d3f..b58da00 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -68,7 +68,7 @@ MODULE_AUTHOR("Bruno Ducrot");
 MODULE_DESCRIPTION("ACPI Video Driver");
 MODULE_LICENSE("GPL");
 
-static bool brightness_switch_enabled = 1;
+static bool brightness_switch_enabled = true;
 module_param(brightness_switch_enabled, bool, 0644);
 
 /*
-- 
1.7.9.5

