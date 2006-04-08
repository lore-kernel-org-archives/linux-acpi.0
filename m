From: Peter Wainwright <prw@ceiriog.eclipse.co.uk>
Subject: Linux does not correctly implement the ACPI specification
Date: Sat, 08 Apr 2006 11:52:36 +0100
Message-ID: <1144493556.8409.0.camel@localhost.localdomain>
References: <971FCB6690CD0E4898387DBF7552B90E04970A19@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Rd+zJfspsi+DyVBpjhwu"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [82.152.177.240] ([82.152.177.240]:63451 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S964831AbWDHKwz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 8 Apr 2006 06:52:55 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.6/8.13.6) with ESMTP id k38Ar6on009368
	for <linux-acpi@vger.kernel.org>; Sat, 8 Apr 2006 11:53:06 +0100
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E04970A19@orsmsx403.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--=-Rd+zJfspsi+DyVBpjhwu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Reference:
http://bugzilla.kernel.org/show_bug.cgi?id=5534

There has been no significant movement on this bug for months.
I can only conclude that the problem is only triggered by a few
very sophisticated DSDTs (the HP nx6125 among them) or has remained
unrecognized on other platforms. Nonetheless it seems to me that
Linux does not correctly implement the ACPI spec.

Therefore, I propose a solution with the patch attached.

Interpretation of control methods called in response to GPE events or
Notify events is confined to one single-threaded workqueue.

It is true that the AML interpreter is essentially single-threaded,
because it is protected by a mutex and therefore only one kernel thread
can be executing AML code at one time. However, this does NOT mean that
the execution of different control methods should not overlap. The ACPI
spec allows for the transfer of control between one method and another
when the AML calls Sleep, Acquire, Wait etc. (see the ACPI-CA
reference).

The way Sleep() is implemented in Linux, it calls schedule() and transfers
control to other kernel threads: but any other control method which is queued 
in the kacpid thread itself will not be able to run until the currently
executing control method is finished.

On the HP nx6125 laptop this is essential, otherwise the ACPI subsystem
will block, thermal events will not be processed, and the system will
overheat. http://bugzilla.kernel.org/show_bug.cgi?id=5534

So, if any of you have an nx6125, or an ACPI bug which you think may be
caused by the mechanism I have described, please try this patch.

This is my first attempt at a serious kernel hack, so please forgive
the state of it: this is work in progress. At least it should show one
approach to the problem. I'm sure it has loads of problems with respect
to locking, SMP, etc. which you will point out.

In order to enable the new behaviour you need to write a positive
integer (e.g. 10) to /proc/acpi/poolsize.

Instead of executing all the GPE and Notify handlers in the single
kacpid thread, we create a pool of worker threads and hand over the
work to them. These can now execute concurrently, though access to the
interpreter is still serialized by the use of a mutex. The thread pool
is allowed to grow dynamically up to the maximum size which is set by
the user by writing an integer to /proc/acpi/poolsize. If this integer
is 0 the thread pool is not used at all and the old behaviour is used.
You can also read /proc/acpi/poolsize to see the maximum pool size and
the currently allocated threads. There is a field "jiffies" in the
thread pool entry structure which is written when a thread finishes
execution of a control method. My intention is that in future this will
be used to reap unused threads.

Of course, the user-configurable pool size may not be necessary. We
might hard-code it. Or even allow the AML to create as many threads as
necessary (assuming we trust the BIOS).


Peter Wainwright (P.S. not the Apache/Perl expert).


--=-Rd+zJfspsi+DyVBpjhwu
Content-Disposition: attachment; filename=acpi-osl.patch
Content-Type: text/x-patch; name=acpi-osl.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -U3 -r linux-2.6.16-prw11-old/drivers/acpi/bus.c linux-2.6.16-prw11/drivers/acpi/bus.c
--- linux-2.6.16-prw11-old/drivers/acpi/bus.c	2006-01-03 03:21:10.000000000 +0000
+++ linux-2.6.16-prw11/drivers/acpi/bus.c	2006-04-08 08:25:09.000000000 +0100
@@ -664,6 +664,7 @@
 	int result = 0;
 	acpi_status status = AE_OK;
 	extern acpi_status acpi_os_initialize1(void);
