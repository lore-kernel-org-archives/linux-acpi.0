From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: [PATCH] Drop back to extended IRQ resource type
Date: Sat, 30 Aug 2003 19:56:41 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200308301956.41007.adq_dvb@lidskialf.net>
References: <20030829045032.GA688@gambit.implode.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pNPU/GwlzAFDWNg"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030829045032.GA688-XxA8UMA2PDBPKbTXaf03yKxOck334EZe@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: John Wong <kernel-AAfBIQCtFhbR7s880joybQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Andew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_pNPU/GwlzAFDWNg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 29 Aug 2003 5:50 am, John Wong wrote:
> On the nForce original with the onboard GeForce2 video, the BIOS does
> assign IRQ 11 to the onboard video, however, Linux does not.  Setting
> acpi=off and pci=noirq does not fix the problem.  I have a nForce2 board
> without onboard video and ACPI/IO-APIC etc all work fine.

Hi, the attached patch should resolve this issue. Originally, if an IRQ is 
<=15, the code always used a standard IRQ descriptor when calling the _SRS 
method. 

However, certain BIOSes always expect an extended IRQ descriptor, and fail 
when passed a standard one. This patch drops back to an extended descriptor 
if a set with a standard one fails... you'll still see the BUFFER LIMIT 
message, but you should now see it saying "Retrying with extended IRQ 
descriptor".. and hopefully succeeding the second time.

--Boundary-00=_pNPU/GwlzAFDWNg
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="linux-2.4.22-irqrestype.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.4.22-irqrestype.patch"


--- linux-2.4.22.orig/drivers/acpi/pci_link.c	2003-08-25 12:44:41.000000000 +0100
+++ linux-2.4.22/drivers/acpi/pci_link.c	2003-08-30 18:54:35.000000000 +0100
@@ -290,7 +290,8 @@
 	struct acpi_buffer	buffer = {sizeof(resource)+1, &resource};
 	int			i = 0;
 	int			valid = 0;
-
+	int			resource_type = 0;
+   
 	ACPI_FUNCTION_TRACE("acpi_pci_link_set");
 
 	if (!link || !irq)
@@ -313,12 +314,23 @@
 		}
 	}
 
+	/* If IRQ<=15, first try with a "normal" IRQ descriptor. If that fails, try with
+	 * an extended one */
+	if (irq <= 15) {
+		resource_type = ACPI_RSTYPE_IRQ;
+	} else {
+		resource_type = ACPI_RSTYPE_EXT_IRQ;
+	}
+
+retry_programming:
+   
 	memset(&resource, 0, sizeof(resource));
 
 	/* NOTE: PCI interrupts are always level / active_low / shared. But not all
 	   interrupts > 15 are PCI interrupts. Rely on the ACPI IRQ definition for 
 	   parameters */
-	if (irq <= 15) {
+	switch(resource_type) {
+	case ACPI_RSTYPE_IRQ:
 		resource.res.id = ACPI_RSTYPE_IRQ;
 		resource.res.length = sizeof(struct acpi_resource);
 		resource.res.data.irq.edge_level = link->irq.edge_level;
@@ -326,8 +338,9 @@
 		resource.res.data.irq.shared_exclusive = ACPI_SHARED;
 		resource.res.data.irq.number_of_interrupts = 1;
 		resource.res.data.irq.interrupts[0] = irq;
-	}
-	else {
+		break;
+	   
+	case ACPI_RSTYPE_EXT_IRQ:
 		resource.res.id = ACPI_RSTYPE_EXT_IRQ;
 		resource.res.length = sizeof(struct acpi_resource);
 		resource.res.data.extended_irq.producer_consumer = ACPI_CONSUMER;
@@ -337,11 +350,22 @@
 		resource.res.data.extended_irq.number_of_interrupts = 1;
 		resource.res.data.extended_irq.interrupts[0] = irq;
 		/* ignore resource_source, it's optional */
+		break;
 	}
 	resource.end.id = ACPI_RSTYPE_END_TAG;
 
 	/* Attempt to set the resource */
 	status = acpi_set_current_resources(link->handle, &buffer);
+   
+
+	/* if we failed and IRQ <= 15, try again with an extended descriptor */
+	if (ACPI_FAILURE(status) && (resource_type == ACPI_RSTYPE_IRQ)) {
+                resource_type = ACPI_RSTYPE_EXT_IRQ;
+                printk(PREFIX "Retrying with extended IRQ descriptor\n");
+                goto retry_programming;
+	}
+  
+	/* check for total failure */
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _SRS\n"));
 		return_VALUE(-ENODEV);

--Boundary-00=_pNPU/GwlzAFDWNg
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="linux-2.6.0-test4-irqrestype.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.0-test4-irqrestype.patch"


--- linux-2.6.0-test4.orig/drivers/acpi/pci_link.c	2003-08-23 00:52:08.000000000 +0100
+++ linux-2.6.0-test4/drivers/acpi/pci_link.c	2003-08-30 18:54:39.000000000 +0100
@@ -294,6 +294,7 @@
 	struct acpi_buffer	buffer = {sizeof(resource)+1, &resource};
 	int			i = 0;
 	int			valid = 0;
+	int			resource_type = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_pci_link_set");
 
@@ -317,20 +318,32 @@
 		}
 	}
 
