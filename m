From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 6/7] ACPI-APEI-HEST: Reduce the scope for a variable in
 acpi_hest_init()
Date: Mon, 5 Sep 2016 22:22:07 +0200
Message-ID: <3dcbbc1b-7af3-4d5f-2851-88c115c5c459@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <9834b713-2c7b-ad6d-76a5-b1db40f561fc@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <9834b713-2c7b-ad6d-76a5-b1db40f561fc@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, trivial@kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Sep 2016 21:50:34 +0200

Move the definition for the local variable "ghes_count" into an if branch
so that the corresponding setting will only be performed if GHES could be
enabled by this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/apei/hest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index ddff1b1..0e629c0 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -216,7 +216,6 @@ void __init acpi_hest_init(void)
 {
 	acpi_status status;
 	int rc = -ENODEV;
-	unsigned int ghes_count = 0;
 
 	if (hest_disable) {
 		pr_info(HEST_PFX "Table parsing disabled.\n");
@@ -238,6 +237,8 @@ void __init acpi_hest_init(void)
 		apei_hest_parse(hest_parse_cmc, NULL);
 
 	if (!ghes_disable) {
+		unsigned int ghes_count = 0;
+
 		rc = apei_hest_parse(hest_parse_ghes_count, &ghes_count);
 		if (rc)
 			goto disable_hest;
-- 
2.10.0

