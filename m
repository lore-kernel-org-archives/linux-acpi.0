From: Len Brown <len.brown@intel.com>
Subject: [PATCH 14/77] ACPI: add ACPI 3.0 _TPC _TSS _PTC throttling support
Date: Sun, 22 Jul 2007 05:13:59 -0400
Message-ID: <11850957162801-git-send-email-len.brown@intel.com>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5737 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762441AbXGVJPT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:19 -0400
In-Reply-To: <1185095715506-git-send-email-len.brown@intel.com>
Message-Id: <01854e697a77a434104b2f7e6d7fd463a978af32.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Luming Yu <luming.yu@gmail.com>, Luming Yu <luming.yu@intel.com>, Len Brown <len.brown@intel.com>

From: Luming Yu <luming.yu@gmail.com>

adds _TPC _TSS _PTC -- Throttling Present Capabilities

Signed-off-by: Luming Yu <luming.yu@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c       |    6 +
 drivers/acpi/processor_throttling.c |  380 ++++++++++++++++++++++++++++++++++-
 include/acpi/processor.h            |   46 ++++-
 3 files changed, 423 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index f7de02a..7aefb7c 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -66,6 +66,7 @@
 #define ACPI_PROCESSOR_FILE_LIMIT	"limit"
 #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
 #define ACPI_PROCESSOR_NOTIFY_POWER	0x81
+#define ACPI_PROCESSOR_NOTIFY_THROTTLING	0x82
 
 #define ACPI_PROCESSOR_LIMIT_USER	0
 #define ACPI_PROCESSOR_LIMIT_THERMAL	1
@@ -84,6 +85,8 @@ static int acpi_processor_info_open_fs(struct inode *inode, struct file *file);
 static void acpi_processor_notify(acpi_handle handle, u32 event, void *data);
 static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu);
 static int acpi_processor_handle_eject(struct acpi_processor *pr);
