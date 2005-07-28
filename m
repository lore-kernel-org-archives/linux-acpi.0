From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: Fw: powersave not working with amd64 on nforce 4 board
Date: Thu, 28 Jul 2005 01:34:16 -0700
Message-ID: <20050728013416.6cd24d6e.akpm@osdl.org>
References: <20050727161646.05c40b3a.akpm@osdl.org>
	<200507281025.25183.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200507281025.25183.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, flo-MALAOO1t6vMdnm+yROfE0A@public.gmane.org, Dave Jones <davej-rdkfGonbjUTCLXcRTR1eJlpr/1R2p/CL@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

"Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org> wrote:
>
> n Thursday, 28 of July 2005 01:16, Andrew Morton wrote:
>  > 
>  > It might help if you were to raise a bugzilla entry for this..
> 
>  More likely it's BIOS bug.  I ran 2.6.13-rc3-mm1 on a box with nForce4
>  and it worked fine except I needed to apply the attached patch from
>  Mark Langsdorf, since the CPU is a dual-core.
> 
>  BTW, any chance to include this patch in -mm?

Spose so.  Would prefer that Mark himself sends it though.

Dave, does it look sane?

--- linux-2.6.12-rc6/arch/i386/kernel/cpu/cpufreq/powernow-k8.c.old	2005-06-12 17:41:55.123651184 -0500
+++ linux-2.6.12-rc6/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2005-06-12 17:46:32.780440936 -0500
@@ -44,7 +44,7 @@
 
 #define PFX "powernow-k8: "
 #define BFX PFX "BIOS error: "
-#define VERSION "version 1.40.2"
+#define VERSION "version 1.40.4"
 #include "powernow-k8.h"
 
 /* serialize freq changes  */
@@ -978,7 +978,7 @@
 {
 	struct powernow_k8_data *data;
 	cpumask_t oldmask = CPU_MASK_ALL;
-	int rc;
+	int rc, i;
 
 	if (!check_supported_cpu(pol->cpu))
 		return -ENODEV;
@@ -1064,7 +1064,9 @@
 	printk("cpu_init done, current fid 0x%x, vid 0x%x\n",
 	       data->currfid, data->currvid);
 
-	powernow_data[pol->cpu] = data;
+	for_each_cpu_mask(i, cpu_core_map[pol->cpu]) {
+		powernow_data[i] = data;
+	}
 
 	return 0;
 




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
