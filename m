From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 4/7] ACPI-APEI-HEST: Rename jump labels in
 hest_ghes_dev_register()
Date: Mon, 5 Sep 2016 22:20:08 +0200
Message-ID: <ddfde37c-65ac-b2e5-9afd-108da4b813fa@users.sourceforge.net>
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
Date: Mon, 5 Sep 2016 21:22:55 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/apei/hest.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 26f5e78..03dd7d3 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -194,14 +194,14 @@ static int __init hest_ghes_dev_register(unsigned int ghes_count)
 	ghes_arr.count = 0;
 	rc = apei_hest_parse(hest_parse_ghes, &ghes_arr);
 	if (rc)
-		goto err;
-out:
+		goto unregister;
+ free_array:
 	kfree(ghes_arr.ghes_devs);
 	return rc;
-err:
+ unregister:
 	for (i = 0; i < ghes_arr.count; i++)
 		platform_device_unregister(ghes_arr.ghes_devs[i]);
-	goto out;
+	goto free_array;
 }
 
 static int __init setup_hest_disable(char *str)
-- 
2.10.0
