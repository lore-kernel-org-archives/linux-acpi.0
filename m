From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH] ACPI: make acpi_bus_register_driver() return zero for success, not device count
Date: Thu, 28 Jul 2005 10:07:53 -0600
Message-ID: <200507281007.53805.bjorn.helgaas@hp.com>
References: <200507271628.25844.bjorn.helgaas@hp.com> <20050728115816.GA29744@hell.org.pl> <200507280926.41472.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200507280926.41472.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
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
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, julien.lerouge-GANU6spQydw@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 28 July 2005 9:26 am, Bjorn Helgaas wrote:
> On Thursday 28 July 2005 5:58 am, Karol Kozimor wrote:
> > Ugh, not again... we've been there (early 2.6.x), done that and it was
> > absolutely confusing (I mean users reporting bogus bugs just because the
> > module was loaded type of confusing). Note that there's currently no easy
> > way to probe for a specific HID in ACPI namespace other than
> > acpi_bus_register_driver(), and unlike pci_register_driver() the former
> > has no hotplug mechanism to help. 
> 
> True.  But your driver can use its own mechanism to determine whether
> it claimed any devices, and if not, call acpi_bus_unregister_driver()
> and then return -ENODEV from the module init function to cause the
> module to be unloaded.

Here's what I had in mind (untested).  Would something like this
address your concern?

Index: work/drivers/acpi/asus_acpi.c
===================================================================
--- work.orig/drivers/acpi/asus_acpi.c	2005-07-27 13:52:21.000000000 -0600
+++ work/drivers/acpi/asus_acpi.c	2005-07-28 09:56:17.000000000 -0600
@@ -1111,6 +1111,8 @@
 }
 
 
+static int __init asus_found;
+
 static int __init asus_hotk_add(struct acpi_device *device)
 {
 	acpi_status status = AE_OK;
@@ -1168,6 +1170,8 @@
 		}
 	}
 
+	asus_found = 1;
+
       end:
 	if (result) {
 		kfree(hotk);
@@ -1221,6 +1225,12 @@
 		return -ENODEV;
 	}
 
+	if (!asus_found) {
+		acpi_bus_unregister_driver(&asus_hotk_driver);
+		remove_proc_entry(PROC_ASUS, acpi_root_dir);
+		return -ENODEV;
+	}
+
 	return 0;
 }
 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
