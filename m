From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 3/3] ACPI / cpuidle: avoid assigning signed errno to acpi_status
Date: Tue, 25 Nov 2014 14:48:50 +0000
Message-ID: <1416926930-792-4-git-send-email-sudeep.holla@arm.com>
References: <1416926930-792-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:36591 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751166AbaKYPyn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Nov 2014 10:54:43 -0500
In-Reply-To: <1416926930-792-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

It's incorrect to assign a signed value to an unsigned acpi_status
variable. This patch fixes it by using a signed integer to return
error values.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/processor_idle.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 380b4b43f361..499536504698 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -334,10 +334,10 @@ static int acpi_processor_get_power_info_default(struct acpi_processor *pr)
 
 static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 {
-	acpi_status status = 0;
+	acpi_status status;
 	u64 count;
 	int current_count;
-	int i;
+	int i, ret = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *cst;
 
@@ -358,7 +358,7 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 	/* There must be at least 2 elements */
 	if (!cst || (cst->type != ACPI_TYPE_PACKAGE) || cst->package.count < 2) {
 		printk(KERN_ERR PREFIX "not enough elements in _CST\n");
-		status = -EFAULT;
+		ret = -EFAULT;
 		goto end;
 	}
 
@@ -367,7 +367,7 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 	/* Validate number of power states. */
 	if (count < 1 || count != cst->package.count - 1) {
 		printk(KERN_ERR PREFIX "count given by _CST is not valid\n");
-		status = -EFAULT;
+		ret = -EFAULT;
 		goto end;
 	}
 
@@ -489,12 +489,12 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 
 	/* Validate number of power states discovered */
 	if (current_count < 2)
-		status = -EFAULT;
+		ret = -EFAULT;
 
       end:
 	kfree(buffer.pointer);
 
-	return status;
+	return ret;
 }
 
 static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
@@ -1109,7 +1109,7 @@ static int acpi_processor_registered;
 
 int acpi_processor_power_init(struct acpi_processor *pr)
 {
-	acpi_status status = 0;
+	acpi_status status;
 	int retval;
 	struct cpuidle_device *dev;
 	static int first_run;
-- 
1.9.1

