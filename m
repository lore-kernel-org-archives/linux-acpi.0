From: Len Brown <len.brown@intel.com>
Subject: [PATCH 15/77] ACPI: Lindent processor throttling code
Date: Sun, 22 Jul 2007 05:14:00 -0400
Message-ID: <11850957173842-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38395 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762050AbXGVJPT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:19 -0400
In-Reply-To: <11850957162801-git-send-email-len.brown@intel.com>
Message-Id: <ff55a9cebab02403f942121e2f898bb06ecfffbb.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_throttling.c |  140 +++++++++++++++++++----------------
 include/acpi/processor.h            |    7 +-
 2 files changed, 79 insertions(+), 68 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 1bae2e4..3a2e9a6 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -44,18 +44,18 @@
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_throttling");
 
-static int acpi_processor_get_throttling (struct acpi_processor *pr);
-int acpi_processor_set_throttling (struct acpi_processor *pr, int state);
+static int acpi_processor_get_throttling(struct acpi_processor *pr);
+int acpi_processor_set_throttling(struct acpi_processor *pr, int state);
 
 static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 {
 	acpi_status status = 0;
 	unsigned long tpc = 0;
 
-	if(!pr) 
+	if (!pr)
 		return -EINVAL;
 	status = acpi_evaluate_integer(pr->handle, "_TPC", NULL, &tpc);
-	if(ACPI_FAILURE(status) && status != AE_NOT_FOUND){
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TPC"));
 		return -ENODEV;
 	}
@@ -102,7 +102,8 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
 	if ((obj.type != ACPI_TYPE_BUFFER)
 	    || (obj.buffer.length < sizeof(struct acpi_ptc_register))
 	    || (obj.buffer.pointer == NULL)) {
-		printk(KERN_ERR PREFIX "Invalid _PTC data (control_register)\n");
+		printk(KERN_ERR PREFIX
+		       "Invalid _PTC data (control_register)\n");
 		result = -EFAULT;
 		goto end;
 	}
@@ -124,9 +125,9 @@ static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
 	}
 
 	memcpy(&pr->throttling.status_register, obj.buffer.pointer,
-		sizeof(struct acpi_ptc_register));
+	       sizeof(struct acpi_ptc_register));
 
-	end:
+      end:
 	kfree(buffer.pointer);
 
 	return result;
@@ -168,7 +169,9 @@ static int acpi_processor_get_throttling_states(struct acpi_processor *pr)
 
 	for (i = 0; i < pr->throttling.state_count; i++) {
 
-		struct acpi_processor_tx_tss *tx = (struct acpi_processor_tx_tss *) &(pr->throttling.states_tss[i]);
+		struct acpi_processor_tx_tss *tx =
+		    (struct acpi_processor_tx_tss *)&(pr->throttling.
+						      states_tss[i]);
 
 		state.length = sizeof(struct acpi_processor_tx_tss);
 		state.pointer = tx;
@@ -186,7 +189,7 @@ static int acpi_processor_get_throttling_states(struct acpi_processor *pr)
 
 		if (!tx->freqpercentage) {
 			printk(KERN_ERR PREFIX
-				    "Invalid _TSS data: freq is zero\n");
+			       "Invalid _TSS data: freq is zero\n");
 			result = -EFAULT;
 			kfree(pr->throttling.states_tss);
 			goto end;
@@ -198,14 +201,14 @@ static int acpi_processor_get_throttling_states(struct acpi_processor *pr)
 
 	return result;
 }
-static int acpi_processor_get_tsd(struct acpi_processor	*pr)
+static int acpi_processor_get_tsd(struct acpi_processor *pr)
 {
 	int result = 0;
 	acpi_status status = AE_OK;
-	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
-	struct acpi_buffer format = {sizeof("NNNNN"), "NNNNN"};
-	struct acpi_buffer state = {0, NULL};
-	union acpi_object  *tsd = NULL;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_buffer format = { sizeof("NNNNN"), "NNNNN" };
+	struct acpi_buffer state = { 0, NULL };
+	union acpi_object *tsd = NULL;
 	struct acpi_tsd_package *pdomain;
 
 	status = acpi_evaluate_object(pr->handle, "_TSD", NULL, &buffer);
@@ -232,7 +235,7 @@ static int acpi_processor_get_tsd(struct acpi_processor	*pr)
 	state.pointer = pdomain;
 
 	status = acpi_extract_package(&(tsd->package.elements[0]),
-		&format, &state);
+				      &format, &state);
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _TSD data\n"));
 		result = -EFAULT;