+extern int acpi_processor_tstate_has_changed(struct acpi_processor *pr);
+
 
 static struct acpi_driver acpi_processor_driver = {
 	.name = "processor",
@@ -699,6 +702,9 @@ static void acpi_processor_notify(acpi_handle handle, u32 event, void *data)
 		acpi_processor_cst_has_changed(pr);
 		acpi_bus_generate_event(device, event, 0);
 		break;
+	case ACPI_PROCESSOR_NOTIFY_THROTTLING:
+		acpi_processor_tstate_has_changed(pr);
+		acpi_bus_generate_event(device, event, 0);
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Unsupported event [0x%x]\n", event));
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index b334860..1bae2e4 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -44,10 +44,222 @@
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_throttling");
 
+static int acpi_processor_get_throttling (struct acpi_processor *pr);
+int acpi_processor_set_throttling (struct acpi_processor *pr, int state);
+
+static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
+{
+	acpi_status status = 0;
+	unsigned long tpc = 0;
+
+	if(!pr) 
+		return -EINVAL;
+	status = acpi_evaluate_integer(pr->handle, "_TPC", NULL, &tpc);
+	if(ACPI_FAILURE(status) && status != AE_NOT_FOUND){
+		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TPC"));
+		return -ENODEV;
+	}
+	pr->throttling_platform_limit = (int)tpc;
+	return 0;
+}
+
+int acpi_processor_tstate_has_changed(struct acpi_processor *pr)
+{
+	return acpi_processor_get_platform_limit(pr);
+}
+
+/* --------------------------------------------------------------------------
+                             _PTC, _TSS, _TSD support 
+   -------------------------------------------------------------------------- */
+static int acpi_processor_get_throttling_control(struct acpi_processor *pr)
+{
+	int result = 0;
+	acpi_status status = 0;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *ptc = NULL;
+	union acpi_object obj = { 0 };
+
+	status = acpi_evaluate_object(pr->handle, "_PTC", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PTC"));
+		return -ENODEV;
+	}
+
+	ptc = (union acpi_object *)buffer.pointer;
+	if (!ptc || (ptc->type != ACPI_TYPE_PACKAGE)
+	    || (ptc->package.count != 2)) {
+		printk(KERN_ERR PREFIX "Invalid _PTC data\n");
+		result = -EFAULT;
+		goto end;
+	}
+
+	/*
+	 * control_register
+	 */
+
+	obj = ptc->package.elements[0];
+
+	if ((obj.type != ACPI_TYPE_BUFFER)
+	    || (obj.buffer.length < sizeof(struct acpi_ptc_register))
+	    || (obj.buffer.pointer == NULL)) {
+		printk(KERN_ERR PREFIX "Invalid _PTC data (control_register)\n");
+		result = -EFAULT;
+		goto end;
+	}
+	memcpy(&pr->throttling.control_register, obj.buffer.pointer,
+	       sizeof(struct acpi_ptc_register));
+
+	/*
+	 * status_register
+	 */
+
+	obj = ptc->package.elements[1];
+
+	if ((obj.type != ACPI_TYPE_BUFFER)
+	    || (obj.buffer.length < sizeof(struct acpi_ptc_register))
+	    || (obj.buffer.pointer == NULL)) {
+		printk(KERN_ERR PREFIX "Invalid _PTC data (status_register)\n");
+		result = -EFAULT;
+		goto end;
+	}
+
+	memcpy(&pr->throttling.status_register, obj.buffer.pointer,
+		sizeof(struct acpi_ptc_register));
+
+	end:
+	kfree(buffer.pointer);
+
+	return result;
+}
+static int acpi_processor_get_throttling_states(struct acpi_processor *pr)
+{
+	int result = 0;
+	acpi_status status = AE_OK;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_buffer format = { sizeof("NNNNN"), "NNNNN" };
+	struct acpi_buffer state = { 0, NULL };
+	union acpi_object *tss = NULL;
+	int i;
+
+	status = acpi_evaluate_object(pr->handle, "_TSS", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TSS"));
+		return -ENODEV;
+	}
+
+	tss = buffer.pointer;
+	if (!tss || (tss->type != ACPI_TYPE_PACKAGE)) {
+		printk(KERN_ERR PREFIX "Invalid _TSS data\n");
+		result = -EFAULT;
+		goto end;
+	}
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d throttling states\n",
+			  tss->package.count));
+
+	pr->throttling.state_count = tss->package.count;
+	pr->throttling.states_tss =
+	    kmalloc(sizeof(struct acpi_processor_tx_tss) * tss->package.count,
+		    GFP_KERNEL);
+	if (!pr->throttling.states_tss) {
+		result = -ENOMEM;
+		goto end;
+	}
+
+	for (i = 0; i < pr->throttling.state_count; i++) {
+
+		struct acpi_processor_tx_tss *tx = (struct acpi_processor_tx_tss *) &(pr->throttling.states_tss[i]);
+
+		state.length = sizeof(struct acpi_processor_tx_tss);
+		state.pointer = tx;
+
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Extracting state %d\n", i));
+
+		status = acpi_extract_package(&(tss->package.elements[i]),
+					      &format, &state);
+		if (ACPI_FAILURE(status)) {
+			ACPI_EXCEPTION((AE_INFO, status, "Invalid _TSS data"));
+			result = -EFAULT;
+			kfree(pr->throttling.states_tss);
+			goto end;
+		}
+
+		if (!tx->freqpercentage) {
+			printk(KERN_ERR PREFIX
+				    "Invalid _TSS data: freq is zero\n");
+			result = -EFAULT;
+			kfree(pr->throttling.states_tss);
+			goto end;
+		}
+	}
+
+      end:
+	kfree(buffer.pointer);
+
+	return result;
+}
+static int acpi_processor_get_tsd(struct acpi_processor	*pr)
+{
+	int result = 0;
+	acpi_status status = AE_OK;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_buffer format = {sizeof("NNNNN"), "NNNNN"};
+	struct acpi_buffer state = {0, NULL};
+	union acpi_object  *tsd = NULL;
+	struct acpi_tsd_package *pdomain;
+
+	status = acpi_evaluate_object(pr->handle, "_TSD", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		return -ENODEV;
+	}
+
+	tsd = buffer.pointer;
+	if (!tsd || (tsd->type != ACPI_TYPE_PACKAGE)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _TSD data\n"));
+		result = -EFAULT;
+		goto end;
+	}
+
+	if (tsd->package.count != 1) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _TSD data\n"));
+		result = -EFAULT;
+		goto end;
+	}
+
+	pdomain = &(pr->throttling.domain_info);
+
+	state.length = sizeof(struct acpi_tsd_package);
+	state.pointer = pdomain;
+
+	status = acpi_extract_package(&(tsd->package.elements[0]),
+		&format, &state);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _TSD data\n"));
+		result = -EFAULT;
+		goto end;
+	}
+
+	if (pdomain->num_entries != ACPI_TSD_REV0_ENTRIES) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unknown _TSD:num_entries\n"));
+		result = -EFAULT;
+		goto end;
+	}
+
+	if (pdomain->revision != ACPI_TSD_REV0_REVISION) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unknown _TSD:revision\n"));
+		result = -EFAULT;
+		goto end;
+	}
+
+end:
+	kfree(buffer.pointer);
+	return result;
+}
+
 /* --------------------------------------------------------------------------
                               Throttling Control
    -------------------------------------------------------------------------- */
