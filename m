From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] acpiphp: Prevent deadlock on PCI-to-PCI bridge remove
Date: Wed, 28 Sep 2011 19:40:53 -0400
Message-ID: <1317253253-28259-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, mjg@redhat.com, bhelgaas@google.com, jbarnes@virtuousgeek.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

I originally submitted a patch to workaround this by pushing all Ejection
Requests and Device Checks onto the kacpi_hotplug queue.

http://marc.info/?l=linux-acpi&m=131678270930105&w=2

The patch is still insufficient in that Bus Checks also need to be added.

Rather than add all events, including non-PCI-hotplug events, to the
hotplug queue, mjg suggested that a better approach would be to modify
the acpiphp driver so only acpiphp events would be added to the
kacpi_hotplug queue.

It's a longer patch, but at least we maintain the benefit of having separate
queues in ACPI.  This, of course, is still only a workaround the problem.
As Bjorn and mjg pointed out, we have to refactor a lot of this code to do
the right thing but at this point it is a better to have this code working.

Jesse -- Unless there are any objections from the ACPI guys, I think this
patch should be pushed through linux-pci now since 95% of the changes are
contained within drivers/pci/hotplug.

P.
---8<---

The acpi core places all events on the kacpi_notify queue.  When the acpiphp
driver is loaded and a PCI card with a PCI-to-PCI bridge is removed the
following call sequence occurs:

cleanup_p2p_bridge()
	    -> cleanup_bridge()
		    -> acpi_remove_notify_handler()
			    -> acpi_os_wait_events_complete()
				    -> flush_workqueue(kacpi_notify_wq)

which is the queue we are currently executing on and the process will hang.

Move all hotplug acpiphp events onto the kacpi_hotplug workqueue.  In
handle_hotplug_event_bridge() and handle_hotplug_event_func() we can simply
push the rest of the work onto the kacpi_hotplug queue and then avoid the
deadlock.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: mjg@redhat.com
Cc: bhelgaas@google.com
Cc: jbarnes@virtuousgeek.org
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/osl.c                 |    3 +-
 drivers/pci/hotplug/acpiphp_glue.c |  109 +++++++++++++++++++++++++++++++-----
 include/acpi/acpiosxf.h            |    2 +
 3 files changed, 98 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index fa32f58..f31c5c5 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -80,7 +80,8 @@ static acpi_osd_handler acpi_irq_handler;
 static void *acpi_irq_context;
 static struct workqueue_struct *kacpid_wq;
 static struct workqueue_struct *kacpi_notify_wq;
-static struct workqueue_struct *kacpi_hotplug_wq;
+struct workqueue_struct *kacpi_hotplug_wq;
+EXPORT_SYMBOL(kacpi_hotplug_wq);
 
 struct acpi_res_list {
 	resource_size_t start;
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 2202857..596172b 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -48,6 +48,7 @@
 #include <linux/pci-acpi.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/acpi.h>
 
 #include "../pci.h"
 #include "acpiphp.h"
@@ -1149,15 +1150,35 @@ check_sub_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
 	return AE_OK ;
 }
 
