From: Thorsten Zachmann <t.zachmann-c61pB8mzqkY@public.gmane.org>
Subject: No handler for Region
Date: Tue, 3 Feb 2004 08:25:41 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402030823.53848.t.zachmann@zagge.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hello all,

I have a toshiba tecra s1. During the bootup I get some errors and the battery 
status is not working. The messages looks similar as described in

http://sourceforge.net/mailarchive/message.php?msg_id=6752695

I run a 2.6.2-rc2 kernel with the acpi-20040116.diff.bz2 patch and the acpi 
initrd patch for setting my own dsdt. Since the update to 2.6.2-rc2 the 
errors for the dockingstation are gone. However there are still some "No 
handler for Region" errors during boot up as seen below:

<4>evregion-0251 [21] ev_address_space_dispa: No handler for Region [ECF2] 
(dfef1ea8) [EmbeddedControl]
<4> exfldio-0284 [20] ex_access_region      : Region EmbeddedControl(3) has no 
handler
<4> dswexec-0435 [13] ds_exec_end_op        : [Store]: Could not resolve 
operands, AE_NOT_EXIST
<4> psparse-1120: *** Error: Method execution failed [\_SB_.BAT0._STA] (Node 
dfef9ba8), AE_NOT_EXIST
<4>evregion-0251 [21] ev_address_space_dispa: No handler for Region [ECF2] 
(dfef1ea8) [EmbeddedControl]
<4> exfldio-0284 [20] ex_access_region      : Region EmbeddedControl(3) has no 
handler
<4> dswexec-0435 [13] ds_exec_end_op        : [Store]: Could not resolve 
operands, AE_NOT_EXIST
<4> psparse-1120: *** Error: Method execution failed [\_SB_.BAT1._STA] (Node 
dfef9428), AE_NOT_EXIST

The problem lies in the Store command of the _STA Methods of the batteries. If 
the store command is replacecd by 

Store (0x01, Local0) 

the functions work without errors messages. 

I have put the file files.tar.gz containing:
dsdt.dsl.org (the dsdt I use)
dmesg.txt 
dmidecode.txt
acpidmp.txt
interrupts.txt
lscpi.txt

which can be found at http://zagge.online.de/files.tar.gz .

If you need more information or if I should test something I'm more than 
willing to do so. Thanks for your help and your good job.

Thorsten



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
