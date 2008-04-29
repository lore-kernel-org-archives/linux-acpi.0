From: Len Brown <lenb@kernel.org>
Subject: [PATCH 011/171] #if 0 acpi/bay.c:eject_removable_drive()
Date: Tue, 29 Apr 2008 04:44:02 -0400
Message-ID: <df44017037957f7d33e916b8864bde3d3daee772.1209457069.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:45231 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760180AbYD2Iou (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:44:50 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Adrian Bunk <bunk@kernel.org>, Len Brown <len.brown@intel.com>

From: Adrian Bunk <bunk@kernel.org>

This patch #if 0's the unused eject_removable_drive().

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bay.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index 1fa8681..d2fc941 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
@@ -201,6 +201,7 @@ static int is_ejectable_bay(acpi_handle handle)
 	return 0;
 }
 
+#if 0
 /**
  * eject_removable_drive - try to eject this drive
  * @dev : the device structure of the drive
@@ -225,6 +226,7 @@ int eject_removable_drive(struct device *dev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(eject_removable_drive);
+#endif  /*  0  */
 
 static int acpi_bay_add_fs(struct bay *bay)
 {
-- 
1.5.5.1.99.gf0ec4

