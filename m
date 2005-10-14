From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC]convert ACPI driver model to Linux driver model -
	takes 2
Date: Fri, 14 Oct 2005 09:13:56 +0800
Message-ID: <1129252436.3948.12.camel@linux-hp.sh.intel.com>
References: <200510131443.47844.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-dHpDHgvXjNmf1MFVy3V8"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200510131443.47844.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-dHpDHgvXjNmf1MFVy3V8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-10-14 at 04:43 +0800, Bjorn Helgaas wrote:
> On Thursday 13 October 2005 12:37 am, Shaohua Li wrote: 
> > This is the updated patch for the topic. In this version, I
> completely 
> > convert devices in ACPI bus into Linux driver model.
> 
> This looks like a nice piece of work.
> 
> > Now the device  
> > driver for ACPI bus device should be a 'struct acpi_phys_driver'.
> Old 
> > style driver (struct acpi_driver) now can't work for ACPI bus
> devices.
> 
> You now have both 'acpi_driver' and 'acpi_phys_driver' (and 
> 'acpi_device' and 'acpi_phys_device').  What exactly is the 
> distinction?  Is the distinction necessary?  Can you just stuff 
> the generic device stuff into 'struct acpi_device' itself?
Devices in ACPI bus use acpi_phys_driver, other devices use acpi_driver.
Converting acpi_device use the generic device stuff might be difficult,
since many devices in DSDT aren't ACPI bus devices. The distinction is
to do smooth change. That is non ACPI bus devices still can register old
style driver. On the future, we might remove the old style driver model.
Adam suggested non-acpi bus device directly use ACPI services instead of
register a 'acpi_driver', which might be worthy tring.

> 
> > I tried to convert one ACPI driver (link device driver) to the new 
> > model. It's quite easy.
> 
> I'd like to see the link device driver patch, just to help 
> me understand all this.
Ok, please see attached patch.

