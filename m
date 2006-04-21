From: Andriy Stepanov <stanv@altlinux.ru>
Subject: Event handler for ACAD
Date: Fri, 21 Apr 2006 15:35:46 +0400
Message-ID: <e2agbt$jtd$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:52926 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751281AbWDULuZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Apr 2006 07:50:25 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FWu9C-0007gU-Fa
	for linux-acpi@vger.kernel.org; Fri, 21 Apr 2006 13:50:02 +0200
Received: from rider.balabanovo.ru ([195.112.97.85])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Fri, 21 Apr 2006 13:50:02 +0200
Received: from stanv by rider.balabanovo.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Fri, 21 Apr 2006 13:50:02 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello!
I have a notebook.

System doesn't change energy consumption policy when I unplug ACAD.

# service acpid stop
# cat /proc/acpi/event
processor CPU0 00000080 00000001   <----- unplug ACAD
processor CPU0 00000080 00000000


No any messages about ACAD.

My dsdt.dsl have two following interesting sections:
1.
Device (AC)
         {
             Name (_HID, "ACPI0003")
             Name (_PCL, Package (0x01)
             {
                 \_SB
             })
             Method (_PSR, 0, NotSerialized)
             {
                 If (\_SB.PCI0.EC.ADP)
                 {
                     Store (0x03, \DBUG)
                     Store (Zero, \_PR.CPU0._PPC)
                 }
                 Else
                 {
                     Store (0x01, \DBUG)
                     Store (0x01, \_PR.CPU0._PPC)
                 }

                 Notify (\_PR.CPU0, 0x80)
                 If (\_SB.PCI0.EC.ECOK)
                 {
                     Return (\_SB.PCI0.EC.ADP)
                 }
             }

2.
Method (_Q16, 0, NotSerialized)
                 {
                     Notify (\_SB.AC, 0x80)
                     If (\_SB.PCI0.EC.ADP)
                     {
                         Store (0x03, \DBUG)
                         Store (Zero, \_PR.CPU0._PPC)
                     }
                     Else
                     {
                         Store (0x01, \DBUG)
                         Store (0x01, \_PR.CPU0._PPC)
                     }

                     Notify (\_PR.CPU0, 0x80)
                 }




Method _Q16 always called when I unplug ACAD.


For instruction: Notify (\_SB.AC, 0x80)
ACPI debug subsystem print:



<4>  nsdump-0087 [33] ns_print_pathname     : [_SB_.AC__]
<4>nssearch-0104 [35] ns_search_node        : Searching \ (c0352bd0) For [_SB_] (Untyped)
<4>nssearch-0138 [35] ns_search_node        : Name [_SB_] (Device) cbf09ca8 found in scope ["\" ] c0352bd0
<4>nssearch-0104 [35] ns_search_node        : Searching \_SB_ (cbf09ca8) For [AC__] (Untyped)
<4>nssearch-0138 [35] ns_search_node        : Name [AC__] (Device) cbf092e8 found in scope [_SB_] cbf09ca8
<4>  psloop-0378 [30] ps_parse_loop         : Opcode 000A [ByteConst] Op cbba1250 Aml cc809a6a aml_offset 0000B
<4> psscope-0228 [31] ps_pop_scope          : Popped Op cbba1218 Args 0
<4>  psloop-0793 [30] ps_parse_loop         : Popped scope, Op=cbba1218
<4> dsutils-0475 [33] ds_create_operand     : Getting a name: Arg=cbba1234
<4> exnames-0276 [34] ex_get_name_string    : root_prefix(\) at cc809a5f
<4> exnames-0318 [34] ex_get_name_string    : dual_name_prefix at cc809a60
<4> exnames-0175 [35] ex_name_segment       : Bytes from stream:
<4> exnames-0181 [35] ex_name_segment       : _
<4> exnames-0181 [35] ex_name_segment       : S
<4> exnames-0181 [35] ex_name_segment       : B
<4> exnames-0181 [35] ex_name_segment       : _
<4> exnames-0194 [35] ex_name_segment       : Appended to - \._SB_
<4> exnames-0175 [35] ex_name_segment       : Bytes from stream:
<4> exnames-0181 [35] ex_name_segment       : A
<4> exnames-0181 [35] ex_name_segment       : C
<4> exnames-0181 [35] ex_name_segment       : _
<4> exnames-0181 [35] ex_name_segment       : _
<4> exnames-0194 [35] ex_name_segment       : Appended to - \._SB_AC__
<4>nsaccess-0403 [34] ns_lookup             : Path is absolute from root [c0352bd0]
<4>nsaccess-0489 [34] ns_lookup             : Dual Pathname (2 segments, Flags=3)
<4>  nsdump-0087 [34] ns_print_pathname     : [_SB_.AC__]
<4>nssearch-0104 [36] ns_search_node        : Searching \ (c0352bd0) For [_SB_] (Untyped)
<4>nssearch-0138 [36] ns_search_node        : Name [_SB_] (Device) cbf09ca8 found in scope ["\" ] c0352bd0
<4>nssearch-0104 [36] ns_search_node        : Searching \_SB_ (cbf09ca8) For [AC__] (Untyped)
<4>nssearch-0138 [36] ns_search_node        : Name [AC__] (Device) cbf092e8 found in scope [_SB_] cbf09ca8
<4>dswstate-0424 [33] ds_obj_stack_push     : Obj=cbf092e8 [Device] State=c1e6b828 #Ops=1
<4> dsutils-0712 [32] ds_create_operands    : Arg #0 (cbba1234) done, Arg1=cbba1234
<4>dswstate-0424 [33] ds_obj_stack_push     : Obj=cbd9bb8c [Integer] State=c1e6b828 #Ops=2
<4> dsutils-0712 [32] ds_create_operands    : Arg #1 (cbba1250) done, Arg1=cbba1234
<4>dswstate-0380 [31] ds_result_stack_pop   : Result=ca92e244 remaining_results=0 State=c1e6b828
<4> exresop-0162 [32] ex_resolve_operands   : Opcode 86 [Notify] required_operand_types=000001A6
<4>exresolv-0119 [33] ex_resolve_to_value   : Resolved object cbd9bb8c
<4>  exdump-0792 [31] ex_dump_operands      : ************* Operand Stack Contents (Opcode [Notify], 2 Operands)
<4>  exdump-0494 [31] ex_dump_operand       : cbd9bb8c Integer 0000000000000080
<4>  exdump-0474 [31] ex_dump_operand       : cbf092e8 Namespace Node:  0  AC__ Device       cbf092e8 06
<4>  exdump-0806 [31] ex_dump_operands      : ************* Operand Stack dump from dswexec(426), after ex_resolve_operands
<4>  evmisc-0138 [32] ev_queue_notify_reques: Dispatching Notify(80) on node cbf092e8
<4>  evmisc-0146 [32] ev_queue_notify_reques: Notify value: 0x80 **Device Specific**
<4>  evmisc-0208 [32] ev_queue_notify_reques: No notify handler for Notify(AC__, 80) node cbf092e8



Why there is string "No notify handler for Notify(AC__, 80) .... ???

Another notify (Notify (\_PR.CPU0, 0x80)) works fine!

Why there is "AC__" not "AC" ?

Thanks!

