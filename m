From: "Anil" <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Proposal for ACPI to have its own thread for Notification Callbacks instead of Kevent thread.
Date: Tue, 6 Apr 2004 15:25:29 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <ORSMSX409yEXUIEAOeI00000034@orsmsx409.amr.corp.intel.com>
Reply-To: <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0003_01C41BEB.6548C970"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Shah, Rajesh" <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0003_01C41BEB.6548C970
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Len,
	
	In the current ACPI implementation, when an hardware SCI event
happens the ACPI driver queues the work on to keventd thread by calling
schedule_work(), as acpi does not have its own thread. 

As we are working on to support CPU hotplugging in the near futures, the
requirement for CPU hot plugging is that, in case of CPU_DOWN, we need to
migrate all the work queued on to the dying CPU's keventd thread to
different CPU's keventd thread and we are forced to kill the keventd thread
of the dying CPU. 

The problem with the above for CPU hot plugging is that, if the hardware SCI
event for CPU removal queues the work request to the CPU that needs to be
removed, then the keventd thread running CPU_DOWN code to remove the CPU
needs to be killed as part of the CPU removal process and since we are
running on the same thread, we would end up in a dead lock.

To better prepare ACPI for CPU hotplugging, here is what I would like to
propose. Let ACPI have its own thread to execute the SCI/hardware events
notification callbacks. Let the acpi queues the work request onto to this
thread instead of keventd thread. In the ACPI there is a function called
acpi_os_queue_for_execution() and in this function instead of calling
schedule_work() I am now queuing the work on to acpi's own thread by calling
acpi_os_schedule_work().

The benefit of this is approach is that
	1) Higher level drivers/protocol can call schedule_work() and can
wait for it to execute(since the event handler will be running on acpi's
event thread and not kevents thread).
	2) Events queued to ACPI's own thread can get executed faster than
the one queued to the keventd thread.
	3) Of course, ACPI can support CPU hot plugging.


Here goes the patch for the same and I have tested it on Tiger4, to see the
functioning of the thread and notification getting called.

I would appreciate if I can get any kind of feedback or testing.

Thanks & Regards,
Anil Keshavamurthy

---

 linux-2.6.5-rc2-root/drivers/acpi/osl.c |  158
++++++++++++++++++++++++++++++--
 1 files changed, 153 insertions(+), 5 deletions(-)

diff -puN drivers/acpi/osl.c~new_acpi_thread drivers/acpi/osl.c
--- linux-2.6.5-rc2/drivers/acpi/osl.c~new_acpi_thread	2004-04-06
22:59:48.233007905 -0700
+++ linux-2.6.5-rc2-root/drivers/acpi/osl.c	2004-04-06
22:59:48.234961031 -0700
@@ -36,6 +36,7 @@
 #include <linux/delay.h>
 #include <linux/workqueue.h>
 #include <linux/nmi.h>
+#include <linux/kthread.h>
 #include <acpi/acpi.h>
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
@@ -55,6 +56,29 @@ struct acpi_os_dpc
     void		    *context;
 };
 
+struct acpi_os_events_struct {
+	struct list_head worklist;
+	spinlock_t lock;
+	wait_queue_head_t more_work;
+	struct task_struct *p;
+};
+
+
+struct acpi_os_work_struct {
+	struct list_head entry;
+	unsigned long pending;
+	void (*func)(void *);
+	void *data;
+};
+
+#define ACPI_OS_INIT_WORK(_work, _func, _data)			\
+	do {							\
+		INIT_LIST_HEAD(&(_work)->entry);		\
+		(_work)->pending = 0;				\
+		(_work)->func = _func;				\
+		(_work)->data = _data;				\
+	} while (0)
+
 
 #ifdef ENABLE_DEBUGGER
 #include <linux/kdb.h>
@@ -66,10 +90,15 @@ extern char line_buf[80];
 static int acpi_irq_irq;
 static OSD_HANDLER acpi_irq_handler;
 static void *acpi_irq_context;
