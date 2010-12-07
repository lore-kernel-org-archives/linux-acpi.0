From: "Jan Beulich" <JBeulich@novell.com>
Subject: [PATCH] ACPI/HEST: adjust section selection
Date: Tue, 07 Dec 2010 14:58:44 +0000
Message-ID: <4CFE59B40200007800026703@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: ying.huang@intel.com, linux-acpi@vger.kernel.org

Properly const-, __init-, and __read_mostly-annotate this code.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Cc: Huang Ying <ying.huang@intel.com>

---
 drivers/acpi/apei/hest.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.37-rc5/drivers/acpi/apei/hest.c
+++ 2.6.37-rc5-acpi-hest-sections/drivers/acpi/apei/hest.c
@@ -46,9 +46,9 @@ EXPORT_SYMBOL_GPL(hest_disable);
 
 /* HEST table parsing */
 
-static struct acpi_table_hest *hest_tab;
+static struct acpi_table_hest *__read_mostly hest_tab;
 
-static int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
+static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
 	[ACPI_HEST_TYPE_IA32_CHECK] = -1,	/* need further calculation */
 	[ACPI_HEST_TYPE_IA32_CORRECTED_CHECK] = -1,
 	[ACPI_HEST_TYPE_IA32_NMI] = sizeof(struct acpi_hest_ia_nmi),
@@ -126,7 +126,7 @@ struct ghes_arr {
 	unsigned int count;
 };
 
-static int hest_parse_ghes_count(struct acpi_hest_header *hest_hdr, void *data)
+static int __init hest_parse_ghes_count(struct acpi_hest_header *hest_hdr, void *data)
 {
 	int *count = data;
 
@@ -135,7 +135,7 @@ static int hest_parse_ghes_count(struct 
 	return 0;
 }
 
-static int hest_parse_ghes(struct acpi_hest_header *hest_hdr, void *data)
+static int __init hest_parse_ghes(struct acpi_hest_header *hest_hdr, void *data)
 {
 	struct platform_device *ghes_dev;
 	struct ghes_arr *ghes_arr = data;
@@ -165,7 +165,7 @@ err:
 	return rc;
 }
 
-static int hest_ghes_dev_register(unsigned int ghes_count)
+static int __init hest_ghes_dev_register(unsigned int ghes_count)
 {
 	int rc, i;
 	struct ghes_arr ghes_arr;



