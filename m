From: Prarit Bhargava <prarit-sJ/iWh9BUns@public.gmane.org>
Subject: [PATCH]: Error in ACPI error handling results in WARN_ON in IDE
Date: Thu, 20 Jan 2005 08:58:07 -0500
Message-ID: <41EFB8EF.7010207@sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060208080905090606020303"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------060208080905090606020303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I found a bug in the error handling in ACPI.

The issue here is the error handling within the ACPI layer.  gsi = 0 is a
valid return value from acpi_pci_irq_lookup, while gsi = (-1) is the value
returned when a PRT cannot be found.



--------------060208080905090606020303
Content-Type: text/plain;
 name="1-acpi-ide.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="1-acpi-ide.patch"

===== drivers/acpi/pci_irq.c 1.35 vs edited =====
--- 1.35/drivers/acpi/pci_irq.c	2005-01-04 21:48:17 -05:00
+++ edited/drivers/acpi/pci_irq.c	2005-01-14 08:14:34 -05:00
@@ -487,10 +487,10 @@
 	 * If no PRT entry was found, we'll try to derive an IRQ from the
 	 * device's parent bridge.
 	 */
-	if (!gsi)
+	if (gsi == -1)
  		gsi = acpi_pci_irq_derive(dev, pin,
 					  &edge_level, &active_high_low);
-	if (!gsi)
+	if (gsi == -1)
 		return_VOID;
 
 	/*

--------------060208080905090606020303--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
