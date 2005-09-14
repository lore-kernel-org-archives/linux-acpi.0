From: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [ACPI][PATCH 4/4] (take 2) Software coordination of freq across CPUs sharing common P-state
Date: Tue, 13 Sep 2005 17:06:44 -0700
Message-ID: <20050913170643.E5968@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: cpufreq <cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Shah, Rajesh" <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


[PATCH 4/4] Software coordination of freq across CPUs sharing common P-state

Final knob to turn on the P-state cpu groups in acpi-cpufreq and
speedstep-centrino. Add the software coordination bit for _PDC calls.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Index: linux-2.6.12/include/acpi/pdc_intel.h
===================================================================
--- linux-2.6.12.orig/include/acpi/pdc_intel.h	2005-09-06 09:44:16.419923288 -0700
+++ linux-2.6.12/include/acpi/pdc_intel.h	2005-09-06 14:31:56.091054448 -0700
@@ -15,6 +15,7 @@
 #define ACPI_PDC_C_C1_FFH		(0x0100)
 
 #define ACPI_PDC_EST_CAPABILITY_SMP	(ACPI_PDC_SMP_C1PT | \
+					 ACPI_PDC_SMP_P_SWCOORD | \
 					 ACPI_PDC_C_C1_HALT)
 
 #define ACPI_PDC_EST_CAPABILITY_SMP_MSR	(ACPI_PDC_EST_CAPABILITY_SMP | \


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
