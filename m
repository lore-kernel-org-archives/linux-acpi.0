From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH 0/30] return statement cleanup - kill pointless parentheses (fwd)
Date: Mon, 20 Dec 2004 23:54:14 +0100
Message-ID: <20041220225414.GD464@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, juhl-lkml-poRShpWsAiE@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

Parenthesis around returns statements were driving me crazy for quite
a long time -- return is not a function and I do not think it should
look as one. Could we get this applied?
								Pavel

Signed-off-by: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Signed-off-by: Jesper Juhl <juhl-lkml-poRShpWsAiE@public.gmane.org>

diff -upr linux-2.6.10-rc3-bk13-orig/drivers/acpi/asus_acpi.c linux-2.6.10-rc3-bk13/drivers/acpi/asus_acpi.c
--- linux-2.6.10-rc3-bk13-orig/drivers/acpi/asus_acpi.c	2004-10-18 23:53:46.000000000 +0200
+++ linux-2.6.10-rc3-bk13/drivers/acpi/asus_acpi.c	2004-12-20 23:35:32.000000000 +0100
@@ -656,7 +656,7 @@ static int get_lcd_state(void)
 			lcd = out_obj.integer.value >> 8;
 	}
 	
-	return (lcd & 1);
+	return lcd & 1;
 }
 
 static int set_lcd_state(int value)
@@ -866,7 +866,7 @@ static int __init asus_hotk_add_fs(struc
 
 	acpi_device_dir(device) = asus_proc_dir;
 	if (!acpi_device_dir(device))
-		return(-ENODEV);
+		return -ENODEV;
 
 	proc = create_proc_entry(PROC_INFO, mode, acpi_device_dir(device));
 	if (proc) {
@@ -1098,16 +1098,16 @@ static int __init asus_hotk_check(void)
 
 	result = acpi_bus_get_status(hotk->device);
 	if (result)
-		return(result);
+		return result;
 
 	if (hotk->device->status.present) {
 		result = asus_hotk_get_info();
 	} else {
 		printk(KERN_ERR "  Hotkey device not present, aborting\n");
-		return(-EINVAL);
+		return -EINVAL;
 	}
 
-	return(result);
+	return result;
 }
 
 
@@ -1117,7 +1117,7 @@ static int __init asus_hotk_add(struct a
 	int result;
 
 	if (!device)
-		return(-EINVAL);
+		return -EINVAL;
 
 	printk(KERN_NOTICE "Asus Laptop ACPI Extras version %s\n",
 	       ASUS_ACPI_VERSION);
@@ -1125,7 +1125,7 @@ static int __init asus_hotk_add(struct a
 	hotk =
 	    (struct asus_hotk *) kmalloc(sizeof(struct asus_hotk), GFP_KERNEL);
 	if (!hotk)
-		return(-ENOMEM);
+		return -ENOMEM;
 	memset(hotk, 0, sizeof(struct asus_hotk));
 
 	hotk->handle = device->handle;
@@ -1173,7 +1173,7 @@ static int __init asus_hotk_add(struct a
 		kfree(hotk);
 	}
 
-	return(result);
+	return result;
 }
 
 
@@ -1182,7 +1182,7 @@ static int asus_hotk_remove(struct acpi_
 	acpi_status status = 0;
 
 	if (!device || !acpi_driver_data(device))
-		return(-EINVAL);
+		return -EINVAL;
 
 	status = acpi_remove_notify_handler(hotk->handle, ACPI_SYSTEM_NOTIFY,
 					    asus_hotk_notify);
@@ -1193,7 +1193,7 @@ static int asus_hotk_remove(struct acpi_
 
 	kfree(hotk);
 
-	return(0);
+	return 0;
 }
 
 
diff -upr linux-2.6.10-rc3-bk13-orig/drivers/acpi/osl.c linux-2.6.10-rc3-bk13/drivers/acpi/osl.c
--- linux-2.6.10-rc3-bk13-orig/drivers/acpi/osl.c	2004-12-06 22:24:26.000000000 +0100
+++ linux-2.6.10-rc3-bk13/drivers/acpi/osl.c	2004-12-20 23:40:29.000000000 +0100
@@ -356,7 +356,7 @@ acpi_os_get_timer (void)
 	if (!t)
 		printk(KERN_ERR PREFIX "acpi_os_get_timer() TBD\n");
 
-	return(++t);
+	return ++t;
 }
 
 acpi_status
@@ -529,7 +529,7 @@ acpi_os_read_pci_configuration (struct a
 				PCI_DEVFN(pci_id->device, pci_id->function),
 				reg, size, value);
 
-	return (result ? AE_ERROR : AE_OK);
+	return result ? AE_ERROR : AE_OK;
 }
 EXPORT_SYMBOL(acpi_os_read_pci_configuration);
 
@@ -558,7 +558,7 @@ acpi_os_write_pci_configuration (struct 
 				PCI_DEVFN(pci_id->device, pci_id->function),
 				reg, size, value);
 
-	return (result ? AE_ERROR : AE_OK);
+	return result ? AE_ERROR : AE_OK;
 }
 
 /* TODO: Change code to take advantage of driver model more */
