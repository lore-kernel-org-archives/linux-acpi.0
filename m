From: Magnus Christensson <mch-8vJNMC6Ql2nxsAP9Fp7wbw@public.gmane.org>
Subject: RSDP scan problem
Date: Thu, 04 Mar 2004 16:47:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40474F84.4060102@virtutech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

There seem to be a problem with the RSDP scan in at least a few different kernel 
versions.

In the 2.6 version I looked at we have:

----
         /*
          * Scan memory looking for the RSDP signature. First search EBDA (low
          * memory) paragraphs and then search upper memory (E0000-FFFFF).
          */
         rsdp_phys = acpi_scan_rsdp (0, 0x400);
         if (!rsdp_phys)
                 rsdp_phys = acpi_scan_rsdp (0xE0000, 0xFFFFF);
----

In a 2.4 version we have:

----
	/*
	 * Physical address is given
	 */
	/*
	 * Region 1) Search EBDA (low memory) paragraphs
	 */
	rsdp = acpi_tb_scan_memory_for_rsdp(__va(LO_RSDP_WINDOW_BASE),
					 LO_RSDP_WINDOW_SIZE);
----

Both versions claim to check the EBDA in the comments, but if I'm not mistaken 
they really check the lowest part of physical memory.

The location of the EBDA varies between BIOSes (the real mode segment part can 
be found at 40:0E).

M.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
