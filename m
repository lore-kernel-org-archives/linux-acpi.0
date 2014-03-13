From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V2 03/13] ACPI: remove ids that does not comply with the ACPI PNP id rule
Date: Fri, 14 Mar 2014 00:16:43 +0800
Message-ID: <1394727413-3587-4-git-send-email-rui.zhang@intel.com>
References: <1394727413-3587-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65264 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753776AbaCMQSE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Mar 2014 12:18:04 -0400
In-Reply-To: <1394727413-3587-1-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bhelgaas@google.com, matthew.garrett@nebula.com, rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com, Zhang Rui <rui.zhang@intel.com>

The acpi pnp scan handler id list just copies all the ids from all the
struct pnp_device_id instances, but some of them do not
comply with the ACPI PNP id rule (3 Alpha Charactors + 4 Hex numbers).

For those ids, the coressponding devices will never be enumerated
via ACPI, so it is safe to remove those ids from the PNPACPI white list.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/acpi_pnp.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index edeed1d..db49e9e 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -33,10 +33,6 @@ static const struct acpi_device_id acpi_pnp_device_ids[]= {
 	/* ide	 */
 	{"PNP0600"}, /* Generic ESDI/IDE/ATA compatible hard disk controller */
 	/* ns558 */
-	{"@P@0001"}, /* ALS 100 */
-	{"@P@0020"}, /* ALS 200 */
-	{"@P@1001"}, /* ALS 100+ */
-	{"@P@2001"}, /* ALS 120 */
 	{"ASB16fd"}, /* AdLib NSC16 */
 	{"AZT3001"}, /* AZT1008 */
 	{"CDC0001"}, /* Opl3-SAx */
-- 
1.7.9.5

