From: Len Brown <lenb@kernel.org>
Subject: [PATCH 118/122] panasonic-laptop: fix build
Date: Thu, 23 Oct 2008 02:39:32 -0400
Message-ID: <3e2dab9a1c2deb03c311eb3f83466009147ed4d3.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:38944 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbYJWGoJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:44:09 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600KZWIPH3KY1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:44:07 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

sync with acpi_driver_data(device)
and acpi_evaluate_integer(..., long long)
changes that happened since this driver
was checked in.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/panasonic-laptop.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/panasonic-laptop.c b/drivers/misc/panasonic-laptop.c
index 9aecda5..a2cb598 100644
--- a/drivers/misc/panasonic-laptop.c
+++ b/drivers/misc/panasonic-laptop.c
@@ -252,7 +252,7 @@ static int acpi_pcc_write_sset(struct pcc_acpi *pcc, int func, int val)
 
 static inline int acpi_pcc_get_sqty(struct acpi_device *device)
 {
-	unsigned long s;
+	unsigned long long s;
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE("acpi_pcc_get_sqty");
@@ -500,7 +500,7 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 	struct input_dev *hotk_input_dev = pcc->input_dev;
 	int rc;
 	int key_code, hkey_num;
-	unsigned long result;
+	unsigned long long result;
 
 	ACPI_FUNCTION_TRACE("acpi_pcc_generate_keyinput");
 
@@ -645,7 +645,7 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	pcc->device = device;
 	pcc->handle = device->handle;
 	pcc->num_sifr = num_sifr;
-	acpi_driver_data(device) = pcc;
+	device->driver_data = pcc;
 	strcpy(acpi_device_name(device), ACPI_PCC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_PCC_CLASS);
 
-- 
1.5.5.1

