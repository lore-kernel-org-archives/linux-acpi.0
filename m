From: "Michael D. Harnois" <mharnois-K5XHh8l1Aeht1OO0OYaSVA@public.gmane.org>
Subject: ECDT breaks Thinkpad X22
Date: 10 Mar 2003 16:24:35 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1047335075.17696.23.camel@mharnois.mdharnois.net>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="=-d0sRBt1wK+ELxaXWPWrj"
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


--=-d0sRBt1wK+ELxaXWPWrj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

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
................................................................................
................................................................................
................................................................................
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

2L, UST School of Law
              Minneapolis, Minnesota
"Any movement in history which
attempts to perpetuate itself,
becomes reactionary." -- Josip Broz
Tito

--=-d0sRBt1wK+ELxaXWPWrj
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/1.1.8">
</HEAD>
<BODY>
<FONT SIZE="3"><TT>The 20030228 addition of ECDT breaks ACPI on my Thinkpad X22. (The result on 2.4.21-pre4 is the same.)<BR>
<BR>
Linux version 2.5.62bk2 (root@michaelh) (gcc version 3.2.3 20030210<BR>
(Debian prerelease)) #7 Wed Feb 19 10:54:28 CST 2003<BR>
<BR>
&lt;snip&gt;<BR>
<BR>
ACPI: RSDP (v002 IBM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ) @ 0x000f73b0<BR>
ACPI: XSDT (v001 IBM&nbsp;&nbsp;&nbsp; TP-1D&nbsp;&nbsp;&nbsp; 00000.04736) @ 0x17f705d3<BR>
ACPI: FADT (v001 IBM&nbsp;&nbsp;&nbsp; TP-1D&nbsp;&nbsp;&nbsp; 00000.04736) @ 0x17f70617<BR>
ACPI: SSDT (v001 IBM&nbsp;&nbsp;&nbsp; TP-1D&nbsp;&nbsp;&nbsp; 00000.04736) @ 0x17f706cb<BR>
ACPI: ECDT (v001 IBM&nbsp;&nbsp;&nbsp; TP-1D&nbsp;&nbsp;&nbsp; 00000.04736) @ 0x17f79f87<BR>
ACPI: BOOT (v001 IBM&nbsp;&nbsp;&nbsp; TP-1D&nbsp;&nbsp;&nbsp; 00000.04736) @ 0x17f79fd8<BR>
ACPI: DSDT (v001 IBM&nbsp;&nbsp;&nbsp; TP-1D&nbsp;&nbsp;&nbsp; 00000.04736) @ 0x00000000<BR>
ACPI: BIOS passes blacklist<BR>
ACPI: MADT not present<BR>
IBM machine detected. Enabling interrupts during APM calls.<BR>
IBM machine detected. Disabling SMBus accesses.<BR>
Building zonelist for node : 0<BR>
Kernel command line: auto BOOT_IMAGE=Linux ro root=302<BR>
Local APIC disabled by BIOS -- reenabling.<BR>
Found and enabled local APIC!<BR>
Initializing CPU#0<BR>
<BR>
&lt;snip&gt;<BR>
<BR>
ACPI: Subsystem revision 20030122<BR>
&nbsp;tbxface-0117 [03] acpi_load_tables&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : ACPI Tables successfully<BR>
acquired<BR>
Parsing all Control<BR>
Methods:....................................................<BR>
................................................................................<BR>
................................................................................<BR>
................................................................................<BR>
...........................................................<BR>
Table [DSDT] - 1190 Objects with 58 Devices 351 Methods 18 Regions<BR>
Parsing all Control Methods:<BR>
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions<BR>
ACPI Namespace successfully loaded at root c03603bc<BR>
evxfevnt-0092 [04] acpi_enable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : Transition to ACPI mode<BR>
successful<BR>
ACPI: Found ECDT<BR>
ACPI: Could not use ECDT<BR>
evxfevnt-0137 [06] acpi_disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : ACPI mode disabled<BR>
&nbsp;utalloc-0986 [05] ut_dump_allocations&nbsp;&nbsp; : No outstanding allocations.</TT></FONT><BR>
<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
--
</TD>
</TR>
<TR>
<TD>
Michael D. Harnois
</TD>
<TD>
<BR>
</TD>
</TR>
<TR>
<TD>
2L, UST School of Law
</TD>
<TD ALIGN="right">
Minneapolis, Minnesota
</TD>
</TR>
<TR>
<TD COLSPAN="2">
&quot;Any movement in history which attempts to perpetuate itself, becomes reactionary.&quot; -- Josip Broz Tito
</TD>
</TR>
<TR>
</TR>
</TABLE>

</BODY>
</HTML>

--=-d0sRBt1wK+ELxaXWPWrj--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
