From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: acpi on new gateway laptops
Date: Tue, 18 Nov 2003 16:11:39 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031118151139.GA32464@poupinou.org>
References: <20031112232315.GD430@masanjin.net> <20031112233328.GE430@masanjin.net> <20031113001013.GE32464@poupinou.org> <20031113170333.GA2336@masanjin.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4bRzO86E/ozDv8r1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031113170333.GA2336-xW3KcqxHEMnk1uMJSBkQmQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: William Morgan <wmorgan-acpi-devel-xW3KcqxHEMnk1uMJSBkQmQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 13, 2003 at 12:03:33PM -0500, William Morgan wrote:
> Hi Ducrot,
> 
> Excerpts (reformatted) from Ducrot Bruno's mail of 12 Nov 2003 (EST):
> > I think that we should do a fake ECDT option.  That is straightforward
> > to implement anyway.
> 
> I'm happy to hear you say this is straightforward, but I have no idea
> how to do this.
> 
> What do I put in the fake ECDT?
> 

Well, I forgot that ECDT support is somewhat still buggy.  Here is anyway
a patch, but for 2.4.23-rc1.  It sucks like hell, though, but
it should work.  I needed to get a patch from Shaohua, but I needed
to look a little bit inside, due to compilation warnings.
Then the patch for faking an ECDT can be done.  The attachement include
both patchs.  When Shaohua work will be included in 2.4 mainstream,
I will go for a bit more cleaner patch.

I don't request this patch being in mainstream, because it is more
an hack, and need therefore to be rewrotten.

On boot, supply something like that:

ecdt_fake=0x66:0x62:5:-1:\\_SB.PCI0.PIB.EC0

where 0x66 is for the command port, 0x62, the data one,
5 is the gpe_bit number, -1 is the uid (when there is
no uid in the DSDT, then just pass -1), and the full
path to the EC (for me, it is \_SB.PCI0.PIB.EC0).

Note that the double \\, needed for lilo.  I must
admit I don't know if that's true for grub.

On lilo, I make something like that:

append="ecdt_fake=0x66:0x62:5:-1:\\_SB.PCI0.PIB.EC0"

Of course, you need at first to get the info from your DSDT at
really first.


Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.

--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="10_fake_ecdt.diff"

--- orig/linux-2.4.23-rc1/drivers/acpi//acpi_ksyms.c	2003-08-25 13:44:40.000000000 +0200
+++ linux-2.4.23-rc1/drivers/acpi//acpi_ksyms.c	2003-11-18 15:24:32.000000000 +0100
@@ -102,7 +102,7 @@
 EXPORT_SYMBOL(acpi_os_create_semaphore);
 EXPORT_SYMBOL(acpi_os_delete_semaphore);
 EXPORT_SYMBOL(acpi_os_wait_semaphore);
-
+EXPORT_SYMBOL(acpi_os_wait_events_complete);
 EXPORT_SYMBOL(acpi_os_read_pci_configuration);
 
 /* ACPI Utilities (acpi_utils.c) */
--- orig/linux-2.4.23-rc1/drivers/acpi//ec.c	2003-11-18 15:53:02.000000000 +0100
+++ linux-2.4.23-rc1/drivers/acpi//ec.c	2003-11-18 15:50:00.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- *  acpi_ec.c - ACPI Embedded Controller Driver ($Revision: 36 $)
+ *  acpi_ec.c - ACPI Embedded Controller Driver ($Revision: 1.1 $)
  *
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
@@ -87,6 +87,11 @@
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
 static struct acpi_ec	*ec_ecdt;
 
+/* Fake an ECDT, if the BIOS do not provide one, but we need it though */
+static int is_ecdt_fake = 0;
+static struct acpi_ec ecdt_fake;
+static char ecdt_fake_id[255];
+
 /* External interfaces use first EC only, so remember */
 static struct acpi_device *first_ec;
 
@@ -585,12 +590,16 @@
 	   we now have the *real* EC info, so kill the makeshift one.*/
 	acpi_evaluate_integer(ec->handle, "_UID", NULL, &uid);
 	if (ec_ecdt && ec_ecdt->uid == uid) {
+		acpi_disable_gpe(NULL, ec_ecdt->gpe_bit, ACPI_NOT_ISR);
+		acpi_os_wait_events_complete(ec_ecdt);
 		acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
 			ACPI_ADR_SPACE_EC, &acpi_ec_space_handler);
 	
 		acpi_remove_gpe_handler(NULL, ec_ecdt->gpe_bit, &acpi_ec_gpe_handler);
 
