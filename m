From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [RFC PATCH] acpi: Automatically online hot-added memory [v2]
Date: Mon, 05 Apr 2010 09:49:53 -0400
Message-ID: <4BB9EA81.4080009@redhat.com>
References: <20100401131944.4086.82010.sendpatchset@prarit.bos.redhat.com> <201004020931.46783.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010800040200000806040202"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:26143 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107Ab0DENue (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Apr 2010 09:50:34 -0400
In-Reply-To: <201004020931.46783.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, trenn@suse.de, mjg@redhat.com

This is a multi-part message in MIME format.
--------------010800040200000806040202
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit


Hi Bjorn,

Thanks for the comments ...
> It looks like acpi_memhotplug can be compiled as a module, so
> shouldn't "mem_hotadd_auto=" be a module parameter?
>
>   

Good point -- I have changed this to a module parameter.

> Is it possible that a user would want to online memory for some
> hot-add events but not others?  If so, maybe the mem_hotadd_auto
> thing should also be in sysfs?
>   
Users are going to turn it on and keep it on.  To be honest, I've only 
included it because I found it useful while debugging cpu hot adds.

> Printks with constant text are one of my pet peeves because they don't
> give any clues for debugging.  Surely there's useful information we
> could include here, like the ACPI device info (maybe using dev_err()),
> the memory range, etc?
>   

Fixed -- I was taking a hint from the surrounding code and not including 
the memory range, but I agree with you that more info is better. I've 
changed this to display the memory range that failed.

P.

D'oh!  Fixed.


> Bjorn
>   

--------------010800040200000806040202
Content-Type: text/plain;
 name="diff1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="diff1"

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

--------------010800040200000806040202--
