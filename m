From: Zwane Mwaikambo <zwane-T6AQWPvKiI1fDP7aoN8Z5Q@public.gmane.org>
Subject: Re: [PATCH] Oops and panic while unloading holder of pm_idle
Date: Mon, 23 Aug 2004 18:41:16 -0400 (EDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0408231839280.13924@montezuma.fsmlabs.com>
References: <200408171728.06262.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200408171728.06262.blaisorblade_spam-whZMOeQn8C0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: BlaisorBlade <blaisorblade_spam-whZMOeQn8C0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 19 Aug 2004, BlaisorBlade wrote:

> (CC me on replies as I'm not subscribed).
>
> A short description, with my hypothesis about how the panic() happened:

There is a short one liner for this which is already in the latest
kernel;

Index: linux-2.6.8-rc1-mm1/drivers/acpi/processor.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc1-mm1/drivers/acpi/processor.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.c
--- linux-2.6.8-rc1-mm1/drivers/acpi/processor.c	14 Jul 2004 04:56:25 -0000	1.1.1.1
+++ linux-2.6.8-rc1-mm1/drivers/acpi/processor.c	20 Jul 2004 15:31:46 -0000
@@ -2372,8 +2372,10 @@ acpi_processor_remove (
 	pr = (struct acpi_processor *) acpi_driver_data(device);

 	/* Unregister the idle handler when processor #0 is removed. */
-	if (pr->id == 0)
+	if (pr->id == 0) {
 		pm_idle = pm_idle_save;
+		synchronize_kernel();
+	}

 	status = acpi_remove_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY,
 		acpi_processor_notify);


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
