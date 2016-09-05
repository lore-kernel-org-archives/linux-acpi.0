From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/7] ACPI-APEI-HEST: Use kmalloc_array() in
 hest_ghes_dev_register()
Date: Mon, 5 Sep 2016 22:17:01 +0200
Message-ID: <99c1e4fd-5fa8-bc22-59b1-e6784806a314@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <9834b713-2c7b-ad6d-76a5-b1db40f561fc@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9834b713-2c7b-ad6d-76a5-b1db40f561fc@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, trivial@kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-acpi@vger.kernel.org

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
index e170885..a852237 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -186,7 +186,9 @@ static int __init hest_ghes_dev_register(unsigned int ghes_count)
 	struct ghes_arr ghes_arr;
 
 	ghes_arr.count = 0;
-	ghes_arr.ghes_devs = kmalloc(sizeof(void *) * ghes_count, GFP_KERNEL);
+	ghes_arr.ghes_devs = kmalloc_array(ghes_count,
+					   sizeof(*ghes_arr.ghes_devs),
+					   GFP_KERNEL);
 	if (!ghes_arr.ghes_devs)
 		return -ENOMEM;
 
-- 
2.10.0
