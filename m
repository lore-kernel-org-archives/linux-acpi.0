From: "Adachi, Kenichi" <aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org>
Subject: RE: ECDT breaks Thinkpad X22
Date: Tue, 11 Mar 2003 22:02:18 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000c01c2e7ce$72d0a1f0$0e01a8c0@sayonara>
References: <1047335075.17696.23.camel@mharnois.mdharnois.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1047335075.17696.23.camel-Jc8jiaiLSic2mD2JOtDPSJ9Kkgttl81Y@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "'Michael D. Harnois'" <mharnois-K5XHh8l1Aeht1OO0OYaSVA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

People on this list has been contacting IBM and made a difference. This
problem must be fixed in IBM's next BIOS update.

You can try Ducrot Bruno's temporary patch:

Howto override your buggy ECDT table for the IBM Thinkpad under Linux
http://www.poupinou.org/acpi/ibm_ecdt.html

Thanks,
- Adachi, Kenichi

-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Michael D.
Harnois
Sent: Tuesday, March 11, 2003 7:25 AM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] ECDT breaks Thinkpad X22


The 20030228 addition of ECDT breaks ACPI on my Thinkpad X22. (The
result on 2.4.21-pre4 is the same.)

Linux version 2.5.62bk2 (root@michaelh) (gcc version 3.2.3 20030210
(Debian prerelease)) #7 Wed Feb 19 10:54:28 CST 2003

<snip>

ACPI: RSDP (v002 IBM                        ) @ 0x000f73b0
ACPI: XSDT (v001 IBM    TP-1D    00000.04736) @ 0x17f705d3
ACPI: FADT (v001 IBM    TP-1D    00000.04736) @ 0x17f70617
ACPI: SSDT (v001 IBM    TP-1D    00000.04736) @ 0x17f706cb
ACPI: ECDT (v001 IBM    TP-1D    00000.04736) @ 0x17f79f87
ACPI: BOOT (v001 IBM    TP-1D    00000.04736) @ 0x17f79fd8
ACPI: DSDT (v001 IBM    TP-1D    00000.04736) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=Linux ro root=302
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0

<snip>

ACPI: Subsystem revision 20030122
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully
acquired
Parsing all Control
Methods:....................................................
........................................................................
........
........................................................................
........
........................................................................
........
...........................................................
Table [DSDT] - 1190 Objects with 58 Devices 351 Methods 18 Regions
Parsing all Control Methods:
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c03603bc
evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode
successful
ACPI: Found ECDT
ACPI: Could not use ECDT
evxfevnt-0137 [06] acpi_disable          : ACPI mode disabled
 utalloc-0986 [05] ut_dump_allocations   : No outstanding allocations.

-- 
Michael D. Harnois 

2L, UST School of Law Minneapolis, Minnesota 
"Any movement in history which attempts to perpetuate itself, becomes
reactionary." -- Josip Broz Tito 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
