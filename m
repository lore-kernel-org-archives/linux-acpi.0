From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: Fw: powersave not working with amd64 on nforce 4 board
Date: Thu, 28 Jul 2005 10:25:24 +0200
Message-ID: <200507281025.25183.rjw@sisk.pl>
References: <20050727161646.05c40b3a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1ZJ6C23lbT3uo+o"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050727161646.05c40b3a.akpm-3NddpPZAyC0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Florian Engelhardt <flo-MALAOO1t6vMdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--Boundary-00=_1ZJ6C23lbT3uo+o
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Thursday, 28 of July 2005 01:16, Andrew Morton wrote:
> 
> It might help if you were to raise a bugzilla entry for this..

More likely it's BIOS bug.  I ran 2.6.13-rc3-mm1 on a box with nForce4
and it worked fine except I needed to apply the attached patch from
Mark Langsdorf, since the CPU is a dual-core.

BTW, any chance to include this patch in -mm?

Greets,
Rafael


> Begin forwarded message:
> 
> Date: Thu, 28 Jul 2005 00:26:18 +0200
> From: Florian Engelhardt <flo-MALAOO1t6vMdnm+yROfE0A@public.gmane.org>
> To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: powersave not working with amd64 on nforce 4 board
> 
> 
> Hello,
> 
> powersaving is not working with a 2.6.12-rc3-mm1 kernel and a amd64
> 3500+ on a nvidia nforce 4 mainboard.
> syslog tells me the following about it:
> 
> ..
> ACPI: Processor [CPU0] (supports 8 throttling states)
> ..
> powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.40.2)
> acpi_processor-0252 [04] acpi_processor_get_per: Error evaluating _PSS
> powernow-k8: BIOS error - no PSB or ACPI _PSS objects
> acpi_processor-0252 [04] acpi_processor_get_per: Error evaluating _PSS
> 
> kind regards
> 
> flo
> 
> -- 
> "I may have invented it, but Bill made it famous"
> David Bradley, who invented the (in)famous ctrl-alt-del key combination
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO September
> 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 
> 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_1ZJ6C23lbT3uo+o
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="jhpn-2.6.12-rc6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="jhpn-2.6.12-rc6.patch"

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
 

--Boundary-00=_1ZJ6C23lbT3uo+o--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
