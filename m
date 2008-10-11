From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/85] ACPI: Attach the ACPI device to the ACPI handle as early
 as possible
Date: Sat, 11 Oct 2008 02:35:24 -0400
Message-ID: <05afbbf73abcbb4f6fc9fcf0a6cbbea623928a7a.1223706853.git.len.brown@intel.com>
References: <1223707005-26864-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:39131 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbYJKGgu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 02:36:50 -0400
In-reply-to: <1223707005-26864-1-git-send-email-lenb@kernel.org>
In-reply-to: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
References: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Zhang Rui <rui.zhang@intel.com>, Andi Kleen <ak@linux.intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Attach the ACPI device to the ACPI handle as early as possible so that OS
can get the corresponding ACPI device by the acpi handle in the course
of getting the power/wakeup/performance flags.

http://bugzilla.kernel.org/show_bug.cgi?id=8049
http://bugzilla.kernel.org/show_bug.cgi?id=11000

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
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

