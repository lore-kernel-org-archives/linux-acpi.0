From: David Moore <dcm-HInyCGIudOg@public.gmane.org>
Subject: _PDC method in DSDT
Date: 22 Jun 2003 17:45:31 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1056329130.10322.36.camel@aldebaran.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

Hi,

Does anyone know the purpose or specification of the _PDC method of the
DSDT?  It's a reserved method that exists on my laptop (a Dell Latitude
D600) but does not seem to be documented in the ACPI specification on
the web.

The reason I ask is that I'm interested in porting the cpufreq driver
for Enhanced Speedstep to ACPI.  Right now, the cpufreq driver has the
tables of proper MSR register values encoded into the source, but a more
elegant solution would be to get this information from ACPI.  In my DSDT
source I notice that when the _PDC method is called properly, the _PCT
method will return FixedHardware addresses for the Enhanced Speedstep
MSRs instead of its normal SystemIO ports.  To get this to work on more
than just my system, I should probably use the proper specification for
calling _PDC rather than just making it work.

Anyone have any suggestions?

Regards,

David



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
