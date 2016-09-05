From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 5/7] ACPI-APEI-HEST: Rename jump labels in acpi_hest_init()
Date: Mon, 5 Sep 2016 22:21:04 +0200
Message-ID: <6e09e601-0feb-0a12-0c7b-a7d370d1013f@users.sourceforge.net>
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
Date: Mon, 5 Sep 2016 21:30:06 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/apei/hest.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 03dd7d3..ddff1b1 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -226,12 +226,12 @@ void __init acpi_hest_init(void)
 	status = acpi_get_table(ACPI_SIG_HEST, 0,
 				(struct acpi_table_header **)&hest_tab);
 	if (status == AE_NOT_FOUND)
-		goto err;
+		goto disable_hest;
 	else if (ACPI_FAILURE(status)) {
 		const char *msg = acpi_format_exception(status);
 		pr_err(HEST_PFX "Failed to get table, %s\n", msg);
 		rc = -EINVAL;
-		goto err;
+		goto disable_hest;
 	}
 
 	if (!acpi_disable_cmcff)
@@ -240,14 +240,14 @@ void __init acpi_hest_init(void)
 	if (!ghes_disable) {
 		rc = apei_hest_parse(hest_parse_ghes_count, &ghes_count);
 		if (rc)
-			goto err;
+			goto disable_hest;
 		rc = hest_ghes_dev_register(ghes_count);
 		if (rc)
-			goto err;
+			goto disable_hest;
 	}
 
 	pr_info(HEST_PFX "Table parsing has been initialized.\n");
 	return;
-err:
+ disable_hest:
 	hest_disable = 1;
 }
-- 
2.10.0
