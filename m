From: James D Strandboge <jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Subject: DSDT in Dell i8200-- does acpi have the correct address?
Date: 16 Dec 2002 14:17:59 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1040066279.2070.18.camel@sirius.strandboge.cxm>
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

My i8200 has basic acpi functionality, with quite a few issues.  I
started poking around the Dell download site and came across this in a
description of a BIOS upgrade for my laptop:

===================================================================
Systems:      Dell Inspiron 8200	(Memory location F000:E845)
Version:      A06                       (Memory location F000:E842)
Build Date:   08/17/02                  (Memory location FFFF:0005)

...

Now, if I read my dsdt from /proc/acpi/dsdt, nd decompile it with iasl,
it shows a version from 1998.  I looked at dmesg and found:

ACPI: DSDT (v001 INT430 SYSFexxx 00000.04097) @ 0x00000000
ACPI: BIOS passes blacklist


The question is, should acpi be looking at a different memory location
for the proper DSDT?  I mean, can 0x00000000 be right?  What is the
'Memory location' dell is referring to?  

For BIOS upgrades, dell has us flash the bios from outside of windows. 
This leads me to believe that the dsdt must be in the bios, and not
overridden by windows from a file.  I don't use windows, so I can't test
this hypothesis fully.

Can I somehow hardcode the address of the dsdt for testing purposes?  I
poked around in drivers/acpi, but didn't see where.

Thanks for any help.

Jamie Strandboge

-- 
Email:        jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
