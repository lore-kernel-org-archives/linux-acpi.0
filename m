From: G E Scott Knauss <scott-2UAVKnXlLSjQT0dZR+AlfA@public.gmane.org>
Subject: error transitioning device
Date: Wed, 24 Mar 2004 12:05:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1080126326.2271.25.camel@eva.ecr.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

OK,
	I've googled and searched bugzilla for it, but can't find any
references to it, today. I seem to remember seeing something a month or
so ago, that implied this wouldn't be fixed until 2.7. Can someone point
me in the right direction ? As I'm reading these errors, my fan isn't
turning on when the kernel or acpid asks it to. I'm guessing that could
be a bad thing ? (The fan really isn't turning on. )


	I guess I really just want to make sure I'm not missing something
simple before I submit a bug.

			Thanks,

OBTW, this is exactly what I'm seeing;

Mar 24 11:45:13 eva kernel: acpi_bus-0256 [44] acpi_bus_set_power    :
Error transitioning device [C210] to D0
Mar 24 11:45:13 eva kernel: acpi_thermal-0612 [43] acpi_thermal_active  
: Unable to turn cooling device [c1a9d928] 'on'
Mar 24 11:45:13 eva kernel: acpi_bus-0256 [44] acpi_bus_set_power    :
Error transitioning device [C210] to D0
Mar 24 11:45:13 eva kernel: acpi_thermal-0612 [43] acpi_thermal_active  
: Unable to turn cooling device [c1a9d928] 'on'
Mar 24 11:45:13 eva kernel: acpi_bus-0256 [44] acpi_bus_set_power    :
Error transitioning device [C210] to D0
Mar 24 11:45:13 eva kernel: acpi_thermal-0612 [43] acpi_thermal_active  
: Unable to turn cooling device [c1a9d928] 'on'
Mar 24 11:45:13 eva acpid_proxy[3641]-1: No action specified for event
thermal_zone TZ1 00000081 00000000
Mar 24 11:45:28 eva kernel: acpi_bus-0256 [44] acpi_bus_set_power    :
Error transitioning device [C210] to D0
Mar 24 11:45:28 eva kernel: acpi_thermal-0612 [43] acpi_thermal_active  
: Unable to turn cooling device [c1a9d928] 'on'
Mar 24 11:45:28 eva kernel: acpi_bus-0256 [44] acpi_bus_set_power    :
Error transitioning device [C210] to D0
Mar 24 11:45:28 eva kernel: acpi_thermal-0612 [43] acpi_thermal_active  
: Unable to turn cooling device [c1a9d928] 'on'
Mar 24 11:45:28 eva kernel: acpi_bus-0256 [44] acpi_bus_set_power    :
Error transitioning device [C210] to D0
Mar 24 11:45:28 eva kernel: acpi_thermal-0612 [43] acpi_thermal_active  
: Unable to turn cooling device [c1a9d928] 'on'
Mar 24 11:45:28 eva acpid_proxy[3706]-1: No action specified for event
thermal_zone TZ1 00000081 00000000



 
Scott Knauss
www.scott.knauss.com
scott-2UAVKnXlLSjQT0dZR+AlfA@public.gmane.org
ECRNOC Naples, Italy
DSN 314-626-4678
COM 39-081-568-4678




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
