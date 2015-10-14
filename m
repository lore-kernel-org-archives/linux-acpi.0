From: Al Stone <al.stone@linaro.org>
Subject: [PATCH 1/4] ACPI: workaround x86 firmware using reserved MADT subtable IDs
Date: Wed, 14 Oct 2015 15:26:22 -0600
Message-ID: <1444857985-28844-2-git-send-email-al.stone@linaro.org>
References: <1444857985-28844-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37600 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108AbbJNV0j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Oct 2015 17:26:39 -0400
Received: by igbhv6 with SMTP id hv6so27296757igb.0
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2015 14:26:38 -0700 (PDT)
In-Reply-To: <1444857985-28844-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Al Stone <al.stone@linaro.org>

According to the ACPI specification, version 6.0, table 5-46,  MADT
subtable IDs in the range of 0x10-0x7f are reserved for possible
future use by the specification.  The function bad_madt_entry() tries
to enforce the spec, but it turns out there are x86 machines that use
0x7f even though they should not.

So, continue to enforce this rule for arm64, since we're starting out
fresh, but relax it for systems already out there so we don't keep them
from booting.

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/tables.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index a2ed38a..e5cfd72 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -413,9 +413,17 @@ static int __init bad_madt_entry(struct acpi_table_header *table,
 	}
 
 	if (entry->type >= ms->num_types) {
-		pr_err("undefined MADT subtable type for FADT %d.%d: %d (length %d)\n",
-		       major, minor, entry->type, entry->length);
-		return 1;
+		if (IS_ENABLED(CONFIG_ARM64)) {
+			/* Enforce this stricture on arm64... */
+			pr_err("undefined MADT subtable type for FADT %d.%d: %d (length %d)\n",
+			       major, minor, entry->type, entry->length);
+			return 1;
+		} else {
+			/* ... but relax it on legacy systems so they boot */
+			pr_warn("undefined MADT subtable type for FADT %d.%d: %d (length %d)\n",
+			         major, minor, entry->type, entry->length);
+			return 0;
+		}
 	}
 
 	/* verify that the table is allowed for this version of the spec */
-- 
2.4.3