-/**
- * handle_hotplug_event_bridge - handle ACPI event on bridges
- * @handle: Notify()'ed acpi_handle
- * @type: Notify code
- * @context: pointer to acpiphp_bridge structure
- *
- * Handles ACPI event notification on {host,p2p} bridges.
- */
-static void handle_hotplug_event_bridge(acpi_handle handle, u32 type, void *context)
+struct acpiphp_hp_work {
+	struct work_struct work;
+	acpi_handle handle;
+	u32 type;
+	void *context;
+};
+
+static void alloc_acpiphp_hp_work(acpi_handle handle, u32 type,
+				  void *context,
+				  void (*func)(struct work_struct *work))
+{
+	struct acpiphp_hp_work *hp_work;
+	int ret;
+
+	hp_work = kmalloc(sizeof(*hp_work), GFP_KERNEL);
+	if (!hp_work)
+		return;
+
+	hp_work->handle = handle;
+	hp_work->type = type;
+	hp_work->context = context;
+
+	INIT_WORK(&hp_work->work, func);
+	ret = queue_work(kacpi_hotplug_wq, &hp_work->work);
+	if (!ret)
+		kfree(hp_work);
+}
+
+static void _handle_hotplug_event_bridge(struct work_struct *work)
 {
 	struct acpiphp_bridge *bridge;
 	char objname[64];
@@ -1165,11 +1186,18 @@ static void handle_hotplug_event_bridge(acpi_handle handle, u32 type, void *cont
 				      .pointer = objname };
 	struct acpi_device *device;
 	int num_sub_bridges = 0;
+	struct acpiphp_hp_work *hp_work;
+	acpi_handle handle;
+	u32 type;
+
+	hp_work = container_of(work, struct acpiphp_hp_work, work);
+	handle = hp_work->handle;
+	type = hp_work->type;
 
 	if (acpi_bus_get_device(handle, &device)) {
 		/* This bridge must have just been physically inserted */
 		handle_bridge_insertion(handle, type);
-		return;
+		goto out;
 	}
 
 	bridge = acpiphp_handle_to_bridge(handle);
@@ -1180,7 +1208,7 @@ static void handle_hotplug_event_bridge(acpi_handle handle, u32 type, void *cont
 
 	if (!bridge && !num_sub_bridges) {
 		err("cannot get bridge info\n");
-		return;
+		goto out;
 	}
 
 	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
@@ -1241,22 +1269,49 @@ static void handle_hotplug_event_bridge(acpi_handle handle, u32 type, void *cont
 		warn("notify_handler: unknown event type 0x%x for %s\n", type, objname);
 		break;
 	}
+
+out:
+	kfree(hp_work); /* allocated in handle_hotplug_event_bridge */
 }
 
 /**
- * handle_hotplug_event_func - handle ACPI event on functions (i.e. slots)
+ * handle_hotplug_event_bridge - handle ACPI event on bridges
  * @handle: Notify()'ed acpi_handle
  * @type: Notify code
- * @context: pointer to acpiphp_func structure
+ * @context: pointer to acpiphp_bridge structure
  *
- * Handles ACPI event notification on slots.
+ * Handles ACPI event notification on {host,p2p} bridges.
  */
-static void handle_hotplug_event_func(acpi_handle handle, u32 type, void *context)
+static void handle_hotplug_event_bridge(acpi_handle handle, u32 type,
+					void *context)
+{
+	/*
+	 * Currently the code adds all hotplug events to the kacpid_wq
+	 * queue when it should add hotplug events to the kacpi_hotplug_wq.
+	 * The proper way to fix this is to reorganize the code so that
+	 * drivers (dock, etc.) do not call acpi_os_execute(), etc.
+	 * For now just re-add this work to the kacpi_hotplug_wq so we
+	 * don't deadlock on hotplug actions.
+	 */
+	alloc_acpiphp_hp_work(handle, type, context,
+			      _handle_hotplug_event_bridge);
+}
+
+static void _handle_hotplug_event_func(struct work_struct *work)
 {
 	struct acpiphp_func *func;
 	char objname[64];
 	struct acpi_buffer buffer = { .length = sizeof(objname),
 				      .pointer = objname };
+	struct acpiphp_hp_work *hp_work;
+	acpi_handle handle;
+	u32 type;
+	void *context;
+
+	hp_work = container_of(work, struct acpiphp_hp_work, work);
+	handle = hp_work->handle;
+	type = hp_work->type;
+	context = hp_work->context;
 
 	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
 
@@ -1291,8 +1346,32 @@ static void handle_hotplug_event_func(acpi_handle handle, u32 type, void *contex
 		warn("notify_handler: unknown event type 0x%x for %s\n", type, objname);
 		break;
 	}
+
+	kfree(hp_work); /* allocated in handle_hotplug_event_func */
 }
 
+/**
+ * handle_hotplug_event_func - handle ACPI event on functions (i.e. slots)
+ * @handle: Notify()'ed acpi_handle
+ * @type: Notify code
+ * @context: pointer to acpiphp_func structure
+ *
+ * Handles ACPI event notification on slots.
+ */
+static void handle_hotplug_event_func(acpi_handle handle, u32 type,
+				      void *context)
+{
+	/*
+	 * Currently the code adds all hotplug events to the kacpid_wq
+	 * queue when it should add hotplug events to the kacpi_hotplug_wq.
+	 * The proper way to fix this is to reorganize the code so that
+	 * drivers (dock, etc.) do not call acpi_os_execute(), etc.
+	 * For now just re-add this work to the kacpi_hotplug_wq so we
+	 * don't deadlock on hotplug actions.
+	 */
+	alloc_acpiphp_hp_work(handle, type, context,
+			      _handle_hotplug_event_func);
+}
 
 static acpi_status
 find_root_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 4543b6f..83062ed 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -189,6 +189,8 @@ void acpi_os_fixed_event_count(u32 fixed_event_number);
 /*
  * Threads and Scheduling
  */
+extern struct workqueue_struct *kacpi_hotplug_wq;
+
 acpi_thread_id acpi_os_get_thread_id(void);
 
 acpi_status
-- 
1.7.1
