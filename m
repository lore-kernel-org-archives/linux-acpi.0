From: "Stefan Becker (NMP/Salo)" <Stefan.Becker-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Fix compilation errors in 20030813 when IO APIC not configured
Date: Thu, 21 Aug 2003 10:22:56 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F447350.3090409@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040904040109090409000902"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

This is a multi-part message in MIME format.
--------------040904040109090409000902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

when I tried to compile 2.4.22-rc2 + ACPI 20030813 I got a compilation 
error in setup.c. Adding a CONFIG_X86_IO_APIC around the offending 
places fixed the problem. See the attached diffs.

Reading some recent messages on this mailing list, I think I should try 
to enable the kernel options LOCAL APIC and IO APIC for my laptop though...

Regards,

	Stefan

---
Stefan Becker
E-Mail: Stefan.Becker-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org

--------------040904040109090409000902
Content-Type: text/plain;
 name="acpi-20030813-2.4.22-rc2-FIX.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi-20030813-2.4.22-rc2-FIX.diff"

--- linux-2.4.22-rc2/arch/i386/kernel/setup.c~	2003-08-20 18:36:25.000000000 +0300
+++ linux-2.4.22-rc2/arch/i386/kernel/setup.c	2003-08-20 19:01:50.000000000 +0300
@@ -179,6 +179,9 @@
 int acpi_disabled __initdata = 0;
 int acpi_ht __initdata = 1; 	/* enable HT */
 int acpi_force __initdata = 0;
+#ifdef  CONFIG_X86_IO_APIC
+extern int skip_ioapic_setup;
+#endif
 #else
 int acpi_disabled __initdata = 1;
 #endif
@@ -825,11 +828,13 @@
 			if (!acpi_force) acpi_disabled = 1; 
 		} 
 
+#ifdef CONFIG_X86_IO_APIC
                 /* disable IO-APIC */
                 else if (!memcmp(from, "noapic", 6)) {
                         skip_ioapic_setup = 1;
                 }
 #endif
+#endif
 		/*
 		 * highmem=size forces highmem to be exactly 'size' bytes.
 		 * This works even on boxes that have no highmem otherwise.

--------------040904040109090409000902--



-------------------------------------------------------
This SF.net email is sponsored by Dice.com.
Did you know that Dice has over 25,000 tech jobs available today? From
careers in IT to Engineering to Tech Sales, Dice has tech jobs from the
best hiring companies. http://www.dice.com/index.epl?rel_code=104
