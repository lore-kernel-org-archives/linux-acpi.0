From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Re: PROBLEM: ACPI freezes 2.6.1 on boot
Date: Thu, 22 Jan 2004 13:08:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040122120854.GB3534@hell.org.pl>
References: <7F740D512C7C1046AB53446D3720017361885C@scsmsx402.sc.intel.com> <m3u12pgfpr.fsf@reason.gnu-hamburg> <m3ptddgckg.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m3ptddgckg.fsf-glUV91rXKAHWIjgkaejU9x2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Cc: "Nakajima, Jun" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Martin Loschwitz <madkiss-R0iKqZn4BxJAfugRpC6u6w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Georg C. F. Greve:
> So the problem we've been seeing seems to be related to the
> interaction between local APIC support and ACPI.

We've definitely had those problems before (with ASUS L3800C), there's 
even a patch fixing this issue (attached below) you might try.
I guess that's another of those lost and forgotten bugzilla bugs :)

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


diff -Bru linux-2.6.0-test8/arch/i386/kernel/apic.c patched/arch/i386/kernel/apic.c
--- linux-2.6.0-test8/arch/i386/kernel/apic.c	2003-10-18 05:43:36.000000000 +0800
+++ patched/arch/i386/kernel/apic.c	2003-10-30 23:17:50.000000000 +0800
@@ -836,8 +836,8 @@
 {
 	unsigned int lvtt1_value, tmp_value;
 
-	lvtt1_value = SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV) |
-			APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
+	lvtt1_value = APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
+
 	apic_write_around(APIC_LVTT, lvtt1_value);
 
 	/*
diff -Bru linux-2.6.0-test8/drivers/acpi/bus.c patched/drivers/acpi/bus.c
--- linux-2.6.0-test8/drivers/acpi/bus.c	2003-10-18 05:43:19.000000000 +0800
+++ patched/drivers/acpi/bus.c	2003-10-30 23:20:32.000000000 +0800
@@ -589,6 +589,7 @@
 
 	ACPI_FUNCTION_TRACE("acpi_bus_init");
 
+	disable_APIC_timer();
 	status = acpi_initialize_subsystem();
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX "Unable to initialize the ACPI Interpreter\n");
@@ -643,6 +644,7 @@
 		goto error1;
 	}
 
+	enable_APIC_timer();
 	printk(KERN_INFO PREFIX "Interpreter enabled\n");
 
 	/*
@@ -672,6 +674,7 @@
 error1:
 	acpi_terminate();
 error0:
+	enable_APIC_timer();
 	return_VALUE(-ENODEV);
 }
 


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
