From: Bharata B Rao <rao.bharata-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: ACPI support for Apollo Pro 133A (2.6.0-test11) ?
Date: Fri, 05 Dec 2003 17:37:35 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FD043CF.10704@samsung.com>
Reply-To: rao.bharata-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rao.bharata-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=us-ascii
Content-Transfer-Encoding: 7BIT
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

Hello,

I have a x86 m/c with Apollo Pro 133A chipset.

With 2.6.0-test11, the supported states are S0, S1 and S5 (according to
/proc/acpi/sleep).

Does this mean that I can't ever do suspend to RAM or DISK given that
there is no BIOS update available for this. The BIOS used is Phoenix
bios version 03AV.20001005. I have to use acpi=force to get ACPI running.

Strangely /sys/power/state says standby, mem and disk are supported
however nothing happens if I write mem to /sys/power/state.

Please let me know if anyone knows about this chipset.

Regards,
Bharata.





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
