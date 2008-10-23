From: Len Brown <lenb@kernel.org>
Subject: [PATCH 071/122] ACPI: Attach the ACPI device to the ACPI handle as
 early as possible
Date: Thu, 23 Oct 2008 02:38:45 -0400
Message-ID: <eab4b645769fa2f8703f5a3cb0cc4ac090d347af.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:55856 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203AbYJWGkK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:10 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600F8XIIW92C4@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:08 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Zhang Rui <rui.zhang@intel.com>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Attach the ACPI device to the ACPI handle as early as possible so that OS
can get the corresponding ACPI device by the acpi handle in the course
of getting the power/wakeup/performance flags.

http://bugzilla.kernel.org/show_bug.cgi?id=8049
http://bugzilla.kernel.org/show_bug.cgi?id=11000

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 308ddb1..ad06798 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1253,6 +1253,16 @@ acpi_add_single_object(struct acpi_device **child,
 	acpi_device_set_id(device, parent, handle, type);
 
 	/*
+	 * The ACPI device is attached to acpi handle before getting
+	 * the power/wakeup/peformance flags. Otherwise OS can't get
+	 * the corresponding ACPI device by the acpi handle in the course
+	 * of getting the power/wakeup/performance flags.
+	 */
+	result = acpi_device_set_context(device, type);
+	if (result)
+		goto end;
+
+	/*
 	 * Power Management
 	 * ----------------
 	 */
@@ -1282,8 +1292,6 @@ acpi_add_single_object(struct acpi_device **child,
 			goto end;
 	}
 
-	if ((result = acpi_device_set_context(device, type)))
-		goto end;
 
 	result = acpi_device_register(device, parent);
 
-- 
1.5.5.1