+	/* If IRQ<=15, first try with a "normal" IRQ descriptor. If that fails, try with
+	 * an extended one */
+	if (irq <= 15) {
+		resource_type = ACPI_RSTYPE_IRQ;
+	} else {
+		resource_type = ACPI_RSTYPE_EXT_IRQ;
+	}
+
+retry_programming:
+   
 	memset(&resource, 0, sizeof(resource));
 
 	/* NOTE: PCI interrupts are always level / active_low / shared. But not all
 	   interrupts > 15 are PCI interrupts. Rely on the ACPI IRQ definition for 
 	   parameters */
-	if (irq <= 15) {
+	switch(resource_type) {
+	case ACPI_RSTYPE_IRQ:
 		resource.res.id = ACPI_RSTYPE_IRQ;
 		resource.res.length = sizeof(struct acpi_resource);
 		resource.res.data.irq.edge_level = link->irq.edge_level;
 		resource.res.data.irq.active_high_low = link->irq.active_high_low;
 		resource.res.data.irq.number_of_interrupts = 1;
 		resource.res.data.irq.interrupts[0] = irq;
-	}
-	else {
+		break;
+	   
+	case ACPI_RSTYPE_EXT_IRQ:
 		resource.res.id = ACPI_RSTYPE_EXT_IRQ;
 		resource.res.length = sizeof(struct acpi_resource);
 		resource.res.data.extended_irq.producer_consumer = ACPI_CONSUMER;
@@ -339,11 +352,21 @@
 		resource.res.data.extended_irq.number_of_interrupts = 1;
 		resource.res.data.extended_irq.interrupts[0] = irq;
 		/* ignore resource_source, it's optional */
+		break;
 	}
 	resource.end.id = ACPI_RSTYPE_END_TAG;
 
 	/* Attempt to set the resource */
 	status = acpi_set_current_resources(link->handle, &buffer);
+
+	/* if we failed and IRQ <= 15, try again with an extended descriptor */
+	if (ACPI_FAILURE(status) && (resource_type == ACPI_RSTYPE_IRQ)) {
+                resource_type = ACPI_RSTYPE_EXT_IRQ;
+                printk(PREFIX "Retrying with extended IRQ descriptor\n");
+                goto retry_programming;
+	}
+  
+	/* check for total failure */
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating _SRS\n"));
 		return_VALUE(-ENODEV);
@@ -458,14 +481,14 @@
 		irq = link->irq.possible[0];
 	}
 
-		/* 
-		 * Select the best IRQ.  This is done in reverse to promote 
-		 * the use of IRQs 9, 10, 11, and >15.
-		 */
-		for (i=(link->irq.possible_count-1); i>0; i--) {
-			if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
-				irq = link->irq.possible[i];
-		}
+	/* 
+	 * Select the best IRQ.  This is done in reverse to promote 
+	 * the use of IRQs 9, 10, 11, and >15.
+	 */
+	for (i=(link->irq.possible_count-1); i>0; i--) {
+		if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
+			irq = link->irq.possible[i];
+	}
 
 	/* Attempt to enable the link device at this IRQ. */
 	if (acpi_pci_link_set(link, irq)) {

--Boundary-00=_pNPU/GwlzAFDWNg--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
