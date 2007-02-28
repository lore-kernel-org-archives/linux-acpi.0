From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: final set of EC init patches
Date: Thu, 01 Mar 2007 01:41:17 +0300
Message-ID: <45E6050D.2060908@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040908000308030602030004"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:9950 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932111AbXB1WlX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Feb 2007 17:41:23 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040908000308030602030004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here is the final set of EC init patches.
Renamed ec_ecdt into boot_ec, hope that's ok...
Regards,
    Alex.

--------------040908000308030602030004
Content-Type: text/plain;
 name="ec-init.mbox"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ec-init.mbox"

>From nobody Thu Mar  1 01:31:38 2007
Subject: [PATCH 1/9] ACPI: EC: Make EC to initialize first in ACPI
To: Alexey Starikovskiy <aystarik@gmail.com>
Date: Thu, 01 Mar 2007 01:31:38 +0300
Message-ID: <20070228223137.3871.7998.stgit@mstrcsd125.ims.intel.com>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>



Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
---

 drivers/acpi/Makefile |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 5956e9f..9623aac 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -1,6 +1,6 @@
 #
 # Makefile for the Linux ACPI interpreter
-# 
+#
 
 export ACPI_CFLAGS
 
@@ -32,16 +32,17 @@ #
 processor-objs	+= processor_core.o processor_throttling.o \
 				processor_idle.o processor_thermal.o
 ifdef CONFIG_CPU_FREQ
-processor-objs	+= processor_perflib.o			
+processor-objs	+= processor_perflib.o
 endif
 
 obj-y				+= sleep/
 obj-y				+= bus.o glue.o
 obj-y				+= scan.o
+# Keep EC driver first. Initialization of others depend on it.
+obj-$(CONFIG_ACPI_EC)		+= ec.o
 obj-$(CONFIG_ACPI_AC) 		+= ac.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
-obj-$(CONFIG_ACPI_EC)		+= ec.o
 obj-$(CONFIG_ACPI_FAN)		+= fan.o
 obj-$(CONFIG_ACPI_DOCK)		+= dock.o
 obj-$(CONFIG_ACPI_BAY)		+= bay.o

>From nobody Thu Mar  1 01:31:39 2007
Subject: [PATCH 2/9] ACPI: EC: "Fake ECDT" workaround is not needed any longer.
To: Alexey Starikovskiy <aystarik@gmail.com>
Date: Thu, 01 Mar 2007 01:31:39 +0300
Message-ID: <20070228223138.3871.50456.stgit@mstrcsd125.ims.intel.com>
In-Reply-To: <20070228223137.3871.7998.stgit@mstrcsd125.ims.intel.com>
References: <20070228223137.3871.7998.stgit@mstrcsd125.ims.intel.com>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>



Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
---

 drivers/acpi/ec.c |   80 -----------------------------------------------------
 1 files changed, 0 insertions(+), 80 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index ab68883..9a65372 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -800,74 +800,6 @@ static int acpi_ec_stop(struct acpi_devi
 	return 0;
 }
 
