From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ACPI / resources: fix memory leak on request_range fail path
Date: Mon, 29 Jun 2015 21:17:00 +0100
Message-ID: <1435609020-18695-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34718 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbbF2URI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Jun 2015 16:17:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

static analysis from cppcheck detected a memory leak:
  [drivers/acpi/resource.c:664]: (error) Memory leak: reg

the error path on a failed request_range call should free
reg before returning. Bug introduced in the recent commit
0f1b414d190724617eb1cdd615592fa8cd9d0b50
("ACPI / PNP: Avoid conflicting resource reservations")

Fixes: 0f1b414d19 ("ACPI / PNP: Avoid conflicting resource reservations")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/resource.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index fcb7807..10561ce 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -660,8 +660,10 @@ static int add_region_before(u64 start, u64 end, u8 space_id,
 		return -ENOMEM;
 
 	error = request_range(start, end, space_id, flags, desc);
-	if (error)
+	if (error) {
+		kfree(reg);
 		return error;
+	}
 
 	reg->start = start;
 	reg->end = end;
-- 
2.1.4

