From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 2/3] ACPI: EC: use BURST mode only for MSI notebooks
Date: Fri, 28 Aug 2009 23:29:44 +0400
Message-ID: <20090828192944.19961.76281.stgit@thinkpad>
References: <20090828192938.19961.63714.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:52885 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752158AbZH1T3n (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 15:29:43 -0400
In-Reply-To: <20090828192938.19961.63714.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 78f8380..829e62e 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -627,7 +627,8 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	if (bits != 8 && acpi_strict)
 		return AE_BAD_PARAMETER;
 
-	acpi_ec_burst_enable(ec);
+	if (EC_FLAGS_MSI)
+		acpi_ec_burst_enable(ec);
 
 	if (function == ACPI_READ) {
 		result = acpi_ec_read(ec, address, &temp);
@@ -648,7 +649,8 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 		}
 	}
 
-	acpi_ec_burst_disable(ec);
+	if (EC_FLAGS_MSI)
+		acpi_ec_burst_disable(ec);
 
 	switch (result) {
 	case -EINVAL:

