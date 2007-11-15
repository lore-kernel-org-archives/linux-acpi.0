From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [Patch_4/7] :Change the function interface for throttling
	control via PTC
Date: Thu, 15 Nov 2007 16:41:48 +0800
Message-ID: <1195116108.6817.13.camel@yakui_zhao.sh.intel.com>
References: <1191814518.3830.2.camel@yakui_zhao.sh.intel.com>
	 <200710092343.40843.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8575 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756229AbXKOIb2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Nov 2007 03:31:28 -0500
In-Reply-To: <200710092343.40843.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Subject: ACPI : Change the function interface for throttling control via PTC
>From : Zhao Yakui <yakui.zhao@intel.com>

Change the function interface for throttling control via PTC.
The following functions are concerned:
acpi_read_throttling_status()
acpi_write_throttling_state()
acpi_get_throttling_value()
acpi_get_throttling_state()

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>

---
 drivers/acpi/processor_throttling.c |   60 +++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 21 deletions(-)

Index: linux-2.6.24-rc1/drivers/acpi/processor_throttling.c
===================================================================
--- linux-2.6.24-rc1.orig/drivers/acpi/processor_throttling.c
+++ linux-2.6.24-rc1/drivers/acpi/processor_throttling.c
@@ -376,16 +376,23 @@ static int acpi_processor_get_throttling
 	return 0;
 }
 
-static int acpi_read_throttling_status(struct acpi_processor_throttling
-				       *throttling)
+static int acpi_read_throttling_status(struct acpi_processor *pr,
+					acpi_integer *value)
 {
-	int value = -1;
+	u64 ptc_value;
+	struct acpi_processor_throttling *throttling;
+	int ret = -1;
+
+	throttling = &pr->throttling;
 	switch (throttling->status_register.space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_IO:
+		ptc_value = 0;
 		acpi_os_read_port((acpi_io_address) throttling->status_register.
-				  address, &value,
+				  address, (u32 *) &ptc_value,
 				  (u32) throttling->status_register.bit_width *
 				  8);
+		*value = (acpi_integer) ptc_value;
+		ret = 0;
 		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
 		printk(KERN_ERR PREFIX
@@ -395,18 +402,22 @@ static int acpi_read_throttling_status(s
 		printk(KERN_ERR PREFIX "Unknown addr space %d\n",
 		       (u32) (throttling->status_register.space_id));
 	}
-	return value;
+	return ret;
 }
 
-static int acpi_write_throttling_state(struct acpi_processor_throttling
-				       *throttling, int value)
+static int acpi_write_throttling_state(struct acpi_processor *pr,
+				acpi_integer value)
 {
+	u64 ptc_value;
+	struct acpi_processor_throttling *throttling;
 	int ret = -1;
 
+	throttling = &pr->throttling;
 	switch (throttling->control_register.space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_IO:
+		ptc_value = value;
 		acpi_os_write_port((acpi_io_address) throttling->
-				   control_register.address, value,
+				   control_register.address, (u32) ptc_value,
 				   (u32) throttling->control_register.
 				   bit_width * 8);
 		ret = 0;
@@ -422,7 +433,8 @@ static int acpi_write_throttling_state(s
 	return ret;
 }
 
-static int acpi_get_throttling_state(struct acpi_processor *pr, int value)
+static int acpi_get_throttling_state(struct acpi_processor *pr,
+				acpi_integer value)
 {
 	int i;
 
@@ -438,22 +450,26 @@ static int acpi_get_throttling_state(str
 	return i;
 }
 
-static int acpi_get_throttling_value(struct acpi_processor *pr, int state)
+static int acpi_get_throttling_value(struct acpi_processor *pr,
+			int state, acpi_integer *value)
 {
-	int value = -1;
+	int ret = -1;
+
 	if (state >= 0 && state <= pr->throttling.state_count) {
 		struct acpi_processor_tx_tss *tx =
 		    (struct acpi_processor_tx_tss *)&(pr->throttling.
 						      states_tss[state]);
-		value = tx->control;
+		*value = tx->control;
+		ret = 0;
 	}
-	return value;
+	return ret;
 }
 
 static int acpi_processor_get_throttling_ptc(struct acpi_processor *pr)
 {
 	int state = 0;
-	u32 value = 0;
+	int ret;
+	acpi_integer value;
 
 	if (!pr)
 		return -EINVAL;
@@ -463,8 +479,9 @@ static int acpi_processor_get_throttling
 
 	pr->throttling.state = 0;
 	local_irq_disable();
-	value = acpi_read_throttling_status(&pr->throttling);
-	if (value >= 0) {
+	value = 0;
+	ret = acpi_read_throttling_status(pr, &value);
+	if (ret >= 0) {
 		state = acpi_get_throttling_state(pr, value);
 		pr->throttling.state = state;
 	}
@@ -588,7 +605,8 @@ static int acpi_processor_set_throttling
 static int acpi_processor_set_throttling_ptc(struct acpi_processor *pr,
 					     int state)
 {
-	u32 value = 0;
+	int ret;
+	acpi_integer value;
 
 	if (!pr)
 		return -EINVAL;
@@ -606,10 +624,10 @@ static int acpi_processor_set_throttling
 		return -EPERM;
 
 	local_irq_disable();
-
-	value = acpi_get_throttling_value(pr, state);
-	if (value >= 0) {
-		acpi_write_throttling_state(&pr->throttling, value);
+	value = 0;
+	ret = acpi_get_throttling_value(pr, state, &value);
+	if (ret >= 0) {
+		acpi_write_throttling_state(pr, value);
 		pr->throttling.state = state;
 	}
 	local_irq_enable();
