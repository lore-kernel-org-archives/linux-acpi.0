From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: acpi_irq_to_vector()
Date: Thu, 5 Jun 2003 20:22:53 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030605192253.GS28581@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


In the 2.5 ia64 patch, there's a lot of places which look like this:

@@ -251,7 +251,14 @@
        irq = acpi_fadt.sci_int;

 #ifdef CONFIG_IA64
-       irq = gsi_to_vector(irq);
+       int vector;
+
+       vector = acpi_irq_to_vector(irq);
+       if (vector < 0) {
+               printk(KERN_ERR PREFIX "SCI (IRQ%d) not registerd\n", irq);
+               return AE_OK;
+       }
+       irq = vector;
 #endif
        acpi_irq_irq = irq;

ok, we renamed gsi_to_vector to acpi_irq_to_vector(); that's fine.
But we still have that ugly ifdef in there.  Any resistance to defining
acpi_irq_to_vector to simply return its value on non-ia64 platforms?

Then it'd look like:

	irq = acpi_fadt.sci_int;
	vector = acpi_irq_to_vector(irq);
	if (vector < 0) {
		printk(KERN_ERR PREFIX "SCI (IRQ%d) not registered\n", irq);
		return AE_OK;
	}
	acpi_irq_irq = vector;
	acpi_irq_handler = handler;
	acpi_irq_context = context;
	if (request_irq(vector, acpi_irq, SA_SHIRQ, "acpi", acpi_irq)) {
...		

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
