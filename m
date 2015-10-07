From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 1/3] nfit: in acpi_nfit_init, break on a 0-length table
Date: Wed,  7 Oct 2015 15:49:35 -0600
Message-ID: <1444254577-23744-2-git-send-email-vishal.l.verma@intel.com>
References: <1444254577-23744-1-git-send-email-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:54372 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754893AbbJGVt7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Oct 2015 17:49:59 -0400
In-Reply-To: <1444254577-23744-1-git-send-email-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org

If acpi_nfit_init is called (such as from nfit_test), with an nfit table
that has more memory allocated than it needs (and a similarly large
'size' field, add_tables would happily keep adding null SPA Range tables
filling up all available memory.

Make it friendlier by breaking out if a 0-length header is found in any
of the tables.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: <linux-acpi@vger.kernel.org>
Cc: <linux-nvdimm@lists.01.org>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/acpi/nfit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index c1b8d03..ed599d1 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -335,6 +335,9 @@ static void *add_table(struct acpi_nfit_desc *acpi_desc, void *table,
 		return NULL;
 
 	hdr = table;
+	if (!hdr->length)
+		return NULL;
+
 	switch (hdr->type) {
 	case ACPI_NFIT_TYPE_SYSTEM_ADDRESS:
 		if (!add_spa(acpi_desc, table))
-- 
2.4.3

