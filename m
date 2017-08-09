From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 3/4] ACPI-APEI-HEST: Move an assignment in
 hest_ghes_dev_register()
Date: Wed, 9 Aug 2017 20:03:48 +0200
Message-ID: <7a0fcfb4-3f47-4031-017a-be078df43ba1@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <9834b713-2c7b-ad6d-76a5-b1db40f561fc@users.sourceforge.net>
 <CAJZ5v0hcD8pi8y+jAtF70cJp8uYyUdOeDJKuR3z=JpB6Z_Qnfw@mail.gmail.com>
 <06ab72bc-6e00-1829-f1bf-67f0a31aff38@users.sourceforge.net>
 <CAJZ5v0i5EW1UpLfaogyD-s4P4vXdgWndwjOpF5ykPDXE=eZVSA@mail.gmail.com>
 <9f6e5436-e550-b64c-db39-b9da668766b0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9f6e5436-e550-b64c-db39-b9da668766b0@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Hanjun Guo <hanjun.guo@linaro.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, trivial@kernel.org
List-Id: linux-acpi@vger.kernel.org

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
index 24d1d3cd3371..94b9bd494c20 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -194,13 +194,13 @@ static int __init hest_ghes_dev_register(unsigned int ghes_count)
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
2.13.4
