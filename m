From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [Patch_3/4]:Throttling control uses T-states returned by
	_TSS when _TSS exists
Date: Wed, 07 Nov 2007 20:35:02 +0800
Message-ID: <1194438902.4039.29.camel@yakui_zhao.sh.intel.com>
References: <1191814518.3830.2.camel@yakui_zhao.sh.intel.com>
	 <200710092343.40843.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48992 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753354AbXKGMZZ (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Wed, 7 Nov 2007 07:25:25 -0500
In-Reply-To: <200710092343.40843.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Subject: ACPI : Throttling control uses T-states returned by _TSS when _TSS exists
>From : Zhao Yakui <yakui.zhao@intel.com>

If _TSS exists, throttling control will use the T-states returned by _TSS.
Otherwise the calculated T-states from FADT.duty_width are used. 

When TSS is used , the access width is included in the throttling.
So it is unnecessary that the access bit width is multiplied by 8.
At the same time the bit_offset should be considered for system I/O Access.


Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>

---
 drivers/acpi/processor_throttling.c |  157 +++++++++++++++++++++++-------------
 1 file changed, 103 insertions(+), 54 deletions(-)

Index: linux-2.6.24-rc1/drivers/acpi/processor_throttling.c
===================================================================
--- linux-2.6.24-rc1.orig/drivers/acpi/processor_throttling.c
+++ linux-2.6.24-rc1/drivers/acpi/processor_throttling.c
@@ -130,6 +130,7 @@ static int acpi_processor_get_throttling
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *ptc = NULL;
 	union acpi_object obj = { 0 };
+	struct acpi_processor_throttling *throttling;
 
 	status = acpi_evaluate_object(pr->handle, "_PTC", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
@@ -181,6 +182,22 @@ static int acpi_processor_get_throttling
 	memcpy(&pr->throttling.status_register, obj.buffer.pointer,
 	       sizeof(struct acpi_ptc_register));
 
+	throttling = &pr->throttling;
+
+	if ((throttling->control_register.bit_width +
+		throttling->control_register.bit_offset) > 32) {
+		printk(KERN_ERR PREFIX "Invalid _PTC control register\n");
+		result = -EFAULT;
+		goto end;
+	}
+
+	if ((throttling->status_register.bit_width +
+		throttling->status_register.bit_offset) > 32) {
+		printk(KERN_ERR PREFIX "Invalid _PTC status register\n");
+		result = -EFAULT;
+		goto end;
+	}
+
       end:
 	kfree(buffer.pointer);
 
@@ -375,16 +392,27 @@ static int acpi_processor_get_throttling
 	return 0;
 }
 
-static int acpi_read_throttling_status(struct acpi_processor_throttling
-				       *throttling)
+static int acpi_read_throttling_status(struct acpi_processor *pr,
+						acpi_integer *value)
 {
-	int value = -1;
+	u32 bit_width, bit_offset;
+	u64 ptc_mask;
+	u64 ptc_value;
+	struct acpi_processor_throttling *throttling;
+	int ret = -1;
+
+	throttling = &pr->throttling;
 	switch (throttling->status_register.space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_IO:
+		bit_width = throttling->status_register.bit_width;
+		bit_offset = throttling->status_register.bit_offset;
+
 		acpi_os_read_port((acpi_io_address) throttling->status_register.
-				  address, &value,
-				  (u32) throttling->status_register.bit_width *
-				  8);
+				  address, (u32 *)&ptc_value,
+				  (u32) (bit_width + bit_offset));
+		ptc_mask = (1 << bit_width ) - 1;
+		*value =(acpi_integer)((ptc_value >> bit_offset) & ptc_mask);
+		ret = 0;
 		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
 		printk(KERN_ERR PREFIX
@@ -394,20 +422,30 @@ static int acpi_read_throttling_status(s
 		printk(KERN_ERR PREFIX "Unknown addr space %d\n",
 		       (u32) (throttling->status_register.space_id));
 	}
-	return value;
+	return ret;
 }
 
-static int acpi_write_throttling_state(struct acpi_processor_throttling
-				       *throttling, int value)
+static int acpi_write_throttling_state(struct acpi_processor *pr,
+					 acpi_integer value)
 {
+	u32 bit_width, bit_offset;
+	u64 ptc_value;
+	u64 ptc_mask;
+	struct acpi_processor_throttling *throttling;
 	int ret = -1;
 
+	throttling = &pr->throttling;
 	switch (throttling->control_register.space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_IO:
+		bit_width = throttling->control_register.bit_width;
+		bit_offset = throttling->control_register.bit_offset;
+		ptc_mask = (1 << bit_width) - 1;
+		ptc_value = value & ptc_mask;
+
 		acpi_os_write_port((acpi_io_address) throttling->
-				   control_register.address, value,
-				   (u32) throttling->control_register.
-				   bit_width * 8);
+				   control_register.address,
+				   (u32) (ptc_value << bit_offset),
+				   (u32) (bit_width + bit_offset));
 		ret = 0;
 		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
@@ -421,7 +459,8 @@ static int acpi_write_throttling_state(s
 	return ret;
 }
 
-static int acpi_get_throttling_state(struct acpi_processor *pr, int value)
+static int acpi_get_throttling_state(struct acpi_processor *pr,
+					acpi_integer value)
 {
 	int i;
 
@@ -437,22 +476,25 @@ static int acpi_get_throttling_state(str
 	return i;
 }
 
-static int acpi_get_throttling_value(struct acpi_processor *pr, int state)
+static int acpi_get_throttling_value(struct acpi_processor *pr,
+				int state, acpi_integer *value)
 {
-	int value = -1;
+	int ret = -1;
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
@@ -462,8 +504,8 @@ static int acpi_processor_get_throttling
 
 	pr->throttling.state = 0;
 	local_irq_disable();
-	value = acpi_read_throttling_status(&pr->throttling);
-	if (value >= 0) {
+	ret = acpi_read_throttling_status(pr, &value);
+	if (ret >= 0) {
 		state = acpi_get_throttling_state(pr, value);
 		pr->throttling.state = state;
 	}
@@ -477,6 +519,40 @@ static int acpi_processor_get_throttling
 	return pr->throttling.acpi_processor_get_throttling(pr);
 }
 
+static int acpi_processor_get_fadt_info(struct acpi_processor *pr)
+{
+	int i, step;
+
+	if (!pr->throttling.address) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No throttling register\n"));
+		return -EINVAL;
+	} else if (!pr->throttling.duty_width) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No throttling states\n"));
+		return -EINVAL;
+	}
+	/* TBD: Support duty_cycle values that span bit 4. */
+	else if ((pr->throttling.duty_offset + pr->throttling.duty_width) > 4) {
+		printk(KERN_WARNING PREFIX "duty_cycle spans bit 4\n");
+		return -EINVAL;
+	}
+
+	pr->throttling.state_count = 1 << acpi_gbl_FADT.duty_width;
+
+	/*
+	 * Compute state values. Note that throttling displays a linear power/
+	 * performance relationship (at 50% performance the CPU will consume
+	 * 50% power).  Values are in 1/10th of a percent to preserve accuracy.
+	 */
+
+	step = (1000 / pr->throttling.state_count);
+
+	for (i = 0; i < pr->throttling.state_count; i++) {
+		pr->throttling.states[i].performance = 1000 - step * i;
+		pr->throttling.states[i].power = 1000 - step * i;
+	}
+	return 0;
+}
+
 static int acpi_processor_set_throttling_fadt(struct acpi_processor *pr,
 					      int state)
 {
@@ -553,7 +629,8 @@ static int acpi_processor_set_throttling
 static int acpi_processor_set_throttling_ptc(struct acpi_processor *pr,
 					     int state)
 {
-	u32 value = 0;
+	int ret ;
+	acpi_integer value = 0;
 
 	if (!pr)
 		return -EINVAL;
@@ -572,9 +649,9 @@ static int acpi_processor_set_throttling
 
 	local_irq_disable();
 
-	value = acpi_get_throttling_value(pr, state);
-	if (value >= 0) {
-		acpi_write_throttling_state(&pr->throttling, value);
+	ret = acpi_get_throttling_value(pr, state, &value);
+	if (ret >= 0) {
+		acpi_write_throttling_state(pr, value);
 		pr->throttling.state = state;
 	}
 	local_irq_enable();
@@ -590,8 +667,6 @@ int acpi_processor_set_throttling(struct
 int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 {
 	int result = 0;
-	int step = 0;
-	int i = 0;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "pblk_address[0x%08x] duty_offset[%d] duty_width[%d]\n",
@@ -610,6 +685,8 @@ int acpi_processor_get_throttling_info(s
 		acpi_processor_get_throttling_states(pr) ||
 		acpi_processor_get_platform_limit(pr))
 	{
+		if (acpi_processor_get_fadt_info(pr))
+			return 0;
 		pr->throttling.acpi_processor_get_throttling =
 		    &acpi_processor_get_throttling_fadt;
 		pr->throttling.acpi_processor_set_throttling =
@@ -623,19 +700,6 @@ int acpi_processor_get_throttling_info(s
 
 	acpi_processor_get_tsd(pr);
 
-	if (!pr->throttling.address) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No throttling register\n"));
-		return 0;
-	} else if (!pr->throttling.duty_width) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No throttling states\n"));
-		return 0;
-	}
-	/* TBD: Support duty_cycle values that span bit 4. */
-	else if ((pr->throttling.duty_offset + pr->throttling.duty_width) > 4) {
-		printk(KERN_WARNING PREFIX "duty_cycle spans bit 4\n");
-		return 0;
-	}
-
 	/*
 	 * PIIX4 Errata: We don't support throttling on the original PIIX4.
 	 * This shouldn't be an issue as few (if any) mobile systems ever
@@ -647,21 +711,6 @@ int acpi_processor_get_throttling_info(s
 		return 0;
 	}
 
-	pr->throttling.state_count = 1 << acpi_gbl_FADT.duty_width;
-
-	/*
-	 * Compute state values. Note that throttling displays a linear power/
-	 * performance relationship (at 50% performance the CPU will consume
-	 * 50% power).  Values are in 1/10th of a percent to preserve accuracy.
-	 */
-
-	step = (1000 / pr->throttling.state_count);
-
-	for (i = 0; i < pr->throttling.state_count; i++) {
-		pr->throttling.states[i].performance = step * i;
-		pr->throttling.states[i].power = step * i;
-	}
-
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d throttling states\n",
 			  pr->throttling.state_count));
 
