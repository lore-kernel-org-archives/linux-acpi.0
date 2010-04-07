From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH]: Automatically Online Hot Added Memory
Date: Wed, 7 Apr 2010 14:22:21 -0400
Message-ID: <20100407182221.29073.98804.sendpatchset@prarit.bos.redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:65495 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755491Ab0DGSWW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Apr 2010 14:22:22 -0400
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o37IMMLE021771
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-acpi@vger.kernel.org>; Wed, 7 Apr 2010 14:22:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, trenn@suse.de, mjg@redhat.com, john.l.villalovos@intel.com, bjorn.helgaas@hp.com, len.brown@intel.com
Cc: Prarit Bhargava <prarit@redhat.com>

New sockets have on-die memory controllers.  This means that in certain
HW configurations the memory behind the socket comes and goes as the socket
is physically enabled and disabled.

When a cpu is brought into service it requests memory from the local node.  If
this fails, memory will be accessed from a different node for percpu data*.
This results in a performance hit on large systems under scheduling
intensive loads.

A solution to this is to have the memory come online automatically so that
when the cpus are onlined they will have local node memory to allocate from.

This patch automatically onlines memory added via an ACPI event, so the memory
is available to a cpu that is also being onlined at the same time.

* A patch to fix this in slab has been presented upstream.

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
index 3597d73..8d40613 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -30,6 +30,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/memory_hotplug.h>
+#include <linux/memory.h>
 #include <acpi/acpi_drivers.h>
 
 #define ACPI_MEMORY_DEVICE_CLASS		"memory"
@@ -45,6 +46,11 @@ ACPI_MODULE_NAME("acpi_memhotplug");
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
@@ -252,6 +258,20 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 		result = add_memory(node, info->start_addr, info->length);
 		if (result)
 			continue;
+#ifdef CONFIG_ACPI_HOTPLUG_MEMORY_AUTO_ONLINE
+		if (mem_hotadd_auto) {
+			result = online_pages(info->start_addr >> PAGE_SHIFT,
+					      info->length >> PAGE_SHIFT);
+			if (!result)
+				set_memory_state(info->start_addr >> PAGE_SHIFT,
+						 info->length >> PAGE_SHIFT,
+						 MEM_ONLINE);
+			else
+				printk(KERN_ERR PREFIX "Memory online failed "
+				       "for 0x%llx - 0x%llx\n", info->start_addr,
+				       info->start_addr + info->length);
+		}
+#endif
 		info->enabled = 1;
 		num_enabled++;
 	}
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index db0848e..219be91 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -515,6 +515,29 @@ int remove_memory_block(unsigned long node_id, struct mem_section *section,
 }
 
 /*
+ * need an interface for the VM to mark sections on and offline when
+ * hot-swapping memory.
+ */
+void set_memory_state(unsigned long start_pfn, unsigned long nr_pages,
+		      unsigned long state)
+{
+	struct mem_section *section;
+	struct memory_block *mem;
+	unsigned long start_sec, end_sec, i;
+
+	start_sec = pfn_to_section_nr(start_pfn);
+	end_sec = pfn_to_section_nr(start_pfn + nr_pages - 1);
+	for (i = start_sec; i <= end_sec; i++) {
+		if (valid_section_nr(i) && present_section_nr(i)) {
+			section = __nr_to_section(i);
+			mem = find_memory_block(section);
+			mem->state = state;
+		}
+	}
+}
+EXPORT_SYMBOL(set_memory_state);
+
+/*
  * need an interface for the VM to add new memory regions,
  * but without onlining it.
  */
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 85582e1..5735253 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -114,6 +114,7 @@ extern int remove_memory_block(unsigned long, struct mem_section *, int);
 extern int memory_notify(unsigned long val, void *v);
 extern int memory_isolate_notify(unsigned long val, void *v);
 extern struct memory_block *find_memory_block(struct mem_section *);
+extern void set_memory_state(unsigned long, unsigned long, unsigned long);
 #define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
 enum mem_add_context { BOOT, HOTPLUG };
 #endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index be211a5..2eb8751 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -450,6 +450,7 @@ int online_pages(unsigned long pfn, unsigned long nr_pages)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(online_pages);
 #endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
 
 /* we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG */
