From: "Jan Beulich" <JBeulich@novell.com>
Subject: [PATCH, resend] ACPI/HEST: avoid stack traces when
	 encountering duplicate source IDs
Date: Tue, 07 Dec 2010 14:58:29 +0000
Message-ID: <4CFE59A50200007800026700@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: ying.huang@intel.com, linux-acpi@vger.kernel.org

Rather than trying to create duplicate platform devices, check for
duplication up front.

Generally the kernel doesn't require uniqueness of the source IDs
other than for obtaining unique platform device names (and making log
message non-ambiguous) - therefore, it would be possible to simply
replace eventual duplicate IDs with kernel assigned ones.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Cc: Huang Ying <ying.huang@intel.com>

---
 drivers/acpi/apei/hest.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- linux-2.6.37-rc5/drivers/acpi/apei/hest.c
+++ 2.6.37-rc5-acpi-hest-unique/drivers/acpi/apei/hest.c
@@ -139,6 +139,7 @@ static int hest_parse_ghes(struct acpi_h
 {
 	struct platform_device *ghes_dev;
 	struct ghes_arr *ghes_arr = data;
+	unsigned int i;
 	int rc;
 
 	if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR)
@@ -146,6 +147,16 @@ static int hest_parse_ghes(struct acpi_h
 
 	if (!((struct acpi_hest_generic *)hest_hdr)->enabled)
 		return 0;
+	for (i = 0; i < ghes_arr->count; ++i) {
+		const struct acpi_hest_header *h;
+
+		h = *(void **)dev_get_platdata(&ghes_arr->ghes_devs[i]->dev);
+		if (hest_hdr->source_id == h->source_id) {
+			pr_warn("Duplicate generic error source ID %#x\n",
+				hest_hdr->source_id);
+			return -EEXIST;
+		}
+	}
 	ghes_dev = platform_device_alloc("GHES", hest_hdr->source_id);
 	if (!ghes_dev)
 		return -ENOMEM;