> > +struct acpi_phys_driver { 
> > +//   struct list_head node; 
> > +     char name[80]; 
> > +     char class[80];
> 
> Shouldn't these be "char *" instead of "char []"?
I'll do code cleanup, if people agree the basic idea.
> 
> > +     struct module *owner; 
> > +     char *ids; 
> > +     int (*probe)(struct acpi_phys_device *dev); 
> > +     void (*remove) (struct acpi_phys_device *dev); 
> > +     int  (*suspend) (struct acpi_phys_device *dev, pm_message_t
> state); 
> > +     int  (*resume) (struct acpi_phys_device *dev); 
> > +     void (*shutdown) (struct acpi_phys_device *dev); 
> > + 
> > +     struct device_driver    phys_drv;
> 
> I think you should name this item "driver", not "phys_drv".
Ditto.

Thanks,
Shaohua

--=-dHpDHgvXjNmf1MFVy3V8
Content-Disposition: attachment; filename=pci_link_convert.patch
Content-Type: text/x-patch; name=pci_link_convert.patch; charset=utf-8
Content-Transfer-Encoding: 7bit



---

 linux-2.6.14-rc3-root/drivers/acpi/osl.c      |    6 -
 linux-2.6.14-rc3-root/drivers/acpi/pci_link.c |  106 +++++++-------------------
 2 files changed, 33 insertions(+), 79 deletions(-)

diff -puN drivers/acpi/osl.c~pci_link_convert drivers/acpi/osl.c
--- linux-2.6.14-rc3/drivers/acpi/osl.c~pci_link_convert	2005-10-12 16:46:57.000000000 +0800
+++ linux-2.6.14-rc3-root/drivers/acpi/osl.c	2005-10-12 16:46:57.000000000 +0800
@@ -136,13 +136,9 @@ void acpi_os_vprintf(const char *fmt, va
 #endif
 }
 
-extern int acpi_in_resume;
 void *acpi_os_allocate(acpi_size size)
 {
-	if (acpi_in_resume)
-		return kmalloc(size, GFP_ATOMIC);
-	else
-		return kmalloc(size, GFP_KERNEL);
+	return kmalloc(size, GFP_KERNEL);
 }
 
 void acpi_os_free(void *ptr)
diff -puN drivers/acpi/pci_link.c~pci_link_convert drivers/acpi/pci_link.c
--- linux-2.6.14-rc3/drivers/acpi/pci_link.c~pci_link_convert	2005-10-12 16:46:57.000000000 +0800
+++ linux-2.6.14-rc3-root/drivers/acpi/pci_link.c	2005-10-12 16:46:57.000000000 +0800
@@ -51,18 +51,6 @@ ACPI_MODULE_NAME("pci_link")
 #define ACPI_PCI_LINK_FILE_INFO		"info"
 #define ACPI_PCI_LINK_FILE_STATUS	"state"
 #define ACPI_PCI_LINK_MAX_POSSIBLE 16
-static int acpi_pci_link_add(struct acpi_device *device);
-static int acpi_pci_link_remove(struct acpi_device *device, int type);
-
-static struct acpi_driver acpi_pci_link_driver = {
-	.name = ACPI_PCI_LINK_DRIVER_NAME,
-	.class = ACPI_PCI_LINK_CLASS,
-	.ids = ACPI_PCI_LINK_HID,
-	.ops = {
-		.add = acpi_pci_link_add,
-		.remove = acpi_pci_link_remove,
-		},
-};
 
 /*
  * If a link is initialized, we never change its active and initialized
@@ -722,14 +710,14 @@ int acpi_pci_link_free_irq(acpi_handle h
                                  Driver Interface
    -------------------------------------------------------------------------- */
 
-static int acpi_pci_link_add(struct acpi_device *device)
+static int __acpi_pci_link_add(struct acpi_device *device)
 {
 	int result = 0;
 	struct acpi_pci_link *link = NULL;
 	int i = 0;
 	int found = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_pci_link_add");
+	ACPI_FUNCTION_TRACE("__acpi_pci_link_add");
 
 	if (!device)
 		return_VALUE(-EINVAL);
@@ -788,47 +776,11 @@ static int acpi_pci_link_add(struct acpi
 	return_VALUE(result);
 }
 
-static int acpi_pci_link_resume(struct acpi_pci_link *link)
+static int __acpi_pci_link_remove(struct acpi_device *device, int type)
 {
-	ACPI_FUNCTION_TRACE("acpi_pci_link_resume");
-
-	if (link->refcnt && link->irq.active && link->irq.initialized)
-		return_VALUE(acpi_pci_link_set(link, link->irq.active));
-	else
-		return_VALUE(0);
-}
-
-/*
- * FIXME: this is a workaround to avoid nasty warning.  It will be removed
- * after every device calls pci_disable_device in .resume.
- */
-int acpi_in_resume;
-static int irqrouter_resume(struct sys_device *dev)
-{
-	struct list_head *node = NULL;
 	struct acpi_pci_link *link = NULL;
 
-	ACPI_FUNCTION_TRACE("irqrouter_resume");
-
-	acpi_in_resume = 1;
-	list_for_each(node, &acpi_link.entries) {
-		link = list_entry(node, struct acpi_pci_link, node);
-		if (!link) {
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "Invalid link context\n"));
-			continue;
-		}
-		acpi_pci_link_resume(link);
-	}
-	acpi_in_resume = 0;
-	return_VALUE(0);
-}
-
-static int acpi_pci_link_remove(struct acpi_device *device, int type)
-{
-	struct acpi_pci_link *link = NULL;
-
-	ACPI_FUNCTION_TRACE("acpi_pci_link_remove");
+	ACPI_FUNCTION_TRACE("__acpi_pci_link_remove");
 
 	if (!device || !acpi_driver_data(device))
 		return_VALUE(-EINVAL);
@@ -932,34 +884,40 @@ int __init acpi_irq_balance_set(char *st
 
 __setup("acpi_irq_balance", acpi_irq_balance_set);
 
-/* FIXME: we will remove this interface after all drivers call pci_disable_device */
-static struct sysdev_class irqrouter_sysdev_class = {
-	set_kset_name("irqrouter"),
-	.resume = irqrouter_resume,
-};
-
-static struct sys_device device_irqrouter = {
-	.id = 0,
-	.cls = &irqrouter_sysdev_class,
-};
-
-static int __init irqrouter_init_sysfs(void)
+static int acpi_pci_link_probe(struct acpi_phys_device *dev)
 {
-	int error;
+	struct acpi_device *acpi_dev = dev->acpi_dev;
+	return __acpi_pci_link_add(acpi_dev);
+}
 
-	ACPI_FUNCTION_TRACE("irqrouter_init_sysfs");
+static void acpi_pci_link_remove(struct acpi_phys_device *dev)
+{
+	struct acpi_device *acpi_dev = dev->acpi_dev;
+	__acpi_pci_link_remove(acpi_dev, 0);
+}
 
-	if (acpi_disabled || acpi_noirq)
-		return_VALUE(0);
+static int acpi_pci_link_resume(struct acpi_phys_device *dev)
+{
+	struct acpi_device *acpi_dev = dev->acpi_dev;
+	struct acpi_pci_link *link = NULL;
 
-	error = sysdev_class_register(&irqrouter_sysdev_class);
-	if (!error)
-		error = sysdev_register(&device_irqrouter);
+	if (!acpi_driver_data(acpi_dev))
+		return -EINVAL;
+	link = (struct acpi_pci_link *)acpi_driver_data(acpi_dev);
 
-	return_VALUE(error);
+	if (link->refcnt && link->irq.active && link->irq.initialized)
+		return acpi_pci_link_set(link, link->irq.active);
+	return 0;
 }
 
-device_initcall(irqrouter_init_sysfs);
+static struct acpi_phys_driver acpi_pci_phys_link_driver = {
+	.name = ACPI_PCI_LINK_DRIVER_NAME,
+	.class = ACPI_PCI_LINK_CLASS,
+	.ids = ACPI_PCI_LINK_HID,
+	.probe = acpi_pci_link_probe,
+	.remove = acpi_pci_link_remove,
+	.resume = acpi_pci_link_resume,
+};
 
 static int __init acpi_pci_link_init(void)
 {
@@ -971,7 +929,7 @@ static int __init acpi_pci_link_init(voi
 	acpi_link.count = 0;
 	INIT_LIST_HEAD(&acpi_link.entries);
 
-	if (acpi_bus_register_driver(&acpi_pci_link_driver) < 0)
+	if (acpi_phys_driver_register(&acpi_pci_phys_link_driver) < 0)
 		return_VALUE(-ENODEV);
 
 	return_VALUE(0);
_

--=-dHpDHgvXjNmf1MFVy3V8--



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
