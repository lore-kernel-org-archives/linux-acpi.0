From: Zhenyu Wang <zhenyu.z.wang@intel.com>
Subject: [patch] remove debug info in acpi video
Date: Tue, 13 Nov 2007 08:50:47 +0800
Message-ID: <20071113005047.GA27837@zhen-devel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48301 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755063AbXKMA6J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Nov 2007 19:58:09 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


Remove acpi video debug message.

Signed-off-by: Zhenyu Wang <zhenyu.z.wang@intel.com>
---
 drivers/acpi/video.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index bac956b..9c8c8e6 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1782,9 +1782,6 @@ static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
 	struct input_dev *input;
 	int keycode;
 
-
-	printk("video bus notify\n");
-
 	if (!video)
 		return;
 
-- 
1.5.3.3
