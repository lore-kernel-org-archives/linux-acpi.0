From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Acpi_load_tables: Could not load namespace: AE_NOT_FOU
	ND
Date: Mon, 23 Sep 2002 11:10:19 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B79B@orsmsx107.jf.intel.com>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "'berndp=p32f3XyCuykqcZcGjlUOXw@public.gmane.org'" <berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


I'm able to load your DSDT with version 20020918 of the ACPI CA code.

We relaxed some typechecking rules for this release, and it looks like this
allows your DSDT to load, albeit with some warnings.

Please give this version a try.

Thanks,
Bob Moore


-----Original Message-----
From: Bernd Pfrommer [mailto:berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org] 
Sent: Friday, September 20, 2002 3:48 AM
To: Moore, Robert
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Grover, Andrew
Subject: Re: [ACPI] Acpi_load_tables: Could not load namespace: AE_NOT_FOUND

There seem to be two tools, acpidump (somewhere off the web) and acpidmp 
(from intel). With these two, I generated the following 3 files, 
attached to this email:

dsdt.orig.bin        obtained with acpidmp DSDT > dsdt.orig.bin
dsdt.orig.acpidmp    obtained with acpidmp > dsdt.orig.acpidmp
dsdt.orig.acpidump    obtained with acpidump > dsdt.orig.acpidump


Some of the Name() lines look bad, and generate errors when using the 
iasl, but I don't know how to fix them properly.

Thanks,

Bernd

Moore, Robert wrote:

>Please send us your raw DSDT
>Thanks,
>Bob Moore
>
>
>-----Original Message-----
>From: Bernd Pfrommer [mailto:berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org] 
>Sent: Tuesday, September 17, 2002 12:19 PM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] Acpi_load_tables: Could not load namespace: AE_NOT_FOUND
>
>Hi,
>
>after many fruitless attempts to get ACPI working with the 2.4.18 or 
>2.4.19 kernel, I'm posting this in case somebody can help.
>The hardware is an Intel manufactured SRMK2 server with a ServerWorks 
>ServerSet IIILE chipset (CNB30LE North Bridge and OSB4 South Bridge), 
>dual PIII 1GHz 256K cache, with 1GB memory. The bios is an AMIBIOS by 
>American Megatrends Inc.
>
>I configured the 2.4.19 kernel with the following parameters:
>
>CONFIG_ACPI=y
>CONFIG_ACPI_DEBUG=y
>CONFIG_ACPI_BUSMGR=y
>CONFIG_ACPI_SYS=y
>CONFIG_ACPI_CPU=y
># CONFIG_ACPI_BUTTON is not set
># CONFIG_ACPI_AC is not set
># CONFIG_ACPI_EC is not set
># CONFIG_APM is not set
>
>And I get the following errors during boot:
>
>Sep 16 14:07:16 foo kernel:  tbxface-0099 [01] Acpi_load_tables      : 
>ACPI Tables successfully loaded
>Sep 16 14:07:16 foo kernel:  tbxface-0106: *** Error: Acpi_load_tables: 
>Could not load namespace: AE_NOT_FOUND
>Sep 16 14:07:16 foo kernel:  tbxface-0115: *** Error: Acpi_load_tables: 
>Could not load tables: AE_NOT_FOUND
>Sep 16 14:07:16 foo kernel: ACPI: System description table load failed
>Sep 16 14:07:16 foo kernel:  utalloc-0504 [03] Ut_dump_allocations   : 
>Outstanding allocations:
>Sep 16 14:07:16 foo kernel: f7e72d88 Len 0038   utalloc-150 Parse_obj 
>Opcode 0010
>Sep 16 14:07:16 foo kernel: f7e72e08 Len 0038   utalloc-150 Parse_obj 
>Opcode 5B82
>Sep 16 14:07:16 foo kernel: f7eaa308 Len 0038   utalloc-150 Parse_obj 
>Opcode 5B82
>Sep 16 14:07:16 foo kernel: f7eab268 Len 0038   utalloc-150 Parse_obj 
>Opcode 5B82
>Sep 16 14:07:16 foo kernel: f7eb8e48 Len 0009  tbconvrt-520
>Sep 16 14:07:16 foo kernel:  utalloc-0598 [03] Ut_dump_allocations   : 
>Total number of unfreed allocations = 5(5)
>
>This may be similar to what Jean-Rene  Peulve posted earlier this year, 
>but I could not find any replies to his posting
>http://www.geocrawler.com/archives/3/17428/2002/2/0/7953806/ .
>
>Although I configured for debug messages, the output of 
>ACPI_DEBUG_PRINT() does not show up in dmesg. Does anybody know why that 
>is?
>
>Any suggestions what could cause the namespace loading to fail, and how 
>to fix it?
>
>Your help is greatly appreciated!
>
>Thanks,
>
>Bernd
>
>
>
>
>-------------------------------------------------------
>This SF.NET email is sponsored by: AMD - Your access to the experts
>on Hammer Technology! Open Source & Linux Developers, register now
>for the AMD Developer Symposium. Code: EX8664
>http://www.developwithamd.com/developerlab
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
