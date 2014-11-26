From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 2/2] ACPI / table: Count matched and successfully parsed entries without specifying max entries
Date: Wed, 26 Nov 2014 22:01:14 +0800
Message-ID: <1417010474-2399-2-git-send-email-hanjun.guo@linaro.com>
References: <1417010474-2399-1-git-send-email-hanjun.guo@linaro.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:38408 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbaKZOBm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Nov 2014 09:01:42 -0500
Received: by mail-pa0-f44.google.com with SMTP id et14so2926583pad.17
        for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2014 06:01:42 -0800 (PST)
In-Reply-To: <1417010474-2399-1-git-send-email-hanjun.guo@linaro.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

acpi_parse_entries() allows to traverse all available table entries (aka
subtables) by passing max_entries parameter equal to 0, but since its count
variable is only incremented if max_entries is not 0, the function always
returns 0 for max_entries equal to 0.  It would be more useful if it returned
the number of entries matched instead, so make it increment count in that
case too.

Acked-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/tables.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index f1debe9..93b8152 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -224,10 +224,13 @@ acpi_parse_entries(char *id, unsigned long table_size,
 	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
 	       table_end) {
 		if (entry->type == entry_id
-		    && (!max_entries || count++ < max_entries))
+		    && (!max_entries || count < max_entries)) {
 			if (handler(entry, table_end))
 				return -EINVAL;
 
+			count++;
+		}
+
 		/*
 		 * If entry->length is 0, break from this loop to avoid
 		 * infinite loop.
-- 
1.9.1

