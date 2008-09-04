From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH]: ACPI : Set 32bit and 64bit waking vector in FCAS table
Date: Thu, 04 Sep 2008 13:51:16 +0800
Message-ID: <1220507476.4007.117.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40675 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619AbYIDFhM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Sep 2008 01:37:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, andi@firstfloor.org

Subject: ACPI : Set 32bit and 64bit waking vector in FCAS table
From: Zhao Yakui <yakui.zhao@intel.com>

    On some laptops only the 64bit waking vecotr is set for ACPI 2.0 FACS.
But when the system is resumed, BIOS will transfer control directly to 
32bit waking vector. In such case the system can't be resumed correctly.
    Maybe it will be more appropriate that both the 32bit and 64bit waking 
vector will be set for the ACPI 2.0 FACS when the system enters the S3 
sleeping state.

 http://bugzilla.kernel.org/show_bug.cgi?id=11368

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/hardware/hwsleep.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/acpi/hardware/hwsleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/hardware/hwsleep.c
+++ linux-2.6/drivers/acpi/hardware/hwsleep.c
@@ -80,14 +80,14 @@ acpi_set_firmware_waking_vector(acpi_phy
 
 	/* Set the vector */
 
-	if ((facs->length < 32) || (!(facs->xfirmware_waking_vector))) {
-		/*
-		 * ACPI 1.0 FACS or short table or optional X_ field is zero
-		 */
-		facs->firmware_waking_vector = (u32) physical_address;
-	} else {
+	/* 32 Bit wakeing vector is always set */
+	facs->firmware_waking_vector = (u32) physical_address;
+
+	if (facs->length >= 32) {
 		/*
-		 * ACPI 2.0 FACS with valid X_ field
+		 * ACPI 2.0 FACS with the valid X_filed. Its length
+		 * will be more than 32 bytes. In such case the 64 bit
+		 * waking vector is also set.
 		 */
 		facs->xfirmware_waking_vector = physical_address;
 	}


