From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/2] ACPI/tables: Correct the wrong count increasing
Date: Tue,  9 Aug 2016 07:01:50 +0800
Message-ID: <1470697311-1292-1-git-send-email-bhe@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52304 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbcHHXB6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Aug 2016 19:01:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Baoquan He <bhe@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

The current code always increases the count in the 1st element of
array proc[].

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 9f0ad6e..34d45bb 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -281,7 +281,7 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 			     proc[i].handler(entry, table_end))
 				return -EINVAL;
 
-			proc->count++;
+			proc[i]->count++;
 			break;
 		}
 		if (i != proc_num)
-- 
2.5.5

