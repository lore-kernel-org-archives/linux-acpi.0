From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH]: acpi: Automatically Online Hot Added Memory [v2]
Date: Wed, 21 Apr 2010 11:47:45 -0400
Message-ID: <20100421154745.27802.58241.sendpatchset@prarit.bos.redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59755 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755859Ab0DUPrr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Apr 2010 11:47:47 -0400
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o3LFlkeT013837
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-acpi@vger.kernel.org>; Wed, 21 Apr 2010 11:47:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, trenn@suse.de, mjg@redhat.com, john.l.villalovos@intel.com, bjorn.helgaas@hp.com, len.brown@intel.com, gregkh@suse.de, dnelson@redhat.com
Cc: Prarit Bhargava <prarit@redhat.com>

Sorry if you received this twice.  It did not appear on linux-acpi.

[v2 changes: Exporting online_pages seemed like a bad idea from the beginning.
It became apparent that the right thing to do was online the memory from the
driver core layer and then introduce and export set_memory_state().

I am not sure if I should wrap set_memory_state with #ifdefs for the auto
online of memory.  If anyone has serious feelings about it, I can resubmit
a patch that adds the #ifdefs. ]

cc'ing gregkh, listed as maintainer for driver core.

P.



New sockets have on-die memory controllers.  This means that in certain
HW configurations the memory behind the socket comes and goes as the socket
is physically enabled and disabled.

When a cpu is brought into service it requests memory from the local node.  If
this fails, memory will be accessed from a different node for percpu data*.
This results in a performance hit on large systems under scheduling
intensive loads.

The common solution is to implement udev rules to online the memory, however,
that model fails in this case because udev handles the cpu and memory add
events in parallel -- it is not possible to synchronize the cpu add events to
the memory add events.

A solution to this problem is to have the memory come online automatically so
that when the cpus are onlined they will have local node memory to allocate
from.

This patch automatically onlines memory added via an ACPI event, so the memory
is available to a cpu that is also being onlined at the same time.  A module
option is added to disable automatic onlining for general use and debugging
purposes.

* Current upstream panics in this situation.  A patch to fix this in slab has
been presented upstream.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 93d2c79..dece6bd 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -350,6 +350,14 @@ config ACPI_HOTPLUG_MEMORY
 	  To compile this driver as a module, choose M here:
 	  the module will be called acpi_memhotplug.
 
+config ACPI_HOTPLUG_MEMORY_AUTO_ONLINE
+	bool "Automatically online hotplugged memory"
+	depends on ACPI_HOTPLUG_MEMORY
+	default n
+	help
+	  This forces memory that is brought into service by ACPI
+	  to be automatically onlined.
+
 config ACPI_SBS
 	tristate "Smart Battery System"
 	depends on X86
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index d985713..5af0bdc 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -31,6 +31,9 @@
 #include <linux/types.h>
 #include <linux/memory_hotplug.h>
 #include <linux/slab.h>
+#ifdef CONFIG_ACPI_HOTPLUG_MEMORY_AUTO_ONLINE
+#include <linux/memory.h>
+#endif
 #include <acpi/acpi_drivers.h>
 
 #define ACPI_MEMORY_DEVICE_CLASS		"memory"
@@ -46,6 +49,11 @@ ACPI_MODULE_NAME("acpi_memhotplug");
 MODULE_AUTHOR("Naveen B S <naveen.b.s@intel.com>");
 MODULE_DESCRIPTION("Hotplug Mem Driver");
 MODULE_LICENSE("GPL");
+#ifdef CONFIG_ACPI_HOTPLUG_MEMORY_AUTO_ONLINE
+static int mem_hotadd_auto = 1;
+module_param(mem_hotadd_auto, bool, 0444);
+MODULE_PARM_DESC(mem_hotadd_auto, "Disable automatic onlining of memory");
+#endif
 
 /* Memory Device States */
 #define MEMORY_INVALID_STATE	0
@@ -219,6 +227,9 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 	int result, num_enabled = 0;
 	struct acpi_memory_info *info;
 	int node;
+#ifdef CONFIG_ACPI_HOTPLUG_MEMORY_AUTO_ONLINE
+	u64 err_addr;
+#endif
 
 
 	/* Get the range from the _CRS */
@@ -253,6 +264,19 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 		result = add_memory(node, info->start_addr, info->length);
 		if (result)
 			continue;
+#ifdef CONFIG_ACPI_HOTPLUG_MEMORY_AUTO_ONLINE
+		if (mem_hotadd_auto) {
+			err_addr = set_memory_state(info->start_addr >>
+						    PAGE_SHIFT,
+						    info->length >> PAGE_SHIFT,
+						    MEM_ONLINE, MEM_OFFLINE);
+			if (err_addr)
+				printk(KERN_ERR PREFIX "Memory online failed "
+				       "for 0x%llx - 0x%llx\n",
+				       err_addr << PAGE_SHIFT,
+				       info->start_addr + info->length);
+		}
+#endif
 		info->enabled = 1;
 		num_enabled++;
 	}
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 933442f..f2a5c19 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -516,6 +516,41 @@ int remove_memory_block(unsigned long node_id, struct mem_section *section,
 }
 
 /*
+ * need an interface for the VM to mark sections on and offline when
+ * hot-swapping memory.
+ *
+ * Returns 0 on success, or the failing pfn on failure.
+ */
+u64 set_memory_state(unsigned long start_pfn, unsigned long nr_pages,
+		     unsigned long to_state, unsigned long from_state_req)
+{
+	struct mem_section *section;
+	struct memory_block *mem;
+	unsigned long start_sec, end_sec, i, current_pfn;
+	int ret = 0;
+
+	start_sec = pfn_to_section_nr(start_pfn);
+	end_sec = pfn_to_section_nr(start_pfn + nr_pages - 1);
+	for (i = start_sec; i <= end_sec; i++) {
+		if (valid_section_nr(i) && present_section_nr(i)) {
+			section = __nr_to_section(i);
+			mem = find_memory_block(section);
+			ret = memory_block_change_state(mem, to_state,
+							from_state_req);
+			if (ret) {
+				current_pfn = section_nr_to_pfn(start_sec);
+				printk(KERN_WARNING "memory (0x%0lx - 0x%0lx) "
+				       "online failed.", current_pfn,
+				       current_pfn + PAGES_PER_SECTION);
+				return current_pfn;
+			}
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL(set_memory_state);
+
+/*
  * need an interface for the VM to add new memory regions,
  * but without onlining it.
  */
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 85582e1..57b8760 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -114,6 +114,8 @@ extern int remove_memory_block(unsigned long, struct mem_section *, int);
 extern int memory_notify(unsigned long val, void *v);
 extern int memory_isolate_notify(unsigned long val, void *v);
 extern struct memory_block *find_memory_block(struct mem_section *);
+extern u64 set_memory_state(unsigned long, unsigned long, unsigned long,
+			    unsigned long);
 #define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
 enum mem_add_context { BOOT, HOTPLUG };
 #endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
