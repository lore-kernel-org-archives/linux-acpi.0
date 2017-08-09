From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 2/4] ACPI-APEI-HEST: Use kmalloc_array() in
 hest_ghes_dev_register()
Date: Wed, 9 Aug 2017 20:02:50 +0200
Message-ID: <c1abc766-db53-2b55-bd3f-a0d64df481b8@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <9834b713-2c7b-ad6d-76a5-b1db40f561fc@users.sourceforge.net>
 <CAJZ5v0hcD8pi8y+jAtF70cJp8uYyUdOeDJKuR3z=JpB6Z_Qnfw@mail.gmail.com>
 <06ab72bc-6e00-1829-f1bf-67f0a31aff38@users.sourceforge.net>
 <CAJZ5v0i5EW1UpLfaogyD-s4P4vXdgWndwjOpF5ykPDXE=eZVSA@mail.gmail.com>
 <9f6e5436-e550-b64c-db39-b9da668766b0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:61264 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751944AbdHISDE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Aug 2017 14:03:04 -0400
In-Reply-To: <9f6e5436-e550-b64c-db39-b9da668766b0@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Hanjun Guo <hanjun.guo@linaro.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, trivial@kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Sep 2016 20:55:33 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus reuse the corresponding function "kmalloc_array".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data type by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/apei/hest.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 832a930e98f2..24d1d3cd3371 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -195,7 +195,9 @@ static int __init hest_ghes_dev_register(unsigned int ghes_count)
 	struct ghes_arr ghes_arr;
 
 	ghes_arr.count = 0;
-	ghes_arr.ghes_devs = kmalloc(sizeof(void *) * ghes_count, GFP_KERNEL);
+	ghes_arr.ghes_devs = kmalloc_array(ghes_count,
+					   sizeof(*ghes_arr.ghes_devs),
+					   GFP_KERNEL);
 	if (!ghes_arr.ghes_devs)
 		return -ENOMEM;
 
-- 
2.13.4

