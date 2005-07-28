From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [PATCH] ACPI: make acpi_bus_register_driver() return zero for success, not device count
Date: Thu, 28 Jul 2005 18:31:06 +0200
Message-ID: <20050728163106.GA28666@hell.org.pl>
References: <200507271628.25844.bjorn.helgaas@hp.com> <20050728115816.GA29744@hell.org.pl> <200507280926.41472.bjorn.helgaas@hp.com> <200507281007.53805.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200507281007.53805.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
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
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, julien.lerouge-GANU6spQydw@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Bjorn Helgaas:
> > True.  But your driver can use its own mechanism to determine whether
> > it claimed any devices, and if not, call acpi_bus_unregister_driver()
> > and then return -ENODEV from the module init function to cause the
> > module to be unloaded.
> Here's what I had in mind (untested).  Would something like this
> address your concern?

It's clunky, but yes, at least until something better (say, sysfs support
for ACPI) goes in. Note that I'm on vacation till monday, so I won't be able
to test it either.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org

Acked-by: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>


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