-		kfree(ec_ecdt);
+		if (!is_ecdt_fake)
+			kfree(ec_ecdt);
+		ec_ecdt = NULL;
 	}
 
 	/* Get GPE bit assignment (EC events). */
@@ -747,6 +756,9 @@
 
 	ec = acpi_driver_data(device);
 
+	acpi_disable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
+	acpi_os_wait_events_complete(ec);
+
 	status = acpi_remove_address_space_handler(ec->handle,
 		ACPI_ADR_SPACE_EC, &acpi_ec_space_handler);
 	if (ACPI_FAILURE(status))
@@ -766,31 +778,38 @@
 	acpi_status		status;
 	struct acpi_table_ecdt 	*ecdt_ptr;
 
-	status = acpi_get_firmware_table("ECDT", 1, ACPI_LOGICAL_ADDRESSING, 
-		(struct acpi_table_header **) &ecdt_ptr);
-	if (ACPI_FAILURE(status))
-		return 0;
+	if (!is_ecdt_fake) {
+		status = acpi_get_firmware_table("ECDT", 1, ACPI_LOGICAL_ADDRESSING, 
+			(struct acpi_table_header **) &ecdt_ptr);
+		if (ACPI_FAILURE(status))
+			return 0;
 
-	printk(KERN_INFO PREFIX "Found ECDT\n");
+		printk(KERN_INFO PREFIX "Found ECDT\n");
 
-	 /*
-	 * Generate a temporary ec context to use until the namespace is scanned
-	 */
-	ec_ecdt = kmalloc(sizeof(struct acpi_ec), GFP_KERNEL);
-	if (!ec_ecdt)
-		return -ENOMEM;
-	memset(ec_ecdt, 0, sizeof(struct acpi_ec));
-
-	ec_ecdt->command_addr = ecdt_ptr->ec_control;
-	ec_ecdt->status_addr = ecdt_ptr->ec_control;
-	ec_ecdt->data_addr = ecdt_ptr->ec_data;
-	ec_ecdt->gpe_bit = ecdt_ptr->gpe_bit;
-	ec_ecdt->lock = SPIN_LOCK_UNLOCKED;
-	/* use the GL just to be safe */
-	ec_ecdt->global_lock = TRUE;
-	ec_ecdt->uid = ecdt_ptr->uid;
+		 /*
+		 * Generate a temporary ec context to use until the namespace is scanned
+		 */
+		ec_ecdt = kmalloc(sizeof(struct acpi_ec), GFP_KERNEL);
+		if (!ec_ecdt)
+			return -ENOMEM;
+		memset(ec_ecdt, 0, sizeof(struct acpi_ec));
+
+		ec_ecdt->command_addr = ecdt_ptr->ec_control;
+		ec_ecdt->status_addr = ecdt_ptr->ec_control;
+		ec_ecdt->data_addr = ecdt_ptr->ec_data;
+		ec_ecdt->gpe_bit = ecdt_ptr->gpe_bit;
+		ec_ecdt->lock = SPIN_LOCK_UNLOCKED;
+		/* use the GL just to be safe */
+		ec_ecdt->global_lock = TRUE;
+		ec_ecdt->uid = ecdt_ptr->uid;
+	} else {
+		if (ec_ecdt)
+			printk(KERN_INFO PREFIX "Faking ECDT\n");
+		else
+			printk(KERN_INFO PREFIX "Can't fake ECDT.  Bug?\n");
+	}
 
-	status = acpi_get_handle(NULL, ecdt_ptr->ec_id, &ec_ecdt->handle);
+	status = acpi_get_handle(NULL, is_ecdt_fake ? ecdt_fake_id : ecdt_ptr->ec_id, &ec_ecdt->handle);
 	if (ACPI_FAILURE(status)) {
 		goto error;
 	}
@@ -818,7 +837,8 @@
 
 error:
 	printk(KERN_ERR PREFIX "Could not use ECDT\n");
-	kfree(ec_ecdt);
+	if (!is_ecdt_fake)
+		kfree(ec_ecdt);
 	ec_ecdt = NULL;
 
 	return -ENODEV;
@@ -845,6 +865,89 @@
 	return_VALUE(0);
 }
 
