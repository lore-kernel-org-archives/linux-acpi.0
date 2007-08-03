From: Len Brown <len.brown@intel.com>
Subject: [PATCH 04/12] sonypi: fix ids member of struct acpi_driver
Date: Fri,  3 Aug 2007 18:33:37 -0400
Message-ID: <11861804292678-git-send-email-len.brown@intel.com>
References: <11861804251625-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28479 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763275AbXHCWdu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Aug 2007 18:33:50 -0400
In-Reply-To: <11861804251625-git-send-email-len.brown@intel.com>
Message-Id: <f7b88ccb63188e775fe02e746c39ed177741cfc7.1186180370.git.len.brown@intel.com>
In-Reply-To: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
References: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Eugene Teo <eugeneteo@kernel.sg>, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Eugene Teo <eugeneteo@kernel.sg>

ids member of struct acpi_driver is of type struct acpi_device_id, not a
character array.

Signed-off-by: Eugene Teo <eugeneteo@kernel.sg>
Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/char/sonypi.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
index 73037a4..aeec67e 100644
--- a/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -1147,10 +1147,15 @@ static int sonypi_acpi_remove(struct acpi_device *device, int type)
 	return 0;
 }
 
+const static struct acpi_device_id sonypi_device_ids[] = {
+	{"SNY6001", 0},
+	{"", 0},
+};
+
 static struct acpi_driver sonypi_acpi_driver = {
 	.name           = "sonypi",
 	.class          = "hkey",
-	.ids            = "SNY6001",
+	.ids            = sonypi_device_ids,
 	.ops            = {
 		           .add = sonypi_acpi_add,
 			   .remove = sonypi_acpi_remove,
-- 
1.5.3.rc3.7.gd58e
