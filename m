From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: DSDT in Dell i8200-- does acpi have the correct addres
	s?
Date: Mon, 16 Dec 2002 11:43:24 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A5A8@orsmsx119.jf.intel.com>
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
To: 'James D Strandboge' <jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: James D Strandboge [mailto:jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org] 
> My i8200 has basic acpi functionality, with quite a few issues.  I
> started poking around the Dell download site and came across this in a
> description of a BIOS upgrade for my laptop:
> 
> ===================================================================
> Systems:      Dell Inspiron 8200	(Memory location F000:E845)
> Version:      A06                       (Memory location F000:E842)
> Build Date:   08/17/02                  (Memory location FFFF:0005)
> 
> ...
> 
> Now, if I read my dsdt from /proc/acpi/dsdt, nd decompile it 
> with iasl,
> it shows a version from 1998.  I looked at dmesg and found:
> 
> ACPI: DSDT (v001 INT430 SYSFexxx 00000.04097) @ 0x00000000
> ACPI: BIOS passes blacklist
> 
> 
> The question is, should acpi be looking at a different memory location
> for the proper DSDT?  I mean, can 0x00000000 be right?  What is the
> 'Memory location' dell is referring to?  

I am so busted.

from drivers/acpi/tables.c:

/* 
 * The DSDT is *not* in the RSDT (why not? no idea.) but we want
 * to print its info, because this is what people usually blacklist
 * against. Unfortunately, we don't know the phys_addr, so just
 * print 0. Maybe no one will notice.
 */
if(!acpi_get_table_header_early(ACPI_DSDT, &header))
	acpi_table_print(header, 0);

Basically there was no clean way to get the DSDTs phys_addr at that point,
so I punted. Rest assured your DSDT does have an address, and yes, it is
stored in the BIOS, and subsequently copied to RAM, where we find it.

Also note that this is printed in the first phase of ACPI init - table
parsing. Just because your system's DSDT info is printed here does not mean
it cannot be overridden before it is actually used. See
http://www.poupinou.org/acpi/over.html .

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
