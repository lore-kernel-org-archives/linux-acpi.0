From: Dirk Mueller <dmueller-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH]  make cpu_has_cpufreq() work
Date: Wed, 21 Dec 2005 04:46:48 +0100
Message-ID: <200512210446.49494.dmueller@suse.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi, 

it seems to me the return values of cpu_has_cpufreq in processor_thermal.c are 
reversed. all callers check for if(!cpu_has_cpufreq()) return -ENODEV, which 
indicates that it expects a return value of 0 for error, and nonzero for 
success. 

However the current implementation gets that reversed. the patch below fixes 
it. Spotted by Thomas Renninger, and fixes the ACPI thermal code never 
actually speedstepping the CPU when it overheats. 


Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Dirk Mueller <dmueller-IBi9RG/b67k@public.gmane.org>

--- processor_thermal.c.orig    2005-12-21 00:18:06.000000000 +0100
+++ processor_thermal.c 2005-12-21 00:18:23.000000000 +0100
@@ -102,8 +102,8 @@ static int cpu_has_cpufreq(unsigned int
 {
        struct cpufreq_policy policy;
        if (!acpi_thermal_cpufreq_is_init || cpufreq_get_policy(&policy, cpu))
-               return -ENODEV;
-       return 0;
+               return 0;
+       return 1;
 }

 static int acpi_thermal_cpufreq_increase(unsigned int cpu)


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
