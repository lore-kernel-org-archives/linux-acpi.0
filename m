From: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Subject: Re: reading battery status and CPU time
Date: Thu, 10 Apr 2003 23:20:30 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.53.0304102315390.1659@tweety.gaugusch.at>
References: <B900970C7DD9474C972986EB3EC7C58F0D4098@andromeda.agcad.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B900970C7DD9474C972986EB3EC7C58F0D4098-PWLG29+z7hEKeIAE67mlpo2P0GrZ+RbP@public.gmane.org>
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

I found something out about battery info being read twice:
(this is battery.c, acpi_battery_get_info())

---snip---
/* Extract Package Data */

   status = acpi_extract_package(package, &format, &data);  <-----
   if (status != AE_BUFFER_OVERFLOW) {
      ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error extracting _BIF\n"));
      result = -ENODEV;
      goto end;
   }

   data.pointer = kmalloc(data.length, GFP_KERNEL);
   if (!data.pointer) {
      result = -ENOMEM;
      goto end;
   }
   memset(data.pointer, 0, data.length);

   status = acpi_extract_package(package, &format, &data);  <-----
   if (ACPI_FAILURE(status)) {
      ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error extracting _BIF\n"));
      kfree(data.pointer);
      result = -ENODEV;
      goto end;
   }
---snip---


Why is acpi_extract_package called twice with different error handling?
The ASL code is definitely called twice (I've put debug statements in
there).
Same with battery state (_BST).

Markus


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
