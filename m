From: Linda Knippers <linda.knippers@hpe.com>
Subject: [PATCH 1/3] nfit: Account for table size length variation
Date: Fri, 20 Nov 2015 19:05:47 -0500
Message-ID: <e65332cc9dbb7eff02f739aa5ba357d4097b4e6a.1448045168.git.linda.knippers@hpe.com>
References: <cover.1448045168.git.linda.knippers@hpe.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t4623.austin.hp.com ([15.73.212.78]:59901 "EHLO
	g2t4623.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759991AbbKUAGR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Nov 2015 19:06:17 -0500
In-Reply-To: <cover.1448045168.git.linda.knippers@hpe.com>
In-Reply-To: <cover.1448045168.git.linda.knippers@hpe.com>
References: <cover.1448045168.git.linda.knippers@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc: linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, toshi.kani@hpe.com, elliott@hpe.com, rafael.j.wysocki@intel.com

The size of NFIT tables don't necessarily match the size of the
data structures that we use for them.  For example, the NVDIMM
Control Region Structure table is shorter for a device with
no block control windows than for a device with block control windows.
Other tables, such as Flush Hint Address Structure and the Interleave
Structure are variable length by definition.

Account for the size difference when comparing table entries by
using the actual table size from the table header if it's less
than the structure size.  

Signed-off-by: Linda Knippers <linda.knippers@hpe.com>
---
 drivers/acpi/nfit.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index f7dab53..710092a 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -235,9 +235,13 @@ static bool add_spa(struct acpi_nfit_desc *acpi_desc,
 {
 	struct device *dev = acpi_desc->dev;
 	struct nfit_spa *nfit_spa;
+	size_t length = sizeof(*spa);
+
+	if (length > spa->header.length)
+		length = spa->header.length;
 
 	list_for_each_entry(nfit_spa, &prev->spas, list) {
-		if (memcmp(nfit_spa->spa, spa, sizeof(*spa)) == 0) {
+		if (memcmp(nfit_spa->spa, spa, length) == 0) {
 			list_move_tail(&nfit_spa->list, &acpi_desc->spas);
 			return true;
 		}
@@ -261,9 +265,13 @@ static bool add_memdev(struct acpi_nfit_desc *acpi_desc,
 {
 	struct device *dev = acpi_desc->dev;
 	struct nfit_memdev *nfit_memdev;
+	size_t length = sizeof(*memdev);
+
+	if (length > memdev->header.length)
+		length = memdev->header.length;
 
 	list_for_each_entry(nfit_memdev, &prev->memdevs, list)
-		if (memcmp(nfit_memdev->memdev, memdev, sizeof(*memdev)) == 0) {
+		if (memcmp(nfit_memdev->memdev, memdev, length) == 0) {
 			list_move_tail(&nfit_memdev->list, &acpi_desc->memdevs);
 			return true;
 		}
@@ -286,9 +294,13 @@ static bool add_dcr(struct acpi_nfit_desc *acpi_desc,
 {
 	struct device *dev = acpi_desc->dev;
 	struct nfit_dcr *nfit_dcr;
+	size_t length = sizeof(*dcr);
+
+	if (length > dcr->header.length)
+		length = dcr->header.length;
 
 	list_for_each_entry(nfit_dcr, &prev->dcrs, list)
-		if (memcmp(nfit_dcr->dcr, dcr, sizeof(*dcr)) == 0) {
+		if (memcmp(nfit_dcr->dcr, dcr, length) == 0) {
 			list_move_tail(&nfit_dcr->list, &acpi_desc->dcrs);
 			return true;
 		}
@@ -310,9 +322,13 @@ static bool add_bdw(struct acpi_nfit_desc *acpi_desc,
 {
 	struct device *dev = acpi_desc->dev;
 	struct nfit_bdw *nfit_bdw;
+	size_t length = sizeof(*bdw);
+
+	if (length > bdw->header.length)
+		length = bdw->header.length;
 
 	list_for_each_entry(nfit_bdw, &prev->bdws, list)
-		if (memcmp(nfit_bdw->bdw, bdw, sizeof(*bdw)) == 0) {
+		if (memcmp(nfit_bdw->bdw, bdw, length) == 0) {
 			list_move_tail(&nfit_bdw->list, &acpi_desc->bdws);
 			return true;
 		}
@@ -334,9 +350,13 @@ static bool add_idt(struct acpi_nfit_desc *acpi_desc,
 {
 	struct device *dev = acpi_desc->dev;
 	struct nfit_idt *nfit_idt;
+	size_t length = sizeof(*idt);
+
+	if (length > idt->header.length)
+		length = idt->header.length;
 
 	list_for_each_entry(nfit_idt, &prev->idts, list)
-		if (memcmp(nfit_idt->idt, idt, sizeof(*idt)) == 0) {
+		if (memcmp(nfit_idt->idt, idt, length) == 0) {
 			list_move_tail(&nfit_idt->list, &acpi_desc->idts);
 			return true;
 		}
@@ -358,9 +378,13 @@ static bool add_flush(struct acpi_nfit_desc *acpi_desc,
 {
 	struct device *dev = acpi_desc->dev;
 	struct nfit_flush *nfit_flush;
+	size_t length = sizeof(*flush);
+
+	if (length > flush->header.length)
+		length = flush->header.length;
 
 	list_for_each_entry(nfit_flush, &prev->flushes, list)
-		if (memcmp(nfit_flush->flush, flush, sizeof(*flush)) == 0) {
+		if (memcmp(nfit_flush->flush, flush, length) == 0) {
 			list_move_tail(&nfit_flush->list, &acpi_desc->flushes);
 			return true;
 		}
-- 
1.8.3.1

