From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 1/2] ACPI/tables: Correct the wrong count increasing
Date: Tue, 9 Aug 2016 08:30:06 +0800
Message-ID: <20160809003006.GF16660@x1.redhat.com>
References: <1470697311-1292-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59230 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbcHIAaK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Aug 2016 20:30:10 -0400
Content-Disposition: inline
In-Reply-To: <1470697311-1292-1-git-send-email-bhe@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

The current code always increases the count in the 1st element of
array proc[].

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---

v1->v2:
    V1 is a wrong post because I didn't update the tested code to my
    local laptop. Repost with a correct v2.

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
+			proc[i].count++;
 			break;
 		}
 		if (i != proc_num)
-- 
2.5.5