+static acpi_status __init acpi_os_initialize_event_thread(void);
+static void acpi_os_terminate_event_thread(void);
+static int acpi_os_schedule_work(struct acpi_os_work_struct *work);
+struct acpi_os_events_struct acpi_os_events;
 
 acpi_status
 acpi_os_initialize(void)
 {
+	acpi_status status;
 	/*
 	 * Initialize PCI configuration space access, as we'll need to
access
 	 * it while walking the namespace (bus 0 and root bridges w/ _BBNs).
@@ -80,8 +109,9 @@ acpi_os_initialize(void)
 		return AE_NULL_ENTRY;
 	}
 #endif
+	status = acpi_os_initialize_event_thread();
 
-	return AE_OK;
+	return status;
 }
 
 acpi_status
@@ -91,6 +121,8 @@ acpi_os_terminate(void)
 		acpi_os_remove_interrupt_handler(acpi_irq_irq,
 						 acpi_irq_handler);
 	}
+	
+	acpi_os_terminate_event_thread();
 
 	return AE_OK;
 }
@@ -627,7 +659,7 @@ acpi_os_queue_for_execution(
 {
 	acpi_status 		status = AE_OK;
 	struct acpi_os_dpc	*dpc;
-	struct work_struct	*task;
+	struct acpi_os_work_struct	*task;
 
 	ACPI_FUNCTION_TRACE ("os_queue_for_execution");
 
@@ -647,7 +679,7 @@ acpi_os_queue_for_execution(
 	 * from the same memory.
 	 */
 
-	dpc = kmalloc(sizeof(struct acpi_os_dpc)+sizeof(struct work_struct),
GFP_ATOMIC);
+	dpc = kmalloc(sizeof(struct acpi_os_dpc)+sizeof(struct
acpi_os_work_struct), GFP_ATOMIC);
 	if (!dpc)
 		return_ACPI_STATUS (AE_NO_MEMORY);
 
@@ -655,9 +687,9 @@ acpi_os_queue_for_execution(
 	dpc->context = context;
 
 	task = (void *)(dpc+1);
-	INIT_WORK(task, acpi_os_execute_deferred, (void*)dpc);
+	ACPI_OS_INIT_WORK(task, acpi_os_execute_deferred, (void*)dpc);
 
-	if (!schedule_work(task)) {
+	if (!acpi_os_schedule_work(task)) {
 		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Call to schedule_work()
failed.\n"));
 		kfree(dpc);
 		status = AE_ERROR;
@@ -1048,3 +1080,119 @@ acpi_serialize_setup(char *str)
 
 __setup("acpi_serialize", acpi_serialize_setup);
 
+static void __acpi_os_queue_work(struct acpi_os_events_struct *ev,
+			 struct acpi_os_work_struct *work)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ev->lock, flags);
+	list_add_tail(&work->entry, &ev->worklist);
+	wake_up(&ev->more_work);
+	spin_unlock_irqrestore(&ev->lock, flags);
+}
+
+int acpi_os_queue_work(struct acpi_os_events_struct *ev, struct
acpi_os_work_struct *work)
+{
+	int ret = 0;
+	get_cpu();
+
+	if (!test_and_set_bit(0, &work->pending)) {
+		BUG_ON(!list_empty(&work->entry));
+		__acpi_os_queue_work(ev, work);
+		ret = 1;
+	}
+	put_cpu();
+	return ret;
+}
+
+
+static int acpi_os_schedule_work(struct acpi_os_work_struct *work)
+{
+	return acpi_os_queue_work(&acpi_os_events, work);
+}
+static inline void acpi_os_run_workqueue(struct acpi_os_events_struct *ev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ev->lock, flags);
+	while (!list_empty(&ev->worklist)) {
+		struct acpi_os_work_struct *work =
list_entry(ev->worklist.next,
+						struct acpi_os_work_struct,
entry);
+		void (*f) (void *) = work->func;
+		void *data = work->data;
+
+		list_del_init(ev->worklist.next);
+		spin_unlock_irqrestore(&ev->lock, flags);
+
+		clear_bit(0, &work->pending);
+		f(data);
+
+		spin_lock_irqsave(&ev->lock, flags);
+	}
+	spin_unlock_irqrestore(&ev->lock, flags);
+}
+
+static int __acpi_os_event_thread(
+	struct acpi_os_events_struct *ev)
+{
+	struct k_sigaction sa;
+	sigset_t blocked;
+	DECLARE_WAITQUEUE(wait, current);
+
+	current->flags |= PF_IOTHREAD;
+	set_user_nice(current, -10);
+
+	/* Block and flush all signals */
+	sigfillset(&blocked);
+	sigprocmask(SIG_BLOCK, &blocked, NULL);
+	flush_signals(current);
+
+	/* SIG_IGN makes children autoreap: see do_notify_parent(). */
+	sa.sa.sa_handler = SIG_IGN;
+	sa.sa.sa_flags = 0;
+	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
+	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
+
+	while(!kthread_should_stop()) {
+		set_task_state(current, TASK_INTERRUPTIBLE);
+	
+		add_wait_queue(&ev->more_work, &wait);
+		if (list_empty(&ev->worklist)){
+			schedule();
+		}
+		else
+			set_task_state(current, TASK_RUNNING);
+		remove_wait_queue(&ev->more_work, &wait);
+
+		if (!list_empty(&ev->worklist)){
+			acpi_os_run_workqueue(ev);
+		}
+	}
+	return 0;
+}
+static int
+acpi_os_event_thread(void *dummy)
+{
+
+	INIT_LIST_HEAD(&acpi_os_events.worklist);
+	spin_lock_init(&acpi_os_events.lock);
+	init_waitqueue_head(&acpi_os_events.more_work);
+
+	return __acpi_os_event_thread(&acpi_os_events);
+}
+
+static acpi_status __init
+acpi_os_initialize_event_thread(void)
+{
+	acpi_os_events.p = kthread_create(acpi_os_event_thread, NULL,
"kacpid");
+	if (IS_ERR(acpi_os_events.p))
+		return AE_ERROR;
+	wake_up_process(acpi_os_events.p);
+	return AE_OK;
+}
+
+static void
+acpi_os_terminate_event_thread(void)
+{
+	kthread_stop(acpi_os_events.p);
+}

_


------=_NextPart_000_0003_01C41BEB.6548C970
Content-Type: application/octet-stream;
	name="new_acpi_thread.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="new_acpi_thread.patch"

---=0A=
=0A=
 linux-2.6.5-rc2-root/drivers/acpi/osl.c |  158 =
++++++++++++++++++++++++++++++--=0A=
 1 files changed, 153 insertions(+), 5 deletions(-)=0A=
=0A=
diff -puN drivers/acpi/osl.c~new_acpi_thread drivers/acpi/osl.c=0A=
--- linux-2.6.5-rc2/drivers/acpi/osl.c~new_acpi_thread	2004-04-06 =
22:59:48.233007905 -0700=0A=
+++ linux-2.6.5-rc2-root/drivers/acpi/osl.c	2004-04-06 =
22:59:48.234961031 -0700=0A=
@@ -36,6 +36,7 @@=0A=
 #include <linux/delay.h>=0A=
 #include <linux/workqueue.h>=0A=
 #include <linux/nmi.h>=0A=
+#include <linux/kthread.h>=0A=
 #include <acpi/acpi.h>=0A=
 #include <asm/io.h>=0A=
 #include <acpi/acpi_bus.h>=0A=
@@ -55,6 +56,29 @@ struct acpi_os_dpc=0A=
     void		    *context;=0A=
 };=0A=
 =0A=
