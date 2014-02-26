From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 3/8] PNPACPI: remove ids that does not comply with the ACPI PNP id rule
Date: Wed, 26 Feb 2014 17:11:09 +0800
Message-ID: <1393405874-3266-4-git-send-email-rui.zhang@intel.com>
References: <1393405874-3266-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393405874-3266-1-git-send-email-rui.zhang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bhelgaas@google.com, matthew.garrett@nebula.com, rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

The PNPACPI white list just copies all the ids from all the
struct pnp_device_id instances, but some of them do not
comply with the ACPI PNP id rule (3 Alpha Charactors + 4 Hex numbers).

For those ids, the coressponding devices will never be enumerated
via ACPI, so it is safe to remove those ids from the PNPACPI white list.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/pnp/pnpacpi/core.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 76df7fc..d47fbdf 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -74,10 +74,6 @@ static const struct acpi_device_id acpi_pnp_device_ids[]= {
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
