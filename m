From: Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH v2] ACPI/resource.c: Fix memory leak reg
Date: Mon, 29 Jun 2015 13:40:26 +0530
Message-ID: <1435565426-42571-1-git-send-email-maninder1.s@samsung.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:54348 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbbF2ILf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Jun 2015 04:11:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: pankaj.m@samsung.com, jiang.liu@linux.intel.com, Maninder Singh <maninder1.s@samsung.com>

static analysis gives memory leak error for reg:-
[drivers/acpi/resource.c:663]: (error) Memory leak: reg

free allocated memory for reg in case of error from request_range

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Akhilesh Kumar <akhilesh.k@samsung.com>
---
v1: allocate memory after request_range error checking
v2: free allocated memory in case of error as Suggested by
	Jiang Liu <jiang.liu@linux.intel.com>

 drivers/acpi/resource.c |    4 +++-
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
1.7.9.5

