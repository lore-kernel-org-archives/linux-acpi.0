From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH] libnvdimm, nfit: Use ACPI_SIG_NFIT instead of hard coded string
Date: Thu, 21 Jan 2016 20:32:10 +0800
Message-ID: <1453379530-21727-1-git-send-email-jlee@suse.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35578 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759214AbcAUMcr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jan 2016 07:32:47 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Len Brown <lenb@kernel.org>

It's minor but that's still better to use ACPI_SIG_NFIT instead of hard
coded string.

Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
---
 drivers/acpi/nfit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index aa45d48..9fb1a6a 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -1739,7 +1739,7 @@ static int acpi_nfit_add(struct acpi_device *adev)
 	acpi_size sz;
 	int rc;
 
-	status = acpi_get_table_with_size("NFIT", 0, &tbl, &sz);
+	status = acpi_get_table_with_size(ACPI_SIG_NFIT, 0, &tbl, &sz);
 	if (ACPI_FAILURE(status)) {
 		/* This is ok, we could have an nvdimm hotplugged later */
 		dev_dbg(dev, "failed to find NFIT at startup\n");
-- 
2.1.4

