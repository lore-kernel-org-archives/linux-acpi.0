From: marco <marco-3nEOSfQFBEQ@public.gmane.org>
Subject: suspend-to-disk problem
Date: Fri, 16 Jul 2004 07:39:33 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <opsa7tz7wzc4gufq@yoda.mh.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
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

hi folks,

if i try a suspend to disk with:
echo -n "disk" > /sys/power/state
i get the following warnings/errors:

Jul 16 07:37:17 swallow kernel: Stopping tasks: 
========================================================================================================================
Jul 16 07:37:17 swallow kernel: Restarting tasks...<6> Strange, ahc_dv_0 
not stopped
Jul 16 07:37:17 swallow kernel:  done
Jul 16 07:37:17 swallow kernel: apm: BIOS version 1.2 Flags 0x07 (Driver 
version 1.16ac)
Jul 16 07:37:17 swallow kernel: apm: overridden by ACPI.
Jul 16 07:37:17 swallow modprobe: FATAL: Error inserting apm 
(/lib/modules/2.6.7/kernel/arch/i386/kernel/apm.ko): No such device

what's wrong?

regards ma


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
