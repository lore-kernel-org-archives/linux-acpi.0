From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Vaio PGC-FXA47 Troubles
Date: Wed, 21 Aug 2002 10:08:05 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DDBB@orsmsx119.jf.intel.com>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "'andre=C0YGx8wpusqlKpGPh6I4hdHuzzzSOjJt@public.gmane.org'" <andre-C0YGx8wpusqlKpGPh6I4hdHuzzzSOjJt@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Andre Masella [mailto:andre-C0YGx8wpusqlKpGPh6I4hdHuzzzSOjJt@public.gmane.org] 
> I am still having problems. I got Linux 2.4.18. I applied the 
> latest acpi 
> patch. There are now many problems. First, the swsusp won't 
> apply on top of 
> the acpi patch. I have tried to compile the kernel but the 
> ACPI does not 
> work. There are a number of AE_NO_MEMORY errors and the 
> /proc/acpi directory 
> is never created. I though it was gcc-3.1, so I downgraded to 
> gcc-2.96.3, but 
> that made no difference. Here is the dmesg output:

[snip]

> PCI: Using configuration type 1
>    tbget-0133: *** Error: Could not map memory at 0fef9a51 
> for length 0
>   tbrsdt-0257 [04] Tb_get_table_rsdt     : Could not get the 
> RSDT/XSDT, 
> AE_NO_MEMORY
>  tbxface-0086: *** Error: Acpi_load_tables: Could not load 
> RSDT: AE_NO_MEMORY
>  tbxface-0116: *** Error: Acpi_load_tables: Could not load tables: 
> AE_NO_MEMORY
> ACPI: Unable to load the System Description Tables

[snip]

> What could be wrong?

Well, why is the error at tbget.c line 133 happening?
Why is it trying to map something of length 0?

The other error messages are just the fallout of that problem.

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