-static int acpi_processor_get_throttling(struct acpi_processor *pr)
+static int acpi_processor_get_throttling_fadt(struct acpi_processor *pr)
 {
 	int state = 0;
 	u32 value = 0;
@@ -94,7 +306,101 @@ static int acpi_processor_get_throttling(struct acpi_processor *pr)
 	return 0;
 }
 
-int acpi_processor_set_throttling(struct acpi_processor *pr, int state)
+static int acpi_read_throttling_status(struct acpi_processor_throttling *throttling)
+{
+	int value = -1;
+	switch (throttling->status_register.space_id) {
+	case ACPI_ADR_SPACE_SYSTEM_IO:
+		acpi_os_read_port((acpi_io_address)throttling->status_register.address,
+				&value,
+				(u32)throttling->status_register.bit_width*8);
+		break;
+	case ACPI_ADR_SPACE_FIXED_HARDWARE:
+		printk(KERN_ERR PREFIX "HARDWARE addr space,NOT supported yet\n");
+		break;
+	default:
+		printk(KERN_ERR PREFIX "Unknown addr space %d\n",
+			(u32) (throttling->status_register.space_id));
+	}
+	return value;
+}
+
+static int acpi_write_throttling_state(struct acpi_processor_throttling *throttling,int value)
+{
+	int ret = -1;
+
+	switch (throttling->control_register.space_id) {
+	case ACPI_ADR_SPACE_SYSTEM_IO:
+		acpi_os_write_port((acpi_io_address)throttling->control_register.address,
+				value,
+				(u32)throttling->control_register.bit_width*8);
+		ret = 0;
+		break;
+	case ACPI_ADR_SPACE_FIXED_HARDWARE:
+		printk(KERN_ERR PREFIX "HARDWARE addr space,NOT supported yet\n");
+		break;
+	default:
+		printk(KERN_ERR PREFIX "Unknown addr space %d\n",
+			(u32) (throttling->control_register.space_id));
+	}
+	return ret;
+}
+
+static int acpi_get_throttling_state(struct acpi_processor *pr,int value)
+{
+	int i;
+
+	for (i = 0; i < pr->throttling.state_count; i++) {
+		struct acpi_processor_tx_tss *tx = (struct acpi_processor_tx_tss *) &(pr->throttling.states_tss[i]);
+		if(tx->control == value)
+			break;
+	}
+	if(i > pr->throttling.state_count)
+		i=-1;
+	return i;
+}
+
+static int acpi_get_throttling_value(struct acpi_processor *pr,int state)
+{
+	int value = -1;
+	if(state >=0 && state <= pr->throttling.state_count){
+		struct acpi_processor_tx_tss *tx = (struct acpi_processor_tx_tss *) &(pr->throttling.states_tss[state]);
+		value = tx->control;
+	}
+	return value;
+}
+
+static int acpi_processor_get_throttling_ptc(struct acpi_processor *pr)
+{
+	int state = 0;
+	u32 value = 0;
+
+
+	if (!pr)
+		return -EINVAL;
+
+	if (!pr->flags.throttling)
+		return -ENODEV;
+
+	pr->throttling.state = 0;
+	local_irq_disable();
+	value = acpi_read_throttling_status(&pr->throttling);
+	if(value >= 0){
+		state = acpi_get_throttling_state(pr,value);
+		pr->throttling.state = state;
+	}
+	local_irq_enable();
+
+	return 0;
+}
+
+
+static int acpi_processor_get_throttling(struct acpi_processor *pr)
+{
+	return pr->throttling.acpi_processor_get_throttling(pr);
+}
+
+int acpi_processor_set_throttling_fadt(struct acpi_processor *pr, int state)
 {
 	u32 value = 0;
 	u32 duty_mask = 0;
@@ -113,6 +419,8 @@ int acpi_processor_set_throttling(struct acpi_processor *pr, int state)
 	if (state == pr->throttling.state)
 		return 0;
 
+	if (state < pr->throttling_platform_limit)
+		return -EPERM;
 	/*
 	 * Calculate the duty_value and duty_mask.
 	 */
@@ -165,11 +473,50 @@ int acpi_processor_set_throttling(struct acpi_processor *pr, int state)
 	return 0;
 }
 
