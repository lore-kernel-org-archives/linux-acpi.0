From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/21] intel_menlow: don't set max_state a negative value
Date: Thu, 06 Nov 2008 23:39:12 -0500
Message-ID: <c2d06fe338912ee56c2ddd7de5574d5396ed8050.1226032677.git.len.brown@intel.com>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:54874 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbYKGEjb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:39:31 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9Y00KON4WB4XO1@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:38:36 -0600 (CST)
In-reply-to: <1226032765-15330-1-git-send-email-lenb@kernel.org>
In-reply-to: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

max_state is unsigned long.
don't set max_state a negative value

Cc : Thomas Sujith <sujith.thomas@intel.com>
Cc : Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/intel_menlow.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/intel_menlow.c b/drivers/misc/intel_menlow.c
index e00a275..124b37d 100644
--- a/drivers/misc/intel_menlow.c
+++ b/drivers/misc/intel_menlow.c
@@ -71,6 +71,9 @@ static int memory_get_int_max_bandwidth(struct thermal_cooling_device *cdev,
 	if (ACPI_FAILURE(status))
 		return -EFAULT;
 
+	if (!value)
+		return -EINVAL;
+
 	*max_state = value - 1;
 	return 0;
 }
@@ -121,7 +124,7 @@ static int memory_set_cur_bandwidth(struct thermal_cooling_device *cdev,
 	if (memory_get_int_max_bandwidth(cdev, &max_state))
 		return -EFAULT;
 
-	if (max_state < 0 || state > max_state)
+	if (state > max_state)
 		return -EINVAL;
 
 	arg_list.count = 1;
-- 
1.5.6.5

