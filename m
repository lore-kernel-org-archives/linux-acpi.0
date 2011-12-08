From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH 04/11] ACPI, APEI, Remove table not found message
Date: Thu,  8 Dec 2011 11:25:43 +0800
Message-ID: <1323314750-8185-5-git-send-email-ying.huang@intel.com>
References: <1323314750-8185-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323314750-8185-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Because APEI tables are optional, these message may confuse users, for
example,

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/599715

Reported-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/apei/einj.c |    5 ++---
 drivers/acpi/apei/erst.c |    5 ++---
 drivers/acpi/apei/hest.c |    5 ++---
 3 files changed, 6 insertions(+), 9 deletions(-)

--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -466,10 +466,9 @@ static int __init einj_init(void)
 
 	status = acpi_get_table(ACPI_SIG_EINJ, 0,
 				(struct acpi_table_header **)&einj_tab);
-	if (status == AE_NOT_FOUND) {
-		pr_info(EINJ_PFX "Table is not found!\n");
+	if (status == AE_NOT_FOUND)
 		return -ENODEV;
-	} else if (ACPI_FAILURE(status)) {
+	else if (ACPI_FAILURE(status)) {
 		const char *msg = acpi_format_exception(status);
 		pr_err(EINJ_PFX "Failed to get table, %s\n", msg);
 		return -EINVAL;
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -1125,10 +1125,9 @@ static int __init erst_init(void)
 
 	status = acpi_get_table(ACPI_SIG_ERST, 0,
 				(struct acpi_table_header **)&erst_tab);
-	if (status == AE_NOT_FOUND) {
-		pr_info(ERST_PFX "Table is not found!\n");
+	if (status == AE_NOT_FOUND)
 		goto err;
-	} else if (ACPI_FAILURE(status)) {
+	else if (ACPI_FAILURE(status)) {
 		const char *msg = acpi_format_exception(status);
 		pr_err(ERST_PFX "Failed to get table, %s\n", msg);
 		rc = -EINVAL;
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -221,10 +221,9 @@ void __init acpi_hest_init(void)
 
 	status = acpi_get_table(ACPI_SIG_HEST, 0,
 				(struct acpi_table_header **)&hest_tab);
-	if (status == AE_NOT_FOUND) {
-		pr_info(HEST_PFX "Table not found.\n");
+	if (status == AE_NOT_FOUND)
 		goto err;
-	} else if (ACPI_FAILURE(status)) {
+	else if (ACPI_FAILURE(status)) {
 		const char *msg = acpi_format_exception(status);
 		pr_err(HEST_PFX "Failed to get table, %s\n", msg);
 		rc = -EINVAL;