@@ -251,7 +254,7 @@ static int acpi_processor_get_tsd(struct acpi_processor	*pr)
 		goto end;
 	}
 
-end:
+      end:
 	kfree(buffer.pointer);
 	return result;
 }
@@ -266,7 +269,6 @@ static int acpi_processor_get_throttling_fadt(struct acpi_processor *pr)
 	u32 duty_mask = 0;
 	u32 duty_value = 0;
 
-
 	if (!pr)
 		return -EINVAL;
 
@@ -306,65 +308,75 @@ static int acpi_processor_get_throttling_fadt(struct acpi_processor *pr)
 	return 0;
 }
 
-static int acpi_read_throttling_status(struct acpi_processor_throttling *throttling)
+static int acpi_read_throttling_status(struct acpi_processor_throttling
+				       *throttling)
 {
 	int value = -1;
 	switch (throttling->status_register.space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_IO:
-		acpi_os_read_port((acpi_io_address)throttling->status_register.address,
-				&value,
-				(u32)throttling->status_register.bit_width*8);
+		acpi_os_read_port((acpi_io_address) throttling->status_register.
+				  address, &value,
+				  (u32) throttling->status_register.bit_width *
+				  8);
 		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
-		printk(KERN_ERR PREFIX "HARDWARE addr space,NOT supported yet\n");
+		printk(KERN_ERR PREFIX
+		       "HARDWARE addr space,NOT supported yet\n");
 		break;
 	default:
 		printk(KERN_ERR PREFIX "Unknown addr space %d\n",
-			(u32) (throttling->status_register.space_id));
+		       (u32) (throttling->status_register.space_id));
 	}
 	return value;
 }
 
-static int acpi_write_throttling_state(struct acpi_processor_throttling *throttling,int value)
+static int acpi_write_throttling_state(struct acpi_processor_throttling
+				       *throttling, int value)
 {
 	int ret = -1;
 
 	switch (throttling->control_register.space_id) {
 	case ACPI_ADR_SPACE_SYSTEM_IO:
-		acpi_os_write_port((acpi_io_address)throttling->control_register.address,
-				value,
-				(u32)throttling->control_register.bit_width*8);
+		acpi_os_write_port((acpi_io_address) throttling->
+				   control_register.address, value,
+				   (u32) throttling->control_register.
+				   bit_width * 8);
 		ret = 0;
 		break;
 	case ACPI_ADR_SPACE_FIXED_HARDWARE:
-		printk(KERN_ERR PREFIX "HARDWARE addr space,NOT supported yet\n");
+		printk(KERN_ERR PREFIX
+		       "HARDWARE addr space,NOT supported yet\n");
 		break;
 	default:
 		printk(KERN_ERR PREFIX "Unknown addr space %d\n",
-			(u32) (throttling->control_register.space_id));
+		       (u32) (throttling->control_register.space_id));
 	}
 	return ret;
 }
 
-static int acpi_get_throttling_state(struct acpi_processor *pr,int value)
+static int acpi_get_throttling_state(struct acpi_processor *pr, int value)
 {
 	int i;
 
 	for (i = 0; i < pr->throttling.state_count; i++) {
-		struct acpi_processor_tx_tss *tx = (struct acpi_processor_tx_tss *) &(pr->throttling.states_tss[i]);
-		if(tx->control == value)
+		struct acpi_processor_tx_tss *tx =
+		    (struct acpi_processor_tx_tss *)&(pr->throttling.
+						      states_tss[i]);
+		if (tx->control == value)
 			break;
 	}
-	if(i > pr->throttling.state_count)
-		i=-1;
+	if (i > pr->throttling.state_count)
+		i = -1;
 	return i;
 }
 
