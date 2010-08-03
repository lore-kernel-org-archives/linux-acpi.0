From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH] ACPI: acpi_pad: fix uninitialized variable warning
Date: Tue,  3 Aug 2010 15:17:32 -0400
Message-ID: <1280863052-31538-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:46454 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755676Ab0HCT0u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Aug 2010 15:26:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trivial@kernel.org
Cc: linux-acpi@vger.kernel.org

drivers/acpi/acpi_pad.c:432: warning: 'num_cpus' may be used
uninitialized in this function

num_cpus is set by the call to acpi_pad_pur()

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
---
 drivers/acpi/acpi_pad.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index b76848c..69e2593 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -429,7 +429,7 @@ static void acpi_pad_ost(acpi_handle handle, int stat,
 
 static void acpi_pad_handle_notify(acpi_handle handle)
 {
-	int num_cpus;
+	int uninitialized_var(num_cpus);
 	uint32_t idle_cpus;
 
 	mutex_lock(&isolated_cpus_lock);
-- 
1.7.2

