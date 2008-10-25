From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/9] i7300_idle: Fix compile warning
 CONFIG_I7300_IDLE_IOAT_CHANNEL not defined
Date: Sat, 25 Oct 2008 04:13:33 -0400
Message-ID: <f371be6352cdde3df2253b76acb979480e93ce4f.1224922389.git.len.brown@intel.com>
References: <1224922419-7823-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:60275 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbYJYINn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Oct 2008 04:13:43 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9A00J3EC6U65X3@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 25 Oct 2008 03:13:42 -0500 (CDT)
In-reply-to: <1224922419-7823-1-git-send-email-lenb@kernel.org>
In-reply-to: <3ad0b02e4c1d5feba44b8ff48dccd1ba61a826b0.1224922389.git.len.brown@intel.com>
References: <3ad0b02e4c1d5feba44b8ff48dccd1ba61a826b0.1224922389.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venki Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Venki Pallipadi <venkatesh.pallipadi@intel.com>

When I7300_idle driver is not configured, there is a compile time
warning about IDLE_IOAT_CHANNEL not defined. Fix it.

Reported-by: Suresh Siddha <suresh.b.siddha@intel.com>
Reported-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/dma/ioat_dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/ioat_dma.c b/drivers/dma/ioat_dma.c
index fd1631d..c6d0ca2 100644
--- a/drivers/dma/ioat_dma.c
+++ b/drivers/dma/ioat_dma.c
@@ -172,7 +172,7 @@ static int ioat_dma_enumerate_channels(struct ioatdma_device *device)
 	xfercap_scale = readb(device->reg_base + IOAT_XFERCAP_OFFSET);
 	xfercap = (xfercap_scale == 0 ? -1 : (1UL << xfercap_scale));
 
-#if CONFIG_I7300_IDLE_IOAT_CHANNEL
+#ifdef  CONFIG_I7300_IDLE_IOAT_CHANNEL
 	if (i7300_idle_platform_probe(NULL, NULL) == 0) {
 		device->common.chancnt--;
 	}
-- 
1.5.6.5

