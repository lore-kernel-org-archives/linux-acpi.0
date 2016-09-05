From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/7] ACPI-APEI-HEST: Move an assignment in
 hest_ghes_dev_register()
Date: Mon, 5 Sep 2016 22:18:21 +0200
Message-ID: <c4956d3c-1b02-468c-686e-acdf3eaf20be@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <9834b713-2c7b-ad6d-76a5-b1db40f561fc@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:51676 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932368AbcIEUSd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Sep 2016 16:18:33 -0400
In-Reply-To: <9834b713-2c7b-ad6d-76a5-b1db40f561fc@users.sourceforge.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, trivial@kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Sep 2016 21:15:22 +0200

Move one assignment for a data structure member in one local variable
so that its setting will only be performed after a corresponding memory
allocation succeeded by this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/apei/hest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index a852237..26f5e78 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -185,13 +185,13 @@ static int __init hest_ghes_dev_register(unsigned int ghes_count)
 	int rc, i;
 	struct ghes_arr ghes_arr;
 
-	ghes_arr.count = 0;
 	ghes_arr.ghes_devs = kmalloc_array(ghes_count,
 					   sizeof(*ghes_arr.ghes_devs),
 					   GFP_KERNEL);
 	if (!ghes_arr.ghes_devs)
 		return -ENOMEM;
 
+	ghes_arr.count = 0;
 	rc = apei_hest_parse(hest_parse_ghes, &ghes_arr);
 	if (rc)
 		goto err;
-- 
2.10.0

