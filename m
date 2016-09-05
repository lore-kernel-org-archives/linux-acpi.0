From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 7/7] ACPI-APEI-HEST: Rename jump labels in hest_parse_ghes()
Date: Mon, 5 Sep 2016 22:23:13 +0200
Message-ID: <779d937a-068a-a84d-781f-afb1c2ff8a15@users.sourceforge.net>
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
Date: Mon, 5 Sep 2016 21:56:02 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/apei/hest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 0e629c0..d5b75fe 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -167,15 +167,15 @@ static int __init hest_parse_ghes(struct acpi_hest_header *hest_hdr, void *data)
 
 	rc = platform_device_add_data(ghes_dev, &hest_hdr, sizeof(void *));
 	if (rc)
-		goto err;
+		goto put_device;
 
 	rc = platform_device_add(ghes_dev);
 	if (rc)
-		goto err;
+		goto put_device;
 	ghes_arr->ghes_devs[ghes_arr->count++] = ghes_dev;
 
 	return 0;
-err:
+ put_device:
 	platform_device_put(ghes_dev);
 	return rc;
 }
-- 
2.10.0