@@ -635,7 +635,7 @@ acpi_os_write_pci_configuration (
 	acpi_integer		value,
 	u32			width)
 {
-	return (AE_SUPPORT);
+	return AE_SUPPORT;
 }
 
 acpi_status
@@ -645,7 +645,7 @@ acpi_os_read_pci_configuration (
 	void			*value,
 	u32			width)
 {
-	return (AE_SUPPORT);
+	return AE_SUPPORT;
 }
 
 void
diff -upr linux-2.6.10-rc3-bk13-orig/drivers/acpi/pci_link.c linux-2.6.10-rc3-bk13/drivers/acpi/pci_link.c
--- linux-2.6.10-rc3-bk13-orig/drivers/acpi/pci_link.c	2004-12-06 22:24:27.000000000 +0100
+++ linux-2.6.10-rc3-bk13/drivers/acpi/pci_link.c	2004-12-20 23:42:13.000000000 +0100
@@ -810,7 +810,7 @@ void acpi_penalize_isa_irq(int irq)
  */
 static int __init acpi_irq_isa(char *str)
 {
-	return(acpi_irq_penalty_update(str, 1));
+	return acpi_irq_penalty_update(str, 1);
 }
 __setup("acpi_irq_isa=", acpi_irq_isa);
 
@@ -821,7 +821,7 @@ __setup("acpi_irq_isa=", acpi_irq_isa);
  */
 static int __init acpi_irq_pci(char *str)
 {
-	return(acpi_irq_penalty_update(str, 0));
+	return acpi_irq_penalty_update(str, 0);
 }
 __setup("acpi_irq_pci=", acpi_irq_pci);
 
diff -upr linux-2.6.10-rc3-bk13-orig/drivers/acpi/processor.c linux-2.6.10-rc3-bk13/drivers/acpi/processor.c
--- linux-2.6.10-rc3-bk13-orig/drivers/acpi/processor.c	2004-12-06 22:24:27.000000000 +0100
+++ linux-2.6.10-rc3-bk13/drivers/acpi/processor.c	2004-12-20 23:49:48.000000000 +0100
@@ -293,9 +293,9 @@ ticks_elapsed (
 	u32			t2)
 {
 	if (t2 >= t1)
-		return (t2 - t1);
+		return t2 - t1;
 	else if (!acpi_fadt.tmr_val_ext)
-		return (((0x00FFFFFF - t1) + t2) & 0x00FFFFFF);
+		return ((0x00FFFFFF - t1) + t2) & 0x00FFFFFF;
 	else
 		return ((0xFFFFFFFF - t1) + t2);
 }
@@ -874,7 +874,7 @@ static int acpi_processor_ppc_has_change
 {
 	int ret = acpi_processor_get_platform_limit(pr);
 	if (ret < 0)
-		return (ret);
+		return ret;
 	else
 		return cpufreq_update_policy(pr->id);
 }
Only in linux-2.6.10-rc3-bk13/drivers/acpi/: returns.txt
diff -upr linux-2.6.10-rc3-bk13-orig/drivers/acpi/tables.c linux-2.6.10-rc3-bk13/drivers/acpi/tables.c
--- linux-2.6.10-rc3-bk13-orig/drivers/acpi/tables.c	2004-10-18 23:53:51.000000000 +0200
+++ linux-2.6.10-rc3-bk13/drivers/acpi/tables.c	2004-12-20 23:51:53.000000000 +0100
@@ -233,7 +233,7 @@ acpi_table_compute_checksum (
 	while (remains--)
 		sum += *p++;
 
-	return (sum & 0xFF);
+	return sum & 0xFF;
 }
 
 /*
diff -upr linux-2.6.10-rc3-bk13-orig/drivers/acpi/toshiba_acpi.c linux-2.6.10-rc3-bk13/drivers/acpi/toshiba_acpi.c
--- linux-2.6.10-rc3-bk13-orig/drivers/acpi/toshiba_acpi.c	2004-10-18 23:53:10.000000000 +0200
+++ linux-2.6.10-rc3-bk13/drivers/acpi/toshiba_acpi.c	2004-12-20 23:46:15.000000000 +0100
@@ -508,7 +508,7 @@ add_device(void)
 			proc->write_proc = (write_proc_t*)dispatch_write;
 	}
 
-	return(AE_OK);
+	return AE_OK;
 }
 
 static acpi_status __exit
@@ -518,7 +518,7 @@ remove_device(void)
 
 	for (item = proc_items; item->name; ++item)
 		remove_proc_entry(item->name, toshiba_proc_dir);
-	return(AE_OK);
+	return AE_OK;
 }
 
 static int __init


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
