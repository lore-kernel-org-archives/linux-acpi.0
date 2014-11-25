From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 2/3] ACPI / processor: remove unused variabled from acpi_processor_power structure
Date: Tue, 25 Nov 2014 14:48:49 +0000
Message-ID: <1416926930-792-3-git-send-email-sudeep.holla@arm.com>
References: <1416926930-792-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:36591 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751107AbaKYPyl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Nov 2014 10:54:41 -0500
In-Reply-To: <1416926930-792-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Few elements in the acpi_processor_power structure are unused. It could
be remnant in the header missed while the code got removed from the
corresponding driver file.

This patch removes those unused variables in the structure declaration.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/acpi/processor.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 8e34af9e1c84..b95dc32a6e6b 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -67,9 +67,6 @@ struct acpi_processor_cx {
 };
 
 struct acpi_processor_power {
-	struct acpi_processor_cx *state;
-	unsigned long bm_check_timestamp;
-	u32 default_state;
 	int count;
 	struct acpi_processor_cx states[ACPI_PROCESSOR_MAX_POWER];
 	int timer_broadcast_on_state;
-- 
1.9.1

