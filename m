From: MAEDA Naoaki <maeda.naoaki-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: latest ACPI patch based on 2.6.13
Date: Mon, 08 Aug 2005 13:41:33 +0900 (JST)
Message-ID: <20050808.134133.41727261.maeda.naoaki@jp.fujitsu.com>
References: <1123214969.13136.51.camel@toshiba>
	<1123220125.13136.77.camel@toshiba>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1123220125.13136.77.camel@toshiba>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Len and Kenji,

From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [ACPI] latest ACPI patch based on 2.6.13
Date: Fri, 05 Aug 2005 01:35:25 -0400

> The Latest ACPI patch based on 2.6.13 is available here:
> 
> http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.12/acpi-20050729-2.6.13-rc6.patch
> 
> These patches are exported to-akpm for inclusion in -mm
> with the intent to integrate into 2.6.14.
> 
> http://ftp.kernel.org/pub/scm/linux/kernel/git/lenb/to-akpm.git/
> 
> Please give it a go and speak up and file bugs if you run into
> any issues.

It cannot be compiled on ia64, due to some typos in ia64 specific files.
The following patch fixes the typos. 

In addition, assign_irq_vector_nopanic() called by iosapic_register_intr()
is missing. Shouldn't be assign_irq_vector()?

Thanks,
MAEDA Naoaki

Index: linux-2.6.13-rc5-mm1/arch/ia64/kernel/acpi.c
===================================================================
--- linux-2.6.13-rc5-mm1.orig/arch/ia64/kernel/acpi.c
+++ linux-2.6.13-rc5-mm1/arch/ia64/kernel/acpi.c
@@ -74,7 +74,7 @@ unsigned int acpi_cpei_override;
 unsigned int acpi_cpei_phys_cpuid;
 
 #define MAX_SAPICS 256
-u16 ia64_acpiid_to_sapicid[MAX_SAPICS] = {[0...MAX_SAPICS - 1] = -1 };
+u16 ia64_acpiid_to_sapicid[MAX_SAPICS] = {[0 ... MAX_SAPICS - 1] = -1 };
 
 EXPORT_SYMBOL(ia64_acpiid_to_sapicid);
 
@@ -138,7 +138,7 @@ const char *acpi_get_sysname(void)
 
 /* Array to record platform interrupt vectors for generic interrupt routing. */
 int platform_intr_list[ACPI_MAX_PLATFORM_INTERRUPTS] = {
-	[0...ACPI_MAX_PLATFORM_INTERRUPTS - 1] = -1
+	[0 ... ACPI_MAX_PLATFORM_INTERRUPTS - 1] = -1
 };
 
 enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_IOSAPIC;
Index: linux-2.6.13-rc5-mm1/arch/ia64/kernel/iosapic.c
===================================================================
--- linux-2.6.13-rc5-mm1.orig/arch/ia64/kernel/iosapic.c
+++ linux-2.6.13-rc5-mm1/arch/ia64/kernel/iosapic.c
@@ -739,7 +739,7 @@ again:
 	if (vector < 0) {
 		vector = iosapic_find_sharable_vector(trigger, polarity);
   		if (vector < 0)
-			Return -ENOSPC;
+			return -ENOSPC;
 	}
 
 	spin_lock_irqsave(&irq_descp(vector)->lock, flags);




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
