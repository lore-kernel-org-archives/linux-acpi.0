From: "Craig Whitmore" <lennon-q3Ck4f9/EBK9koe0gwxAeg@public.gmane.org>
Subject: Errors with ACPI
Date: Sat, 9 Nov 2002 22:14:02 +1300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000b01c287d0$59154a30$0100000a@lennon>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

I am having troubles with a few errors with 2.4.19 ACPI when booting up on a
the Latest Intel SHG2 Motherboard (Dual Xeon2.4 with HT) (and SC5200
Chassis)  Are these becuase its not totally supported yet in Linux?  I have
tried 2.4.20-rc1 with the latest patches from the acpi site and the sameish
results occured.



Thanks
Craig Whitmore

----------------------------------------------------------------------------
---
 tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing
Methods:....................................................................
................................................
............................................................................
..........................................
234 Control Methods found and parsed (565 nodes total)
ACPI Namespace successfully loaded at root c0400920
ACPI: Core Subsystem version [20011018]
evxfevnt-0081 [02] Acpi_enable           : Transition to ACPI mode
successful
Executing device _INI
methods:......................................evregion-0302 [21]
Ev_address_space_dispa: Region handler: AE_ER
ROR [PCIConfig]
 dswexec-0392 [12] Ds_exec_end_op        : [LEqual]: Could not resolve
operands, AE_ERROR
Ps_execute: method failed - \_SB_.PCI0.LAN1._STA (f7af43a8)
  uteval-0337 [05] Ut_execute_STA        : _STA on LAN1 failed AE_ERROR
...............
53 Devices found: 52 _STA, 0 _INI
Completing Region and Field initialization:.............
13/19 Regions, 0/0 Fields initialized (565 nodes total)
ACPI: Subsystem enabled
evregion-0302 [20] Ev_address_space_dispa: Region handler: AE_ERROR
[PCIConfig]
 dswexec-0392 [11] Ds_exec_end_op        : [LEqual]: Could not resolve
operands, AE_ERROR
Ps_execute: method failed - \_SB_.PCI0.LAN1._STA (f7af43a8)
  uteval-0337 [04] Ut_execute_STA        : _STA on LAN1 failed AE_ERROR
evregion-0302 [22] Ev_address_space_dispa: Region handler: AE_ERROR
[PCIConfig]
 dswexec-0392 [13] Ds_exec_end_op        : [LEqual]: Could not resolve
operands, AE_ERROR
Ps_execute: method failed - \_SB_.PCI0.LAN1._STA (f7af43a8)
evregion-0302 [25] Ev_address_space_dispa: Region handler: AE_BAD_PARAMETER
[Embedded_control]
Ps_execute: method failed - \_SB_.PCI0.ISA0.EC0_._REG (f7af69a8)
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1
Processor[1]: C0 C1
Processor[2]: C0 C1
Processor[3]: C0 C1
ACPI: Power Button (FF) found
ACPI: Sleep Button (CM) found



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
