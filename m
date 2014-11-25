From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 1/3] ACPI / processor: remove incorrect comparison of phys_id
Date: Tue, 25 Nov 2014 14:48:48 +0000
Message-ID: <1416926930-792-2-git-send-email-sudeep.holla@arm.com>
References: <1416926930-792-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:36591 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751118AbaKYPym (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Nov 2014 10:54:42 -0500
In-Reply-To: <1416926930-792-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

phys_id in acpi_processor structure is unsigned 32-bit integer,
comparing it with signed value is incorrect.

This patch removes that incorrect comparision in acpi_processor_hotadd_init
as the lone user of this function is already checking for correctness
of phys_id before calling it.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/acpi_processor.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index c4a8a5666298..eaf56f6ce1eb 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -170,9 +170,6 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 	acpi_status status;
 	int ret;
 
-	if (pr->phys_id == -1)
-		return -ENODEV;
-
 	status = acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
 	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_PRESENT))
 		return -ENODEV;
-- 
1.9.1

