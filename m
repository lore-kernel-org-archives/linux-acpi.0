From: Len Brown <lenb@kernel.org>
Subject: [PATCH 092/103] thermal: Fix test of unsigned in
 thermal_cooling_device_cur_state_store()
Date: Wed, 16 Dec 2009 03:36:43 -0500
Message-ID: <edb949185210365f107ddc5efa60df105d25e1d7.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:62434 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761852AbZLPJFz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 04:05:55 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0055NMLOFSID@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 03:05:50 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Roel Kluin <roel.kluin@gmail.com>, Len Brown <len.brown@intel.com>

From: Roel Kluin <roel.kluin@gmail.com>

state is unsigned long so the test did not work.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/thermal_sys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 6f8d8f9..800e0c5 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -374,7 +374,7 @@ thermal_cooling_device_cur_state_store(struct device *dev,
 	if (!sscanf(buf, "%ld\n", &state))
 		return -EINVAL;
 
-	if (state < 0)
+	if ((long)state < 0)
 		return -EINVAL;
 
 	result = cdev->ops->set_cur_state(cdev, state);
-- 
1.6.0.6