+int __init
+acpi_fake_ecdt_setup(char *str)
+{
+	u64 control;
+	u64 data;
+	unsigned long gpe_bit;
+	unsigned long uid;
+//	char *handle;
+	struct acpi_generic_address reg;
+
+	if (!str || !*str)
+		return 0;
+
+	control = simple_strtoull(str, &str, 0);
+	if (!control || !str || *str != ':')
+		return 0;
+	str++;
+
+	data = simple_strtoull(str, &str, 0);
+	if (!data || !str || *str != ':')
+		return 0;
+	str++;
+
+	gpe_bit = simple_strtoul(str, &str, 0);
+	if (!str || *str != ':')
+		return 0;
+	str++;
+
+	/* uid made be -1 */
+	uid = simple_strtol(str, &str, 0);
+	if (!str || *str != ':')
+		return 0;
+	str++;
+
+	memset(ecdt_fake_id, 0, 255);
+	strncpy(ecdt_fake_id, str, strlen(str));
+#if 0
+	handle = kmalloc(strlen(str)+1, GFP_KERNEL);
+	if (!handle)
+		return 0;
+	strncpy(handle, str, strlen(str));
+#endif
+	// strncpy(ecdt_fake_handle, str, strlen(str));
+
+#if 0
+	ec_ecdt = kmalloc(sizeof(struct acpi_ec), GFP_KERNEL);
+	if (!ec_ecdt) {
+		kfree(handle);
+		return 0;
+	}
+#endif
+
+	ec_ecdt = &ecdt_fake;
+	memset(ec_ecdt, 0, sizeof(struct acpi_ec));
+
+	memset(&reg, 0, sizeof(reg));
+	reg.address_space_id = ACPI_ADR_SPACE_SYSTEM_IO;
+	reg.register_bit_width = 8;
+	reg.register_bit_offset = 0;
+
+	memcpy(&ec_ecdt->command_addr, &reg, sizeof(reg));
+	memcpy(&ec_ecdt->status_addr, &reg, sizeof(reg));
+	memcpy(&ec_ecdt->data_addr, &reg, sizeof(reg));
+
+	ec_ecdt->command_addr.address = control;
+	ec_ecdt->status_addr.address = control;
+	ec_ecdt->data_addr.address = data;
+	ec_ecdt->gpe_bit = gpe_bit;
+	ec_ecdt->lock = SPIN_LOCK_UNLOCKED;
+	/* use the GL just to be safe */
+	ec_ecdt->global_lock = TRUE;
+	ec_ecdt->uid = uid;
+	// ec_ecdt->handle = handle;
+
+	is_ecdt_fake = 1;
+
+	return 1;
+
+}
+
+__setup("ecdt_fake=", acpi_fake_ecdt_setup);
+
+
 /* EC can't be unloaded atm, so don't compile these */
 #if 0
 void __exit
--- orig/linux-2.4.23-rc1/drivers/acpi//osl.c	2003-08-25 13:44:41.000000000 +0200
+++ linux-2.4.23-rc1/drivers/acpi//osl.c	2003-11-18 15:35:27.000000000 +0100
@@ -54,6 +54,7 @@
 {
     OSD_EXECUTION_CALLBACK  function;
     void		    *context;
+    struct list_head	    next;
 };
 
 
@@ -611,25 +612,36 @@
 
 #endif /*CONFIG_ACPI_PCI*/
 
