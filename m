From: alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org
Subject: ACPI error on 2.5.47-ac5
Date: 16 Nov 2002 06:46:39 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <87lm3ukqww.fsf@lapper.ihatent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

I just hacked up 2.5.47-ac5 on my Comapq Evo n800c, and caught these
in my bootlog:

ACPI: AC Adapter [C11A] (on-line)
ACPI: Power Button (FF) [PWRF]
acpi_processor-1131 [19] acpi_processor_set_per: Transition failed
acpi_processor-1779 [18] acpi_cpufreq_init     : Disabled P-States due to failure while switching.
ACPI: Processor [C000] (supports C1 C2 C3, 8 throttling states)
[ACPI Debug] Integer: 0000000000000E3A
[ACPI Debug] Integer: 0000000000000DB8
[ACPI Debug] Integer: 0000000000000D7C
[ACPI Debug] Integer: 0000000000000D4A
[ACPI Debug] Integer: 0000000000000CD2
ACPI: Thermal Zone [TZ1] (53 C)
ACPI: Thermal Zone [TZ2] (43 C)
[ACPI Debug] Integer: 0000000000000CBE
ACPI: Thermal Zone [TZ3] (16 C)


Not that ACPI works to great witht he built-in DSDT, anyway. :)

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
