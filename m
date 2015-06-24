From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ACPI / resources: free memory on error in add_region_before()
Date: Wed, 24 Jun 2015 17:30:15 +0300
Message-ID: <20150624143015.GD1702@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:43682 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbbFXOaf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jun 2015 10:30:35 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org

There is a small memory leak on error.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

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