-static acpi_status __init
-acpi_fake_ecdt_callback(acpi_handle handle,
-			u32 Level, void *context, void **retval)
-{
-	acpi_status status;
-
-	mutex_init(&ec_ecdt->lock);
-	if (acpi_ec_mode == EC_INTR) {
-		init_waitqueue_head(&ec_ecdt->wait);
-	}
-	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
-				     acpi_ec_io_ports, ec_ecdt);
-	if (ACPI_FAILURE(status))
-		return status;
-
-	ec_ecdt->uid = -1;
-	acpi_evaluate_integer(handle, "_UID", NULL, &ec_ecdt->uid);
-
-	status = acpi_evaluate_integer(handle, "_GPE", NULL, &ec_ecdt->gpe);
-	if (ACPI_FAILURE(status))
-		return status;
-	ec_ecdt->global_lock = TRUE;
-	ec_ecdt->handle = handle;
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "GPE=0x%02lx, ports=0x%2lx, 0x%2lx",
-			  ec_ecdt->gpe, ec_ecdt->command_addr,
-			  ec_ecdt->data_addr));
-
-	return AE_CTRL_TERMINATE;
-}
-
-/*
- * Some BIOS (such as some from Gateway laptops) access EC region very early
- * such as in BAT0._INI or EC._INI before an EC device is found and
- * do not provide an ECDT. According to ACPI spec, ECDT isn't mandatorily
- * required, but if EC regison is accessed early, it is required.
- * The routine tries to workaround the BIOS bug by pre-scan EC device
- * It assumes that _CRS, _HID, _GPE, _UID methods of EC don't touch any
- * op region (since _REG isn't invoked yet). The assumption is true for
- * all systems found.
- */
-static int __init acpi_ec_fake_ecdt(void)
-{
-	acpi_status status;
-	int ret = 0;
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Try to make an fake ECDT"));
-
-	ec_ecdt = kzalloc(sizeof(struct acpi_ec), GFP_KERNEL);
-	if (!ec_ecdt) {
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	status = acpi_get_devices(ACPI_EC_HID,
-				  acpi_fake_ecdt_callback, NULL, NULL);
-	if (ACPI_FAILURE(status)) {
-		kfree(ec_ecdt);
-		ec_ecdt = NULL;
-		ret = -ENODEV;
-		ACPI_EXCEPTION((AE_INFO, status, "Can't make an fake ECDT"));
-		goto error;
-	}
-	return 0;
-      error:
-	return ret;
-}
-
 static int __init acpi_ec_get_real_ecdt(void)
 {
 	acpi_status status;
@@ -912,17 +844,12 @@ static int __init acpi_ec_get_real_ecdt(
 	return -ENODEV;
 }
 
-static int __initdata acpi_fake_ecdt_enabled;
 int __init acpi_ec_ecdt_probe(void)
 {
 	acpi_status status;
 	int ret;
 
 	ret = acpi_ec_get_real_ecdt();
-	/* Try to make a fake ECDT */
-	if (ret && acpi_fake_ecdt_enabled) {
-		ret = acpi_ec_fake_ecdt();
-	}
 
 	if (ret)
 		return 0;
@@ -996,13 +923,6 @@ static void __exit acpi_ec_exit(void)
 }
 #endif				/* 0 */
 
-static int __init acpi_fake_ecdt_setup(char *str)
-{
-	acpi_fake_ecdt_enabled = 1;
-	return 1;
-}
-
-__setup("acpi_fake_ecdt", acpi_fake_ecdt_setup);
 static int __init acpi_ec_set_intr_mode(char *str)
 {
 	int intr;

>From nobody Thu Mar  1 01:31:39 2007
Subject: [PATCH 3/9] ACPI: EC: enable burst functionality in EC.
To: Alexey Starikovskiy <aystarik@gmail.com>
Date: Thu, 01 Mar 2007 01:31:39 +0300
Message-ID: <20070228223139.3871.58590.stgit@mstrcsd125.ims.intel.com>
In-Reply-To: <20070228223137.3871.7998.stgit@mstrcsd125.ims.intel.com>
References: <20070228223137.3871.7998.stgit@mstrcsd125.ims.intel.com>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>



Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
---

 drivers/acpi/ec.c |   96 ++++++++++++++++++++++-------------------------------
 1 files changed, 40 insertions(+), 56 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 9a65372..816caec 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -100,7 +100,6 @@ static struct acpi_ec {
 	unsigned long global_lock;
 	struct mutex lock;
 	atomic_t query_pending;
-	atomic_t leaving_burst;	/* 0 : No, 1 : Yes, 2: abort */
 	wait_queue_head_t wait;
 } *ec_ecdt;
 
@@ -170,56 +169,6 @@ static int acpi_ec_wait(struct acpi_ec *
 	return -ETIME;
 }
 
-#ifdef ACPI_FUTURE_USAGE
-/*
- * Note: samsung nv5000 doesn't work with ec burst mode.
- * http://bugzilla.kernel.org/show_bug.cgi?id=4980
- */
-int acpi_ec_enter_burst_mode(struct acpi_ec *ec)
-{
-	u8 tmp = 0;
-	u8 status = 0;
-
-	status = acpi_ec_read_status(ec);
-	if (status != -EINVAL && !(status & ACPI_EC_FLAG_BURST)) {
-		status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0);
-		if (status)
-			goto end;
-		acpi_ec_write_cmd(ec, ACPI_EC_BURST_ENABLE);
-		status = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF_1);
-		tmp = acpi_ec_read_data(ec);
-		if (tmp != 0x90) {	/* Burst ACK byte */
-			return -EINVAL;
-		}
-	}
-
-	atomic_set(&ec->leaving_burst, 0);
-	return 0;
-      end:
-	ACPI_EXCEPTION((AE_INFO, status, "EC wait, burst mode"));
-	return -1;
-}
-
-int acpi_ec_leave_burst_mode(struct acpi_ec *ec)
-{
-	u8 status = 0;
-
-	status = acpi_ec_read_status(ec);
-	if (status != -EINVAL && (status & ACPI_EC_FLAG_BURST)) {
-		status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0);
-		if (status)
-			goto end;
-		acpi_ec_write_cmd(ec, ACPI_EC_BURST_DISABLE);
-		acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0);
-	}
-	atomic_set(&ec->leaving_burst, 1);
-	return 0;
-      end:
-	ACPI_EXCEPTION((AE_INFO, status, "EC leave burst mode"));
-	return -1;
-}
-#endif				/* ACPI_FUTURE_USAGE */
-
 static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
 					const u8 * wdata, unsigned wdata_len,
 					u8 * rdata, unsigned rdata_len)
@@ -308,6 +257,21 @@ static int acpi_ec_transaction(struct ac
 	return status;
 }
 
