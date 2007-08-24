From: Len Brown <len.brown@intel.com>
Subject: [PATCH 24/25] make drivers/acpi/scan.c:create_modalias() static
Date: Fri, 24 Aug 2007 03:21:11 -0400
Message-ID: <11879401012161-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
 <11879400762710-git-send-email-len.brown@intel.com>
 <11879400782033-git-send-email-len.brown@intel.com>
 <11879400793131-git-send-email-len.brown@intel.com>
 <11879400794174-git-send-email-len.brown@intel.com>
 <11879400802531-git-send-email-len.brown@intel.com>
 <11879400812208-git-send-email-len.brown@intel.com>
 <11879400823500-git-send-email-len.brown@intel.com>
 <11879400841550-git-send-email-len.brown@intel.com>
 <1187940085345-git-send-email-len.brown@intel.com>
 <1187940086685-git-send-email-len.brown@intel.com>
 <11879400872911-git-send-email-len.brown@intel.com>
 <11879400882727-git-send-email-len.brown@intel.com>
 <11879400892741-git-send-email-len.brown@intel.com>
 <11879400903190-git-send-email-len.brown@intel.com>
 <11879400911609-git-send-email-len.brown@intel.com>
 <11879400921598-git-send-email-len.brown@intel.com>
 <11879400933976-git-send-email-len.brown@intel.com>
 <1187940094867-git-send-email-len.brown@intel.com>
 <11879400951708-git-send-email-len.brown@intel.com>
 <11879400963954-git-send-email-len.brown@intel.com>
 <11879400972603-git-send-email-len.brown@intel.com>
 <11879400984017-git-send-email-len.brown@intel.com>
 <11879401002195-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63728 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762364AbXHXHVm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:42 -0400
In-Reply-To: <11879401002195-git-send-email-len.brown@intel.com>
Message-Id: <29bb7fd39d8976d9d510a9ab79f8942fdcd2b2ea.1187939443.git.len.brown@intel.com>
In-Reply-To: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
References: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Adrian Bunk <bunk@kernel.org>, Len Brown <len.brown@intel.com>

From: Adrian Bunk <bunk@kernel.org>

This patch makes the needlessly global create_modalias() static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index be74347..64620d6 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -35,8 +35,9 @@ struct acpi_device_bus_id{
  * e.g. on a device with hid:IBM0001 and cid:ACPI0001 you get:
  * char *modalias: "acpi:IBM0001:ACPI0001"
 */
-int create_modalias(struct acpi_device *acpi_dev, char *modalias, int size){
-
+static int create_modalias(struct acpi_device *acpi_dev, char *modalias,
+			   int size)
+{
 	int len;
 
 	if (!acpi_dev->flags.hardware_id)
-- 
1.5.3.rc6.17.g1911
