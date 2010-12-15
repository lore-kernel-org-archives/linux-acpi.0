From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH] acpi: update return value in EC gpe handler
Date: Wed, 15 Dec 2010 15:47:08 +0800
Message-ID: <1292399228.10384.175.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56000 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753496Ab0LOHmN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Dec 2010 02:42:13 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi <linux-acpi@vger.kernel.org>

EC gpe handler should return ACPI_REENABLE_GPE, so acpi_ev_gpe_dispatch
can clear and reenable the GPE.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---

Len, 

I forgot to update EC gpe handler return value in the series of 
"[PATCH v2 0/8] Minimize ACPICA/linux GPE code divergence".
This is the fix.

 drivers/acpi/ec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e15439a..8a0e907 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -619,7 +619,7 @@ static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
 		wake_up(&ec->wait);
 		ec_check_sci(ec, acpi_ec_read_status(ec));
 	}
-	return ACPI_INTERRUPT_HANDLED;
+	return ACPI_REENABLE_GPE;
 }
 
 /* --------------------------------------------------------------------------


