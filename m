From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: fix ACPI poweroff in 2.4.25-rc2
Date: 06 Mar 2004 01:16:48 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1078553807.12999.3187.camel@dhcppc4>
References: <200403031117.25937.bjorn.helgaas@hp.com>
	 <20040303194656.GV25779@parcelfarce.linux.theplanet.co.uk>
	 <200403031305.31966.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200403031305.31966.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-03-03 at 15:05, Bjorn Helgaas wrote:
> On Wednesday 03 March 2004 12:46 pm, Matthew Wilcox wrote:
> > On Wed, Mar 03, 2004 at 11:17:25AM -0700, Bjorn Helgaas wrote:

> Here's a patch to do it that way, if you prefer.  acpi_system_save_state()
> isn't defined before use, so you get a warning about that, which I didn't
> bother to fix (I expect x86 probably sees the same warning).

I think you mean this, yes?
(note that CONFIG_X86 was redundant since CONFIG_ACPI_SLEEP depends on
it)

-Len

===== drivers/acpi/system.c 1.16 vs edited =====
--- 1.16/drivers/acpi/system.c	Sun Feb 15 06:38:17 2004
+++ edited/drivers/acpi/system.c	Sat Mar  6 00:57:18 2004
@@ -41,14 +41,18 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
-#ifdef CONFIG_X86
 #ifdef CONFIG_ACPI_SLEEP
 #include <linux/mc146818rtc.h>
 #include <linux/irq.h>
 #include <asm/hw_irq.h>
-#endif
-#endif
 
+acpi_status acpi_system_save_state(u32);
+#else
+static inline acpi_status acpi_system_save_state(u32 state)
+{
+	return AE_OK;
+}
+#endif /* !CONFIG_ACPI_SLEEP */
 
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME		("acpi_system")





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
