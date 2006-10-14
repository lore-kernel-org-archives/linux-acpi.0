From: Len Brown <len.brown@intel.com>
Subject: [PATCH 2/28] ACPI: ibm_acpi: Remove experimental status for brightness and volume.
Date: Sat, 14 Oct 2006 04:05:43 -0400
Message-ID: <11608131711468-git-send-email-len.brown@intel.com>
References: <11608131691346-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:14872 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1752120AbWJNICu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Oct 2006 04:02:50 -0400
In-Reply-To: <11608131691346-git-send-email-len.brown@intel.com>
Message-Id: <4d6bd5ea4ec4991901a8cf5a586babef68e1fa3f.1160812999.git.len.brown@intel.com>
In-Reply-To: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
References: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
Date: Fri, 22 Sep 2006 12:19:14 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Stefan Schmidt <stefan@datenfreihafen.org>, Len Brown <len.brown@intel.com>

From: Stefan Schmidt <stefan@datenfreihafen.org>

The brightness and volume features from ibm-acpi are stable.
The experimental flag is no longer needed.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Acked-by: Borislav Deianov <borislav@users.sourceforge.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ibm_acpi.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 15fc124..003a987 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -1702,13 +1702,11 @@ #endif
 	 .name = "brightness",
 	 .read = brightness_read,
 	 .write = brightness_write,
-	 .experimental = 1,
 	 },
 	{
 	 .name = "volume",
 	 .read = volume_read,
 	 .write = volume_write,
-	 .experimental = 1,
 	 },
 	{
 	 .name = "fan",
-- 
1.4.3.rc2.g23bed-dirty
