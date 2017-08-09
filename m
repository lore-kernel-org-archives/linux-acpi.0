From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 4/4] ACPI-APEI-HEST: Reduce the scope for a variable in
 acpi_hest_init()
Date: Wed, 9 Aug 2017 20:04:43 +0200
Message-ID: <a5dd4279-dcc0-30a9-2fc7-5a2800b182e0@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <9834b713-2c7b-ad6d-76a5-b1db40f561fc@users.sourceforge.net>
 <CAJZ5v0hcD8pi8y+jAtF70cJp8uYyUdOeDJKuR3z=JpB6Z_Qnfw@mail.gmail.com>
 <06ab72bc-6e00-1829-f1bf-67f0a31aff38@users.sourceforge.net>
 <CAJZ5v0i5EW1UpLfaogyD-s4P4vXdgWndwjOpF5ykPDXE=eZVSA@mail.gmail.com>
 <9f6e5436-e550-b64c-db39-b9da668766b0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <9f6e5436-e550-b64c-db39-b9da668766b0@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Hanjun Guo <hanjun.guo@linaro.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, trivial@kernel.org
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
index 94b9bd494c20..c0d81387ce18 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -225,7 +225,6 @@ void __init acpi_hest_init(void)
 {
 	acpi_status status;
 	int rc = -ENODEV;
-	unsigned int ghes_count = 0;
 
 	if (hest_disable) {
 		pr_info(HEST_PFX "Table parsing disabled.\n");
@@ -248,6 +247,8 @@ void __init acpi_hest_init(void)
 		goto err;
 
 	if (!ghes_disable) {
+		unsigned int ghes_count = 0;
+
 		rc = apei_hest_parse(hest_parse_ghes_count, &ghes_count);
 		if (rc)
 			goto err;
-- 
2.13.4