+struct acpi_os_events_struct {=0A=
+	struct list_head worklist;=0A=
+	spinlock_t lock;=0A=
+	wait_queue_head_t more_work;=0A=
+	struct task_struct *p;=0A=
+};=0A=
+=0A=
+=0A=
+struct acpi_os_work_struct {=0A=
+	struct list_head entry;=0A=
+	unsigned long pending;=0A=
+	void (*func)(void *);=0A=
+	void *data;=0A=
+};=0A=
+=0A=
+#define ACPI_OS_INIT_WORK(_work, _func, _data)			\=0A=
+	do {							\=0A=
+		INIT_LIST_HEAD(&(_work)->entry);		\=0A=
+		(_work)->pending =3D 0;				\=0A=
+		(_work)->func =3D _func;				\=0A=
+		(_work)->data =3D _data;				\=0A=
+	} while (0)=0A=
+=0A=
 =0A=
 #ifdef ENABLE_DEBUGGER=0A=
 #include <linux/kdb.h>=0A=
@@ -66,10 +90,15 @@ extern char line_buf[80];=0A=
 static int acpi_irq_irq;=0A=
 static OSD_HANDLER acpi_irq_handler;=0A=
 static void *acpi_irq_context;=0A=
+static acpi_status __init acpi_os_initialize_event_thread(void);=0A=
+static void acpi_os_terminate_event_thread(void);=0A=
+static int acpi_os_schedule_work(struct acpi_os_work_struct *work);=0A=
+struct acpi_os_events_struct acpi_os_events;=0A=
 =0A=
 acpi_status=0A=
 acpi_os_initialize(void)=0A=
 {=0A=
+	acpi_status status;=0A=
 	/*=0A=
 	 * Initialize PCI configuration space access, as we'll need to access=0A=
 	 * it while walking the namespace (bus 0 and root bridges w/ _BBNs).=0A=
@@ -80,8 +109,9 @@ acpi_os_initialize(void)=0A=
 		return AE_NULL_ENTRY;=0A=
 	}=0A=
 #endif=0A=
+	status =3D acpi_os_initialize_event_thread();=0A=
 =0A=
-	return AE_OK;=0A=
+	return status;=0A=
 }=0A=
 =0A=
 acpi_status=0A=
@@ -91,6 +121,8 @@ acpi_os_terminate(void)=0A=
 		acpi_os_remove_interrupt_handler(acpi_irq_irq,=0A=
 						 acpi_irq_handler);=0A=
 	}=0A=
+	=0A=
+	acpi_os_terminate_event_thread();=0A=
 =0A=
 	return AE_OK;=0A=
 }=0A=
@@ -627,7 +659,7 @@ acpi_os_queue_for_execution(=0A=
 {=0A=
 	acpi_status 		status =3D AE_OK;=0A=
 	struct acpi_os_dpc	*dpc;=0A=
-	struct work_struct	*task;=0A=
+	struct acpi_os_work_struct	*task;=0A=
 =0A=
 	ACPI_FUNCTION_TRACE ("os_queue_for_execution");=0A=
 =0A=
@@ -647,7 +679,7 @@ acpi_os_queue_for_execution(=0A=
 	 * from the same memory.=0A=
 	 */=0A=
 =0A=
-	dpc =3D kmalloc(sizeof(struct acpi_os_dpc)+sizeof(struct work_struct), =
GFP_ATOMIC);=0A=
+	dpc =3D kmalloc(sizeof(struct acpi_os_dpc)+sizeof(struct =
acpi_os_work_struct), GFP_ATOMIC);=0A=
 	if (!dpc)=0A=
 		return_ACPI_STATUS (AE_NO_MEMORY);=0A=
 =0A=
@@ -655,9 +687,9 @@ acpi_os_queue_for_execution(=0A=
 	dpc->context =3D context;=0A=
 =0A=
 	task =3D (void *)(dpc+1);=0A=
-	INIT_WORK(task, acpi_os_execute_deferred, (void*)dpc);=0A=
+	ACPI_OS_INIT_WORK(task, acpi_os_execute_deferred, (void*)dpc);=0A=
 =0A=
-	if (!schedule_work(task)) {=0A=
+	if (!acpi_os_schedule_work(task)) {=0A=
 		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Call to schedule_work() =
failed.\n"));=0A=
 		kfree(dpc);=0A=
 		status =3D AE_ERROR;=0A=
@@ -1048,3 +1080,119 @@ acpi_serialize_setup(char *str)=0A=
 =0A=
 __setup("acpi_serialize", acpi_serialize_setup);=0A=
 =0A=
+static void __acpi_os_queue_work(struct acpi_os_events_struct *ev,=0A=
+			 struct acpi_os_work_struct *work)=0A=
+{=0A=
+	unsigned long flags;=0A=
+=0A=
+	spin_lock_irqsave(&ev->lock, flags);=0A=
+	list_add_tail(&work->entry, &ev->worklist);=0A=
+	wake_up(&ev->more_work);=0A=
+	spin_unlock_irqrestore(&ev->lock, flags);=0A=
+}=0A=
+=0A=
+int acpi_os_queue_work(struct acpi_os_events_struct *ev, struct =
acpi_os_work_struct *work)=0A=
+{=0A=
+	int ret =3D 0;=0A=
+	get_cpu();=0A=
+=0A=
+	if (!test_and_set_bit(0, &work->pending)) {=0A=
+		BUG_ON(!list_empty(&work->entry));=0A=
+		__acpi_os_queue_work(ev, work);=0A=
+		ret =3D 1;=0A=
+	}=0A=
+	put_cpu();=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+=0A=
+static int acpi_os_schedule_work(struct acpi_os_work_struct *work)=0A=
+{=0A=
+	return acpi_os_queue_work(&acpi_os_events, work);=0A=
+}=0A=
+static inline void acpi_os_run_workqueue(struct acpi_os_events_struct =
*ev)=0A=
+{=0A=
+	unsigned long flags;=0A=
+=0A=
+	spin_lock_irqsave(&ev->lock, flags);=0A=
+	while (!list_empty(&ev->worklist)) {=0A=
+		struct acpi_os_work_struct *work =3D list_entry(ev->worklist.next,=0A=
+						struct acpi_os_work_struct, entry);=0A=
+		void (*f) (void *) =3D work->func;=0A=
+		void *data =3D work->data;=0A=
+=0A=
+		list_del_init(ev->worklist.next);=0A=
+		spin_unlock_irqrestore(&ev->lock, flags);=0A=
+=0A=
+		clear_bit(0, &work->pending);=0A=
+		f(data);=0A=
+=0A=
+		spin_lock_irqsave(&ev->lock, flags);=0A=
+	}=0A=
+	spin_unlock_irqrestore(&ev->lock, flags);=0A=
+}=0A=
+=0A=
+static int __acpi_os_event_thread(=0A=
+	struct acpi_os_events_struct *ev)=0A=
+{=0A=
+	struct k_sigaction sa;=0A=
+	sigset_t blocked;=0A=
+	DECLARE_WAITQUEUE(wait, current);=0A=
+=0A=
+	current->flags |=3D PF_IOTHREAD;=0A=
+	set_user_nice(current, -10);=0A=
+=0A=
+	/* Block and flush all signals */=0A=
+	sigfillset(&blocked);=0A=
+	sigprocmask(SIG_BLOCK, &blocked, NULL);=0A=
+	flush_signals(current);=0A=
+=0A=
+	/* SIG_IGN makes children autoreap: see do_notify_parent(). */=0A=
+	sa.sa.sa_handler =3D SIG_IGN;=0A=
+	sa.sa.sa_flags =3D 0;=0A=
+	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));=0A=
+	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);=0A=
+=0A=
+	while(!kthread_should_stop()) {=0A=
+		set_task_state(current, TASK_INTERRUPTIBLE);=0A=
+	=0A=
+		add_wait_queue(&ev->more_work, &wait);=0A=
+		if (list_empty(&ev->worklist)){=0A=
+			schedule();=0A=
+		}=0A=
+		else=0A=
+			set_task_state(current, TASK_RUNNING);=0A=
+		remove_wait_queue(&ev->more_work, &wait);=0A=
+=0A=
+		if (!list_empty(&ev->worklist)){=0A=
+			acpi_os_run_workqueue(ev);=0A=
+		}=0A=
+	}=0A=
+	return 0;=0A=
+}=0A=
+static int=0A=
+acpi_os_event_thread(void *dummy)=0A=
+{=0A=
+=0A=
+	INIT_LIST_HEAD(&acpi_os_events.worklist);=0A=
+	spin_lock_init(&acpi_os_events.lock);=0A=
+	init_waitqueue_head(&acpi_os_events.more_work);=0A=
+=0A=
+	return __acpi_os_event_thread(&acpi_os_events);=0A=
+}=0A=
+=0A=
+static acpi_status __init=0A=
+acpi_os_initialize_event_thread(void)=0A=
+{=0A=
+	acpi_os_events.p =3D kthread_create(acpi_os_event_thread, NULL, =
"kacpid");=0A=
+	if (IS_ERR(acpi_os_events.p))=0A=
+		return AE_ERROR;=0A=
+	wake_up_process(acpi_os_events.p);=0A=
+	return AE_OK;=0A=
+}=0A=
+=0A=
+static void=0A=
+acpi_os_terminate_event_thread(void)=0A=
+{=0A=
+	kthread_stop(acpi_os_events.p);=0A=
+}=0A=
=0A=
_=0A=

------=_NextPart_000_0003_01C41BEB.6548C970--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
