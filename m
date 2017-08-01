From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH 3/3] ACPI / APEI: HEST: Don't set hest_disable if table not found
Date: Tue,  1 Aug 2017 14:36:08 +0100
Message-ID: <20170801133608.21017-4-punit.agrawal@arm.com>
References: <20170801133608.21017-1-punit.agrawal@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170801133608.21017-1-punit.agrawal@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Punit Agrawal <punit.agrawal@arm.com>, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

During initialisation, the driver sets hest_disable to 1 if the HEST
table is not found. This value is checked during the GHES driver
initialisation and in turn leads to a message such as -

[    3.460067] GHES: HEST is not enabled!

being output in the bootlog. The message appears even on systems that do
not have the HEST table or APEI support.

Update the initialisation to skip setting hest_disable when the HEST
table is not found.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Borislav Petkov <bp@suse.de>
---
 drivers/acpi/apei/hest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 456b488eb1df..3aa1b34459b6 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -233,7 +233,7 @@ void __init acpi_hest_init(void)
 	status = acpi_get_table(ACPI_SIG_HEST, 0,
 				(struct acpi_table_header **)&hest_tab);
 	if (status == AE_NOT_FOUND)
-		goto err;
+		return;
 	else if (ACPI_FAILURE(status)) {
 		const char *msg = acpi_format_exception(status);
 		pr_err(HEST_PFX "Failed to get table, %s\n", msg);
-- 
2.11.0
