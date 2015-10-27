From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v3 1/2] nfit: in acpi_nfit_init, break on a 0-length table
Date: Tue, 27 Oct 2015 16:58:26 -0600
Message-ID: <1445986707-15395-2-git-send-email-vishal.l.verma@intel.com>
References: <1445986707-15395-1-git-send-email-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8291 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754326AbbJ0W6v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Oct 2015 18:58:51 -0400
In-Reply-To: <1445986707-15395-1-git-send-email-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>, Elliott Robert <elliott@hpe.com>, Toshi Kani <toshi.kani@hpe.com>

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
 drivers/acpi/nfit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index c1b8d03..35b4b56 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -335,6 +335,12 @@ static void *add_table(struct acpi_nfit_desc *acpi_desc, void *table,
 		return NULL;
 
 	hdr = table;
+	if (!hdr->length) {
+		dev_warn(dev, "found a zero length table '%d' parsing nfit\n",
+			hdr->type);
+		return NULL;
+	}
+
 	switch (hdr->type) {
 	case ACPI_NFIT_TYPE_SYSTEM_ADDRESS:
 		if (!add_spa(acpi_desc, table))
-- 
2.4.3

