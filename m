From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Re: 2.5.51: sleep broken
Date: Sun, 15 Dec 2002 23:56:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212152356.09656.p_christ@hol.gr>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A591@orsmsx119.jf.intel.com> <200212130111.32710.p_christ@hol.gr> <200212131604.23595.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200212131604.23595.p_christ-U04EIuiosng@public.gmane.org>
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

I also noted some perculiarity in the code:

in: linux/arch/i386/kernel/acpi.c
in: acpi_reserve_bootmem(void)
...
        if ((&wakeup_end - &wakeup_start) > PAGE_SIZE)
                printk(KERN_CRIT "ACPI: Wakeup code way too big, will crash on 
                      attempt to suspend (0x%8.8lx)\n",
                        (&wakeup_end - &wakeup_start));

--- I added the parameter to see what's happening. The message indicated an 
0x3000 size. (12k)

the comment for the fn says:
 * We allocate a page in low memory for the wakeup
 * routine for when we come back from a sleep state. The
 * runtime allocator allows specification of <16M pages, but not
 * <1M pages.

Are the above lines correct? AFAIK macro PAGE_SIZE = 4096
That would mean that only <4k code is allowed. OK, but the comment suggests 
otherwise...



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
