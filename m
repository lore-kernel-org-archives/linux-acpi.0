From: giggz <giggzounet@gmail.com>
Subject: Re: Problem with the Fn+F3 key. acpi problem ?
Date: Sat, 08 Mar 2008 10:46:22 +0100
Message-ID: <fqtngv$2o2$1@ger.gmane.org>
References: <fmaaj5$jsl$1@ger.gmane.org>	 <20080112121714.GB15173@srcf.ucam.org> <fmac61$oc8$1@ger.gmane.org>	 <20080112124619.GA15578@srcf.ucam.org>  <fmakts$gqs$1@ger.gmane.org> <1203347919.6019.79.camel@queen.suse.de> <fqtkjq$rod$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:52590 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbYCHJul (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 8 Mar 2008 04:50:41 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JXvhL-0000Sv-AS
	for linux-acpi@vger.kernel.org; Sat, 08 Mar 2008 09:50:35 +0000
Received: from cam44-1-82-67-121-239.fbx.proxad.net ([82.67.121.239])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 08 Mar 2008 09:50:35 +0000
Received: from giggzounet by cam44-1-82-67-121-239.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 08 Mar 2008 09:50:35 +0000
In-Reply-To: <fqtkjq$rod$1@ger.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

giggz a =C3=A9crit :

>=20
>> (or even: echo 0x21F >/sys/module/acpi/parameters/debug_level)

with this level, I get this message in my /var/log/messages :

Mar  8 10:37:45 linux kernel:      osl-0798 [00] os_execute            =
:
Scheduling function [c02178d5(dffc7bc0)] for deferred execution.
Mar  8 10:37:45 linux kernel:       ec-0413 [00] ec_gpe_query          =
:
Evaluating _Q0C nsutils-0454 [00] ns_build_internal_name: Returning
[f308cb80] (rel) "_Q0C"
Mar  8 10:37:45 linux kernel:  nsnames-0239 [00] ns_handle_to_pathname =
:
\_SB_.PCI0.LPCB.EC0_._Q0C [1A]
Mar  8 10:37:45 linux kernel: Execute Method:
[\_SB_.PCI0.LPCB.EC0_._Q0C] (Node dfff5360)
Mar  8 10:37:45 linux kernel:   nseval-0147 [00] ns_evaluate           =
:
Method at AML address f8802e84 Length 20F
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a7400 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswscope-0139 [00] ds_scope_stack_push   =
:
[01] Pushed scope [\___] (ROOT), New scope -> [_Q0C] (Method)
Mar  8 10:37:45 linux kernel: dsmthdat-0206 [00] ds_method_data_init_ar=
:
No param list passed to method
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a7350 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8063c [Integer] State=3Df37ca200 #Ops=3D1
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddfffe324 [RegionField] State=3Df37ca200 #Ops=3D2
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a7350 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  exresop-0163 [00] ex_resolve_operands   =
:
Opcode 70 [Store] RequiredOperandTypes=3D000002CF
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff8063c
Mar  8 10:37:45 linux kernel:   exdump-0788 [00] ex_dump_operands      =
:
************* Operand Stack Contents (Opcode [Store], 2 Operands)
Mar  8 10:37:45 linux kernel:   exdump-0469 [00] ex_dump_operand       =
:
dfffe324 Namespace Node:  0  P80H RegionField  dfffe324 01 Rgn [PORT]
Off 000 Len 08 Acc 01
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8063c Integer 000000000000000C
Mar  8 10:37:45 linux kernel:   exdump-0802 [00] ex_dump_operands      =
:
************* Operand Stack dump from dswexec(430), after ExResolveOper=
ands
Mar  8 10:37:45 linux kernel:  exstore-0561 [00] ex_store_object_to_nod=
:
Storing dff8063c(Integer) into node dfffe324(RegionField)
Mar  8 10:37:45 linux kernel: exregion-0287 [00] ex_system_io_space_han=
:
System-IO (width 8) R/W 1 Address=3DC020668600000080
Mar  8 10:37:45 linux kernel: dswstate-0312 [00] ds_result_push        =
:
Obj=3Ddff8063c [Integer] State=3Df37ca200 Num=3D1 Cur=3D0
Mar  8 10:37:45 linux kernel: dswstate-0184 [00] ds_result_pop         =
:
Obj=3Ddff8063c [Integer] Index=3D0 State=3Df37ca200 Num=3D0
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a7350 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff802f4 [Integer] State=3Df37ca200 #Ops=3D1
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddfffe5e0 [RegionField] State=3Df37ca200 #Ops=3D2
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a7350 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  exresop-0163 [00] ex_resolve_operands   =
:
Opcode 70 [Store] RequiredOperandTypes=3D000002CF
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff802f4
Mar  8 10:37:45 linux kernel:   exdump-0788 [00] ex_dump_operands      =
:
************* Operand Stack Contents (Opcode [Store], 2 Operands)
Mar  8 10:37:45 linux kernel:   exdump-0469 [00] ex_dump_operand       =
:
dfffe5e0 Namespace Node:  0  SMIF RegionField  dfffe5e0 01 Rgn [MNVS]
Off 010 Len 08 Acc 01
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff802f4 Integer 000000000000002E
Mar  8 10:37:45 linux kernel:   exdump-0802 [00] ex_dump_operands      =
:
************* Operand Stack dump from dswexec(430), after ExResolveOper=
ands
Mar  8 10:37:45 linux kernel:  exstore-0561 [00] ex_store_object_to_nod=
:
Storing dff802f4(Integer) into node dfffe5e0(RegionField)
Mar  8 10:37:45 linux kernel:   evmisc-0479 [00] ev_acquire_global_lock=
:
Acquired hardware Global Lock
Mar  8 10:37:45 linux kernel: exregion-0185 [00] ex_system_memory_space=
:
System-Memory (width 8) R/W 1 Address=3DDFFF0FC47FF7BE7F
Mar  8 10:37:45 linux kernel:   evmisc-0550 [00] ev_release_global_lock=
:
Released hardware Global Lock
Mar  8 10:37:45 linux kernel: dswstate-0312 [00] ds_result_push        =
:
Obj=3Ddff802f4 [Integer] State=3Df37ca200 Num=3D1 Cur=3D0
Mar  8 10:37:45 linux kernel: dswstate-0184 [00] ds_result_pop         =
:
Obj=3Ddff802f4 [Integer] Index=3D0 State=3Df37ca200 Num=3D0
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a7350 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8063c [Integer] State=3Df37ca200 #Ops=3D1
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddfffe2fc [RegionField] State=3Df37ca200 #Ops=3D2
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a7350 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  exresop-0163 [00] ex_resolve_operands   =
:
Opcode 70 [Store] RequiredOperandTypes=3D000002CF
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff8063c
Mar  8 10:37:45 linux kernel:   exdump-0788 [00] ex_dump_operands      =
:
************* Operand Stack Contents (Opcode [Store], 2 Operands)
Mar  8 10:37:45 linux kernel:   exdump-0469 [00] ex_dump_operand       =
:
dfffe2fc Namespace Node:  0  TRP0 RegionField  dfffe2fc 01 Rgn [IO_T]
Off 000 Len 08 Acc 01
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8063c Integer 0000000000000000
Mar  8 10:37:45 linux kernel:   exdump-0802 [00] ex_dump_operands      =
:
************* Operand Stack dump from dswexec(430), after ExResolveOper=
ands
Mar  8 10:37:45 linux kernel:  exstore-0561 [00] ex_store_object_to_nod=
:
Storing dff8063c(Integer) into node dfffe2fc(RegionField)
Mar  8 10:37:45 linux kernel: exregion-0287 [00] ex_system_io_space_han=
:
System-IO (width 8) R/W 1 Address=3DDFFF0FC400000800
Mar  8 10:37:45 linux kernel: dswstate-0312 [00] ds_result_push        =
:
Obj=3Ddff8063c [Integer] State=3Df37ca200 Num=3D1 Cur=3D0
Mar  8 10:37:45 linux kernel: dswstate-0184 [00] ds_result_pop         =
:
Obj=3Ddff8063c [Integer] Index=3D0 State=3Df37ca200 Num=3D0
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a7350 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  dswexec-0264 [00] ds_exec_begin_op      =
:
Exec predicate Op=3Df30a8384 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a72cc State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a7274 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a721c State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddfffe5b8 [RegionField] State=3Df37ca200 #Ops=3D1
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff802f4 [Integer] State=3Df37ca200 #Ops=3D2
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8022c [Integer] State=3Df37ca200 #Ops=3D3
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a721c RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  exresop-0163 [00] ex_resolve_operands   =
:
Opcode 7B [And] RequiredOperandTypes=3D000018CF
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff802f4
Mar  8 10:37:45 linux kernel: exresnte-0102 [00] ex_resolve_node_to_val=
:
Entry=3Ddfffe5b8 SourceDesc=3Ddfff340c [RegionField]
Mar  8 10:37:45 linux kernel: exresnte-0207 [00] ex_resolve_node_to_val=
:
=46ieldRead Node=3Ddfffe5b8 SourceDesc=3Ddfff340c Type=3D11
Mar  8 10:37:45 linux kernel:   evmisc-0479 [00] ev_acquire_global_lock=
:
Acquired hardware Global Lock
Mar  8 10:37:45 linux kernel: exregion-0185 [00] ex_system_memory_space=
:
System-Memory (width 8) R/W 0 Address=3DDFFF0FC47FF7BE81
Mar  8 10:37:45 linux kernel:   evmisc-0550 [00] ev_release_global_lock=
:
Released hardware Global Lock
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff80394
Mar  8 10:37:45 linux kernel:   exdump-0788 [00] ex_dump_operands      =
:
************* Operand Stack Contents (Opcode [And], 3 Operands)
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8022c Integer 0000000000000000
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff802f4 Integer 0000000000000040
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff80394 Integer 0000000000000000
Mar  8 10:37:45 linux kernel:   exdump-0802 [00] ex_dump_operands      =
:
************* Operand Stack dump from dswexec(430), after ExResolveOper=
ands
Mar  8 10:37:45 linux kernel: dswstate-0312 [00] ds_result_push        =
:
Obj=3Ddff8036c [Integer] State=3Df37ca200 Num=3D1 Cur=3D0
Mar  8 10:37:45 linux kernel: dswstate-0256 [00] ds_result_pop_from_bot=
:
Obj=3Ddff8036c [Integer] Results=3Df30a7274 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8036c [Integer] State=3Df37ca200 #Ops=3D1
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8063c [Integer] State=3Df37ca200 #Ops=3D2
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a7274 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  exresop-0163 [00] ex_resolve_operands   =
:
Opcode 93 [LEqual] RequiredOperandTypes=3D0000014A
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff8063c
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff8036c
Mar  8 10:37:45 linux kernel:   exdump-0788 [00] ex_dump_operands      =
:
************* Operand Stack Contents (Opcode [LEqual], 2 Operands)
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8063c Integer 0000000000000040
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8036c Integer 0000000000000000
Mar  8 10:37:45 linux kernel:   exdump-0802 [00] ex_dump_operands      =
:
************* Operand Stack dump from dswexec(430), after ExResolveOper=
ands
Mar  8 10:37:45 linux kernel: dswstate-0312 [00] ds_result_push        =
:
Obj=3Ddff8022c [Integer] State=3Df37ca200 Num=3D1 Cur=3D0
Mar  8 10:37:45 linux kernel: dswstate-0256 [00] ds_result_pop_from_bot=
:
Obj=3Ddff8022c [Integer] Results=3Df30a72cc State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8022c [Integer] State=3Df37ca200 #Ops=3D1
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a72cc RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  exresop-0163 [00] ex_resolve_operands   =
:
Opcode 92 [LNot] RequiredOperandTypes=3D00000006
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff8022c
Mar  8 10:37:45 linux kernel:   exdump-0788 [00] ex_dump_operands      =
:
************* Operand Stack Contents (Opcode [LNot], 1 Operands)
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8022c Integer 0000000000000000
Mar  8 10:37:45 linux kernel:   exdump-0802 [00] ex_dump_operands      =
:
************* Operand Stack dump from dswexec(430), after ExResolveOper=
ands
Mar  8 10:37:45 linux kernel: dswstate-0312 [00] ds_result_push        =
:
Obj=3Ddff8036c [Integer] State=3Df37ca200 Num=3D1 Cur=3D0
Mar  8 10:37:45 linux kernel: dswstate-0184 [00] ds_result_pop         =
:
Obj=3Ddff8036c [Integer] Index=3D0 State=3Df37ca200 Num=3D0
Mar  8 10:37:45 linux kernel:  dswexec-0173 [00] ds_get_predicate_value=
:
Completed a predicate eval=3D1 Op=3Df30a8384
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a72cc State=3Df37ca200
Mar  8 10:37:45 linux kernel:  dswexec-0264 [00] ds_exec_begin_op      =
:
Exec predicate Op=3Df30a8314 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a7248 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddfff75cc [Integer] State=3Df37ca200 #Ops=3D1
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8036c [Integer] State=3Df37ca200 #Ops=3D2
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a7248 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  exresop-0163 [00] ex_resolve_operands   =
:
Opcode 93 [LEqual] RequiredOperandTypes=3D0000014A
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff8036c
Mar  8 10:37:45 linux kernel: exresnte-0102 [00] ex_resolve_node_to_val=
:
Entry=3Ddfff75cc SourceDesc=3Ddfff2254 [Integer]
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dfff2254
Mar  8 10:37:45 linux kernel:   exdump-0788 [00] ex_dump_operands      =
:
************* Operand Stack Contents (Opcode [LEqual], 2 Operands)
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8036c Integer 000000000000000F
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dfff2254 Integer 000000000000000F
Mar  8 10:37:45 linux kernel:   exdump-0802 [00] ex_dump_operands      =
:
************* Operand Stack dump from dswexec(430), after ExResolveOper=
ands
Mar  8 10:37:45 linux kernel: dswstate-0312 [00] ds_result_push        =
:
Obj=3Ddff8063c [Integer] State=3Df37ca200 Num=3D1 Cur=3D0
Mar  8 10:37:45 linux kernel: dswstate-0184 [00] ds_result_pop         =
:
Obj=3Ddff8063c [Integer] Index=3D0 State=3Df37ca200 Num=3D0
Mar  8 10:37:45 linux kernel:  dswexec-0173 [00] ds_get_predicate_value=
:
Completed a predicate eval=3D1 Op=3Df30a8314
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a7248 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8063c [Integer] State=3Df37ca200 #Ops=3D1
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddfffe5e0 [RegionField] State=3Df37ca200 #Ops=3D2
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a7248 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  exresop-0163 [00] ex_resolve_operands   =
:
Opcode 70 [Store] RequiredOperandTypes=3D000002CF
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff8063c
Mar  8 10:37:45 linux kernel:   exdump-0788 [00] ex_dump_operands      =
:
************* Operand Stack Contents (Opcode [Store], 2 Operands)
Mar  8 10:37:45 linux kernel:   exdump-0469 [00] ex_dump_operand       =
:
dfffe5e0 Namespace Node:  0  SMIF RegionField  dfffe5e0 01 Rgn [MNVS]
Off 010 Len 08 Acc 01
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8063c Integer 000000000000002B
Mar  8 10:37:45 linux kernel:   exdump-0802 [00] ex_dump_operands      =
:
************* Operand Stack dump from dswexec(430), after ExResolveOper=
ands
Mar  8 10:37:45 linux kernel:  exstore-0561 [00] ex_store_object_to_nod=
:
Storing dff8063c(Integer) into node dfffe5e0(RegionField)
Mar  8 10:37:45 linux kernel:   evmisc-0479 [00] ev_acquire_global_lock=
:
Acquired hardware Global Lock
Mar  8 10:37:45 linux kernel: exregion-0185 [00] ex_system_memory_space=
:
System-Memory (width 8) R/W 1 Address=3DDFFF0FC47FF7BE7F
Mar  8 10:37:45 linux kernel:   evmisc-0550 [00] ev_release_global_lock=
:
Released hardware Global Lock
Mar  8 10:37:45 linux kernel: dswstate-0312 [00] ds_result_push        =
:
Obj=3Ddff8063c [Integer] State=3Df37ca200 Num=3D1 Cur=3D0
Mar  8 10:37:45 linux kernel: dswstate-0184 [00] ds_result_pop         =
:
Obj=3Ddff8063c [Integer] Index=3D0 State=3Df37ca200 Num=3D0
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a7248 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8022c [Integer] State=3Df37ca200 #Ops=3D1
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddfffe2fc [RegionField] State=3Df37ca200 #Ops=3D2
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a7248 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  exresop-0163 [00] ex_resolve_operands   =
:
Opcode 70 [Store] RequiredOperandTypes=3D000002CF
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff8022c
Mar  8 10:37:45 linux kernel:   exdump-0788 [00] ex_dump_operands      =
:
************* Operand Stack Contents (Opcode [Store], 2 Operands)
Mar  8 10:37:45 linux kernel:   exdump-0469 [00] ex_dump_operand       =
:
dfffe2fc Namespace Node:  0  TRP0 RegionField  dfffe2fc 01 Rgn [IO_T]
Off 000 Len 08 Acc 01
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8022c Integer 0000000000000000
Mar  8 10:37:45 linux kernel:   exdump-0802 [00] ex_dump_operands      =
:
************* Operand Stack dump from dswexec(430), after ExResolveOper=
ands
Mar  8 10:37:45 linux kernel:  exstore-0561 [00] ex_store_object_to_nod=
:
Storing dff8022c(Integer) into node dfffe2fc(RegionField)
Mar  8 10:37:45 linux kernel: exregion-0287 [00] ex_system_io_space_han=
:
System-IO (width 8) R/W 1 Address=3DDFFF0FC400000800
Mar  8 10:37:45 linux kernel: dswstate-0312 [00] ds_result_push        =
:
Obj=3Ddff8022c [Integer] State=3Df37ca200 Num=3D1 Cur=3D0
Mar  8 10:37:45 linux kernel: dswstate-0184 [00] ds_result_pop         =
:
Obj=3Ddff8022c [Integer] Index=3D0 State=3Df37ca200 Num=3D0
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a7248 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  dswexec-0264 [00] ds_exec_begin_op      =
:
Exec predicate Op=3Df30a8368 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a71c4 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a716c State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddfffe5b8 [RegionField] State=3Df37ca200 #Ops=3D1
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8063c [Integer] State=3Df37ca200 #Ops=3D2
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a716c RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  exresop-0163 [00] ex_resolve_operands   =
:
Opcode 95 [LLess] RequiredOperandTypes=3D0000014A
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff8063c
Mar  8 10:37:45 linux kernel: exresnte-0102 [00] ex_resolve_node_to_val=
:
Entry=3Ddfffe5b8 SourceDesc=3Ddfff340c [RegionField]
Mar  8 10:37:45 linux kernel: exresnte-0207 [00] ex_resolve_node_to_val=
:
=46ieldRead Node=3Ddfffe5b8 SourceDesc=3Ddfff340c Type=3D11
Mar  8 10:37:45 linux kernel:   evmisc-0479 [00] ev_acquire_global_lock=
:
Acquired hardware Global Lock
Mar  8 10:37:45 linux kernel: exregion-0185 [00] ex_system_memory_space=
:
System-Memory (width 8) R/W 0 Address=3DDFFF0FC47FF7BE81
Mar  8 10:37:45 linux kernel:   evmisc-0550 [00] ev_release_global_lock=
:
Released hardware Global Lock
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff8036c
Mar  8 10:37:45 linux kernel:   exdump-0788 [00] ex_dump_operands      =
:
************* Operand Stack Contents (Opcode [LLess], 2 Operands)
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8063c Integer 0000000000000002
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8036c Integer 0000000000000002
Mar  8 10:37:45 linux kernel:   exdump-0802 [00] ex_dump_operands      =
:
************* Operand Stack dump from dswexec(430), after ExResolveOper=
ands
Mar  8 10:37:45 linux kernel: dswstate-0312 [00] ds_result_push        =
:
Obj=3Ddff802f4 [Integer] State=3Df37ca200 Num=3D1 Cur=3D0
Mar  8 10:37:45 linux kernel: dswstate-0256 [00] ds_result_pop_from_bot=
:
Obj=3Ddff802f4 [Integer] Results=3Df30a71c4 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff802f4 [Integer] State=3Df37ca200 #Ops=3D1
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a71c4 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  exresop-0163 [00] ex_resolve_operands   =
:
Opcode 92 [LNot] RequiredOperandTypes=3D00000006
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff802f4
Mar  8 10:37:45 linux kernel:   exdump-0788 [00] ex_dump_operands      =
:
************* Operand Stack Contents (Opcode [LNot], 1 Operands)
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff802f4 Integer 0000000000000000
Mar  8 10:37:45 linux kernel:   exdump-0802 [00] ex_dump_operands      =
:
************* Operand Stack dump from dswexec(430), after ExResolveOper=
ands
Mar  8 10:37:45 linux kernel: dswstate-0312 [00] ds_result_push        =
:
Obj=3Ddff8022c [Integer] State=3Df37ca200 Num=3D1 Cur=3D0
Mar  8 10:37:45 linux kernel: dswstate-0184 [00] ds_result_pop         =
:
Obj=3Ddff8022c [Integer] Index=3D0 State=3Df37ca200 Num=3D0
Mar  8 10:37:45 linux kernel:  dswexec-0173 [00] ds_get_predicate_value=
:
Completed a predicate eval=3D1 Op=3Df30a8368
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a71c4 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8022c [Integer] State=3Df37ca200 #Ops=3D1
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddfff75cc [Integer] State=3Df37ca200 #Ops=3D2
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a71c4 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  exresop-0163 [00] ex_resolve_operands   =
:
Opcode 70 [Store] RequiredOperandTypes=3D000002CF
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff8022c
Mar  8 10:37:45 linux kernel:   exdump-0788 [00] ex_dump_operands      =
:
************* Operand Stack Contents (Opcode [Store], 2 Operands)
Mar  8 10:37:45 linux kernel:   exdump-0469 [00] ex_dump_operand       =
:
dfff75cc Namespace Node:  0  TOGF Integer      dfff75cc 01 =3D
000000000000000F
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8022c Integer 0000000000000000
Mar  8 10:37:45 linux kernel:   exdump-0802 [00] ex_dump_operands      =
:
************* Operand Stack dump from dswexec(430), after ExResolveOper=
ands
Mar  8 10:37:45 linux kernel:  exstore-0561 [00] ex_store_object_to_nod=
:
Storing dff8022c(Integer) into node dfff75cc(Integer)
Mar  8 10:37:45 linux kernel: dswstate-0312 [00] ds_result_push        =
:
Obj=3Ddff8022c [Integer] State=3Df37ca200 Num=3D1 Cur=3D0
Mar  8 10:37:45 linux kernel: dswstate-0184 [00] ds_result_pop         =
:
Obj=3Ddff8022c [Integer] Index=3D0 State=3Df37ca200 Num=3D0
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a7248 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a7248 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a7248 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a72cc RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a72cc State=3Df37ca200
Mar  8 10:37:45 linux kernel:  dswexec-0264 [00] ds_exec_begin_op      =
:
Exec predicate Op=3Df30a8314 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a7248 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a71f0 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddfffe5f4 [RegionField] State=3Df37ca200 #Ops=3D1
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff802f4 [Integer] State=3Df37ca200 #Ops=3D2
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a71f0 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  exresop-0163 [00] ex_resolve_operands   =
:
Opcode 93 [LEqual] RequiredOperandTypes=3D0000014A
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff802f4
Mar  8 10:37:45 linux kernel: exresnte-0102 [00] ex_resolve_node_to_val=
:
Entry=3Ddfffe5f4 SourceDesc=3Ddfff3484 [RegionField]
Mar  8 10:37:45 linux kernel: exresnte-0207 [00] ex_resolve_node_to_val=
:
=46ieldRead Node=3Ddfffe5f4 SourceDesc=3Ddfff3484 Type=3D11
Mar  8 10:37:45 linux kernel:   evmisc-0479 [00] ev_acquire_global_lock=
:
Acquired hardware Global Lock
Mar  8 10:37:45 linux kernel: exregion-0185 [00] ex_system_memory_space=
:
System-Memory (width 8) R/W 0 Address=3DDFFF0FC47FF7BE7D
Mar  8 10:37:45 linux kernel: exregion-0185 [00] ex_system_memory_space=
:
System-Memory (width 8) R/W 0 Address=3DDFFF0FC47FF7BE7E
Mar  8 10:37:45 linux kernel:   evmisc-0550 [00] ev_release_global_lock=
:
Released hardware Global Lock
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff8063c
Mar  8 10:37:45 linux kernel:   exdump-0788 [00] ex_dump_operands      =
:
************* Operand Stack Contents (Opcode [LEqual], 2 Operands)
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff802f4 Integer 00000000000007CE
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8063c Integer 00000000000007D1
Mar  8 10:37:45 linux kernel:   exdump-0802 [00] ex_dump_operands      =
:
************* Operand Stack dump from dswexec(430), after ExResolveOper=
ands
Mar  8 10:37:45 linux kernel: dswstate-0312 [00] ds_result_push        =
:
Obj=3Ddff8036c [Integer] State=3Df37ca200 Num=3D1 Cur=3D0
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a71f0 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddfffe5f4 [RegionField] State=3Df37ca200 #Ops=3D1
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8022c [Integer] State=3Df37ca200 #Ops=3D2
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a71f0 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  exresop-0163 [00] ex_resolve_operands   =
:
Opcode 93 [LEqual] RequiredOperandTypes=3D0000014A
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff8022c
Mar  8 10:37:45 linux kernel: exresnte-0102 [00] ex_resolve_node_to_val=
:
Entry=3Ddfffe5f4 SourceDesc=3Ddfff3484 [RegionField]
Mar  8 10:37:45 linux kernel: exresnte-0207 [00] ex_resolve_node_to_val=
:
=46ieldRead Node=3Ddfffe5f4 SourceDesc=3Ddfff3484 Type=3D11
Mar  8 10:37:45 linux kernel:   evmisc-0479 [00] ev_acquire_global_lock=
:
Acquired hardware Global Lock
Mar  8 10:37:45 linux kernel: exregion-0185 [00] ex_system_memory_space=
:
System-Memory (width 8) R/W 0 Address=3DDFFF0FC47FF7BE7D
Mar  8 10:37:45 linux kernel: exregion-0185 [00] ex_system_memory_space=
:
System-Memory (width 8) R/W 0 Address=3DDFFF0FC47FF7BE7E
Mar  8 10:37:45 linux kernel:   evmisc-0550 [00] ev_release_global_lock=
:
Released hardware Global Lock
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff802f4
Mar  8 10:37:45 linux kernel:   exdump-0788 [00] ex_dump_operands      =
:
************* Operand Stack Contents (Opcode [LEqual], 2 Operands)
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8022c Integer 00000000000007CF
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff802f4 Integer 00000000000007D1
Mar  8 10:37:45 linux kernel:   exdump-0802 [00] ex_dump_operands      =
:
************* Operand Stack dump from dswexec(430), after ExResolveOper=
ands
Mar  8 10:37:45 linux kernel: dswstate-0312 [00] ds_result_push        =
:
Obj=3Ddff8063c [Integer] State=3Df37ca200 Num=3D2 Cur=3D0
Mar  8 10:37:45 linux kernel: dswstate-0256 [00] ds_result_pop_from_bot=
:
Obj=3Ddff8036c [Integer] Results=3Df30a7248 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8036c [Integer] State=3Df37ca200 #Ops=3D1
Mar  8 10:37:45 linux kernel: dswstate-0256 [00] ds_result_pop_from_bot=
:
Obj=3Ddff8063c [Integer] Results=3Df30a7248 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8063c [Integer] State=3Df37ca200 #Ops=3D2
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a7248 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  exresop-0163 [00] ex_resolve_operands   =
:
Opcode 91 [LOr] RequiredOperandTypes=3D000000C6
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff8063c
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff8036c
Mar  8 10:37:45 linux kernel:   exdump-0788 [00] ex_dump_operands      =
:
************* Operand Stack Contents (Opcode [LOr], 2 Operands)
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8063c Integer 0000000000000000
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8036c Integer 0000000000000000
Mar  8 10:37:45 linux kernel:   exdump-0802 [00] ex_dump_operands      =
:
************* Operand Stack dump from dswexec(430), after ExResolveOper=
ands
Mar  8 10:37:45 linux kernel: dswstate-0312 [00] ds_result_push        =
:
Obj=3Ddff8022c [Integer] State=3Df37ca200 Num=3D1 Cur=3D0
Mar  8 10:37:45 linux kernel: dswstate-0184 [00] ds_result_pop         =
:
Obj=3Ddff8022c [Integer] Index=3D0 State=3Df37ca200 Num=3D0
Mar  8 10:37:45 linux kernel:  dswexec-0173 [00] ds_get_predicate_value=
:
Completed a predicate eval=3D0 Op=3Df30a8314
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a72cc RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a72cc State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a7274 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddfff761c [Integer] State=3Df37ca200 #Ops=3D1
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8022c [Reference] State=3Df37ca200 #Ops=3D2
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a7274 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  exresop-0163 [00] ex_resolve_operands   =
:
Opcode 70 [Store] RequiredOperandTypes=3D000002CF
Mar  8 10:37:45 linux kernel:  exresop-0257 [00] ex_resolve_operands   =
:
Operand is a Reference, RefOpcode [Local0]
Mar  8 10:37:45 linux kernel: exresnte-0102 [00] ex_resolve_node_to_val=
:
Entry=3Ddfff761c SourceDesc=3Ddfff22f4 [Integer]
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dfff22f4
Mar  8 10:37:45 linux kernel:   exdump-0788 [00] ex_dump_operands      =
:
************* Operand Stack Contents (Opcode [Store], 2 Operands)
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8022c Reference: Local1
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dfff22f4 Integer 0000000000000001
Mar  8 10:37:45 linux kernel:   exdump-0802 [00] ex_dump_operands      =
:
************* Operand Stack dump from dswexec(430), after ExResolveOper=
ands
Mar  8 10:37:45 linux kernel: dsmthdat-0543 [00] ds_store_object_to_loc=
:
Opcode=3D60 Index=3D1 Obj=3Ddfff22f4
Mar  8 10:37:45 linux kernel: dsmthdat-0326 [00] ds_method_data_set_val=
:
NewObj dff8036c Opcode 60, Refs=3D1 [Integer]
Mar  8 10:37:45 linux kernel: dswstate-0312 [00] ds_result_push        =
:
Obj=3Ddfff22f4 [Integer] State=3Df37ca200 Num=3D1 Cur=3D0
Mar  8 10:37:45 linux kernel: dswstate-0184 [00] ds_result_pop         =
:
Obj=3Ddfff22f4 [Integer] Index=3D0 State=3Df37ca200 Num=3D0
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a7274 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  dswexec-0264 [00] ds_exec_begin_op      =
:
Exec predicate Op=3Df30a8330 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a71f0 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8063c [Reference] State=3Df37ca200 #Ops=3D1
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8022c [Integer] State=3Df37ca200 #Ops=3D2
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a71f0 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  exresop-0163 [00] ex_resolve_operands   =
:
Opcode 93 [LEqual] RequiredOperandTypes=3D0000014A
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff8022c
Mar  8 10:37:45 linux kernel:  exresop-0257 [00] ex_resolve_operands   =
:
Operand is a Reference, RefOpcode [Local0]
Mar  8 10:37:45 linux kernel: exresolv-0195 [00] ex_resolve_object_to_v=
:
[Arg/Local 1] ValueObj is dff8036c
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff8036c
Mar  8 10:37:45 linux kernel:   exdump-0788 [00] ex_dump_operands      =
:
************* Operand Stack Contents (Opcode [LEqual], 2 Operands)
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8022c Integer 0000000000000000
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8036c Integer 0000000000000001
Mar  8 10:37:45 linux kernel:   exdump-0802 [00] ex_dump_operands      =
:
************* Operand Stack dump from dswexec(430), after ExResolveOper=
ands
Mar  8 10:37:45 linux kernel: dswstate-0312 [00] ds_result_push        =
:
Obj=3Ddff8063c [Integer] State=3Df37ca200 Num=3D1 Cur=3D0
Mar  8 10:37:45 linux kernel: dswstate-0184 [00] ds_result_pop         =
:
Obj=3Ddff8063c [Integer] Index=3D0 State=3Df37ca200 Num=3D0
Mar  8 10:37:45 linux kernel:  dswexec-0173 [00] ds_get_predicate_value=
:
Completed a predicate eval=3D0 Op=3Df30a8330
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a7274 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a7274 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  dswexec-0264 [00] ds_exec_begin_op      =
:
Exec predicate Op=3Df30a8330 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a71f0 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8063c [Reference] State=3Df37ca200 #Ops=3D1
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8022c [Integer] State=3Df37ca200 #Ops=3D2
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a71f0 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  exresop-0163 [00] ex_resolve_operands   =
:
Opcode 93 [LEqual] RequiredOperandTypes=3D0000014A
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff8022c
Mar  8 10:37:45 linux kernel:  exresop-0257 [00] ex_resolve_operands   =
:
Operand is a Reference, RefOpcode [Local0]
Mar  8 10:37:45 linux kernel: exresolv-0195 [00] ex_resolve_object_to_v=
:
[Arg/Local 1] ValueObj is dff8036c
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff8036c
Mar  8 10:37:45 linux kernel:   exdump-0788 [00] ex_dump_operands      =
:
************* Operand Stack Contents (Opcode [LEqual], 2 Operands)
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8022c Integer 0000000000000001
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8036c Integer 0000000000000001
Mar  8 10:37:45 linux kernel:   exdump-0802 [00] ex_dump_operands      =
:
************* Operand Stack dump from dswexec(430), after ExResolveOper=
ands
Mar  8 10:37:45 linux kernel: dswstate-0312 [00] ds_result_push        =
:
Obj=3Ddff8063c [Integer] State=3Df37ca200 Num=3D1 Cur=3D0
Mar  8 10:37:45 linux kernel: dswstate-0184 [00] ds_result_pop         =
:
Obj=3Ddff8063c [Integer] Index=3D0 State=3Df37ca200 Num=3D0
Mar  8 10:37:45 linux kernel:  dswexec-0173 [00] ds_get_predicate_value=
:
Completed a predicate eval=3D1 Op=3Df30a8330
Mar  8 10:37:45 linux kernel: dswstate-0344 [00] ds_result_stack_push  =
:
Results=3Df30a71f0 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8063c [String] State=3Df37ca200 #Ops=3D1
Mar  8 10:37:45 linux kernel: dswstate-0423 [00] ds_obj_stack_push     =
:
Obj=3Ddff8022c [Reference] State=3Df37ca200 #Ops=3D2
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a71f0 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel:  exresop-0163 [00] ex_resolve_operands   =
:
Opcode 70 [Store] RequiredOperandTypes=3D000002CF
Mar  8 10:37:45 linux kernel:  exresop-0257 [00] ex_resolve_operands   =
:
Operand is a Reference, RefOpcode [Debug]
Mar  8 10:37:45 linux kernel: exresolv-0119 [00] ex_resolve_to_value   =
:
Resolved object dff8063c
Mar  8 10:37:45 linux kernel:   exdump-0788 [00] ex_dump_operands      =
:
************* Operand Stack Contents (Opcode [Store], 2 Operands)
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8022c Reference: Debug
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8063c String length D @ f8803083 " SMI routine "
Mar  8 10:37:45 linux kernel:   exdump-0802 [00] ex_dump_operands      =
:
************* Operand Stack dump from dswexec(430), after ExResolveOper=
ands
Mar  8 10:37:45 linux kernel:  exstore-0356 [00] ex_store              =
:
**** Write to Debug Object: Object dff8063c String ****:
Mar  8 10:37:45 linux kernel:
Mar  8 10:37:45 linux kernel: [ACPI Debug]  String: [0x0D] " SMI routin=
e "
Mar  8 10:37:45 linux kernel:
Mar  8 10:37:45 linux kernel: dswstate-0312 [00] ds_result_push        =
:
Obj=3Ddff8063c [String] State=3Df37ca200 Num=3D1 Cur=3D0
Mar  8 10:37:45 linux kernel: dswstate-0184 [00] ds_result_pop         =
:
Obj=3Ddff8063c [String] Index=3D0 State=3Df37ca200 Num=3D0
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a7274 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a72cc RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswstate-0379 [00] ds_result_stack_pop   =
:
Result=3Df30a7350 RemainingResults=3D0 State=3Df37ca200
Mar  8 10:37:45 linux kernel: dswscope-0078 [00] ds_scope_stack_clear  =
:
Popped object type (Method)
Mar  8 10:37:45 linux kernel: dsmthdat-0152 [00] ds_method_data_delete_=
:
Deleting Local1=3Ddff8036c
Mar  8 10:37:45 linux kernel:   exdump-0489 [00] ex_dump_operand       =
:
dff8063c String length D @ f8803083 " SMI routine "

If this help I can send you in a separate file, it could be better...

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
