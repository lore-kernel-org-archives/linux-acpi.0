From: Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1] ACPI/resource.c: Fixing memory leak for reg
Date: Mon, 29 Jun 2015 12:04:00 +0530
Message-ID: <1435559640-18059-1-git-send-email-maninder1.s@samsung.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:50871 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbbF2Gec (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Jun 2015 02:34:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: pankaj.m@samsung.com, Maninder Singh <maninder1.s@samsung.com>

static analysis gives memory leak error for reg:-
[drivers/acpi/resource.c:663]: (error) Memory leak: reg

Thus to prevent this allocate memory for reg after
request_range error checking.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Akhilesh Kumar <akhilesh.k@samsung.com>
---
 drivers/acpi/resource.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index fcb7807..f942b70 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -655,14 +655,14 @@ static int add_region_before(u64 start, u64 end, u8 space_id,
 	struct reserved_region *reg;
 	int error;
 
-	reg = kmalloc(sizeof(*reg), GFP_KERNEL);
-	if (!reg)
-		return -ENOMEM;
-
 	error = request_range(start, end, space_id, flags, desc);
 	if (error)
 		return error;
 
+	reg = kmalloc(sizeof(*reg), GFP_KERNEL);
+	if (!reg)
+		return -ENOMEM;
+
 	reg->start = start;
 	reg->end = end;
 	list_add_tail(&reg->node, head);
-- 
1.7.9.5

