From: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Subject: Re: "irq 11: nobody cared" after S3
Date: Mon, 02 Aug 2004 21:27:50 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <410EEA16.6030800@optonline.net>
References: <B44D37711ED29844BEA67908EAF36F03768BD0@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_PwZBupbCV0Jzl0XFEMAxwg)"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <B44D37711ED29844BEA67908EAF36F03768BD0-4yWAQGcml65pB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: stefandoesinger-RbZlAiThDcE@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_PwZBupbCV0Jzl0XFEMAxwg)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Li, Shaohua wrote:

>I don't think your patch works, and even it works for your system, it
>will break other systems. The goal of 'setonboot' is to prevent setting
>LINK device's IRQ every time, which we added last year. Without it, many
>systems will break. IIRC, its goal is to resolve a bug in bugzilla. But
>currently I don't remember the exact bug number.
>  
>
Thanks for the feedback. It works for my system--but only for devices 
that call pci_device_enable(). Therefore I am currently reinstating the 
"setonboot" flag and reworking the patch along the lines of the attached:

--Boundary_(ID_PwZBupbCV0Jzl0XFEMAxwg)
Content-type: text/x-patch; name=acpi-fixes.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=acpi-fixes.patch

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/02 20:41:54-04:00 nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org 
#   [ACPI] drivers/acpi/pci_link.c: add acpi_pci_link_resume(), which will be
#   called when resuming from a suspend state that needs IRQ routing to be
#   restored. This fixes issues reported on the mailing lists, e.g.:
#   
#   http://marc.theaimsgroup.com/?l=acpi4linux&m=109142999328643&w=2
# 
# drivers/acpi/pci_link.c
#   2004/08/02 20:41:45-04:00 nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org +23 -0
#   [ACPI] drivers/acpi/pci_link.c: add acpi_pci_link_resume(), which will be
#   called when resuming from a suspend state that needs IRQ routing to be
#   restored. This fixes issues reported on the mailing lists, e.g.:
#   
#   http://marc.theaimsgroup.com/?l=acpi4linux&m=109142999328643&w=2
# 
# BitKeeper/etc/ignore
#   2004/08/02 20:41:45-04:00 nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org +2 -0
#   Added Module.symvers drivers/acpi/pci_link.c~ to the ignore list
# 
diff -Nru a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
--- a/drivers/acpi/pci_link.c	2004-08-02 21:23:19 -04:00
+++ b/drivers/acpi/pci_link.c	2004-08-02 21:23:19 -04:00
@@ -55,6 +55,7 @@
 #define ACPI_PCI_LINK_MAX_POSSIBLE 16
 
 static int acpi_pci_link_add (struct acpi_device *device);
+static int acpi_pci_link_resume (struct acpi_device *device, int state);
 static int acpi_pci_link_remove (struct acpi_device *device, int type);
 
 static struct acpi_driver acpi_pci_link_driver = {
@@ -64,6 +65,7 @@
 	.ops =		{
 				.add =    acpi_pci_link_add,
 				.remove = acpi_pci_link_remove,
+				.resume = acpi_pci_link_resume,
 			},
 };
 
@@ -691,6 +693,27 @@
 		kfree(link);
 
 	return_VALUE(result);
+}
+
+
+static int
+acpi_pci_link_resume (
+	struct acpi_device	*device,
+	int state)
+{
+	struct acpi_pci_link *link = NULL;
+	
+	ACPI_FUNCTION_TRACE("acpi_pci_link_resume");
+	
+	if (!device || !acpi_driver_data(device))
+		return_VALUE(-EINVAL);
+		
+	link = (struct acpi_pci_link *) acpi_driver_data(device);
+
+	if (link->irq.active && link->irq.setonboot)
+		return_VALUE(acpi_pci_link_set(link, link->irq.active));
+	else
+		return_VALUE(0);
 }
 
 

--Boundary_(ID_PwZBupbCV0Jzl0XFEMAxwg)--


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