+/*
+ * Note: samsung nv5000 doesn't work with ec burst mode.
+ * http://bugzilla.kernel.org/show_bug.cgi?id=4980
+ */
+int acpi_ec_burst_enable(struct acpi_ec *ec)
+{
+	u8 d;
+	return acpi_ec_transaction(ec, ACPI_EC_BURST_ENABLE, NULL, 0, &d, 1);
+}
+
+int acpi_ec_burst_disable(struct acpi_ec *ec)
+{
+	return acpi_ec_transaction(ec, ACPI_EC_BURST_DISABLE, NULL, 0, NULL, 0);
+}
+
 static int acpi_ec_read(struct acpi_ec *ec, u8 address, u8 * data)
 {
 	int result;
@@ -329,6 +293,28 @@ static int acpi_ec_write(struct acpi_ec 
 /*
  * Externally callable EC access functions. For now, assume 1 EC only
  */
+int ec_burst_enable(void)
+{
+	struct acpi_ec *ec;
+	if (!first_ec)
+		return -ENODEV;
+	ec = acpi_driver_data(first_ec);
+	return acpi_ec_burst_enable(ec);
+}
+
+EXPORT_SYMBOL(ec_burst_enable);
+
+int ec_burst_disable(void)
+{
+	struct acpi_ec *ec;
+	if (!first_ec)
+		return -ENODEV;
+	ec = acpi_driver_data(first_ec);
+	return acpi_ec_burst_disable(ec);
+}
+
+EXPORT_SYMBOL(ec_burst_disable);
+
 int ec_read(u8 addr, u8 * val)
 {
 	struct acpi_ec *ec;
@@ -369,8 +355,8 @@ int ec_write(u8 addr, u8 val)
 EXPORT_SYMBOL(ec_write);
 
 int ec_transaction(u8 command,
-			  const u8 * wdata, unsigned wdata_len,
-			  u8 * rdata, unsigned rdata_len)
+		   const u8 * wdata, unsigned wdata_len,
+		   u8 * rdata, unsigned rdata_len)
 {
 	struct acpi_ec *ec;
 
@@ -634,7 +620,6 @@ static int acpi_ec_add(struct acpi_devic
 	mutex_init(&ec->lock);
 	atomic_set(&ec->query_pending, 0);
 	if (acpi_ec_mode == EC_INTR) {
-		atomic_set(&ec->leaving_burst, 1);
 		init_waitqueue_head(&ec->wait);
 	}
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
@@ -936,8 +921,7 @@ static int __init acpi_ec_set_intr_mode(
 		acpi_ec_mode = EC_POLL;
 	}
 	acpi_ec_driver.ops.add = acpi_ec_add;
-	printk(KERN_NOTICE PREFIX "%s mode.\n",
-			  intr ? "interrupt" : "polling");
+	printk(KERN_NOTICE PREFIX "%s mode.\n", intr ? "interrupt" : "polling");
 
 	return 1;
 }

>From nobody Thu Mar  1 01:31:39 2007
Subject: [PATCH 4/9] ACPI: EC: Remove casts to/from void* from ec.c
To: Alexey Starikovskiy <aystarik@gmail.com>
Date: Thu, 01 Mar 2007 01:31:39 +0300
Message-ID: <20070228223139.3871.25541.stgit@mstrcsd125.ims.intel.com>
In-Reply-To: <20070228223137.3871.7998.stgit@mstrcsd125.ims.intel.com>
References: <20070228223137.3871.7998.stgit@mstrcsd125.ims.intel.com>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>



Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
---

 drivers/acpi/ec.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 816caec..7f50ea1 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -402,7 +402,7 @@ static int acpi_ec_query(struct acpi_ec 
 
 static void acpi_ec_gpe_query(void *ec_cxt)
 {
-	struct acpi_ec *ec = (struct acpi_ec *)ec_cxt;
+	struct acpi_ec *ec = ec_cxt;
 	u8 value = 0;
 	char object_name[8];
 
@@ -420,7 +420,7 @@ static u32 acpi_ec_gpe_handler(void *dat
 {
 	acpi_status status = AE_OK;
 	u8 value;
-	struct acpi_ec *ec = (struct acpi_ec *)data;
+	struct acpi_ec *ec = data;
 
 	if (acpi_ec_mode == EC_INTR) {
 		wake_up(&ec->wait);
@@ -464,7 +464,7 @@ acpi_ec_space_handler(u32 function,
 		      void *handler_context, void *region_context)
 {
 	int result = 0;
-	struct acpi_ec *ec = NULL;
+	struct acpi_ec *ec = handler_context;
 	u64 temp = *value;
 	acpi_integer f_v = 0;
 	int i = 0;
@@ -476,8 +476,6 @@ acpi_ec_space_handler(u32 function,
 		return AE_BAD_PARAMETER;
 	}
 
-	ec = (struct acpi_ec *)handler_context;
-
       next_byte:
 	switch (function) {
 	case ACPI_READ:
@@ -533,7 +531,7 @@ static struct proc_dir_entry *acpi_ec_di
 
 static int acpi_ec_read_info(struct seq_file *seq, void *offset)
 {
-	struct acpi_ec *ec = (struct acpi_ec *)seq->private;
+	struct acpi_ec *ec = seq->private;
 
 	if (!ec)
 		goto end;
@@ -689,7 +687,7 @@ static int acpi_ec_remove(struct acpi_de
 static acpi_status
 acpi_ec_io_ports(struct acpi_resource *resource, void *context)
 {
-	struct acpi_ec *ec = (struct acpi_ec *)context;
+	struct acpi_ec *ec = context;
 
 	if (resource->type != ACPI_RESOURCE_TYPE_IO) {
 		return AE_OK;

>From nobody Thu Mar  1 01:31:40 2007
Subject: [PATCH 5/9] ACPI: EC: Put install handlers into separate function.
To: Alexey Starikovskiy <aystarik@gmail.com>
Date: Thu, 01 Mar 2007 01:31:40 +0300
Message-ID: <20070228223139.3871.21724.stgit@mstrcsd125.ims.intel.com>
In-Reply-To: <20070228223137.3871.7998.stgit@mstrcsd125.ims.intel.com>
References: <20070228223137.3871.7998.stgit@mstrcsd125.ims.intel.com>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>



Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
---

 drivers/acpi/ec.c |   87 ++++++++++++++++-------------------------------------
 1 files changed, 27 insertions(+), 60 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 7f50ea1..5147caa 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -709,6 +709,28 @@ acpi_ec_io_ports(struct acpi_resource *r
 	return AE_OK;
 }
 
+static int ec_install_handlers(struct acpi_ec *ec)
+{
+	acpi_status status = acpi_install_gpe_handler(NULL, ec->gpe,
+						      ACPI_GPE_EDGE_TRIGGERED,
+						      &acpi_ec_gpe_handler, ec);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+	acpi_set_gpe_type(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
+	acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
+
+	status = acpi_install_address_space_handler(ec->handle,
+						    ACPI_ADR_SPACE_EC,
+						    &acpi_ec_space_handler,
+						    &acpi_ec_space_setup, ec);
+	if (ACPI_FAILURE(status)) {
+		acpi_remove_gpe_handler(NULL, ec->gpe, &acpi_ec_gpe_handler);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int acpi_ec_start(struct acpi_device *device)
 {
 	acpi_status status = AE_OK;
@@ -736,28 +758,7 @@ static int acpi_ec_start(struct acpi_dev
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "gpe=0x%02lx, ports=0x%2lx,0x%2lx",
 			  ec->gpe, ec->command_addr, ec->data_addr));
 
-	/*
-	 * Install GPE handler
-	 */
-	status = acpi_install_gpe_handler(NULL, ec->gpe,
-					  ACPI_GPE_EDGE_TRIGGERED,
-					  &acpi_ec_gpe_handler, ec);
-	if (ACPI_FAILURE(status)) {
-		return -ENODEV;
-	}
-	acpi_set_gpe_type(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
-	acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
-
-	status = acpi_install_address_space_handler(ec->handle,
-						    ACPI_ADR_SPACE_EC,
-						    &acpi_ec_space_handler,
-						    &acpi_ec_space_setup, ec);
-	if (ACPI_FAILURE(status)) {
-		acpi_remove_gpe_handler(NULL, ec->gpe, &acpi_ec_gpe_handler);
-		return -ENODEV;
-	}
-
-	return AE_OK;
+	return ec_install_handlers(ec);
 }
 
 static int acpi_ec_stop(struct acpi_device *device, int type)
@@ -813,23 +814,12 @@ static int __init acpi_ec_get_real_ecdt(
 	ec_ecdt->global_lock = TRUE;
 	ec_ecdt->uid = ecdt_ptr->uid;
 
-	status = acpi_get_handle(NULL, ecdt_ptr->id, &ec_ecdt->handle);
-	if (ACPI_FAILURE(status)) {
-		goto error;
-	}
-
+	ec_ecdt->handle = ACPI_ROOT_OBJECT;
 	return 0;
-      error:
-	ACPI_EXCEPTION((AE_INFO, status, "Could not use ECDT"));
-	kfree(ec_ecdt);
-	ec_ecdt = NULL;
-
-	return -ENODEV;
 }
 
 int __init acpi_ec_ecdt_probe(void)
 {
-	acpi_status status;
 	int ret;
 
 	ret = acpi_ec_get_real_ecdt();
@@ -837,33 +827,10 @@ int __init acpi_ec_ecdt_probe(void)
 	if (ret)
 		return 0;
 
-	/*
-	 * Install GPE handler
-	 */
-	status = acpi_install_gpe_handler(NULL, ec_ecdt->gpe,
-					  ACPI_GPE_EDGE_TRIGGERED,
-					  &acpi_ec_gpe_handler, ec_ecdt);
-	if (ACPI_FAILURE(status)) {
-		goto error;
-	}
-	acpi_set_gpe_type(NULL, ec_ecdt->gpe, ACPI_GPE_TYPE_RUNTIME);
-	acpi_enable_gpe(NULL, ec_ecdt->gpe, ACPI_NOT_ISR);
-
-	status = acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
-						    ACPI_ADR_SPACE_EC,
-						    &acpi_ec_space_handler,
-						    &acpi_ec_space_setup,
-						    ec_ecdt);
-	if (ACPI_FAILURE(status)) {
-		acpi_remove_gpe_handler(NULL, ec_ecdt->gpe,
-					&acpi_ec_gpe_handler);
-		goto error;
-	}
-
-	return 0;
+	ret = ec_install_handlers(ec_ecdt);
+	if (!ret)
+		return 0;
 
-      error:
-	ACPI_EXCEPTION((AE_INFO, status, "Could not use ECDT"));
 	kfree(ec_ecdt);
 	ec_ecdt = NULL;
 

>From nobody Thu Mar  1 01:31:40 2007
Subject: [PATCH 6/9] ACPI: EC: Clean ECDT and namespace parsing.
To: Alexey Starikovskiy <aystarik@gmail.com>
Date: Thu, 01 Mar 2007 01:31:40 +0300
Message-ID: <20070228223140.3871.80025.stgit@mstrcsd125.ims.intel.com>
In-Reply-To: <20070228223137.3871.7998.stgit@mstrcsd125.ims.intel.com>
References: <20070228223137.3871.7998.stgit@mstrcsd125.ims.intel.com>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>



Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
---

 drivers/acpi/ec.c |  203 ++++++++++++++++++++++++++++-------------------------
 1 files changed, 108 insertions(+), 95 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 5147caa..c6dec3d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -599,73 +599,72 @@ static int acpi_ec_remove_fs(struct acpi
 /* --------------------------------------------------------------------------
                                Driver Interface
    -------------------------------------------------------------------------- */
+static acpi_status
+ec_parse_io_ports(struct acpi_resource *resource, void *context);
+
+static acpi_status
+ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval);
+
+static struct acpi_ec *make_acpi_ec(void)
+{
+	struct acpi_ec *ec = kzalloc(sizeof(struct acpi_ec), GFP_KERNEL);
+	if (!ec)
+		return NULL;
+
+	atomic_set(&ec->query_pending, 0);
+	mutex_init(&ec->lock);
+	init_waitqueue_head(&ec->wait);
+
+	return ec;
+}
 
 static int acpi_ec_add(struct acpi_device *device)
 {
-	int result = 0;
 	acpi_status status = AE_OK;
 	struct acpi_ec *ec = NULL;
 
 	if (!device)
 		return -EINVAL;
 
-	ec = kzalloc(sizeof(struct acpi_ec), GFP_KERNEL);
+	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
+
+	ec = make_acpi_ec();
 	if (!ec)
 		return -ENOMEM;
 
-	ec->handle = device->handle;
-	ec->uid = -1;
-	mutex_init(&ec->lock);
-	atomic_set(&ec->query_pending, 0);
-	if (acpi_ec_mode == EC_INTR) {
-		init_waitqueue_head(&ec->wait);
+	status = ec_parse_device(device->handle, 0, ec, NULL);
+	if (status != AE_CTRL_TERMINATE) {
+		kfree(ec);
+		return -EINVAL;
 	}
-	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
-	acpi_driver_data(device) = ec;
-
-	/* Use the global lock for all EC transactions? */
-	acpi_evaluate_integer(ec->handle, "_GLK", NULL, &ec->global_lock);
 
-	/* XXX we don't test uids, because on some boxes ecdt uid = 0, see:
-	   http://bugzilla.kernel.org/show_bug.cgi?id=6111 */
+	/* Check if we found the boot EC */
 	if (ec_ecdt) {
-		acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
-						  ACPI_ADR_SPACE_EC,
-						  &acpi_ec_space_handler);
+		if (ec_ecdt->gpe == ec->gpe) {
+			/* We might have incorrect info for GL at boot time */
+			mutex_lock(&ec_ecdt->lock);
+			ec_ecdt->global_lock = ec->global_lock;
+			mutex_unlock(&ec_ecdt->lock);
+			kfree(ec);
+			ec = ec_ecdt;
+		}
+	}
 
-		acpi_remove_gpe_handler(NULL, ec_ecdt->gpe,
-					&acpi_ec_gpe_handler);
+	ec->handle = device->handle;
 
-		kfree(ec_ecdt);
-	}
+	acpi_driver_data(device) = ec;
 
-	/* Get GPE bit assignment (EC events). */
-	/* TODO: Add support for _GPE returning a package */
-	status = acpi_evaluate_integer(ec->handle, "_GPE", NULL, &ec->gpe);
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status,
-				"Obtaining GPE bit assignment"));
-		result = -ENODEV;
-		goto end;
-	}
+	if (!first_ec)
+		first_ec = device;
 
-	result = acpi_ec_add_fs(device);
-	if (result)
-		goto end;
+	acpi_ec_add_fs(device);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "%s [%s] (gpe %d) interrupt mode.",
 			  acpi_device_name(device), acpi_device_bid(device),
 			  (u32) ec->gpe));
 
-	if (!first_ec)
-		first_ec = device;
-
-      end:
-	if (result)
-		kfree(ec);
-
-	return result;
+	return 0;
 }
 
 static int acpi_ec_remove(struct acpi_device *device, int type)
@@ -679,13 +678,19 @@ static int acpi_ec_remove(struct acpi_de
 
 	acpi_ec_remove_fs(device);
 
-	kfree(ec);
+	acpi_driver_data(device) = NULL;
+	if (device == first_ec)
+		first_ec = NULL;
+
+	/* Don't touch boot EC */
+	if (ec_ecdt != ec)
+		kfree(ec);
 
 	return 0;
 }
 
 static acpi_status
-acpi_ec_io_ports(struct acpi_resource *resource, void *context)
+ec_parse_io_ports(struct acpi_resource *resource, void *context)
 {
 	struct acpi_ec *ec = context;
 
@@ -711,9 +716,10 @@ acpi_ec_io_ports(struct acpi_resource *r
 
 static int ec_install_handlers(struct acpi_ec *ec)
 {
-	acpi_status status = acpi_install_gpe_handler(NULL, ec->gpe,
-						      ACPI_GPE_EDGE_TRIGGERED,
-						      &acpi_ec_gpe_handler, ec);
+	acpi_status status;
+	status = acpi_install_gpe_handler(NULL, ec->gpe,
+					  ACPI_GPE_EDGE_TRIGGERED,
+					  &acpi_ec_gpe_handler, ec);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 	acpi_set_gpe_type(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
@@ -733,8 +739,7 @@ static int ec_install_handlers(struct ac
 
 static int acpi_ec_start(struct acpi_device *device)
 {
-	acpi_status status = AE_OK;
-	struct acpi_ec *ec = NULL;
+	struct acpi_ec *ec;
 
 	if (!device)
 		return -EINVAL;
@@ -744,32 +749,31 @@ static int acpi_ec_start(struct acpi_dev
 	if (!ec)
 		return -EINVAL;
 
-	/*
-	 * Get I/O port addresses. Convert to GAS format.
-	 */
-	status = acpi_walk_resources(ec->handle, METHOD_NAME__CRS,
-				     acpi_ec_io_ports, ec);
-	if (ACPI_FAILURE(status) || ec->command_addr == 0) {
-		ACPI_EXCEPTION((AE_INFO, status,
-				"Error getting I/O port addresses"));
-		return -ENODEV;
-	}
-
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "gpe=0x%02lx, ports=0x%2lx,0x%2lx",
 			  ec->gpe, ec->command_addr, ec->data_addr));
 
+	/* Boot EC is already working */
+	if (ec == ec_ecdt)
+		return 0;
+
 	return ec_install_handlers(ec);
 }
 
 static int acpi_ec_stop(struct acpi_device *device, int type)
 {
-	acpi_status status = AE_OK;
-	struct acpi_ec *ec = NULL;
+	acpi_status status;
+	struct acpi_ec *ec;
 
 	if (!device)
 		return -EINVAL;
 
 	ec = acpi_driver_data(device);
+	if (!ec)
+		return -EINVAL;
+
+	/* Don't touch boot EC */
+	if (ec == ec_ecdt)
+		return 0;
 
 	status = acpi_remove_address_space_handler(ec->handle,
 						   ACPI_ADR_SPACE_EC,
@@ -784,53 +788,66 @@ static int acpi_ec_stop(struct acpi_devi
 	return 0;
 }
 
-static int __init acpi_ec_get_real_ecdt(void)
+static acpi_status
+ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
+{
+	acpi_status status;
+
+	struct acpi_ec *ec = context;
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
+				     ec_parse_io_ports, ec);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	/* Get GPE bit assignment (EC events). */
+	/* TODO: Add support for _GPE returning a package */
+	status = acpi_evaluate_integer(handle, "_GPE", NULL, &ec->gpe);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	/* Use the global lock for all EC transactions? */
+	acpi_evaluate_integer(handle, "_GLK", NULL, &ec->global_lock);
+
+	ec->handle = handle;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "GPE=0x%02lx, ports=0x%2lx, 0x%2lx",
+			  ec->gpe, ec->command_addr, ec->data_addr));
+
+	return AE_CTRL_TERMINATE;
+}
+
+int __init acpi_ec_ecdt_probe(void)
 {
+	int ret;
 	acpi_status status;
 	struct acpi_table_ecdt *ecdt_ptr;
 
+	ec_ecdt = make_acpi_ec();
+	if (!ec_ecdt)
+		return -ENOMEM;
+	/*
+	 * Generate a boot ec context
+	 */
+
 	status = acpi_get_table(ACPI_SIG_ECDT, 1,
 				(struct acpi_table_header **)&ecdt_ptr);
 	if (ACPI_FAILURE(status))
-		return -ENODEV;
+		goto error;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found ECDT"));
 
-	/*
-	 * Generate a temporary ec context to use until the namespace is scanned
-	 */
-	ec_ecdt = kzalloc(sizeof(struct acpi_ec), GFP_KERNEL);
-	if (!ec_ecdt)
-		return -ENOMEM;
-
-	mutex_init(&ec_ecdt->lock);
-	if (acpi_ec_mode == EC_INTR) {
-		init_waitqueue_head(&ec_ecdt->wait);
-	}
 	ec_ecdt->command_addr = ecdt_ptr->control.address;
 	ec_ecdt->data_addr = ecdt_ptr->data.address;
 	ec_ecdt->gpe = ecdt_ptr->gpe;
 	/* use the GL just to be safe */
 	ec_ecdt->global_lock = TRUE;
 	ec_ecdt->uid = ecdt_ptr->uid;
-
 	ec_ecdt->handle = ACPI_ROOT_OBJECT;
-	return 0;
-}
-
-int __init acpi_ec_ecdt_probe(void)
-{
-	int ret;
-
-	ret = acpi_ec_get_real_ecdt();
-
-	if (ret)
-		return 0;
 
 	ret = ec_install_handlers(ec_ecdt);
 	if (!ret)
 		return 0;
-
+      error:
 	kfree(ec_ecdt);
 	ec_ecdt = NULL;
 
@@ -880,12 +897,8 @@ static int __init acpi_ec_set_intr_mode(
 	if (!get_option(&str, &intr))
 		return 0;
 
-	if (intr) {
-		acpi_ec_mode = EC_INTR;
-	} else {
-		acpi_ec_mode = EC_POLL;
-	}
-	acpi_ec_driver.ops.add = acpi_ec_add;
+	acpi_ec_mode = (intr) ? EC_INTR : EC_POLL;
+
 	printk(KERN_NOTICE PREFIX "%s mode.\n", intr ? "interrupt" : "polling");
 
 	return 1;

>From nobody Thu Mar  1 01:31:40 2007
Subject: [PATCH 7/9] ACPI: EC: Rename ec_ecdt to more informative boot_ec
To: Alexey Starikovskiy <aystarik@gmail.com>
Date: Thu, 01 Mar 2007 01:31:40 +0300
Message-ID: <20070228223140.3871.37699.stgit@mstrcsd125.ims.intel.com>
In-Reply-To: <20070228223137.3871.7998.stgit@mstrcsd125.ims.intel.com>
References: <20070228223137.3871.7998.stgit@mstrcsd125.ims.intel.com>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>



Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
---

 drivers/acpi/ec.c |   45 +++++++++++++++++++++------------------------
 1 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index c6dec3d..9ca87b6 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -101,7 +101,7 @@ static struct acpi_ec {
 	struct mutex lock;
 	atomic_t query_pending;
 	wait_queue_head_t wait;
-} *ec_ecdt;
+} *boot_ec;
 
 /* External interfaces use first EC only, so remember */
 static struct acpi_device *first_ec;
@@ -640,21 +640,18 @@ static int acpi_ec_add(struct acpi_devic
 	}
 
 	/* Check if we found the boot EC */
-	if (ec_ecdt) {
-		if (ec_ecdt->gpe == ec->gpe) {
+	if (boot_ec) {
+		if (boot_ec->gpe == ec->gpe) {
 			/* We might have incorrect info for GL at boot time */
-			mutex_lock(&ec_ecdt->lock);
-			ec_ecdt->global_lock = ec->global_lock;
-			mutex_unlock(&ec_ecdt->lock);
+			mutex_lock(&boot_ec->lock);
+			boot_ec->global_lock = ec->global_lock;
+			mutex_unlock(&boot_ec->lock);
 			kfree(ec);
-			ec = ec_ecdt;
+			ec = boot_ec;
 		}
 	}
-
 	ec->handle = device->handle;
-
 	acpi_driver_data(device) = ec;
-
 	if (!first_ec)
 		first_ec = device;
 
@@ -683,7 +680,7 @@ static int acpi_ec_remove(struct acpi_de
 		first_ec = NULL;
 
 	/* Don't touch boot EC */
-	if (ec_ecdt != ec)
+	if (boot_ec != ec)
 		kfree(ec);
 
 	return 0;
@@ -753,7 +750,7 @@ static int acpi_ec_start(struct acpi_dev
 			  ec->gpe, ec->command_addr, ec->data_addr));
 
 	/* Boot EC is already working */
-	if (ec == ec_ecdt)
+	if (ec == boot_ec)
 		return 0;
 
 	return ec_install_handlers(ec);
@@ -772,7 +769,7 @@ static int acpi_ec_stop(struct acpi_devi
 		return -EINVAL;
 
 	/* Don't touch boot EC */
-	if (ec == ec_ecdt)
+	if (ec == boot_ec)
 		return 0;
 
 	status = acpi_remove_address_space_handler(ec->handle,
@@ -822,8 +819,8 @@ int __init acpi_ec_ecdt_probe(void)
 	acpi_status status;
 	struct acpi_table_ecdt *ecdt_ptr;
 
-	ec_ecdt = make_acpi_ec();
-	if (!ec_ecdt)
+	boot_ec = make_acpi_ec();
+	if (!boot_ec)
 		return -ENOMEM;
 	/*
 	 * Generate a boot ec context
@@ -836,20 +833,20 @@ int __init acpi_ec_ecdt_probe(void)
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found ECDT"));
 
-	ec_ecdt->command_addr = ecdt_ptr->control.address;
-	ec_ecdt->data_addr = ecdt_ptr->data.address;
-	ec_ecdt->gpe = ecdt_ptr->gpe;
+	boot_ec->command_addr = ecdt_ptr->control.address;
+	boot_ec->data_addr = ecdt_ptr->data.address;
+	boot_ec->gpe = ecdt_ptr->gpe;
 	/* use the GL just to be safe */
-	ec_ecdt->global_lock = TRUE;
-	ec_ecdt->uid = ecdt_ptr->uid;
-	ec_ecdt->handle = ACPI_ROOT_OBJECT;
+	boot_ec->global_lock = TRUE;
+	boot_ec->uid = ecdt_ptr->uid;
+	boot_ec->handle = ACPI_ROOT_OBJECT;
 
-	ret = ec_install_handlers(ec_ecdt);
+	ret = ec_install_handlers(boot_ec);
 	if (!ret)
 		return 0;
       error:
-	kfree(ec_ecdt);
-	ec_ecdt = NULL;
+	kfree(boot_ec);
+	boot_ec = NULL;
 
 	return -ENODEV;
 }

>From nobody Thu Mar  1 01:31:40 2007
Subject: [PATCH 8/9] ACPI: EC: first_ec is better to be acpi_ec than
	acpi_device.
To: Alexey Starikovskiy <aystarik@gmail.com>
Date: Thu, 01 Mar 2007 01:31:40 +0300
Message-ID: <20070228223140.3871.44078.stgit@mstrcsd125.ims.intel.com>
In-Reply-To: <20070228223137.3871.7998.stgit@mstrcsd125.ims.intel.com>
References: <20070228223137.3871.7998.stgit@mstrcsd125.ims.intel.com>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>



Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
---

 drivers/acpi/ec.c |   41 +++++++++++++----------------------------
 1 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 9ca87b6..fbfb256 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -91,6 +91,7 @@ static struct acpi_driver acpi_ec_driver
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
+/* External interfaces use first EC only, so remember */
 static struct acpi_ec {
 	acpi_handle handle;
 	unsigned long uid;
@@ -101,10 +102,7 @@ static struct acpi_ec {
 	struct mutex lock;
 	atomic_t query_pending;
 	wait_queue_head_t wait;
-} *boot_ec;
-
-/* External interfaces use first EC only, so remember */
-static struct acpi_device *first_ec;
+} *boot_ec, *first_ec;
 
 /* --------------------------------------------------------------------------
                              Transaction Management
@@ -295,38 +293,31 @@ static int acpi_ec_write(struct acpi_ec 
  */
 int ec_burst_enable(void)
 {
-	struct acpi_ec *ec;
 	if (!first_ec)
 		return -ENODEV;
-	ec = acpi_driver_data(first_ec);
-	return acpi_ec_burst_enable(ec);
+	return acpi_ec_burst_enable(first_ec);
 }
 
 EXPORT_SYMBOL(ec_burst_enable);
 
 int ec_burst_disable(void)
 {
-	struct acpi_ec *ec;
 	if (!first_ec)
 		return -ENODEV;
-	ec = acpi_driver_data(first_ec);
-	return acpi_ec_burst_disable(ec);
+	return acpi_ec_burst_disable(first_ec);
 }
 
 EXPORT_SYMBOL(ec_burst_disable);
 
 int ec_read(u8 addr, u8 * val)
 {
-	struct acpi_ec *ec;
 	int err;
 	u8 temp_data;
 
 	if (!first_ec)
 		return -ENODEV;
 
-	ec = acpi_driver_data(first_ec);
-
-	err = acpi_ec_read(ec, addr, &temp_data);
+	err = acpi_ec_read(first_ec, addr, &temp_data);
 
 	if (!err) {
 		*val = temp_data;
@@ -339,15 +330,12 @@ EXPORT_SYMBOL(ec_read);
 
 int ec_write(u8 addr, u8 val)
 {
-	struct acpi_ec *ec;
 	int err;
 
 	if (!first_ec)
 		return -ENODEV;
 
-	ec = acpi_driver_data(first_ec);
-
-	err = acpi_ec_write(ec, addr, val);
+	err = acpi_ec_write(first_ec, addr, val);
 
 	return err;
 }
@@ -358,14 +346,10 @@ int ec_transaction(u8 command,
 		   const u8 * wdata, unsigned wdata_len,
 		   u8 * rdata, unsigned rdata_len)
 {
-	struct acpi_ec *ec;
-
 	if (!first_ec)
 		return -ENODEV;
 
-	ec = acpi_driver_data(first_ec);
-
-	return acpi_ec_transaction(ec, command, wdata,
+	return acpi_ec_transaction(first_ec, command, wdata,
 				   wdata_len, rdata, rdata_len);
 }
 
@@ -649,11 +633,10 @@ static int acpi_ec_add(struct acpi_devic
 			kfree(ec);
 			ec = boot_ec;
 		}
-	}
+	} else
+		first_ec = ec;
 	ec->handle = device->handle;
 	acpi_driver_data(device) = ec;
-	if (!first_ec)
-		first_ec = device;
 
 	acpi_ec_add_fs(device);
 
@@ -676,7 +659,7 @@ static int acpi_ec_remove(struct acpi_de
 	acpi_ec_remove_fs(device);
 
 	acpi_driver_data(device) = NULL;
-	if (device == first_ec)
+	if (ec == first_ec)
 		first_ec = NULL;
 
 	/* Don't touch boot EC */
@@ -842,8 +825,10 @@ int __init acpi_ec_ecdt_probe(void)
 	boot_ec->handle = ACPI_ROOT_OBJECT;
 
 	ret = ec_install_handlers(boot_ec);
-	if (!ret)
+	if (!ret) {
+		first_ec = boot_ec;
 		return 0;
+	}
       error:
 	kfree(boot_ec);
 	boot_ec = NULL;

>From nobody Thu Mar  1 01:31:41 2007
Subject: [PATCH 9/9] ACPI: EC: Cleanup of EC initialization
To: Alexey Starikovskiy <aystarik@gmail.com>
Date: Thu, 01 Mar 2007 01:31:41 +0300
Message-ID: <20070228223140.3871.52456.stgit@mstrcsd125.ims.intel.com>
In-Reply-To: <20070228223137.3871.7998.stgit@mstrcsd125.ims.intel.com>
References: <20070228223137.3871.7998.stgit@mstrcsd125.ims.intel.com>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>



Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
---

 drivers/acpi/ec.c |   32 +++++++++++++-------------------
 1 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index fbfb256..fce38fe 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1,6 +1,8 @@
 /*
- *  acpi_ec.c - ACPI Embedded Controller Driver ($Revision: 38 $)
+ *  ec.c - ACPI Embedded Controller Driver (v2.0)
  *
+ *  Copyright (C) 2006, 2007 Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
+ *  Copyright (C) 2006 Denis Sadykov <denis.m.sadykov@intel.com>
  *  Copyright (C) 2004 Luming Yu <luming.yu@intel.com>
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
@@ -94,7 +96,6 @@ static struct acpi_driver acpi_ec_driver
 /* External interfaces use first EC only, so remember */
 static struct acpi_ec {
 	acpi_handle handle;
-	unsigned long uid;
 	unsigned long gpe;
 	unsigned long command_addr;
 	unsigned long data_addr;
@@ -520,13 +521,11 @@ static int acpi_ec_read_info(struct seq_
 	if (!ec)
 		goto end;
 
-	seq_printf(seq, "gpe:                 0x%02x\n", (u32) ec->gpe);
-	seq_printf(seq, "ports:                   0x%02x, 0x%02x\n",
-		   (u32) ec->command_addr, (u32) ec->data_addr);
-	seq_printf(seq, "use global lock:         %s\n",
+	seq_printf(seq, "gpe:\t\t\t0x%02x\n", (u32) ec->gpe);
+	seq_printf(seq, "ports:\t\t\t0x%02x, 0x%02x\n",
+		   (unsigned)ec->command_addr, (unsigned)ec->data_addr);
+	seq_printf(seq, "use global lock:\t%s\n",
 		   ec->global_lock ? "yes" : "no");
-	acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
-
       end:
 	return 0;
 }
@@ -649,15 +648,13 @@ static int acpi_ec_add(struct acpi_devic
 
 static int acpi_ec_remove(struct acpi_device *device, int type)
 {
-	struct acpi_ec *ec = NULL;
+	struct acpi_ec *ec;
 
 	if (!device)
 		return -EINVAL;
 
 	ec = acpi_driver_data(device);
-
 	acpi_ec_remove_fs(device);
-
 	acpi_driver_data(device) = NULL;
 	if (ec == first_ec)
 		first_ec = NULL;
@@ -665,7 +662,6 @@ static int acpi_ec_remove(struct acpi_de
 	/* Don't touch boot EC */
 	if (boot_ec != ec)
 		kfree(ec);
-
 	return 0;
 }
 
@@ -674,22 +670,20 @@ ec_parse_io_ports(struct acpi_resource *
 {
 	struct acpi_ec *ec = context;
 
-	if (resource->type != ACPI_RESOURCE_TYPE_IO) {
+	if (resource->type != ACPI_RESOURCE_TYPE_IO)
 		return AE_OK;
-	}
 
 	/*
 	 * The first address region returned is the data port, and
 	 * the second address region returned is the status/command
 	 * port.
 	 */
-	if (ec->data_addr == 0) {
+	if (ec->data_addr == 0)
 		ec->data_addr = resource->data.io.minimum;
-	} else if (ec->command_addr == 0) {
+	else if (ec->command_addr == 0)
 		ec->command_addr = resource->data.io.minimum;
-	} else {
+	else
 		return AE_CTRL_TERMINATE;
-	}
 
 	return AE_OK;
 }
@@ -702,6 +696,7 @@ static int ec_install_handlers(struct ac
 					  &acpi_ec_gpe_handler, ec);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
+
 	acpi_set_gpe_type(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
 	acpi_enable_gpe(NULL, ec->gpe, ACPI_NOT_ISR);
 
@@ -821,7 +816,6 @@ int __init acpi_ec_ecdt_probe(void)
 	boot_ec->gpe = ecdt_ptr->gpe;
 	/* use the GL just to be safe */
 	boot_ec->global_lock = TRUE;
-	boot_ec->uid = ecdt_ptr->uid;
 	boot_ec->handle = ACPI_ROOT_OBJECT;
 
 	ret = ec_install_handlers(boot_ec);


--------------040908000308030602030004--