-static void
-acpi_os_execute_deferred (
-	void *context)
-{
-	struct acpi_os_dpc	*dpc = NULL;
-
-	ACPI_FUNCTION_TRACE ("os_execute_deferred");
-
-	dpc = (struct acpi_os_dpc *) context;
-	if (!dpc) {
-		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Invalid (NULL) context.\n"));
-		return_VOID;
+/*
+ * ACPI use kernel thread to handle SCI interrupt. Every SCI interrupt will add 
+ * a new entry in the acpi events queue. And keventd will execute the queue.The 
+ * purpose to implement the new queue is to provide a mechanism in which we can
+ * wait for completing SCI interrupt handling. In this way, before EC replaced 
+ * ECDT, it can guarantee all SCI interrupts with ECDT as its context complete.
+ */
+static LIST_HEAD(acpi_events_list);
+static spinlock_t acpi_events_list_spinlock = SPIN_LOCK_UNLOCKED;
+static struct tq_struct	task;
+static int		first_acpi_event = 1;
+
+static void 
+do_acpi_task_queue(void *dummy)
+{
+	struct list_head 	*p;
+	struct acpi_os_dpc 	*dpc;
+	unsigned long 		flags = 0;
+
+   	spin_lock_irqsave(&acpi_events_list_spinlock, flags);	
+	while (!list_empty(&acpi_events_list)) {
+		p = acpi_events_list.next;		/* get first item */
+		dpc = (struct acpi_os_dpc *)list_entry(p, struct acpi_os_dpc, next);
+		list_del(p);
+		spin_unlock_irqrestore(&acpi_events_list_spinlock, flags);
+		dpc->function(dpc->context);
+		kfree(dpc);
+		spin_lock_irqsave(&acpi_events_list_spinlock, flags);
 	}
-
-	dpc->function(dpc->context);
-
-	kfree(dpc);
-
-	return_VOID;
+	spin_unlock_irqrestore(&acpi_events_list_spinlock, flags);
 }
 
 acpi_status
@@ -639,45 +651,63 @@
 	void			*context)
 {
 	acpi_status 		status = AE_OK;
-	struct acpi_os_dpc	*dpc = NULL;
-	struct tq_struct	*task;
+	struct acpi_os_dpc	*dpc;
 
-	ACPI_FUNCTION_TRACE ("os_queue_for_execution");
+	ACPI_FUNCTION_TRACE ("acpi_os_queue_for_execution");
 
 	ACPI_DEBUG_PRINT ((ACPI_DB_EXEC, "Scheduling function [%p(%p)] for deferred execution.\n", function, context));
 
 	if (!function)
 		return_ACPI_STATUS (AE_BAD_PARAMETER);
-
-	/*
-	 * Allocate/initialize DPC structure.  Note that this memory will be
-	 * freed by the callee.  The kernel handles the tq_struct list  in a
-	 * way that allows us to also free its memory inside the callee.
-	 * Because we may want to schedule several tasks with different
-	 * parameters we can't use the approach some kernel code uses of
-	 * having a static tq_struct.
-	 * We can save time and code by allocating the DPC and tq_structs
-	 * from the same memory.
-	 */
-	dpc = kmalloc(sizeof(struct acpi_os_dpc)+sizeof(struct tq_struct), GFP_ATOMIC);
+	dpc = kmalloc(sizeof(struct acpi_os_dpc), GFP_ATOMIC);
 	if (!dpc)
 		return_ACPI_STATUS (AE_NO_MEMORY);
 
 	dpc->function = function;
 	dpc->context = context;
-
-	task = (void *)(dpc+1);
-	INIT_TQUEUE(task, acpi_os_execute_deferred, (void*)dpc);
-
-	if (!schedule_task(task)) {
-		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Call to schedule_task() failed.\n"));
-		kfree(dpc);
-		status = AE_ERROR;
+	INIT_LIST_HEAD(&dpc->next);
+	
+	spin_lock(&acpi_events_list_spinlock);
+	list_add_tail(&dpc->next, &acpi_events_list);
+	if (first_acpi_event || (!task.sync)) {
+		INIT_TQUEUE(&task, do_acpi_task_queue, NULL);
+		if (!schedule_task(&task)) {
+			ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Call to schedule_work() failed.\n"));
+			kfree(dpc);
+			status = AE_ERROR;
+		}
+		first_acpi_event = 0;
 	}
+	spin_unlock(&acpi_events_list_spinlock);
 
 	return_ACPI_STATUS (status);
 }
 
+void acpi_os_wait_events_complete(
+	void * context)
+{
+	unsigned long		flags;
+	int			over = 0;
+	struct list_head * node, * next;
+
+	while (!over) {
+		over = 1;
+		spin_lock_irqsave(&acpi_events_list_spinlock, flags);
+	 	list_for_each_safe(node, next, &acpi_events_list) {
+			struct acpi_os_dpc *dpc = list_entry(node, struct acpi_os_dpc, next);
+			if (dpc->context == context) {
+				over = 0;
+				break;
+			}
+	 	}
+
+		spin_unlock_irqrestore(&acpi_events_list_spinlock, flags);
+		if (over)
+			return;
+		do_acpi_task_queue(NULL);
+	}
+}
+
 /*
  * Allocate the memory for a spinlock and initialize it.
  */

--4bRzO86E/ozDv8r1--


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