+	extern acpi_status acpi_os_initialize2(void);
 
 	ACPI_FUNCTION_TRACE("acpi_bus_init");
 
@@ -727,6 +728,8 @@
 	 */
 	acpi_root_dir = proc_mkdir(ACPI_BUS_FILE_ROOT, NULL);
 
+	status = acpi_os_initialize2();
+
 	return_VALUE(0);
 
 	/* Mimic structured exception handling */
diff -U3 -r linux-2.6.16-prw11-old/drivers/acpi/osl.c linux-2.6.16-prw11/drivers/acpi/osl.c
--- linux-2.6.16-prw11-old/drivers/acpi/osl.c	2006-04-08 07:50:57.000000000 +0100
+++ linux-2.6.16-prw11/drivers/acpi/osl.c	2006-04-08 09:10:05.000000000 +0100
@@ -46,6 +46,10 @@
 
 #include <linux/efi.h>
 
+#include <linux/kthread.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+
 #define _COMPONENT		ACPI_OS_SERVICES
 ACPI_MODULE_NAME("osl")
 #define PREFIX		"ACPI: "
@@ -76,6 +80,165 @@
 static void *acpi_irq_context;
 static struct workqueue_struct *kacpid_wq;
 
+/* This parameter may be configured at runtime by writing to
+   /proc/acpi/poolsize */
+static int max_thread_pool_size = 0;
+
+/* Hopefully we need no special locking here, since this always
+   executes in one thread: kacpid */
+static int thread_pool_size = 0;
+static struct list_head thread_pool = LIST_HEAD_INIT(thread_pool);
+
+struct thread_pool_entry {
+	struct task_struct *thread;
+	int id;
+	int active;
+	acpi_osd_exec_callback function;
+	void *context;
+	unsigned long jiffies;
+	wait_queue_head_t more_work;
+	wait_queue_head_t work_done;
+	struct list_head list;
+};
+
+static int acpi_osl_poolsize_read(struct seq_file *seq, void *offset)
+{
+	struct list_head *l;
+
+	ACPI_FUNCTION_TRACE("acpi_osl_poolsize_read");
+
+	seq_printf(seq, "poolsize=%d\n", max_thread_pool_size);
+	/* FIXME: Need lock? */
+	list_for_each(l, &thread_pool) {
+		struct thread_pool_entry *e = list_entry(l, struct thread_pool_entry, list);
+		seq_printf(seq, "entry=(%p,%d,%p,%p)\n",
+			   e->thread, e->active, e->function, e->context);
+	}
+	return_VALUE(0);
+}
+
+static int acpi_osl_poolsize_open_fs(struct inode *inode, struct file *file)
+{
+	return single_open(file, acpi_osl_poolsize_read, PDE(inode)->data);
+}
+
+static ssize_t
+acpi_osl_poolsize_write(struct file *file,
+			   const char __user * buffer,
+			   size_t count, loff_t * ppos)
+{
+	char *size_string;
+
+	ACPI_FUNCTION_TRACE("acpi_osl_poolsize_write");
+
+	size_string = kmalloc(4096, GFP_KERNEL);
+	if (!size_string)
+		return_VALUE(-ENOMEM);
+
+	memset(size_string, 0, 4096);
+
+	if (copy_from_user(size_string, buffer, count)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid data\n"));
+		count = -EFAULT;
+		goto end;
+	}
+
+	size_string[count] = '\0';
+	max_thread_pool_size = simple_strtol(size_string, NULL, 10);
+	ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Poolsize now %d\n", max_thread_pool_size));
+
+end:
+	kfree(size_string);
+	return_VALUE(count);
+}
+
+static struct file_operations acpi_osl_poolsize_ops = {
+	.open = acpi_osl_poolsize_open_fs,
+	.read = seq_read,
+	.write = acpi_osl_poolsize_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+/* This is based on workqueue worker_thread */
+static int acpi_os_execute_worker(void *context)
+{
+	struct thread_pool_entry *e = (struct thread_pool_entry *)context;
+	DECLARE_WAITQUEUE(wait, current);
+
+	set_user_nice(current, -5);
+
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	ACPI_DEBUG_PRINT((ACPI_DB_WARN, "[%d:%p] before loop\n", e->id, e));
+	while (!kthread_should_stop()) {
+		/* Wait until there is work to do in this thread */
+		add_wait_queue(&e->more_work, &wait);
+		if (!e->function) {
+			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "[%d:%p] sleeping\n", e->id, e));
+			schedule();
+			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "[%d:%p] waking (function=%p)\n", e->id, e, e->function));
+		}
+		else {
+			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "[%d:%p] running (function=%p)\n", e->id, e, e->function));
+			__set_current_state(TASK_RUNNING);
+		}
+		try_to_freeze();
+		remove_wait_queue(&e->more_work, &wait);
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "[%d:%p] ready (function=%p)\n", e->id, e, e->function));
+		if (e->function) {
+			acpi_osd_exec_callback function = e->function;
+			void *context = e->context;
+			e->function = NULL;
+			e->context = NULL;
+			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "[%d:%p] executing function=%p context=%p\n",
+					  e->id, e, function, context));
+			function(context);
+
+			e->active = 0;
+			e->jiffies = jiffies;
+			ACPI_DEBUG_PRINT((ACPI_DB_WARN, "[%d:%p] function=%p context=%p exit at %lx\n",
+					  e->id, e, function, context, e->jiffies));
+
+		}
+		set_current_state(TASK_INTERRUPTIBLE);
+	}
+
+	return 0;
+}
+
+static struct thread_pool_entry *get_pool_thread(void)
+{
+	struct list_head *l;
+	list_for_each(l, &thread_pool) {
+		struct thread_pool_entry *e = list_entry(l, struct thread_pool_entry, list);
+		if (!e->active) {
+			e->active = 1;
+			return e;
+		}
+	}
+	/* N.B. For the time being we have a user-configurable limit
+	 on the thread_pool_size.  We don't want a bad BIOS to create
+	 unlimited kthreads. */
+	if (thread_pool_size < max_thread_pool_size) {
+		struct thread_pool_entry *e;
+		e = kmalloc(sizeof(struct thread_pool_entry), GFP_KERNEL);
+		list_add_tail(&e->list, &thread_pool);
+		e->id = thread_pool_size;
+		init_waitqueue_head(&e->more_work);
+		init_waitqueue_head(&e->work_done);
+		e->function = NULL;
+		e->context = NULL;
+		e->active = 1;
+		/* kthread_run does kthread_create and wake_up_process */
+		e->thread = kthread_run(acpi_os_execute_worker, e, "kacpid-work-%d",
+					thread_pool_size);
+		thread_pool_size++;
+		return e;
+	}
+	return NULL;
+}
+
 acpi_status acpi_os_initialize(void)
 {
 	return AE_OK;
@@ -98,6 +261,16 @@
 	return AE_OK;
 }
 
