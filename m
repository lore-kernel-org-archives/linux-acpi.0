From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 02/16] sem2mutex: acpi, acpi_link_lock
Date: Sat, 13 May 2006 23:13:42 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB670F335@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:37729 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932362AbWENDNq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 May 2006 23:13:46 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, mingo@elte.hu

applied.

thanks,
-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Thursday, April 27, 2006 5:25 AM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; mingo@elte.hu
>Subject: [patch 02/16] sem2mutex: acpi, acpi_link_lock
>
>
>From: Ingo Molnar <mingo@elte.hu>
>
>Semaphore to mutex conversion.
>
>The conversion was generated via scripts, and the result was validated
>automatically via a script as well.
>
>Signed-off-by: Ingo Molnar <mingo@elte.hu>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/pci_link.c |   25 +++++++++++++------------
> 1 files changed, 13 insertions(+), 12 deletions(-)
>
>diff -puN 
>drivers/acpi/pci_link.c~sem2mutex-acpi-acpi_link_lock 
>drivers/acpi/pci_link.c
>--- 
>devel/drivers/acpi/pci_link.c~sem2mutex-acpi-acpi_link_lock	
>2006-04-10 23:16:19.000000000 -0700
>+++ devel-akpm/drivers/acpi/pci_link.c	2006-04-10 
>23:16:19.000000000 -0700
>@@ -38,6 +38,7 @@
> #include <linux/spinlock.h>
> #include <linux/pm.h>
> #include <linux/pci.h>
>+#include <linux/mutex.h>
> 
> #include <acpi/acpi_bus.h>
> #include <acpi/acpi_drivers.h>
>@@ -91,7 +92,7 @@ static struct {
> 	int count;
> 	struct list_head entries;
> } acpi_link;
>-DECLARE_MUTEX(acpi_link_lock);
>+DEFINE_MUTEX(acpi_link_lock);
> 
> /* 
>---------------------------------------------------------------
>-----------
>                             PCI Link Device Management
>@@ -634,19 +635,19 @@ acpi_pci_link_allocate_irq(acpi_handle h
> 		return_VALUE(-1);
> 	}
> 
>-	down(&acpi_link_lock);
>+	mutex_lock(&acpi_link_lock);
> 	if (acpi_pci_link_allocate(link)) {
>-		up(&acpi_link_lock);
>+		mutex_unlock(&acpi_link_lock);
> 		return_VALUE(-1);
> 	}
> 
> 	if (!link->irq.active) {
>-		up(&acpi_link_lock);
>+		mutex_unlock(&acpi_link_lock);
> 		ACPI_ERROR((AE_INFO, "Link active IRQ is 0!"));
> 		return_VALUE(-1);
> 	}
> 	link->refcnt++;
>-	up(&acpi_link_lock);
>+	mutex_unlock(&acpi_link_lock);
> 
> 	if (triggering)
> 		*triggering = link->irq.triggering;
>@@ -684,9 +685,9 @@ int acpi_pci_link_free_irq(acpi_handle h
> 		return_VALUE(-1);
> 	}
> 
>-	down(&acpi_link_lock);
>+	mutex_lock(&acpi_link_lock);
> 	if (!link->irq.initialized) {
>-		up(&acpi_link_lock);
>+		mutex_unlock(&acpi_link_lock);
> 		ACPI_ERROR((AE_INFO, "Link isn't initialized"));
> 		return_VALUE(-1);
> 	}
>@@ -709,7 +710,7 @@ int acpi_pci_link_free_irq(acpi_handle h
> 	if (link->refcnt == 0) {
> 		acpi_ut_evaluate_object(link->handle, "_DIS", 0, NULL);
> 	}
>-	up(&acpi_link_lock);
>+	mutex_unlock(&acpi_link_lock);
> 	return_VALUE(link->irq.active);
> }
> 
>@@ -740,7 +741,7 @@ static int acpi_pci_link_add(struct acpi
> 	strcpy(acpi_device_class(device), ACPI_PCI_LINK_CLASS);
> 	acpi_driver_data(device) = link;
> 
>-	down(&acpi_link_lock);
>+	mutex_lock(&acpi_link_lock);
> 	result = acpi_pci_link_get_possible(link);
> 	if (result)
> 		goto end;
>@@ -775,7 +776,7 @@ static int acpi_pci_link_add(struct acpi
>       end:
> 	/* disable all links -- to be activated on use */
> 	acpi_ut_evaluate_object(link->handle, "_DIS", 0, NULL);
>-	up(&acpi_link_lock);
>+	mutex_unlock(&acpi_link_lock);
> 
> 	if (result)
> 		kfree(link);
>@@ -829,9 +830,9 @@ static int acpi_pci_link_remove(struct a
> 
> 	link = (struct acpi_pci_link *)acpi_driver_data(device);
> 
>-	down(&acpi_link_lock);
>+	mutex_lock(&acpi_link_lock);
> 	list_del(&link->node);
>-	up(&acpi_link_lock);
>+	mutex_unlock(&acpi_link_lock);
> 
> 	kfree(link);
> 
>_
>