+int acpi_processor_set_throttling_ptc(struct acpi_processor *pr, int state)
+{
+	u32 value = 0;
+
+	if (!pr)
+		return -EINVAL;
+
+	if ((state < 0) || (state > (pr->throttling.state_count - 1)))
+		return -EINVAL;
+
+	if (!pr->flags.throttling)
+		return -ENODEV;
+
+	if (state == pr->throttling.state)
+		return 0;
+
+	if (state < pr->throttling_platform_limit)
+		return -EPERM;
+
+	local_irq_disable();
+
+	value = acpi_get_throttling_value(pr,state);
+	if(value >=0){ 
+		acpi_write_throttling_state(&pr->throttling,value);
+		pr->throttling.state = state;
+	}
+	local_irq_enable();
+
+	return 0;
+}
+
+int acpi_processor_set_throttling(struct acpi_processor *pr, int state)
+{
+	return pr->throttling.acpi_processor_set_throttling(pr,state);
+}
+
 int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 {
 	int result = 0;
 	int step = 0;
 	int i = 0;
+	int no_ptc = 0;
+	int no_tss = 0;
+	int no_tsd = 0;
 
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -182,6 +529,17 @@ int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 		return -EINVAL;
 
 	/* TBD: Support ACPI 2.0 objects */
+	no_ptc = acpi_processor_get_throttling_control(pr);
+	no_tss = acpi_processor_get_throttling_states(pr);
+	no_tsd = acpi_processor_get_tsd(pr);
+
+	if(no_ptc || no_tss) {
+		pr->throttling.acpi_processor_get_throttling = &acpi_processor_get_throttling_fadt;
+		pr->throttling.acpi_processor_set_throttling = &acpi_processor_set_throttling_fadt;
+	} else {
+		pr->throttling.acpi_processor_get_throttling = &acpi_processor_get_throttling_ptc;
+		pr->throttling.acpi_processor_set_throttling = &acpi_processor_set_throttling_ptc;
+	}
 
 	if (!pr->throttling.address) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No throttling register\n"));
@@ -280,15 +638,25 @@ static int acpi_processor_throttling_seq_show(struct seq_file *seq,
 	}
 
 	seq_printf(seq, "state count:             %d\n"
-		   "active state:            T%d\n",
-		   pr->throttling.state_count, pr->throttling.state);
+		   "active state:            T%d\n"
+			"state available: T%d to T%d\n",
+		   pr->throttling.state_count, pr->throttling.state,
+			pr->throttling_platform_limit,
+			pr->throttling.state_count-1);
 
 	seq_puts(seq, "states:\n");
