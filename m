From: Al Stone <al.stone@linaro.org>
Subject: [PATCH 3/4] ACPI: workaround FADT always being revision 2
Date: Wed, 14 Oct 2015 15:26:24 -0600
Message-ID: <1444857985-28844-4-git-send-email-al.stone@linaro.org>
References: <1444857985-28844-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:35304 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093AbbJNV0m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Oct 2015 17:26:42 -0400
Received: by iofl186 with SMTP id l186so70219028iof.2
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2015 14:26:41 -0700 (PDT)
In-Reply-To: <1444857985-28844-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Al Stone <al.stone@linaro.org>

In some environments, the FADT revision number is always 2, independent
of any other factors indicating that it may be a newer revision.  So,
we cannot rely on the FADT and MADT revisions being in proper sync.  For
those environments, relax the checking so we only enforce the size check,
even if we do issue warnings on other problems.

If we do not relax the rules, these systems will not boot as they have in
the past.

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/tables.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 3b5ddfb..790d4b0 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -416,7 +416,6 @@ static int __init bad_madt_entry(struct acpi_table_header *table,
 			/* ... but relax it on legacy systems so they boot */
 			pr_warn("undefined version for either FADT %d.%d or MADT %d\n",
 			        major, minor, madt->header.revision);
-			return 0;
 		}
 	}
 
@@ -430,16 +429,41 @@ static int __init bad_madt_entry(struct acpi_table_header *table,
 			/* ... but relax it on legacy systems so they boot */
 			pr_warn("undefined MADT subtable type for FADT %d.%d: %d (length %d)\n",
 			         major, minor, entry->type, entry->length);
-			return 0;
 		}
 	}
 
 	/* verify that the table is allowed for this version of the spec */
 	len = ms->lengths[entry->type];
 	if (!len) {
-		pr_err("MADT subtable %d not defined for FADT %d.%d\n",
-			 entry->type, major, minor);
-		return 1;
+		if (IS_ENABLED(CONFIG_ARM64)) {
+			pr_err("MADT subtable %d not defined for FADT %d.%d\n",
+			       entry->type, major, minor);
+			return 1;
+		} else {
+			pr_warn("MADT subtable %d not defined for FADT %d.%d\n",
+			        entry->type, major, minor);
+		}
+	}
+
+	/*
+	 * When we get this far, we may have issued warnings on either
+	 * a mismatch in FADT/MADT revisions, or have noted that the subtable
+	 * ID is not defined for the MADT revision we're using.  On some
+	 * architectures, this is an error, but for legacy systems, we need
+	 * to push on with other checks of the subtable.
+	 *
+	 * In fact, there are environments where the *only* value the FADT
+	 * revision will ever have is 2, regardless of anything else.  So,
+	 * for those systems to boot, we have to pretend the MADT is the
+	 * latest version to allow all known subtables since we have no way
+	 * to determine what revision it should be.
+	 */
+	if (!IS_ENABLED(CONFIG_ARM64) && major == 2) {
+		ms = spec_info;
+		while (ms->num_types != 0)
+			ms++;
+		ms--;
+		len = ms->lengths[entry->type];
 	}
 
 	/* verify that the length is what we expect */
-- 
2.4.3

