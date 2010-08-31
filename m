From: "Jan Beulich" <JBeulich@novell.com>
Subject: [PATCH] ACPI/HEST: adjust section selection
Date: Tue, 31 Aug 2010 14:21:14 +0100
Message-ID: <4C7D1DEA0200007800013301@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Properly const-, __init-, and __read_mostly-annotate this code.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

---
 drivers/acpi/apei/hest.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.36-rc3/drivers/acpi/apei/hest.c
+++ 2.6.36-rc3-acpi-hest-sections/drivers/acpi/apei/hest.c
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
 	struct acpi_hest_generic *generic;
 	struct platform_device *ghes_dev;
@@ -162,7 +162,7 @@ err:
 	return rc;
 }
 
-static int hest_ghes_dev_register(unsigned int ghes_count)
+static int __init hest_ghes_dev_register(unsigned int ghes_count)
 {
 	int rc, i;
 	struct ghes_arr ghes_arr;



