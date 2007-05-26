From: "Luming Yu" <luming.yu@gmail.com>
Subject: [PATCH] _TPC,_TSS,_PTC support
Date: Sat, 26 May 2007 22:49:58 +0800
Message-ID: <3877989d0705260749y1fd55beau899f25b39e881d5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_155631_4113571.1180190998774"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:48081 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754660AbXEZOuC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 May 2007 10:50:02 -0400
Received: by nz-out-0506.google.com with SMTP id n1so567871nzf
        for <linux-acpi@vger.kernel.org>; Sat, 26 May 2007 07:50:01 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

------=_Part_155631_4113571.1180190998774
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

adds _TPC,_TSS,_PTC support which support Throttling Present Capabilities
change for ACPI processor driver

signed-off-by: Luming Yu <Luming.yu@intel.com>
--
 drivers/acpi/processor_core.c       |    6
 drivers/acpi/processor_throttling.c |  380 +++++++++++++++++++++++++++++++++++-
 include/acpi/processor.h            |   46 ++++
 3 files changed, 423 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 60646dd..7dedf3b 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -67,6 +67,7 @@ #define ACPI_PROCESSOR_FILE_THROTTLING	"
 #define ACPI_PROCESSOR_FILE_LIMIT	"limit"
 #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
 #define ACPI_PROCESSOR_NOTIFY_POWER	0x81
+#define ACPI_PROCESSOR_NOTIFY_THROTTLING	0x82

 #define ACPI_PROCESSOR_LIMIT_USER	0
 #define ACPI_PROCESSOR_LIMIT_THERMAL	1
@@ -85,6 +86,8 @@ static int acpi_processor_info_open_fs(s
 static void acpi_processor_notify(acpi_handle handle, u32 event, void *data);
 static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu);
 static int acpi_processor_handle_eject(struct acpi_processor *pr);