-	for (i = 0; i < pr->throttling.state_count; i++)
-		seq_printf(seq, "   %cT%d:                  %02d%%\n",
+	if(acpi_processor_get_throttling == acpi_processor_get_throttling_fadt)
+		for (i = 0; i < pr->throttling.state_count; i++)
+			seq_printf(seq, "   %cT%d:                  %02d%%\n",
 			   (i == pr->throttling.state ? '*' : ' '), i,
 			   (pr->throttling.states[i].performance ? pr->
 			    throttling.states[i].performance / 10 : 0));
+	else
+		for (i = 0; i < pr->throttling.state_count; i++)
+			seq_printf(seq, "   %cT%d:                  %02d%%\n",
+			   (i == pr->throttling.state ? '*' : ' '), i,
+			   (int)pr->throttling.states_tss[i].freqpercentage);
+		
 
       end:
 	return 0;
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index b4b0ffd..01d2f24 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -21,6 +21,8 @@
 #define ACPI_PSD_REV0_REVISION		0	/* Support for _PSD as in ACPI 3.0 */
 #define ACPI_PSD_REV0_ENTRIES		5
 
+#define ACPI_TSD_REV0_REVISION		0	/* Support for _PSD as in ACPI 3.0 */
+#define ACPI_TSD_REV0_ENTRIES		5
 /*
  * Types of coordination defined in ACPI 3.0. Same macros can be used across
  * P, C and T states
@@ -125,17 +127,52 @@ struct acpi_processor_performance {
 
 /* Throttling Control */
 
+struct acpi_tsd_package {
+	acpi_integer num_entries;
+	acpi_integer revision;
+	acpi_integer domain;
+	acpi_integer coord_type;
+	acpi_integer num_processors;
+} __attribute__ ((packed));
+
+struct acpi_ptc_register {
+	u8 descriptor;
+	u16 length;
+	u8 space_id;
+	u8 bit_width;
+	u8 bit_offset;
+	u8 reserved;
+	u64 address;
+} __attribute__ ((packed));
+
+struct acpi_processor_tx_tss {
+	acpi_integer freqpercentage;	/* */
+	acpi_integer power;	/* milliWatts */
+	acpi_integer transition_latency;	/* microseconds */
+	acpi_integer control;	/* control value */
+	acpi_integer status;	/* success indicator */
+};
 struct acpi_processor_tx {
 	u16 power;
 	u16 performance;
 };
 
+struct acpi_processor;
 struct acpi_processor_throttling {
-	int state;
+	unsigned int state;
+	unsigned int platform_limit;
+	struct acpi_pct_register control_register;
+	struct acpi_pct_register status_register;
+	unsigned int state_count;
+	struct acpi_processor_tx_tss *states_tss;
+	struct acpi_tsd_package domain_info;
+	cpumask_t shared_cpu_map;
+	int (*acpi_processor_get_throttling) (struct acpi_processor *pr);
+	int (*acpi_processor_set_throttling) (struct acpi_processor *pr, int state);
+
 	u32 address;
 	u8 duty_offset;
 	u8 duty_width;
-	int state_count;
 	struct acpi_processor_tx states[ACPI_PROCESSOR_MAX_THROTTLING];
 };
 
@@ -169,6 +206,9 @@ struct acpi_processor {
 	u32 id;
 	u32 pblk;
 	int performance_platform_limit;
+	int throttling_platform_limit;
+		/*0 - states 0..n-th satte available*/
+
 	struct acpi_processor_flags flags;
 	struct acpi_processor_power power;
 	struct acpi_processor_performance *performance;
@@ -270,7 +310,7 @@ static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr)
 
 /* in processor_throttling.c */
 int acpi_processor_get_throttling_info(struct acpi_processor *pr);
-int acpi_processor_set_throttling(struct acpi_processor *pr, int state);
+extern int acpi_processor_set_throttling(struct acpi_processor *pr, int state);
 extern struct file_operations acpi_processor_throttling_fops;
 
 /* in processor_idle.c */
-- 
1.5.3.rc2.22.g69a9b
