From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: ACPI blacklisting: move year blacklist into acpi/blacklist.c
Date: Wed, 1 Oct 2003 12:18:26 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20031001101826.GA3503@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

This moves year-based blacklisting to blacklist.c, where it belongs
AFAICS. It also adds some externs to include/linux/acpi.h, but I
believe *way* more externs are needed. Please apply,

								Pavel

--- /usr/src/tmp/linux/arch/i386/kernel/dmi_scan.c	2003-09-28 22:05:29.000000000 +0200
+++ /usr/src/linux/arch/i386/kernel/dmi_scan.c	2003-10-01 11:55:21.000000000 +0200
@@ -997,24 +998,10 @@
 	int i;
 		
 #ifdef	CONFIG_ACPI_BOOT
-#define	ACPI_BLACKLIST_CUTOFF_YEAR	2001
-
 	if (dmi_ident[DMI_BIOS_DATE]) { 
 		char *s = strrchr(dmi_ident[DMI_BIOS_DATE], '/'); 
-		if (s) { 
-			int year, disable = 0;
-			s++; 
-			year = simple_strtoul(s,NULL,0); 
-			if (year >= 1000) 
-				disable = year < ACPI_BLACKLIST_CUTOFF_YEAR; 
-			else if (year < 1 || (year > 90 && year <= 99))
-				disable = 1; 
-			if (disable && !acpi_force) { 
-				printk(KERN_NOTICE "ACPI disabled because your bios is from %s and too old\n", s);
-				printk(KERN_NOTICE "You can enable it with acpi=force\n");
-				acpi_disabled = 1; 
-			} 
-		}
+		if (s && !acpi_force)
+			acpi_bios_year(s+1);
 	}
 #endif
 
--- /usr/src/tmp/linux/drivers/acpi/blacklist.c	2003-02-15 18:51:16.000000000 +0100
+++ /usr/src/linux/drivers/acpi/blacklist.c	2003-10-01 11:55:19.000000000 +0200
@@ -83,6 +83,27 @@
 	{""}
 };
 
+#define	ACPI_BLACKLIST_CUTOFF_YEAR	2001
+
+/*
+ * Notice: this is called from dmi_scan.c, which contains second (!) blacklist
+ */
+void __init
+acpi_bios_year(char *s)
+{
+	int year, disable = 0;
+
+	year = simple_strtoul(s,NULL,0); 
+	if (year >= 1000) 
+		disable = year < ACPI_BLACKLIST_CUTOFF_YEAR; 
+	else if (year < 1 || (year > 90 && year <= 99))
+		disable = 1; 
+	if (disable) { 
+		printk(KERN_NOTICE "ACPI disabled because your bios is from %s and too old\n", s);
+		printk(KERN_NOTICE "You can enable it with acpi=force\n");
+		acpi_disabled = 1; 
+	}
+}
 
 int __init
 acpi_blacklisted(void)
--- /usr/src/tmp/linux/include/linux/acpi.h	2003-08-27 12:00:48.000000000 +0200
+++ /usr/src/linux/include/linux/acpi.h	2003-10-01 11:53:51.000000000 +0200
@@ -403,8 +403,8 @@
 
 struct pci_dev;
 
-int acpi_pci_irq_enable (struct pci_dev *dev);
-int acpi_pci_irq_init (void);
+extern int acpi_pci_irq_enable (struct pci_dev *dev);
+extern int acpi_pci_irq_init (void);
 
 struct acpi_pci_driver {
 	struct acpi_pci_driver *next;
@@ -412,21 +412,22 @@
 	void (*remove)(acpi_handle handle);
 };
 
-int acpi_pci_register_driver(struct acpi_pci_driver *driver);
-void acpi_pci_unregister_driver(struct acpi_pci_driver *driver);
+extern int acpi_pci_register_driver(struct acpi_pci_driver *driver);
+extern void acpi_pci_unregister_driver(struct acpi_pci_driver *driver);
 
 #endif /*CONFIG_ACPI_PCI*/
 
 #ifdef CONFIG_ACPI_EC
 
-int ec_read(u8 addr, u8 *val);
-int ec_write(u8 addr, u8 val);
+extern int ec_read(u8 addr, u8 *val);
+extern int ec_write(u8 addr, u8 val);
 
 #endif /*CONFIG_ACPI_EC*/
 
 #ifdef CONFIG_ACPI
 
-int acpi_blacklisted(void);
+extern int acpi_blacklisted(void);
+extern void acpi_bios_year(char *s);
 
 #else
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