+extern int acpi_processor_tstate_has_changed(struct acpi_processor *pr);
+

 static struct acpi_driver acpi_processor_driver = {
 	.name = "processor",
@@ -700,6 +703,9 @@ static void acpi_processor_notify(acpi_h
 		acpi_processor_cst_has_changed(pr);
 		acpi_bus_generate_event(device, event, 0);
 		break;
+	case ACPI_PROCESSOR_NOTIFY_THROTTLING:
+		acpi_processor_tstate_has_changed(pr);
+		acpi_bus_generate_event(device, event, 0);
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Unsupported event [0x%x]\n", event));
diff --git a/drivers/acpi/processor_throttling.c
b/drivers/acpi/processor_throttling.c
index b334860..1bae2e4 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -44,10 +44,222 @@ #define ACPI_PROCESSOR_CLASS
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
+   --------------------------------------------------------------------------
*/
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
+		struct acpi_processor_tx_tss *tx = (struct acpi_processor_tx_tss *)
&(pr->throttling.states_tss[i]);
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
    --------------------------------------------------------------------------
*/
-static int acpi_processor_get_throttling(struct acpi_processor *pr)
+static int acpi_processor_get_throttling_fadt(struct acpi_processor *pr)
 {
 	int state = 0;
 	u32 value = 0;
@@ -94,7 +306,101 @@ static int acpi_processor_get_throttling
 	return 0;
 }

-int acpi_processor_set_throttling(struct acpi_processor *pr, int state)
+static int acpi_read_throttling_status(struct
acpi_processor_throttling *throttling)
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
+static int acpi_write_throttling_state(struct
acpi_processor_throttling *throttling,int value)
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
+		struct acpi_processor_tx_tss *tx = (struct acpi_processor_tx_tss *)
&(pr->throttling.states_tss[i]);
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
+		struct acpi_processor_tx_tss *tx = (struct acpi_processor_tx_tss *)
&(pr->throttling.states_tss[state]);
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
@@ -113,6 +419,8 @@ int acpi_processor_set_throttling(struct
 	if (state == pr->throttling.state)
 		return 0;

+	if (state < pr->throttling_platform_limit)
+		return -EPERM;
 	/*
 	 * Calculate the duty_value and duty_mask.
 	 */
@@ -165,11 +473,50 @@ int acpi_processor_set_throttling(struct
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
@@ -182,6 +529,17 @@ int acpi_processor_get_throttling_info(s
 		return -EINVAL;

 	/* TBD: Support ACPI 2.0 objects */
+	no_ptc = acpi_processor_get_throttling_control(pr);
+	no_tss = acpi_processor_get_throttling_states(pr);
+	no_tsd = acpi_processor_get_tsd(pr);
+
+	if(no_ptc || no_tss) {
+		pr->throttling.acpi_processor_get_throttling =
&acpi_processor_get_throttling_fadt;
+		pr->throttling.acpi_processor_set_throttling =
&acpi_processor_set_throttling_fadt;
+	} else {
+		pr->throttling.acpi_processor_get_throttling =
&acpi_processor_get_throttling_ptc;
+		pr->throttling.acpi_processor_set_throttling =
&acpi_processor_set_throttling_ptc;
+	}

 	if (!pr->throttling.address) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No throttling register\n"));
@@ -280,15 +638,25 @@ static int acpi_processor_throttling_seq
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
index 70f3209..500637d 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -21,6 +21,8 @@ #define ACPI_PDC_REVISION_ID		0x1
 #define ACPI_PSD_REV0_REVISION		0 /* Support for _PSD as in ACPI 3.0 */
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

@@ -170,6 +207,9 @@ struct acpi_processor {
 	u32 id;
 	u32 pblk;
 	int performance_platform_limit;
+	int throttling_platform_limit;
+		/*0 - states 0..n-th satte available*/
+
 	struct acpi_processor_flags flags;
 	struct acpi_processor_power power;
 	struct acpi_processor_performance *performance;
@@ -267,7 +307,7 @@ #endif				/* CONFIG_CPU_FREQ */

 /* in processor_throttling.c */
 int acpi_processor_get_throttling_info(struct acpi_processor *pr);
-int acpi_processor_set_throttling(struct acpi_processor *pr, int state);
+extern int acpi_processor_set_throttling(struct acpi_processor *pr, int state);
 extern struct file_operations acpi_processor_throttling_fops;

 /* in processor_idle.c */

------=_Part_155631_4113571.1180190998774
Content-Type: application/octet-stream; name=tpc.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f2677g37
Content-Disposition: attachment; filename="tpc.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfY29yZS5jIGIvZHJpdmVycy9hY3Bp
L3Byb2Nlc3Nvcl9jb3JlLmMKaW5kZXggNjA2NDZkZC4uN2RlZGYzYiAxMDA2NDQKLS0tIGEvZHJp
dmVycy9hY3BpL3Byb2Nlc3Nvcl9jb3JlLmMKKysrIGIvZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9j
b3JlLmMKQEAgLTY3LDYgKzY3LDcgQEAgI2RlZmluZSBBQ1BJX1BST0NFU1NPUl9GSUxFX1RIUk9U
VExJTkcJIgogI2RlZmluZSBBQ1BJX1BST0NFU1NPUl9GSUxFX0xJTUlUCSJsaW1pdCIKICNkZWZp
bmUgQUNQSV9QUk9DRVNTT1JfTk9USUZZX1BFUkZPUk1BTkNFIDB4ODAKICNkZWZpbmUgQUNQSV9Q
Uk9DRVNTT1JfTk9USUZZX1BPV0VSCTB4ODEKKyNkZWZpbmUgQUNQSV9QUk9DRVNTT1JfTk9USUZZ
X1RIUk9UVExJTkcJMHg4MgogCiAjZGVmaW5lIEFDUElfUFJPQ0VTU09SX0xJTUlUX1VTRVIJMAog
I2RlZmluZSBBQ1BJX1BST0NFU1NPUl9MSU1JVF9USEVSTUFMCTEKQEAgLTg1LDYgKzg2LDggQEAg
c3RhdGljIGludCBhY3BpX3Byb2Nlc3Nvcl9pbmZvX29wZW5fZnMocwogc3RhdGljIHZvaWQgYWNw
aV9wcm9jZXNzb3Jfbm90aWZ5KGFjcGlfaGFuZGxlIGhhbmRsZSwgdTMyIGV2ZW50LCB2b2lkICpk
YXRhKTsKIHN0YXRpYyBhY3BpX3N0YXR1cyBhY3BpX3Byb2Nlc3Nvcl9ob3RhZGRfaW5pdChhY3Bp
X2hhbmRsZSBoYW5kbGUsIGludCAqcF9jcHUpOwogc3RhdGljIGludCBhY3BpX3Byb2Nlc3Nvcl9o
YW5kbGVfZWplY3Qoc3RydWN0IGFjcGlfcHJvY2Vzc29yICpwcik7CitleHRlcm4gaW50IGFjcGlf
cHJvY2Vzc29yX3RzdGF0ZV9oYXNfY2hhbmdlZChzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByKTsK
KwogCiBzdGF0aWMgc3RydWN0IGFjcGlfZHJpdmVyIGFjcGlfcHJvY2Vzc29yX2RyaXZlciA9IHsK
IAkubmFtZSA9ICJwcm9jZXNzb3IiLApAQCAtNzAwLDYgKzcwMyw5IEBAIHN0YXRpYyB2b2lkIGFj
cGlfcHJvY2Vzc29yX25vdGlmeShhY3BpX2gKIAkJYWNwaV9wcm9jZXNzb3JfY3N0X2hhc19jaGFu
Z2VkKHByKTsKIAkJYWNwaV9idXNfZ2VuZXJhdGVfZXZlbnQoZGV2aWNlLCBldmVudCwgMCk7CiAJ
CWJyZWFrOworCWNhc2UgQUNQSV9QUk9DRVNTT1JfTk9USUZZX1RIUk9UVExJTkc6CisJCWFjcGlf
cHJvY2Vzc29yX3RzdGF0ZV9oYXNfY2hhbmdlZChwcik7CisJCWFjcGlfYnVzX2dlbmVyYXRlX2V2
ZW50KGRldmljZSwgZXZlbnQsIDApOwogCWRlZmF1bHQ6CiAJCUFDUElfREVCVUdfUFJJTlQoKEFD
UElfREJfSU5GTywKIAkJCQkgICJVbnN1cHBvcnRlZCBldmVudCBbMHgleF1cbiIsIGV2ZW50KSk7
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX3Rocm90dGxpbmcuYyBiL2RyaXZl
cnMvYWNwaS9wcm9jZXNzb3JfdGhyb3R0bGluZy5jCmluZGV4IGIzMzQ4NjAuLjFiYWUyZTQgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfdGhyb3R0bGluZy5jCisrKyBiL2RyaXZl
cnMvYWNwaS9wcm9jZXNzb3JfdGhyb3R0bGluZy5jCkBAIC00NCwxMCArNDQsMjIyIEBAICNkZWZp
bmUgQUNQSV9QUk9DRVNTT1JfQ0xBU1MgICAgICAgICAgICAKICNkZWZpbmUgX0NPTVBPTkVOVCAg
ICAgICAgICAgICAgQUNQSV9QUk9DRVNTT1JfQ09NUE9ORU5UCiBBQ1BJX01PRFVMRV9OQU1FKCJw
cm9jZXNzb3JfdGhyb3R0bGluZyIpOwogCitzdGF0aWMgaW50IGFjcGlfcHJvY2Vzc29yX2dldF90
aHJvdHRsaW5nIChzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByKTsKK2ludCBhY3BpX3Byb2Nlc3Nv
cl9zZXRfdGhyb3R0bGluZyAoc3RydWN0IGFjcGlfcHJvY2Vzc29yICpwciwgaW50IHN0YXRlKTsK
Kworc3RhdGljIGludCBhY3BpX3Byb2Nlc3Nvcl9nZXRfcGxhdGZvcm1fbGltaXQoc3RydWN0IGFj
cGlfcHJvY2Vzc29yICpwcikKK3sKKwlhY3BpX3N0YXR1cyBzdGF0dXMgPSAwOworCXVuc2lnbmVk
IGxvbmcgdHBjID0gMDsKKworCWlmKCFwcikgCisJCXJldHVybiAtRUlOVkFMOworCXN0YXR1cyA9
IGFjcGlfZXZhbHVhdGVfaW50ZWdlcihwci0+aGFuZGxlLCAiX1RQQyIsIE5VTEwsICZ0cGMpOwor
CWlmKEFDUElfRkFJTFVSRShzdGF0dXMpICYmIHN0YXR1cyAhPSBBRV9OT1RfRk9VTkQpeworCQlB
Q1BJX0VYQ0VQVElPTigoQUVfSU5GTywgc3RhdHVzLCAiRXZhbHVhdGluZyBfVFBDIikpOworCQly
ZXR1cm4gLUVOT0RFVjsKKwl9CisJcHItPnRocm90dGxpbmdfcGxhdGZvcm1fbGltaXQgPSAoaW50
KXRwYzsKKwlyZXR1cm4gMDsKK30KKworaW50IGFjcGlfcHJvY2Vzc29yX3RzdGF0ZV9oYXNfY2hh
bmdlZChzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByKQoreworCXJldHVybiBhY3BpX3Byb2Nlc3Nv
cl9nZXRfcGxhdGZvcm1fbGltaXQocHIpOworfQorCisvKiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBfUFRDLCBfVFNTLCBfVFNEIHN1cHBvcnQgCisgICAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSAqLworc3RhdGljIGludCBhY3BpX3Byb2Nlc3Nvcl9nZXRfdGhyb3R0
bGluZ19jb250cm9sKHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIpCit7CisJaW50IHJlc3VsdCA9
IDA7CisJYWNwaV9zdGF0dXMgc3RhdHVzID0gMDsKKwlzdHJ1Y3QgYWNwaV9idWZmZXIgYnVmZmVy
ID0geyBBQ1BJX0FMTE9DQVRFX0JVRkZFUiwgTlVMTCB9OworCXVuaW9uIGFjcGlfb2JqZWN0ICpw
dGMgPSBOVUxMOworCXVuaW9uIGFjcGlfb2JqZWN0IG9iaiA9IHsgMCB9OworCisJc3RhdHVzID0g
YWNwaV9ldmFsdWF0ZV9vYmplY3QocHItPmhhbmRsZSwgIl9QVEMiLCBOVUxMLCAmYnVmZmVyKTsK
KwlpZiAoQUNQSV9GQUlMVVJFKHN0YXR1cykpIHsKKwkJQUNQSV9FWENFUFRJT04oKEFFX0lORk8s
IHN0YXR1cywgIkV2YWx1YXRpbmcgX1BUQyIpKTsKKwkJcmV0dXJuIC1FTk9ERVY7CisJfQorCisJ
cHRjID0gKHVuaW9uIGFjcGlfb2JqZWN0ICopYnVmZmVyLnBvaW50ZXI7CisJaWYgKCFwdGMgfHwg
KHB0Yy0+dHlwZSAhPSBBQ1BJX1RZUEVfUEFDS0FHRSkKKwkgICAgfHwgKHB0Yy0+cGFja2FnZS5j
b3VudCAhPSAyKSkgeworCQlwcmludGsoS0VSTl9FUlIgUFJFRklYICJJbnZhbGlkIF9QVEMgZGF0
YVxuIik7CisJCXJlc3VsdCA9IC1FRkFVTFQ7CisJCWdvdG8gZW5kOworCX0KKworCS8qCisJICog
Y29udHJvbF9yZWdpc3RlcgorCSAqLworCisJb2JqID0gcHRjLT5wYWNrYWdlLmVsZW1lbnRzWzBd
OworCisJaWYgKChvYmoudHlwZSAhPSBBQ1BJX1RZUEVfQlVGRkVSKQorCSAgICB8fCAob2JqLmJ1
ZmZlci5sZW5ndGggPCBzaXplb2Yoc3RydWN0IGFjcGlfcHRjX3JlZ2lzdGVyKSkKKwkgICAgfHwg
KG9iai5idWZmZXIucG9pbnRlciA9PSBOVUxMKSkgeworCQlwcmludGsoS0VSTl9FUlIgUFJFRklY
ICJJbnZhbGlkIF9QVEMgZGF0YSAoY29udHJvbF9yZWdpc3RlcilcbiIpOworCQlyZXN1bHQgPSAt
RUZBVUxUOworCQlnb3RvIGVuZDsKKwl9CisJbWVtY3B5KCZwci0+dGhyb3R0bGluZy5jb250cm9s
X3JlZ2lzdGVyLCBvYmouYnVmZmVyLnBvaW50ZXIsCisJICAgICAgIHNpemVvZihzdHJ1Y3QgYWNw
aV9wdGNfcmVnaXN0ZXIpKTsKKworCS8qCisJICogc3RhdHVzX3JlZ2lzdGVyCisJICovCisKKwlv
YmogPSBwdGMtPnBhY2thZ2UuZWxlbWVudHNbMV07CisKKwlpZiAoKG9iai50eXBlICE9IEFDUElf
VFlQRV9CVUZGRVIpCisJICAgIHx8IChvYmouYnVmZmVyLmxlbmd0aCA8IHNpemVvZihzdHJ1Y3Qg
YWNwaV9wdGNfcmVnaXN0ZXIpKQorCSAgICB8fCAob2JqLmJ1ZmZlci5wb2ludGVyID09IE5VTEwp
KSB7CisJCXByaW50ayhLRVJOX0VSUiBQUkVGSVggIkludmFsaWQgX1BUQyBkYXRhIChzdGF0dXNf
cmVnaXN0ZXIpXG4iKTsKKwkJcmVzdWx0ID0gLUVGQVVMVDsKKwkJZ290byBlbmQ7CisJfQorCisJ
bWVtY3B5KCZwci0+dGhyb3R0bGluZy5zdGF0dXNfcmVnaXN0ZXIsIG9iai5idWZmZXIucG9pbnRl
ciwKKwkJc2l6ZW9mKHN0cnVjdCBhY3BpX3B0Y19yZWdpc3RlcikpOworCisJZW5kOgorCWtmcmVl
KGJ1ZmZlci5wb2ludGVyKTsKKworCXJldHVybiByZXN1bHQ7Cit9CitzdGF0aWMgaW50IGFjcGlf
cHJvY2Vzc29yX2dldF90aHJvdHRsaW5nX3N0YXRlcyhzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnBy
KQoreworCWludCByZXN1bHQgPSAwOworCWFjcGlfc3RhdHVzIHN0YXR1cyA9IEFFX09LOworCXN0
cnVjdCBhY3BpX2J1ZmZlciBidWZmZXIgPSB7IEFDUElfQUxMT0NBVEVfQlVGRkVSLCBOVUxMIH07
CisJc3RydWN0IGFjcGlfYnVmZmVyIGZvcm1hdCA9IHsgc2l6ZW9mKCJOTk5OTiIpLCAiTk5OTk4i
IH07CisJc3RydWN0IGFjcGlfYnVmZmVyIHN0YXRlID0geyAwLCBOVUxMIH07CisJdW5pb24gYWNw
aV9vYmplY3QgKnRzcyA9IE5VTEw7CisJaW50IGk7CisKKwlzdGF0dXMgPSBhY3BpX2V2YWx1YXRl
X29iamVjdChwci0+aGFuZGxlLCAiX1RTUyIsIE5VTEwsICZidWZmZXIpOworCWlmIChBQ1BJX0ZB
SUxVUkUoc3RhdHVzKSkgeworCQlBQ1BJX0VYQ0VQVElPTigoQUVfSU5GTywgc3RhdHVzLCAiRXZh
bHVhdGluZyBfVFNTIikpOworCQlyZXR1cm4gLUVOT0RFVjsKKwl9CisKKwl0c3MgPSBidWZmZXIu
cG9pbnRlcjsKKwlpZiAoIXRzcyB8fCAodHNzLT50eXBlICE9IEFDUElfVFlQRV9QQUNLQUdFKSkg
eworCQlwcmludGsoS0VSTl9FUlIgUFJFRklYICJJbnZhbGlkIF9UU1MgZGF0YVxuIik7CisJCXJl
c3VsdCA9IC1FRkFVTFQ7CisJCWdvdG8gZW5kOworCX0KKworCUFDUElfREVCVUdfUFJJTlQoKEFD
UElfREJfSU5GTywgIkZvdW5kICVkIHRocm90dGxpbmcgc3RhdGVzXG4iLAorCQkJICB0c3MtPnBh
Y2thZ2UuY291bnQpKTsKKworCXByLT50aHJvdHRsaW5nLnN0YXRlX2NvdW50ID0gdHNzLT5wYWNr
YWdlLmNvdW50OworCXByLT50aHJvdHRsaW5nLnN0YXRlc190c3MgPQorCSAgICBrbWFsbG9jKHNp
emVvZihzdHJ1Y3QgYWNwaV9wcm9jZXNzb3JfdHhfdHNzKSAqIHRzcy0+cGFja2FnZS5jb3VudCwK
KwkJICAgIEdGUF9LRVJORUwpOworCWlmICghcHItPnRocm90dGxpbmcuc3RhdGVzX3Rzcykgewor
CQlyZXN1bHQgPSAtRU5PTUVNOworCQlnb3RvIGVuZDsKKwl9CisKKwlmb3IgKGkgPSAwOyBpIDwg
cHItPnRocm90dGxpbmcuc3RhdGVfY291bnQ7IGkrKykgeworCisJCXN0cnVjdCBhY3BpX3Byb2Nl
c3Nvcl90eF90c3MgKnR4ID0gKHN0cnVjdCBhY3BpX3Byb2Nlc3Nvcl90eF90c3MgKikgJihwci0+
dGhyb3R0bGluZy5zdGF0ZXNfdHNzW2ldKTsKKworCQlzdGF0ZS5sZW5ndGggPSBzaXplb2Yoc3Ry
dWN0IGFjcGlfcHJvY2Vzc29yX3R4X3Rzcyk7CisJCXN0YXRlLnBvaW50ZXIgPSB0eDsKKworCQlB
Q1BJX0RFQlVHX1BSSU5UKChBQ1BJX0RCX0lORk8sICJFeHRyYWN0aW5nIHN0YXRlICVkXG4iLCBp
KSk7CisKKwkJc3RhdHVzID0gYWNwaV9leHRyYWN0X3BhY2thZ2UoJih0c3MtPnBhY2thZ2UuZWxl
bWVudHNbaV0pLAorCQkJCQkgICAgICAmZm9ybWF0LCAmc3RhdGUpOworCQlpZiAoQUNQSV9GQUlM
VVJFKHN0YXR1cykpIHsKKwkJCUFDUElfRVhDRVBUSU9OKChBRV9JTkZPLCBzdGF0dXMsICJJbnZh
bGlkIF9UU1MgZGF0YSIpKTsKKwkJCXJlc3VsdCA9IC1FRkFVTFQ7CisJCQlrZnJlZShwci0+dGhy
b3R0bGluZy5zdGF0ZXNfdHNzKTsKKwkJCWdvdG8gZW5kOworCQl9CisKKwkJaWYgKCF0eC0+ZnJl
cXBlcmNlbnRhZ2UpIHsKKwkJCXByaW50ayhLRVJOX0VSUiBQUkVGSVgKKwkJCQkgICAgIkludmFs
aWQgX1RTUyBkYXRhOiBmcmVxIGlzIHplcm9cbiIpOworCQkJcmVzdWx0ID0gLUVGQVVMVDsKKwkJ
CWtmcmVlKHByLT50aHJvdHRsaW5nLnN0YXRlc190c3MpOworCQkJZ290byBlbmQ7CisJCX0KKwl9
CisKKyAgICAgIGVuZDoKKwlrZnJlZShidWZmZXIucG9pbnRlcik7CisKKwlyZXR1cm4gcmVzdWx0
OworfQorc3RhdGljIGludCBhY3BpX3Byb2Nlc3Nvcl9nZXRfdHNkKHN0cnVjdCBhY3BpX3Byb2Nl
c3NvcgkqcHIpCit7CisJaW50IHJlc3VsdCA9IDA7CisJYWNwaV9zdGF0dXMgc3RhdHVzID0gQUVf
T0s7CisJc3RydWN0IGFjcGlfYnVmZmVyIGJ1ZmZlciA9IHtBQ1BJX0FMTE9DQVRFX0JVRkZFUiwg
TlVMTH07CisJc3RydWN0IGFjcGlfYnVmZmVyIGZvcm1hdCA9IHtzaXplb2YoIk5OTk5OIiksICJO
Tk5OTiJ9OworCXN0cnVjdCBhY3BpX2J1ZmZlciBzdGF0ZSA9IHswLCBOVUxMfTsKKwl1bmlvbiBh
Y3BpX29iamVjdCAgKnRzZCA9IE5VTEw7CisJc3RydWN0IGFjcGlfdHNkX3BhY2thZ2UgKnBkb21h
aW47CisKKwlzdGF0dXMgPSBhY3BpX2V2YWx1YXRlX29iamVjdChwci0+aGFuZGxlLCAiX1RTRCIs
IE5VTEwsICZidWZmZXIpOworCWlmIChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSkgeworCQlyZXR1cm4g
LUVOT0RFVjsKKwl9CisKKwl0c2QgPSBidWZmZXIucG9pbnRlcjsKKwlpZiAoIXRzZCB8fCAodHNk
LT50eXBlICE9IEFDUElfVFlQRV9QQUNLQUdFKSkgeworCQlBQ1BJX0RFQlVHX1BSSU5UKChBQ1BJ
X0RCX0VSUk9SLCAiSW52YWxpZCBfVFNEIGRhdGFcbiIpKTsKKwkJcmVzdWx0ID0gLUVGQVVMVDsK
KwkJZ290byBlbmQ7CisJfQorCisJaWYgKHRzZC0+cGFja2FnZS5jb3VudCAhPSAxKSB7CisJCUFD
UElfREVCVUdfUFJJTlQoKEFDUElfREJfRVJST1IsICJJbnZhbGlkIF9UU0QgZGF0YVxuIikpOwor
CQlyZXN1bHQgPSAtRUZBVUxUOworCQlnb3RvIGVuZDsKKwl9CisKKwlwZG9tYWluID0gJihwci0+
dGhyb3R0bGluZy5kb21haW5faW5mbyk7CisKKwlzdGF0ZS5sZW5ndGggPSBzaXplb2Yoc3RydWN0
IGFjcGlfdHNkX3BhY2thZ2UpOworCXN0YXRlLnBvaW50ZXIgPSBwZG9tYWluOworCisJc3RhdHVz
ID0gYWNwaV9leHRyYWN0X3BhY2thZ2UoJih0c2QtPnBhY2thZ2UuZWxlbWVudHNbMF0pLAorCQkm
Zm9ybWF0LCAmc3RhdGUpOworCWlmIChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSkgeworCQlBQ1BJX0RF
QlVHX1BSSU5UKChBQ1BJX0RCX0VSUk9SLCAiSW52YWxpZCBfVFNEIGRhdGFcbiIpKTsKKwkJcmVz
dWx0ID0gLUVGQVVMVDsKKwkJZ290byBlbmQ7CisJfQorCisJaWYgKHBkb21haW4tPm51bV9lbnRy
aWVzICE9IEFDUElfVFNEX1JFVjBfRU5UUklFUykgeworCQlBQ1BJX0RFQlVHX1BSSU5UKChBQ1BJ
X0RCX0VSUk9SLCAiVW5rbm93biBfVFNEOm51bV9lbnRyaWVzXG4iKSk7CisJCXJlc3VsdCA9IC1F
RkFVTFQ7CisJCWdvdG8gZW5kOworCX0KKworCWlmIChwZG9tYWluLT5yZXZpc2lvbiAhPSBBQ1BJ
X1RTRF9SRVYwX1JFVklTSU9OKSB7CisJCUFDUElfREVCVUdfUFJJTlQoKEFDUElfREJfRVJST1Is
ICJVbmtub3duIF9UU0Q6cmV2aXNpb25cbiIpKTsKKwkJcmVzdWx0ID0gLUVGQVVMVDsKKwkJZ290
byBlbmQ7CisJfQorCitlbmQ6CisJa2ZyZWUoYnVmZmVyLnBvaW50ZXIpOworCXJldHVybiByZXN1
bHQ7Cit9CisKIC8qIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBUaHJvdHRsaW5nIENvbnRyb2wKICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICovCi1zdGF0aWMg
aW50IGFjcGlfcHJvY2Vzc29yX2dldF90aHJvdHRsaW5nKHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAq
cHIpCitzdGF0aWMgaW50IGFjcGlfcHJvY2Vzc29yX2dldF90aHJvdHRsaW5nX2ZhZHQoc3RydWN0
IGFjcGlfcHJvY2Vzc29yICpwcikKIHsKIAlpbnQgc3RhdGUgPSAwOwogCXUzMiB2YWx1ZSA9IDA7
CkBAIC05NCw3ICszMDYsMTAxIEBAIHN0YXRpYyBpbnQgYWNwaV9wcm9jZXNzb3JfZ2V0X3Rocm90
dGxpbmcKIAlyZXR1cm4gMDsKIH0KIAotaW50IGFjcGlfcHJvY2Vzc29yX3NldF90aHJvdHRsaW5n
KHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIsIGludCBzdGF0ZSkKK3N0YXRpYyBpbnQgYWNwaV9y
ZWFkX3Rocm90dGxpbmdfc3RhdHVzKHN0cnVjdCBhY3BpX3Byb2Nlc3Nvcl90aHJvdHRsaW5nICp0
aHJvdHRsaW5nKQoreworCWludCB2YWx1ZSA9IC0xOworCXN3aXRjaCAodGhyb3R0bGluZy0+c3Rh
dHVzX3JlZ2lzdGVyLnNwYWNlX2lkKSB7CisJY2FzZSBBQ1BJX0FEUl9TUEFDRV9TWVNURU1fSU86
CisJCWFjcGlfb3NfcmVhZF9wb3J0KChhY3BpX2lvX2FkZHJlc3MpdGhyb3R0bGluZy0+c3RhdHVz
X3JlZ2lzdGVyLmFkZHJlc3MsCisJCQkJJnZhbHVlLAorCQkJCSh1MzIpdGhyb3R0bGluZy0+c3Rh
dHVzX3JlZ2lzdGVyLmJpdF93aWR0aCo4KTsKKwkJYnJlYWs7CisJY2FzZSBBQ1BJX0FEUl9TUEFD
RV9GSVhFRF9IQVJEV0FSRToKKwkJcHJpbnRrKEtFUk5fRVJSIFBSRUZJWCAiSEFSRFdBUkUgYWRk
ciBzcGFjZSxOT1Qgc3VwcG9ydGVkIHlldFxuIik7CisJCWJyZWFrOworCWRlZmF1bHQ6CisJCXBy
aW50ayhLRVJOX0VSUiBQUkVGSVggIlVua25vd24gYWRkciBzcGFjZSAlZFxuIiwKKwkJCSh1MzIp
ICh0aHJvdHRsaW5nLT5zdGF0dXNfcmVnaXN0ZXIuc3BhY2VfaWQpKTsKKwl9CisJcmV0dXJuIHZh
bHVlOworfQorCitzdGF0aWMgaW50IGFjcGlfd3JpdGVfdGhyb3R0bGluZ19zdGF0ZShzdHJ1Y3Qg
YWNwaV9wcm9jZXNzb3JfdGhyb3R0bGluZyAqdGhyb3R0bGluZyxpbnQgdmFsdWUpCit7CisJaW50
IHJldCA9IC0xOworCisJc3dpdGNoICh0aHJvdHRsaW5nLT5jb250cm9sX3JlZ2lzdGVyLnNwYWNl
X2lkKSB7CisJY2FzZSBBQ1BJX0FEUl9TUEFDRV9TWVNURU1fSU86CisJCWFjcGlfb3Nfd3JpdGVf
cG9ydCgoYWNwaV9pb19hZGRyZXNzKXRocm90dGxpbmctPmNvbnRyb2xfcmVnaXN0ZXIuYWRkcmVz
cywKKwkJCQl2YWx1ZSwKKwkJCQkodTMyKXRocm90dGxpbmctPmNvbnRyb2xfcmVnaXN0ZXIuYml0
X3dpZHRoKjgpOworCQlyZXQgPSAwOworCQlicmVhazsKKwljYXNlIEFDUElfQURSX1NQQUNFX0ZJ
WEVEX0hBUkRXQVJFOgorCQlwcmludGsoS0VSTl9FUlIgUFJFRklYICJIQVJEV0FSRSBhZGRyIHNw
YWNlLE5PVCBzdXBwb3J0ZWQgeWV0XG4iKTsKKwkJYnJlYWs7CisJZGVmYXVsdDoKKwkJcHJpbnRr
KEtFUk5fRVJSIFBSRUZJWCAiVW5rbm93biBhZGRyIHNwYWNlICVkXG4iLAorCQkJKHUzMikgKHRo
cm90dGxpbmctPmNvbnRyb2xfcmVnaXN0ZXIuc3BhY2VfaWQpKTsKKwl9CisJcmV0dXJuIHJldDsK
K30KKworc3RhdGljIGludCBhY3BpX2dldF90aHJvdHRsaW5nX3N0YXRlKHN0cnVjdCBhY3BpX3By
b2Nlc3NvciAqcHIsaW50IHZhbHVlKQoreworCWludCBpOworCisJZm9yIChpID0gMDsgaSA8IHBy
LT50aHJvdHRsaW5nLnN0YXRlX2NvdW50OyBpKyspIHsKKwkJc3RydWN0IGFjcGlfcHJvY2Vzc29y
X3R4X3RzcyAqdHggPSAoc3RydWN0IGFjcGlfcHJvY2Vzc29yX3R4X3RzcyAqKSAmKHByLT50aHJv
dHRsaW5nLnN0YXRlc190c3NbaV0pOworCQlpZih0eC0+Y29udHJvbCA9PSB2YWx1ZSkKKwkJCWJy
ZWFrOworCX0KKwlpZihpID4gcHItPnRocm90dGxpbmcuc3RhdGVfY291bnQpCisJCWk9LTE7CisJ
cmV0dXJuIGk7Cit9CisKK3N0YXRpYyBpbnQgYWNwaV9nZXRfdGhyb3R0bGluZ192YWx1ZShzdHJ1
Y3QgYWNwaV9wcm9jZXNzb3IgKnByLGludCBzdGF0ZSkKK3sKKwlpbnQgdmFsdWUgPSAtMTsKKwlp
ZihzdGF0ZSA+PTAgJiYgc3RhdGUgPD0gcHItPnRocm90dGxpbmcuc3RhdGVfY291bnQpeworCQlz
dHJ1Y3QgYWNwaV9wcm9jZXNzb3JfdHhfdHNzICp0eCA9IChzdHJ1Y3QgYWNwaV9wcm9jZXNzb3Jf
dHhfdHNzICopICYocHItPnRocm90dGxpbmcuc3RhdGVzX3Rzc1tzdGF0ZV0pOworCQl2YWx1ZSA9
IHR4LT5jb250cm9sOworCX0KKwlyZXR1cm4gdmFsdWU7Cit9CisKK3N0YXRpYyBpbnQgYWNwaV9w
cm9jZXNzb3JfZ2V0X3Rocm90dGxpbmdfcHRjKHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIpCit7
CisJaW50IHN0YXRlID0gMDsKKwl1MzIgdmFsdWUgPSAwOworCisKKwlpZiAoIXByKQorCQlyZXR1
cm4gLUVJTlZBTDsKKworCWlmICghcHItPmZsYWdzLnRocm90dGxpbmcpCisJCXJldHVybiAtRU5P
REVWOworCisJcHItPnRocm90dGxpbmcuc3RhdGUgPSAwOworCWxvY2FsX2lycV9kaXNhYmxlKCk7
CisJdmFsdWUgPSBhY3BpX3JlYWRfdGhyb3R0bGluZ19zdGF0dXMoJnByLT50aHJvdHRsaW5nKTsK
KwlpZih2YWx1ZSA+PSAwKXsKKwkJc3RhdGUgPSBhY3BpX2dldF90aHJvdHRsaW5nX3N0YXRlKHBy
LHZhbHVlKTsKKwkJcHItPnRocm90dGxpbmcuc3RhdGUgPSBzdGF0ZTsKKwl9CisJbG9jYWxfaXJx
X2VuYWJsZSgpOworCisJcmV0dXJuIDA7Cit9CisKKworc3RhdGljIGludCBhY3BpX3Byb2Nlc3Nv
cl9nZXRfdGhyb3R0bGluZyhzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByKQoreworCXJldHVybiBw
ci0+dGhyb3R0bGluZy5hY3BpX3Byb2Nlc3Nvcl9nZXRfdGhyb3R0bGluZyhwcik7Cit9CisKK2lu
dCBhY3BpX3Byb2Nlc3Nvcl9zZXRfdGhyb3R0bGluZ19mYWR0KHN0cnVjdCBhY3BpX3Byb2Nlc3Nv
ciAqcHIsIGludCBzdGF0ZSkKIHsKIAl1MzIgdmFsdWUgPSAwOwogCXUzMiBkdXR5X21hc2sgPSAw
OwpAQCAtMTEzLDYgKzQxOSw4IEBAIGludCBhY3BpX3Byb2Nlc3Nvcl9zZXRfdGhyb3R0bGluZyhz
dHJ1Y3QKIAlpZiAoc3RhdGUgPT0gcHItPnRocm90dGxpbmcuc3RhdGUpCiAJCXJldHVybiAwOwog
CisJaWYgKHN0YXRlIDwgcHItPnRocm90dGxpbmdfcGxhdGZvcm1fbGltaXQpCisJCXJldHVybiAt
RVBFUk07CiAJLyoKIAkgKiBDYWxjdWxhdGUgdGhlIGR1dHlfdmFsdWUgYW5kIGR1dHlfbWFzay4K
IAkgKi8KQEAgLTE2NSwxMSArNDczLDUwIEBAIGludCBhY3BpX3Byb2Nlc3Nvcl9zZXRfdGhyb3R0
bGluZyhzdHJ1Y3QKIAlyZXR1cm4gMDsKIH0KIAoraW50IGFjcGlfcHJvY2Vzc29yX3NldF90aHJv
dHRsaW5nX3B0YyhzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByLCBpbnQgc3RhdGUpCit7CisJdTMy
IHZhbHVlID0gMDsKKworCWlmICghcHIpCisJCXJldHVybiAtRUlOVkFMOworCisJaWYgKChzdGF0
ZSA8IDApIHx8IChzdGF0ZSA+IChwci0+dGhyb3R0bGluZy5zdGF0ZV9jb3VudCAtIDEpKSkKKwkJ
cmV0dXJuIC1FSU5WQUw7CisKKwlpZiAoIXByLT5mbGFncy50aHJvdHRsaW5nKQorCQlyZXR1cm4g
LUVOT0RFVjsKKworCWlmIChzdGF0ZSA9PSBwci0+dGhyb3R0bGluZy5zdGF0ZSkKKwkJcmV0dXJu
IDA7CisKKwlpZiAoc3RhdGUgPCBwci0+dGhyb3R0bGluZ19wbGF0Zm9ybV9saW1pdCkKKwkJcmV0
dXJuIC1FUEVSTTsKKworCWxvY2FsX2lycV9kaXNhYmxlKCk7CisKKwl2YWx1ZSA9IGFjcGlfZ2V0
X3Rocm90dGxpbmdfdmFsdWUocHIsc3RhdGUpOworCWlmKHZhbHVlID49MCl7IAorCQlhY3BpX3dy
aXRlX3Rocm90dGxpbmdfc3RhdGUoJnByLT50aHJvdHRsaW5nLHZhbHVlKTsKKwkJcHItPnRocm90
dGxpbmcuc3RhdGUgPSBzdGF0ZTsKKwl9CisJbG9jYWxfaXJxX2VuYWJsZSgpOworCisJcmV0dXJu
IDA7Cit9CisKK2ludCBhY3BpX3Byb2Nlc3Nvcl9zZXRfdGhyb3R0bGluZyhzdHJ1Y3QgYWNwaV9w
cm9jZXNzb3IgKnByLCBpbnQgc3RhdGUpCit7CisJcmV0dXJuIHByLT50aHJvdHRsaW5nLmFjcGlf
cHJvY2Vzc29yX3NldF90aHJvdHRsaW5nKHByLHN0YXRlKTsKK30KKwogaW50IGFjcGlfcHJvY2Vz
c29yX2dldF90aHJvdHRsaW5nX2luZm8oc3RydWN0IGFjcGlfcHJvY2Vzc29yICpwcikKIHsKIAlp
bnQgcmVzdWx0ID0gMDsKIAlpbnQgc3RlcCA9IDA7CiAJaW50IGkgPSAwOworCWludCBub19wdGMg
PSAwOworCWludCBub190c3MgPSAwOworCWludCBub190c2QgPSAwOwogCiAKIAlBQ1BJX0RFQlVH
X1BSSU5UKChBQ1BJX0RCX0lORk8sCkBAIC0xODIsNiArNTI5LDE3IEBAIGludCBhY3BpX3Byb2Nl
c3Nvcl9nZXRfdGhyb3R0bGluZ19pbmZvKHMKIAkJcmV0dXJuIC1FSU5WQUw7CiAKIAkvKiBUQkQ6
IFN1cHBvcnQgQUNQSSAyLjAgb2JqZWN0cyAqLworCW5vX3B0YyA9IGFjcGlfcHJvY2Vzc29yX2dl
dF90aHJvdHRsaW5nX2NvbnRyb2wocHIpOworCW5vX3RzcyA9IGFjcGlfcHJvY2Vzc29yX2dldF90
aHJvdHRsaW5nX3N0YXRlcyhwcik7CisJbm9fdHNkID0gYWNwaV9wcm9jZXNzb3JfZ2V0X3RzZChw
cik7CisKKwlpZihub19wdGMgfHwgbm9fdHNzKSB7CisJCXByLT50aHJvdHRsaW5nLmFjcGlfcHJv
Y2Vzc29yX2dldF90aHJvdHRsaW5nID0gJmFjcGlfcHJvY2Vzc29yX2dldF90aHJvdHRsaW5nX2Zh
ZHQ7CisJCXByLT50aHJvdHRsaW5nLmFjcGlfcHJvY2Vzc29yX3NldF90aHJvdHRsaW5nID0gJmFj
cGlfcHJvY2Vzc29yX3NldF90aHJvdHRsaW5nX2ZhZHQ7CisJfSBlbHNlIHsKKwkJcHItPnRocm90
dGxpbmcuYWNwaV9wcm9jZXNzb3JfZ2V0X3Rocm90dGxpbmcgPSAmYWNwaV9wcm9jZXNzb3JfZ2V0
X3Rocm90dGxpbmdfcHRjOworCQlwci0+dGhyb3R0bGluZy5hY3BpX3Byb2Nlc3Nvcl9zZXRfdGhy
b3R0bGluZyA9ICZhY3BpX3Byb2Nlc3Nvcl9zZXRfdGhyb3R0bGluZ19wdGM7CisJfQogCiAJaWYg
KCFwci0+dGhyb3R0bGluZy5hZGRyZXNzKSB7CiAJCUFDUElfREVCVUdfUFJJTlQoKEFDUElfREJf
SU5GTywgIk5vIHRocm90dGxpbmcgcmVnaXN0ZXJcbiIpKTsKQEAgLTI4MCwxNSArNjM4LDI1IEBA
IHN0YXRpYyBpbnQgYWNwaV9wcm9jZXNzb3JfdGhyb3R0bGluZ19zZXEKIAl9CiAKIAlzZXFfcHJp
bnRmKHNlcSwgInN0YXRlIGNvdW50OiAgICAgICAgICAgICAlZFxuIgotCQkgICAiYWN0aXZlIHN0
YXRlOiAgICAgICAgICAgIFQlZFxuIiwKLQkJICAgcHItPnRocm90dGxpbmcuc3RhdGVfY291bnQs
IHByLT50aHJvdHRsaW5nLnN0YXRlKTsKKwkJICAgImFjdGl2ZSBzdGF0ZTogICAgICAgICAgICBU
JWRcbiIKKwkJCSJzdGF0ZSBhdmFpbGFibGU6IFQlZCB0byBUJWRcbiIsCisJCSAgIHByLT50aHJv
dHRsaW5nLnN0YXRlX2NvdW50LCBwci0+dGhyb3R0bGluZy5zdGF0ZSwKKwkJCXByLT50aHJvdHRs
aW5nX3BsYXRmb3JtX2xpbWl0LAorCQkJcHItPnRocm90dGxpbmcuc3RhdGVfY291bnQtMSk7CiAK
IAlzZXFfcHV0cyhzZXEsICJzdGF0ZXM6XG4iKTsKLQlmb3IgKGkgPSAwOyBpIDwgcHItPnRocm90
dGxpbmcuc3RhdGVfY291bnQ7IGkrKykKLQkJc2VxX3ByaW50ZihzZXEsICIgICAlY1QlZDogICAg
ICAgICAgICAgICAgICAlMDJkJSVcbiIsCisJaWYoYWNwaV9wcm9jZXNzb3JfZ2V0X3Rocm90dGxp
bmcgPT0gYWNwaV9wcm9jZXNzb3JfZ2V0X3Rocm90dGxpbmdfZmFkdCkKKwkJZm9yIChpID0gMDsg
aSA8IHByLT50aHJvdHRsaW5nLnN0YXRlX2NvdW50OyBpKyspCisJCQlzZXFfcHJpbnRmKHNlcSwg
IiAgICVjVCVkOiAgICAgICAgICAgICAgICAgICUwMmQlJVxuIiwKIAkJCSAgIChpID09IHByLT50
aHJvdHRsaW5nLnN0YXRlID8gJyonIDogJyAnKSwgaSwKIAkJCSAgIChwci0+dGhyb3R0bGluZy5z
dGF0ZXNbaV0ucGVyZm9ybWFuY2UgPyBwci0+CiAJCQkgICAgdGhyb3R0bGluZy5zdGF0ZXNbaV0u
cGVyZm9ybWFuY2UgLyAxMCA6IDApKTsKKwllbHNlCisJCWZvciAoaSA9IDA7IGkgPCBwci0+dGhy
b3R0bGluZy5zdGF0ZV9jb3VudDsgaSsrKQorCQkJc2VxX3ByaW50ZihzZXEsICIgICAlY1QlZDog
ICAgICAgICAgICAgICAgICAlMDJkJSVcbiIsCisJCQkgICAoaSA9PSBwci0+dGhyb3R0bGluZy5z
dGF0ZSA/ICcqJyA6ICcgJyksIGksCisJCQkgICAoaW50KXByLT50aHJvdHRsaW5nLnN0YXRlc190
c3NbaV0uZnJlcXBlcmNlbnRhZ2UpOworCQkKIAogICAgICAgZW5kOgogCXJldHVybiAwOwpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9hY3BpL3Byb2Nlc3Nvci5oIGIvaW5jbHVkZS9hY3BpL3Byb2Nlc3Nv
ci5oCmluZGV4IDcwZjMyMDkuLjUwMDYzN2QgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvYWNwaS9wcm9j
ZXNzb3IuaAorKysgYi9pbmNsdWRlL2FjcGkvcHJvY2Vzc29yLmgKQEAgLTIxLDYgKzIxLDggQEAg
I2RlZmluZSBBQ1BJX1BEQ19SRVZJU0lPTl9JRAkJMHgxCiAjZGVmaW5lIEFDUElfUFNEX1JFVjBf
UkVWSVNJT04JCTAgLyogU3VwcG9ydCBmb3IgX1BTRCBhcyBpbiBBQ1BJIDMuMCAqLwogI2RlZmlu
ZSBBQ1BJX1BTRF9SRVYwX0VOVFJJRVMJCTUKIAorI2RlZmluZSBBQ1BJX1RTRF9SRVYwX1JFVklT
SU9OCQkwCS8qIFN1cHBvcnQgZm9yIF9QU0QgYXMgaW4gQUNQSSAzLjAgKi8KKyNkZWZpbmUgQUNQ
SV9UU0RfUkVWMF9FTlRSSUVTCQk1CiAvKgogICogVHlwZXMgb2YgY29vcmRpbmF0aW9uIGRlZmlu
ZWQgaW4gQUNQSSAzLjAuIFNhbWUgbWFjcm9zIGNhbiBiZSB1c2VkIGFjcm9zcwogICogUCwgQyBh
bmQgVCBzdGF0ZXMKQEAgLTEyNSwxNyArMTI3LDUyIEBAIHN0cnVjdCBhY3BpX3Byb2Nlc3Nvcl9w
ZXJmb3JtYW5jZSB7CiAKIC8qIFRocm90dGxpbmcgQ29udHJvbCAqLwogCitzdHJ1Y3QgYWNwaV90
c2RfcGFja2FnZSB7CisJYWNwaV9pbnRlZ2VyIG51bV9lbnRyaWVzOworCWFjcGlfaW50ZWdlciBy
ZXZpc2lvbjsKKwlhY3BpX2ludGVnZXIgZG9tYWluOworCWFjcGlfaW50ZWdlciBjb29yZF90eXBl
OworCWFjcGlfaW50ZWdlciBudW1fcHJvY2Vzc29yczsKK30gX19hdHRyaWJ1dGVfXyAoKHBhY2tl
ZCkpOworCitzdHJ1Y3QgYWNwaV9wdGNfcmVnaXN0ZXIgeworCXU4IGRlc2NyaXB0b3I7CisJdTE2
IGxlbmd0aDsKKwl1OCBzcGFjZV9pZDsKKwl1OCBiaXRfd2lkdGg7CisJdTggYml0X29mZnNldDsK
Kwl1OCByZXNlcnZlZDsKKwl1NjQgYWRkcmVzczsKK30gX19hdHRyaWJ1dGVfXyAoKHBhY2tlZCkp
OworCitzdHJ1Y3QgYWNwaV9wcm9jZXNzb3JfdHhfdHNzIHsKKwlhY3BpX2ludGVnZXIgZnJlcXBl
cmNlbnRhZ2U7CS8qICovCisJYWNwaV9pbnRlZ2VyIHBvd2VyOwkvKiBtaWxsaVdhdHRzICovCisJ
YWNwaV9pbnRlZ2VyIHRyYW5zaXRpb25fbGF0ZW5jeTsJLyogbWljcm9zZWNvbmRzICovCisJYWNw
aV9pbnRlZ2VyIGNvbnRyb2w7CS8qIGNvbnRyb2wgdmFsdWUgKi8KKwlhY3BpX2ludGVnZXIgc3Rh
dHVzOwkvKiBzdWNjZXNzIGluZGljYXRvciAqLworfTsKIHN0cnVjdCBhY3BpX3Byb2Nlc3Nvcl90
eCB7CiAJdTE2IHBvd2VyOwogCXUxNiBwZXJmb3JtYW5jZTsKIH07CiAKK3N0cnVjdCBhY3BpX3By
b2Nlc3NvcjsKIHN0cnVjdCBhY3BpX3Byb2Nlc3Nvcl90aHJvdHRsaW5nIHsKLQlpbnQgc3RhdGU7
CisJdW5zaWduZWQgaW50IHN0YXRlOworCXVuc2lnbmVkIGludCBwbGF0Zm9ybV9saW1pdDsKKwlz
dHJ1Y3QgYWNwaV9wY3RfcmVnaXN0ZXIgY29udHJvbF9yZWdpc3RlcjsKKwlzdHJ1Y3QgYWNwaV9w
Y3RfcmVnaXN0ZXIgc3RhdHVzX3JlZ2lzdGVyOworCXVuc2lnbmVkIGludCBzdGF0ZV9jb3VudDsK
KwlzdHJ1Y3QgYWNwaV9wcm9jZXNzb3JfdHhfdHNzICpzdGF0ZXNfdHNzOworCXN0cnVjdCBhY3Bp
X3RzZF9wYWNrYWdlIGRvbWFpbl9pbmZvOworCWNwdW1hc2tfdCBzaGFyZWRfY3B1X21hcDsKKwlp
bnQgKCphY3BpX3Byb2Nlc3Nvcl9nZXRfdGhyb3R0bGluZykgKHN0cnVjdCBhY3BpX3Byb2Nlc3Nv
ciAqcHIpOworCWludCAoKmFjcGlfcHJvY2Vzc29yX3NldF90aHJvdHRsaW5nKSAoc3RydWN0IGFj
cGlfcHJvY2Vzc29yICpwciwgaW50IHN0YXRlKTsKKwogCXUzMiBhZGRyZXNzOwogCXU4IGR1dHlf
b2Zmc2V0OwogCXU4IGR1dHlfd2lkdGg7Ci0JaW50IHN0YXRlX2NvdW50OwogCXN0cnVjdCBhY3Bp
X3Byb2Nlc3Nvcl90eCBzdGF0ZXNbQUNQSV9QUk9DRVNTT1JfTUFYX1RIUk9UVExJTkddOwogfTsK
IApAQCAtMTcwLDYgKzIwNyw5IEBAIHN0cnVjdCBhY3BpX3Byb2Nlc3NvciB7CiAJdTMyIGlkOwog
CXUzMiBwYmxrOwogCWludCBwZXJmb3JtYW5jZV9wbGF0Zm9ybV9saW1pdDsKKwlpbnQgdGhyb3R0
bGluZ19wbGF0Zm9ybV9saW1pdDsKKwkJLyowIC0gc3RhdGVzIDAuLm4tdGggc2F0dGUgYXZhaWxh
YmxlKi8KKwogCXN0cnVjdCBhY3BpX3Byb2Nlc3Nvcl9mbGFncyBmbGFnczsKIAlzdHJ1Y3QgYWNw
aV9wcm9jZXNzb3JfcG93ZXIgcG93ZXI7CiAJc3RydWN0IGFjcGlfcHJvY2Vzc29yX3BlcmZvcm1h
bmNlICpwZXJmb3JtYW5jZTsKQEAgLTI2Nyw3ICszMDcsNyBAQCAjZW5kaWYJCQkJLyogQ09ORklH
X0NQVV9GUkVRICovCiAKIC8qIGluIHByb2Nlc3Nvcl90aHJvdHRsaW5nLmMgKi8KIGludCBhY3Bp
X3Byb2Nlc3Nvcl9nZXRfdGhyb3R0bGluZ19pbmZvKHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIp
OwotaW50IGFjcGlfcHJvY2Vzc29yX3NldF90aHJvdHRsaW5nKHN0cnVjdCBhY3BpX3Byb2Nlc3Nv
ciAqcHIsIGludCBzdGF0ZSk7CitleHRlcm4gaW50IGFjcGlfcHJvY2Vzc29yX3NldF90aHJvdHRs
aW5nKHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIsIGludCBzdGF0ZSk7CiBleHRlcm4gc3RydWN0
IGZpbGVfb3BlcmF0aW9ucyBhY3BpX3Byb2Nlc3Nvcl90aHJvdHRsaW5nX2ZvcHM7CiAKIC8qIGlu
IHByb2Nlc3Nvcl9pZGxlLmMgKi8K
------=_Part_155631_4113571.1180190998774--