-static int acpi_get_throttling_value(struct acpi_processor *pr,int state)
+static int acpi_get_throttling_value(struct acpi_processor *pr, int state)
 {
 	int value = -1;
-	if(state >=0 && state <= pr->throttling.state_count){
-		struct acpi_processor_tx_tss *tx = (struct acpi_processor_tx_tss *) &(pr->throttling.states_tss[state]);
+	if (state >= 0 && state <= pr->throttling.state_count) {
+		struct acpi_processor_tx_tss *tx =
+		    (struct acpi_processor_tx_tss *)&(pr->throttling.
+						      states_tss[state]);
 		value = tx->control;
 	}
 	return value;
@@ -375,7 +387,6 @@ static int acpi_processor_get_throttling_ptc(struct acpi_processor *pr)
 	int state = 0;
 	u32 value = 0;
 
-
 	if (!pr)
 		return -EINVAL;
 
@@ -385,8 +396,8 @@ static int acpi_processor_get_throttling_ptc(struct acpi_processor *pr)
 	pr->throttling.state = 0;
 	local_irq_disable();
 	value = acpi_read_throttling_status(&pr->throttling);
-	if(value >= 0){
-		state = acpi_get_throttling_state(pr,value);
+	if (value >= 0) {
+		state = acpi_get_throttling_state(pr, value);
 		pr->throttling.state = state;
 	}
 	local_irq_enable();
@@ -394,7 +405,6 @@ static int acpi_processor_get_throttling_ptc(struct acpi_processor *pr)
 	return 0;
 }
 
-
 static int acpi_processor_get_throttling(struct acpi_processor *pr)
 {
 	return pr->throttling.acpi_processor_get_throttling(pr);
@@ -406,7 +416,6 @@ int acpi_processor_set_throttling_fadt(struct acpi_processor *pr, int state)
 	u32 duty_mask = 0;
 	u32 duty_value = 0;
 
-
 	if (!pr)
 		return -EINVAL;
 
@@ -494,9 +503,9 @@ int acpi_processor_set_throttling_ptc(struct acpi_processor *pr, int state)
 
 	local_irq_disable();
 
-	value = acpi_get_throttling_value(pr,state);
-	if(value >=0){ 
-		acpi_write_throttling_state(&pr->throttling,value);
+	value = acpi_get_throttling_value(pr, state);
+	if (value >= 0) {
+		acpi_write_throttling_state(&pr->throttling, value);
 		pr->throttling.state = state;
 	}
 	local_irq_enable();
@@ -506,7 +515,7 @@ int acpi_processor_set_throttling_ptc(struct acpi_processor *pr, int state)
 
 int acpi_processor_set_throttling(struct acpi_processor *pr, int state)
 {
-	return pr->throttling.acpi_processor_set_throttling(pr,state);
+	return pr->throttling.acpi_processor_set_throttling(pr, state);
 }
 
 int acpi_processor_get_throttling_info(struct acpi_processor *pr)
@@ -518,7 +527,6 @@ int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 	int no_tss = 0;
 	int no_tsd = 0;
 
-
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "pblk_address[0x%08x] duty_offset[%d] duty_width[%d]\n",
 			  pr->throttling.address,
@@ -533,12 +541,16 @@ int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 	no_tss = acpi_processor_get_throttling_states(pr);
 	no_tsd = acpi_processor_get_tsd(pr);
 
-	if(no_ptc || no_tss) {
-		pr->throttling.acpi_processor_get_throttling = &acpi_processor_get_throttling_fadt;
-		pr->throttling.acpi_processor_set_throttling = &acpi_processor_set_throttling_fadt;
+	if (no_ptc || no_tss) {
+		pr->throttling.acpi_processor_get_throttling =
+		    &acpi_processor_get_throttling_fadt;
+		pr->throttling.acpi_processor_set_throttling =
+		    &acpi_processor_set_throttling_fadt;
 	} else {
-		pr->throttling.acpi_processor_get_throttling = &acpi_processor_get_throttling_ptc;
-		pr->throttling.acpi_processor_set_throttling = &acpi_processor_set_throttling_ptc;
+		pr->throttling.acpi_processor_get_throttling =
+		    &acpi_processor_get_throttling_ptc;
+		pr->throttling.acpi_processor_set_throttling =
+		    &acpi_processor_set_throttling_ptc;
 	}
 
 	if (!pr->throttling.address) {
@@ -620,7 +632,6 @@ static int acpi_processor_throttling_seq_show(struct seq_file *seq,
 	int i = 0;
 	int result = 0;
 
-
 	if (!pr)
 		goto end;
 
@@ -639,24 +650,24 @@ static int acpi_processor_throttling_seq_show(struct seq_file *seq,
 
 	seq_printf(seq, "state count:             %d\n"
 		   "active state:            T%d\n"
-			"state available: T%d to T%d\n",
+		   "state available: T%d to T%d\n",
 		   pr->throttling.state_count, pr->throttling.state,
-			pr->throttling_platform_limit,
-			pr->throttling.state_count-1);
+		   pr->throttling_platform_limit,
+		   pr->throttling.state_count - 1);
 
 	seq_puts(seq, "states:\n");
-	if(acpi_processor_get_throttling == acpi_processor_get_throttling_fadt)
+	if (acpi_processor_get_throttling == acpi_processor_get_throttling_fadt)
 		for (i = 0; i < pr->throttling.state_count; i++)
 			seq_printf(seq, "   %cT%d:                  %02d%%\n",
-			   (i == pr->throttling.state ? '*' : ' '), i,
-			   (pr->throttling.states[i].performance ? pr->
-			    throttling.states[i].performance / 10 : 0));
+				   (i == pr->throttling.state ? '*' : ' '), i,
+				   (pr->throttling.states[i].performance ? pr->
+				    throttling.states[i].performance / 10 : 0));
 	else
 		for (i = 0; i < pr->throttling.state_count; i++)
 			seq_printf(seq, "   %cT%d:                  %02d%%\n",
-			   (i == pr->throttling.state ? '*' : ' '), i,
-			   (int)pr->throttling.states_tss[i].freqpercentage);
-		
+				   (i == pr->throttling.state ? '*' : ' '), i,
+				   (int)pr->throttling.states_tss[i].
+				   freqpercentage);
 
       end:
 	return 0;
@@ -669,7 +680,7 @@ static int acpi_processor_throttling_open_fs(struct inode *inode,
 			   PDE(inode)->data);
 }
 
-static ssize_t acpi_processor_write_throttling(struct file * file,
+static ssize_t acpi_processor_write_throttling(struct file *file,
 					       const char __user * buffer,
 					       size_t count, loff_t * data)
 {
@@ -678,7 +689,6 @@ static ssize_t acpi_processor_write_throttling(struct file * file,
 	struct acpi_processor *pr = m->private;
 	char state_string[12] = { '\0' };
 
-
 	if (!pr || (count > sizeof(state_string) - 1))
 		return -EINVAL;
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 01d2f24..f9f987f 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -167,8 +167,9 @@ struct acpi_processor_throttling {
 	struct acpi_processor_tx_tss *states_tss;
 	struct acpi_tsd_package domain_info;
 	cpumask_t shared_cpu_map;
-	int (*acpi_processor_get_throttling) (struct acpi_processor *pr);
-	int (*acpi_processor_set_throttling) (struct acpi_processor *pr, int state);
+	int (*acpi_processor_get_throttling) (struct acpi_processor * pr);
+	int (*acpi_processor_set_throttling) (struct acpi_processor * pr,
+					      int state);
 
 	u32 address;
 	u8 duty_offset;
@@ -207,7 +208,7 @@ struct acpi_processor {
 	u32 pblk;
 	int performance_platform_limit;
 	int throttling_platform_limit;
-		/*0 - states 0..n-th satte available*/
+	/* 0 - states 0..n-th state available */
 
 	struct acpi_processor_flags flags;
 	struct acpi_processor_power power;
-- 
1.5.3.rc2.22.g69a9b