+/* enable poolsize modification by /proc filesystem */
+acpi_status acpi_os_initialize2(void)
+{
+	struct proc_dir_entry *entry;
+	entry = create_proc_entry("poolsize", S_IRUSR|S_IWUSR, acpi_root_dir);
+	if (entry)
+		entry->proc_fops = &acpi_osl_poolsize_ops;
+	return AE_OK;
+}
+
 acpi_status acpi_os_terminate(void)
 {
 	if (acpi_irq_handler) {
@@ -661,6 +834,7 @@
 static void acpi_os_execute_deferred(void *context)
 {
 	struct acpi_os_dpc *dpc = NULL;
+	struct thread_pool_entry *e = NULL;
 
 	ACPI_FUNCTION_TRACE("os_execute_deferred");
 
@@ -670,8 +844,18 @@
 		return_VOID;
 	}
 
-	dpc->function(dpc->context);
-
+	if (max_thread_pool_size > 0 && (e = get_pool_thread())) {
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "[%d:%p] function=%p context=%p\n",
+				  e->id, e, dpc->function, dpc->context));
+		e->context = dpc->context;
+		e->function = dpc->function;
+		wake_up(&e->more_work);
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "[%d:%p] wake finished\n", e->id, e));
+	}
+	else {
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "(now) function=%p context=%p\n", dpc->function, dpc->context));
+		dpc->function(dpc->context);
+	}
 	kfree(dpc);
 
 	return_VOID;

--=-Rd+zJfspsi+DyVBpjhwu--

