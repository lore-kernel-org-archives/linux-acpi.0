From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: i810 based system won't power off with Linux 2.5.67-bk
	8
Date: Thu, 17 Apr 2003 09:52:46 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19BCA5@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Pavel Roskin' <proski-mXXj517/zsQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Please send your raw DSDT, this is usually a bug in the table.

(cat /proc/acpi/dsdt/ > dsdt.dat)

Thanks,
Bob


> -----Original Message-----
> From: Pavel Roskin [mailto:proski-mXXj517/zsQ@public.gmane.org]
> Sent: Thursday, April 17, 2003 9:22 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] i810 based system won't power off with Linux 2.5.67-bk8
> 
> Hello!
> 
> I have a system with i810 chipset that won't power down.  Linux kernel is
> 2.5.67-bk8 (all recent 2.5.x kernels exhibit the same problem).
> 
> That's what I see on the serial console:
> 
> Halting system...
> Shutting down devices
> Power down.
> acpi_power_off called
> dsmthdat-0475 [21] ds_method_data_get_val: Uninitialized Local[0] at node
> c116bd08
>  psparse-1121: *** Error: Method execution failed [\SALD] (Node c7e154b8),
> AE_AML_UNINITIALIZED_LOCAL
>  psparse-1121: *** Error: Method execution failed [\_PTS] (Node c7e86524),
> AE_AML_UNINITIALIZED_LOCAL
> 
> 
> ACPI debugging is enabled.  .config and the output of dmesg after boot
> are attached.
> 
> --
> Regards,
> Pavel Roskin


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
