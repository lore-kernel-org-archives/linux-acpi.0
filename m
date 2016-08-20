From: Al Stone <ahs3@redhat.com>
Subject: [PATCH v2 3/3] ACPI: do not report the number of entries ignored by acpi_parse_entries()
Date: Fri, 19 Aug 2016 18:48:13 -0600
Message-ID: <1471654093-6962-4-git-send-email-ahs3@redhat.com>
References: <1471654093-6962-1-git-send-email-ahs3@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755888AbcHTAsV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 Aug 2016 20:48:21 -0400
In-Reply-To: <1471654093-6962-1-git-send-email-ahs3@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ahs3@redhat.com, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

The function acpi_parse_entries_array() has a limiting parameter,
max_entries, which tells the function to stop looking at subtables
once that limit has been reached.  If the limit is reached, it is
reported.  However, the logic is incorrect in that the loop to
examine all subtables will always report that zero subtables have
been ignored since it does not continue once the max_entries have
been reached.

One approach to fixing this would be to correct the logic so that
all subtables are examined, even if we have hit the max_entries, but
without executing all the callback functions.  This could be risky
since we cannot guarantee that no callback will ever have side effects
that another callback depends on to work correctly.

So, the simplest approach is to just remove the part of the error
message that will always be incorrect.

Signed-off-by: Al Stone <ahs3@redhat.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/acpi/tables.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 0d5d17f..984260d 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -304,8 +304,8 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 	}
 
 	if (max_entries && count > max_entries) {
-		pr_warn("[%4.4s:0x%02x] ignored %i entries of %i found\n",
-			id, proc->id, count - max_entries, count);
+		pr_warn("[%4.4s:0x%02x] found the maximum %i entries\n",
+			id, proc->id, count);
 	}
 
 	return (errs_found) ? -EINVAL : count;
-- 
2.7.4

