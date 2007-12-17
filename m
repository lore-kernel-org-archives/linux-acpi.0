From: Joe Perches <joe@perches.com>
Subject: [PATCH] drivers/acpi/: Spelling fixes
Date: Mon, 17 Dec 2007 11:30:25 -0800
Message-ID: <1197919875-5288-26-git-send-email-joe@perches.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from DSL022.labridge.com ([206.117.136.22]:2981 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761061AbXLQTbm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Dec 2007 14:31:42 -0500
Message-Id: <5703e57f925f31fc0eb38873bd7f10fc44f99cb4.1197918890.git.joe@perches.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org


Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/acpi/scan.c              |    2 +-
 drivers/acpi/utilities/utresrc.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5b4d462..fad2eaa 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -830,7 +830,7 @@ static int acpi_bus_get_flags(struct acpi_device *device)
 	if (ACPI_SUCCESS(status))
 		device->flags.wake_capable = 1;
 
-	/* TBD: Peformance management */
+	/* TBD: Performance management */
 
 	return 0;
 }
diff --git a/drivers/acpi/utilities/utresrc.c b/drivers/acpi/utilities/utresrc.c
index cbbd331..b630ee1 100644
--- a/drivers/acpi/utilities/utresrc.c
+++ b/drivers/acpi/utilities/utresrc.c
@@ -1,6 +1,6 @@
 /*******************************************************************************
  *
- * Module Name: utresrc - Resource managment utilities
+ * Module Name: utresrc - Resource management utilities
  *
  ******************************************************************************/
 
-- 
1.5.3.7.949.g2221a6

