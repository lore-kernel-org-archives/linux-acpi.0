From: mochel@linux.intel.com
Subject: [PATCH 8/24] Remove unneeded debugging macros in drivers/acpi/ec.c
Date: Mon, 17 Apr 2006 18:21:53 -0700
Message-ID: <11453233132040-git-send-email-mochel@linux.intel.com>
References: <1145323313872-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:59791 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932116AbWDRBZZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:25 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr002.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1POBH025141
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:24 GMT
In-Reply-To: <1145323313872-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/ec.c |  165 +++++++++++++++++++----------------------------------
 1 files changed, 60 insertions(+), 105 deletions(-)

applies-to: cf24a0e712f1477d5d680c4649c79c0c83e2885b
98488685dd4e5edcb7b4cd83996082a5a9e7eaca
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 8745af7..943c382 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -207,8 +207,6 @@ static int acpi_ec_intr_wait(union acpi_
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_ec_wait");
-
 	ec->intr.expect_event = event;
 	smp_mb();
 
@@ -216,7 +214,7 @@ static int acpi_ec_intr_wait(union acpi_
 	case ACPI_EC_EVENT_IBE:
 		if (~acpi_ec_read_status(ec) & event) {
 			ec->intr.expect_event = 0;
-			return_VALUE(0);
+			return 0;
 		}
 		break;
 	default:
@@ -238,16 +236,16 @@ static int acpi_ec_intr_wait(union acpi_
 	switch (event) {
 	case ACPI_EC_EVENT_OBF:
 		if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_OBF)
-			return_VALUE(0);
+			return 0;
 		break;
 
 	case ACPI_EC_EVENT_IBE:
 		if (~acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF)
-			return_VALUE(0);
+			return 0;
 		break;
 	}
 
-	return_VALUE(-ETIME);
+	return -ETIME;
 }
 
 #ifdef ACPI_FUTURE_USAGE
@@ -260,8 +258,6 @@ int acpi_ec_enter_burst_mode(union acpi_
 	u32 tmp = 0;
 	int status = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_ec_enter_burst_mode");
-
 	status = acpi_ec_read_status(ec);
 	if (status != -EINVAL && !(status & ACPI_EC_FLAG_BURST)) {
 		status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
@@ -272,23 +268,21 @@ int acpi_ec_enter_burst_mode(union acpi_
 		status = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
 		acpi_hw_low_level_read(8, &tmp, &ec->common.data_addr);
 		if (tmp != 0x90) {	/* Burst ACK byte */
-			return_VALUE(-EINVAL);
+			return -EINVAL;
 		}
 	}
 
 	atomic_set(&ec->intr.leaving_burst, 0);
-	return_VALUE(0);
+	return 0;
       end:
 	ACPI_EXCEPTION ((AE_INFO, status, "EC wait, burst mode");
-	return_VALUE(-1);
+	return -1;
 }
 
 int acpi_ec_leave_burst_mode(union acpi_ec *ec)
 {
 	int status = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_ec_leave_burst_mode");
-
 	status = acpi_ec_read_status(ec);
 	if (status != -EINVAL && (status & ACPI_EC_FLAG_BURST)){
 		status = acpi_ec_wait(ec, ACPI_EC_FLAG_IBF);
@@ -298,10 +292,10 @@ int acpi_ec_leave_burst_mode(union acpi_
 		acpi_ec_wait(ec, ACPI_EC_FLAG_IBF);
 	} 
 	atomic_set(&ec->intr.leaving_burst, 1);
-	return_VALUE(0);
+	return 0;
 end:
 	ACPI_EXCEPTION((AE_INFO, status, "EC leave burst mode");
-	return_VALUE(-1);
+	return -1;
 }
 #endif /* ACPI_FUTURE_USAGE */
 
@@ -326,17 +320,15 @@ static int acpi_ec_poll_read(union acpi_
 	unsigned long flags = 0;
 	u32 glk = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_ec_read");
-
 	if (!ec || !data)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	*data = 0;
 
 	if (ec->common.global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
 		if (ACPI_FAILURE(status))
-			return_VALUE(-ENODEV);
+			return -ENODEV;
 	}
 
 	spin_lock_irqsave(&ec->poll.lock, flags);
@@ -363,7 +355,7 @@ static int acpi_ec_poll_read(union acpi_
 	if (ec->common.global_lock)
 		acpi_release_global_lock(glk);
 
-	return_VALUE(result);
+	return result;
 }
 
 static int acpi_ec_poll_write(union acpi_ec *ec, u8 address, u8 data)
@@ -373,15 +365,13 @@ static int acpi_ec_poll_write(union acpi
 	unsigned long flags = 0;
 	u32 glk = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_ec_write");
-
 	if (!ec)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (ec->common.global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
 		if (ACPI_FAILURE(status))
-			return_VALUE(-ENODEV);
+			return -ENODEV;
 	}
 
 	spin_lock_irqsave(&ec->poll.lock, flags);
@@ -411,7 +401,7 @@ static int acpi_ec_poll_write(union acpi
 	if (ec->common.global_lock)
 		acpi_release_global_lock(glk);
 
-	return_VALUE(result);
+	return result;
 }
 
 static int acpi_ec_intr_read(union acpi_ec *ec, u8 address, u32 * data)
@@ -419,17 +409,15 @@ static int acpi_ec_intr_read(union acpi_
 	int status = 0;
 	u32 glk;
 
-	ACPI_FUNCTION_TRACE("acpi_ec_read");
-
 	if (!ec || !data)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	*data = 0;
 
 	if (ec->common.global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
 		if (ACPI_FAILURE(status))
-			return_VALUE(-ENODEV);
+			return -ENODEV;
 	}
 
 	WARN_ON(in_interrupt());
@@ -463,7 +451,7 @@ static int acpi_ec_intr_read(union acpi_
 	if (ec->common.global_lock)
 		acpi_release_global_lock(glk);
 
-	return_VALUE(status);
+	return status;
 }
 
 static int acpi_ec_intr_write(union acpi_ec *ec, u8 address, u8 data)
@@ -471,15 +459,13 @@ static int acpi_ec_intr_write(union acpi
 	int status = 0;
 	u32 glk;
 
-	ACPI_FUNCTION_TRACE("acpi_ec_write");
-
 	if (!ec)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (ec->common.global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
 		if (ACPI_FAILURE(status))
-			return_VALUE(-ENODEV);
+			return -ENODEV;
 	}
 
 	WARN_ON(in_interrupt());
@@ -512,7 +498,7 @@ static int acpi_ec_intr_write(union acpi
 	if (ec->common.global_lock)
 		acpi_release_global_lock(glk);
 
-	return_VALUE(status);
+	return status;
 }
 
 /*
@@ -571,17 +557,15 @@ static int acpi_ec_poll_query(union acpi
 	unsigned long flags = 0;
 	u32 glk = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_ec_query");
-
 	if (!ec || !data)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	*data = 0;
 
 	if (ec->common.global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
 		if (ACPI_FAILURE(status))
-			return_VALUE(-ENODEV);
+			return -ENODEV;
 	}
 
 	/*
@@ -607,23 +591,21 @@ static int acpi_ec_poll_query(union acpi
 	if (ec->common.global_lock)
 		acpi_release_global_lock(glk);
 
-	return_VALUE(result);
+	return result;
 }
 static int acpi_ec_intr_query(union acpi_ec *ec, u32 * data)
 {
 	int status = 0;
 	u32 glk;
 
-	ACPI_FUNCTION_TRACE("acpi_ec_query");
-
 	if (!ec || !data)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 	*data = 0;
 
 	if (ec->common.global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
 		if (ACPI_FAILURE(status))
-			return_VALUE(-ENODEV);
+			return -ENODEV;
 	}
 
 	down(&ec->intr.sem);
@@ -656,7 +638,7 @@ static int acpi_ec_intr_query(union acpi
 	if (ec->common.global_lock)
 		acpi_release_global_lock(glk);
 
-	return_VALUE(status);
+	return status;
 }
 
 /* --------------------------------------------------------------------------
@@ -686,8 +668,6 @@ static void acpi_ec_gpe_poll_query(void 
 		'8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
 	};
 
-	ACPI_FUNCTION_TRACE("acpi_ec_gpe_query");
-
 	if (!ec_cxt)
 		goto end;
 
@@ -727,8 +707,6 @@ static void acpi_ec_gpe_intr_query(void 
 		'8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
 	};
 
-	ACPI_FUNCTION_TRACE("acpi_ec_gpe_query");
-
 	if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_SCI)
 		result = acpi_ec_query(ec, &value);
 
@@ -840,15 +818,13 @@ acpi_ec_space_handler(u32 function,
 	acpi_integer f_v = 0;
 	int i = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_ec_space_handler");
-
 	if ((address > 0xFF) || !value || !handler_context)
-		return_VALUE(AE_BAD_PARAMETER);
+		return AE_BAD_PARAMETER;
 
 	if (bit_width != 8 && acpi_strict) {
 		printk(KERN_WARNING PREFIX
 		       "acpi_ec_space_handler: bit_width should be 8\n");
-		return_VALUE(AE_BAD_PARAMETER);
+		return AE_BAD_PARAMETER;
 	}
 
 	ec = (union acpi_ec *)handler_context;
@@ -887,16 +863,16 @@ acpi_ec_space_handler(u32 function,
       out:
 	switch (result) {
 	case -EINVAL:
-		return_VALUE(AE_BAD_PARAMETER);
+		return AE_BAD_PARAMETER;
 		break;
 	case -ENODEV:
-		return_VALUE(AE_NOT_FOUND);
+		return AE_NOT_FOUND;
 		break;
 	case -ETIME:
-		return_VALUE(AE_TIME);
+		return AE_TIME;
 		break;
 	default:
-		return_VALUE(AE_OK);
+		return AE_OK;
 	}
 }
 
@@ -910,8 +886,6 @@ static int acpi_ec_read_info(struct seq_
 {
 	union acpi_ec *ec = (union acpi_ec *)seq->private;
 
-	ACPI_FUNCTION_TRACE("acpi_ec_read_info");
-
 	if (!ec)
 		goto end;
 
@@ -925,7 +899,7 @@ static int acpi_ec_read_info(struct seq_
 	acpi_enable_gpe(NULL, ec->common.gpe_bit, ACPI_NOT_ISR);
 
       end:
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_ec_info_open_fs(struct inode *inode, struct file *file)
@@ -945,39 +919,35 @@ static int acpi_ec_add_fs(struct acpi_de
 {
 	struct proc_dir_entry *entry = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_ec_add_fs");
-
 	if (!acpi_device_dir(device)) {
 		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
 						     acpi_ec_dir);
 		if (!acpi_device_dir(device))
-			return_VALUE(-ENODEV);
+			return -ENODEV;
 	}
 
 	entry = create_proc_entry(ACPI_EC_FILE_INFO, S_IRUGO,
 				  acpi_device_dir(device));
 	if (!entry)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	else {
 		entry->proc_fops = &acpi_ec_info_ops;
 		entry->data = acpi_driver_data(device);
 		entry->owner = THIS_MODULE;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_ec_remove_fs(struct acpi_device *device)
 {
-	ACPI_FUNCTION_TRACE("acpi_ec_remove_fs");
-
 	if (acpi_device_dir(device)) {
 		remove_proc_entry(ACPI_EC_FILE_INFO, acpi_device_dir(device));
 		remove_proc_entry(acpi_device_bid(device), acpi_ec_dir);
 		acpi_device_dir(device) = NULL;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 /* --------------------------------------------------------------------------
@@ -990,14 +960,12 @@ static int acpi_ec_poll_add(struct acpi_
 	acpi_status status = AE_OK;
 	union acpi_ec *ec = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_ec_add");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	ec = kmalloc(sizeof(union acpi_ec), GFP_KERNEL);
 	if (!ec)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	memset(ec, 0, sizeof(union acpi_ec));
 
 	ec->common.handle = device->handle;
@@ -1050,7 +1018,7 @@ static int acpi_ec_poll_add(struct acpi_
 	if (result)
 		kfree(ec);
 
-	return_VALUE(result);
+	return result;
 }
 static int acpi_ec_intr_add(struct acpi_device *device)
 {
@@ -1058,14 +1026,12 @@ static int acpi_ec_intr_add(struct acpi_
 	acpi_status status = AE_OK;
 	union acpi_ec *ec = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_ec_add");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	ec = kmalloc(sizeof(union acpi_ec), GFP_KERNEL);
 	if (!ec)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	memset(ec, 0, sizeof(union acpi_ec));
 
 	ec->common.handle = device->handle;
@@ -1121,17 +1087,15 @@ static int acpi_ec_intr_add(struct acpi_
 	if (result)
 		kfree(ec);
 
-	return_VALUE(result);
+	return result;
 }
 
 static int acpi_ec_remove(struct acpi_device *device, int type)
 {
 	union acpi_ec *ec = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_ec_remove");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	ec = acpi_driver_data(device);
 
@@ -1139,7 +1103,7 @@ static int acpi_ec_remove(struct acpi_de
 
 	kfree(ec);
 
-	return_VALUE(0);
+	return 0;
 }
 
 static acpi_status
@@ -1178,15 +1142,13 @@ static int acpi_ec_start(struct acpi_dev
 	acpi_status status = AE_OK;
 	union acpi_ec *ec = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_ec_start");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	ec = acpi_driver_data(device);
 
 	if (!ec)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	/*
 	 * Get I/O port addresses. Convert to GAS format.
@@ -1196,7 +1158,7 @@ static int acpi_ec_start(struct acpi_dev
 	if (ACPI_FAILURE(status)
 	    || ec->common.command_addr.register_bit_width == 0) {
 		ACPI_ERROR((AE_INFO, "Error getting I/O port addresses"));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	ec->common.status_addr = ec->common.command_addr;
@@ -1213,7 +1175,7 @@ static int acpi_ec_start(struct acpi_dev
 					  ACPI_GPE_EDGE_TRIGGERED,
 					  &acpi_ec_gpe_handler, ec);
 	if (ACPI_FAILURE(status)) {
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 	acpi_set_gpe_type(NULL, ec->common.gpe_bit, ACPI_GPE_TYPE_RUNTIME);
 	acpi_enable_gpe(NULL, ec->common.gpe_bit, ACPI_NOT_ISR);
@@ -1225,10 +1187,10 @@ static int acpi_ec_start(struct acpi_dev
 	if (ACPI_FAILURE(status)) {
 		acpi_remove_gpe_handler(NULL, ec->common.gpe_bit,
 					&acpi_ec_gpe_handler);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(AE_OK);
+	return AE_OK;
 }
 
 static int acpi_ec_stop(struct acpi_device *device, int type)
@@ -1236,10 +1198,8 @@ static int acpi_ec_stop(struct acpi_devi
 	acpi_status status = AE_OK;
 	union acpi_ec *ec = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_ec_stop");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	ec = acpi_driver_data(device);
 
@@ -1247,15 +1207,15 @@ static int acpi_ec_stop(struct acpi_devi
 						   ACPI_ADR_SPACE_EC,
 						   &acpi_ec_space_handler);
 	if (ACPI_FAILURE(status))
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	status =
 	    acpi_remove_gpe_handler(NULL, ec->common.gpe_bit,
 				    &acpi_ec_gpe_handler);
 	if (ACPI_FAILURE(status))
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
-	return_VALUE(0);
+	return 0;
 }
 
 static acpi_status __init
@@ -1525,23 +1485,21 @@ static int __init acpi_ec_init(void)
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_ec_init");
-
 	if (acpi_disabled)
-		return_VALUE(0);
+		return 0;
 
 	acpi_ec_dir = proc_mkdir(ACPI_EC_CLASS, acpi_root_dir);
 	if (!acpi_ec_dir)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	/* Now register the driver for the EC */
 	result = acpi_bus_register_driver(&acpi_ec_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_EC_CLASS, acpi_root_dir);
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
-	return_VALUE(result);
+	return result;
 }
 
 subsys_initcall(acpi_ec_init);
@@ -1550,13 +1508,10 @@ subsys_initcall(acpi_ec_init);
 #if 0
 static void __exit acpi_ec_exit(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_ec_exit");
-
 	acpi_bus_unregister_driver(&acpi_ec_driver);
 
 	remove_proc_entry(ACPI_EC_CLASS, acpi_root_dir);
 
-	return_VOID;
 }
 #endif				/* 0 */
 
---
0.99.9.GIT


