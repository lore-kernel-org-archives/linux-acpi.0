From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: acpi/test panic
Date: Mon, 27 Sep 2010 09:26:02 +0800
Message-ID: <1285550762.5416.30.camel@minggr.sh.intel.com>
References: <4C9FC97F.7030405@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:18451 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757580Ab0I0BZU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Sep 2010 21:25:20 -0400
In-Reply-To: <4C9FC97F.7030405@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai.lu@oracle.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, 2010-09-27 at 06:30 +0800, Yinghai Lu wrote:
> acpi/test panic
> 
> with acpi/test
> 
> [   36.519401] ACPI Error: Needed [Integer/String/Buffer], found [Extra] ffff884079f2c168 (20100915/exresop-422)
> [   36.520313] ACPI Error: Method parse/execution failed [\_SB_.RWPE] (Node ffff883079c6ee60), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   36.536637] ACPI Error: Method parse/execution failed [\_SB_.DEVS] (Node ffff883079c6f4b0), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   36.575592] ACPI Error: Method parse/execution failed [\_SB_.PCI0.NPE3.S2F0._STA] (Node ffff887079c68168), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   36.596525] ACPI Error: Needed [Integer/String/Buffer], found [Extra] ffff886079f08120 (20100915/exresop-422)
> [   36.615696] ACPI Error: Method parse/execution failed [\_SB_.RWPE] (Node ffff883079c6ee60), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   36.635680] ACPI Error: Method parse/execution failed [\_SB_.DEVS] (Node ffff883079c6f4b0), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   36.655787] ACPI Error: Method parse/execution failed [\_SB_.PCI0.NPE3.S2F1._STA] (Node ffff887079c68280), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   36.676637] ACPI Error: Needed [Integer/String/Buffer], found [Extra] ffff882079f3b048 (20100915/exresop-422)
> [   36.695848] ACPI Error: Method parse/execution failed [\_SB_.RWPE] (Node ffff883079c6ee60), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   36.715886] ACPI Error: Method parse/execution failed [\_SB_.DEVS] (Node ffff883079c6f4b0), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   36.735973] ACPI Error: Method parse/execution failed [\_SB_.PCI0.NPE3.S2F2._STA] (Node ffff887079c68398), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   36.756816] ACPI Error: Needed [Integer/String/Buffer], found [Extra] ffff887079f2b000 (20100915/exresop-422)
> [   36.775842] ACPI Error: Method parse/execution failed [\_SB_.RWPE] (Node ffff883079c6ee60), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   36.796326] ACPI Error: Method parse/execution failed [\_SB_.DEVS] (Node ffff883079c6f4b0), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   36.816076] ACPI Error: Method parse/execution failed [\_SB_.PCI0.NPE3.S2F3._STA] (Node ffff887079c684b0), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   36.855881] ACPI Error: Needed [Integer/String/Buffer], found [Extra] ffff881078704120 (20100915/exresop-422)
> [   36.875396] ACPI Error: Method parse/execution failed [\_SB_.RWPE] (Node ffff883079c6ee60), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   36.895105] ACPI Error: Method parse/execution failed [\_SB_.DEVS] (Node ffff883079c6f4b0), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   36.915053] ACPI Error: Method parse/execution failed [\_SB_.PCI0.NPE3.S2F4._STA] (Node ffff887079c685c8), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   36.935631] ACPI Error: Needed [Integer/String/Buffer], found [Extra] ffff881078704120 (20100915/exresop-422)
> [   36.955221] ACPI Error: Method parse/execution failed [\_SB_.RWPE] (Node ffff883079c6ee60), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   36.975253] ACPI Error: Method parse/execution failed [\_SB_.DEVS] (Node ffff883079c6f4b0), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   36.995440] ACPI Error: Method parse/execution failed [\_SB_.PCI0.NPE3.S2F5._STA] (Node ffff887079c686e0), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   37.016106] ACPI Error: Needed type [Reference], found [Integer] ffff8810787041f8 (20100915/exresop-104)
> [   37.035165] ACPI Exception: AE_AML_OPERAND_TYPE, While resolving operands for [And] (20100915/dswexec-445)
> [   37.055057] ACPI Error: Method parse/execution failed [\_SB_.RWPE] (Node ffff883079c6ee60), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   37.075055] ACPI Error: Method parse/execution failed [\_SB_.DEVS] (Node ffff883079c6f4b0), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   37.095494] ACPI Error: Method parse/execution failed [\_SB_.PCI0.NPE3.S2F6._STA] (Node ffff887079c687f8), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   37.115811] ACPI Error: ffff887079f1dc00 is not an ACPI Operand object [Invalid] (20100915/utobject-427)
> [   37.135567] ACPI Error: Needed [Integer/String/Buffer], found [Reference] ffff882079f18048 (20100915/exresop-422)
> [   37.155212] ACPI Exception: AE_AML_OPERAND_TYPE, While resolving operands for [Add] (20100915/dswexec-445)
> [   37.174838] ACPI Error: Method parse/execution failed [\_SB_.RWPE] (Node ffff883079c6ee60), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   37.195151] ACPI Error: Method parse/execution failed [\_SB_.DEVS] (Node ffff883079c6f4b0), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   37.214976] ACPI Error: Method parse/execution failed [\_SB_.PCI0.NPE3.S2F7._STA] (Node ffff887079c68910), AE_AML_OPERAND_TYPE (20100915/psparse-537)
> [   37.235566] BUG: unable to handle kernel paging request at 0000000000050008
> [   37.254798] IP: [<ffffffff814a7527>] acpi_ut_update_object_reference+0x27/0x1ae
> [   37.274452] PGD 0 
> [   37.274621] Oops: 0000 [#1] SMP 
> [   37.274939] last sysfs file: 
> [   37.294106] CPU 0 
> [   37.294311] Modules linked in:
> [   37.294611] 
> [   37.294809] Pid: 1, comm: swapper Not tainted 2.6.36-rc5-tip-yh-01831-gdeb947f-dirty #48      /unknown       
> [   37.314564] RIP: 0010:[<ffffffff814a7527>]  [<ffffffff814a7527>] acpi_ut_update_object_reference+0x27/0x1ae
> [   37.334381] RSP: 0018:ffff885079ca5860  EFLAGS: 00010206
> [   37.334947] RAX: 0000000000000000 RBX: 0000000000050000 RCX: 0000000000000000
> [   37.354460] RDX: ffff887079f205a0 RSI: 0000000000000001 RDI: ffff884079c88000
> [   37.374032] RBP: ffff885079ca58a0 R08: 0000000000000001 R09: ffffffff82300d2f
> [   37.374715] R10: ffffffff8147b6d8 R11: 0000000179c63180 R12: 0000000000000000
> [   37.394378] R13: 000000000000000a R14: 0000000000000000 R15: ffff8810786d4000
> [   37.413894] FS:  0000000000000000(0000) GS:ffff880003600000(0000) knlGS:0000000000000000
> [   37.414629] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [   37.434096] CR2: 0000000000050008 CR3: 0000000002486000 CR4: 00000000000006f0
> [   37.434758] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   37.474250] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [   37.493932] Process swapper (pid: 1, threadinfo ffff885079ca4000, task ffff884079c88000)
> [   37.513670] Stack:
> [   37.513890]  ffff885079f57818 0000000000000008 ffff885079ca5890 ffff887079f20500
> [   37.514423] <0> ffff885079c6d750 0000000000000000 ffff883079c6f2a8 ffff8810786d42e0
> [   37.534488] <0> ffff885079ca58d0 ffffffff814a77ad ffff885079c6d750 ffff883000000001
> [   37.553874] Call Trace:
> [   37.554058]  [<ffffffff814a77ad>] acpi_ut_add_reference+0x5c/0x63
> [   37.573545]  [<ffffffff814977c7>] acpi_ex_resolve_node_to_value+0x18f/0x2c0
> [   37.574232]  [<ffffffff81491e71>] acpi_ex_resolve_to_value+0x279/0x2c8
> [   37.593712]  [<ffffffff8148a617>] acpi_ds_evaluate_name_path+0x7f/0x10b
> [   37.594362]  [<ffffffff8149f8f8>] ? acpi_ps_get_next_namepath+0x7b/0x25e
> [   37.613946]  [<ffffffff81488a81>] acpi_ds_exec_end_op+0x97/0x5b6
> [   37.614461]  [<ffffffff814a0f81>] acpi_ps_parse_loop+0x8f8/0xafb
> [   37.633955]  [<ffffffff81489915>] ? acpi_ds_call_control_method+0x20b/0x261
> [   37.653641]  [<ffffffff8149fed6>] acpi_ps_parse_aml+0x112/0x3e5
> [   37.654117]  [<ffffffff814a19a5>] acpi_ps_execute_method+0x1f8/0x2eb
> [   37.673546]  [<ffffffff8149b670>] acpi_ns_evaluate+0x194/0x2ed
> [   37.674077]  [<ffffffff8149aed9>] acpi_evaluate_object+0x1dd/0x32d
> [   37.693685]  [<ffffffff810a4f18>] ? trace_hardirqs_on+0xd/0xf
> [   37.694194]  [<ffffffff8147c5da>] acpi_evaluate_integer+0x45/0xc0
> [   37.713741]  [<ffffffff8147b81f>] ? acpi_os_signal_semaphore+0x67/0x70
> [   37.733191]  [<ffffffff8147de19>] acpi_bus_get_status_handle+0x22/0x38
> [   37.733862]  [<ffffffff8147ff23>] acpi_bus_check_add+0x50/0x125
> [   37.753275]  [<ffffffff8149dd30>] acpi_ns_walk_namespace+0xba/0x186
> [   37.753940]  [<ffffffff8147fed3>] ? acpi_bus_check_add+0x0/0x125
> [   37.773455]  [<ffffffff8147fed3>] ? acpi_bus_check_add+0x0/0x125
> [   37.774079]  [<ffffffff8149accc>] acpi_walk_namespace+0x96/0xc6
> [   37.793696]  [<ffffffff81480050>] acpi_bus_scan+0x58/0x7b
> [   37.794136]  [<ffffffff8150fe34>] ? bus_register+0x1c2/0x29e
> [   37.813373]  [<ffffffff8282a4fe>] ? acpi_init+0x0/0x402
> [   37.813748]  [<ffffffff8282a98d>] acpi_scan_init+0x4b/0xd2
> [   37.833343]  [<ffffffff8282a4fe>] ? acpi_init+0x0/0x402
> [   37.833828]  [<ffffffff8282a4fe>] ? acpi_init+0x0/0x402
> [   37.853253]  [<ffffffff81b21ae4>] ? dmi_check_system+0x1c/0x49
> [   37.853884]  [<ffffffff8282a82c>] acpi_init+0x32e/0x402
> [   37.873135]  [<ffffffff8109cc2a>] ? ktime_get+0x6a/0xcb
> [   37.873660]  [<ffffffff810001f2>] do_one_initcall+0x57/0x13a
> [   37.893019]  [<ffffffff827f9b81>] kernel_init+0x165/0x1ef
> [   37.893495]  [<ffffffff81034954>] kernel_thread_helper+0x4/0x10
> [   37.913053]  [<ffffffff81ce843c>] ? restore_args+0x0/0x30
> [   37.913590]  [<ffffffff827f9a1c>] ? kernel_init+0x0/0x1ef
> [   37.933069]  [<ffffffff81034950>] ? kernel_thread_helper+0x0/0x10
> [   37.933620] Code: 41 5d c9 c3 55 48 89 e5 41 56 41 55 41 54 53 48 83 ec 20 0f 1f 44 00 00 48 89 fb 41 89 f6 48 c7 45 d8 00 00 00 00 e9 22 01 00 00 <80> 7b 08 0f 75 35 49 c7 c1 0b 0e 30 82 41 b8 01 00 00 00 48 c7 
> [   37.973311] RIP  [<ffffffff814a7527>] acpi_ut_update_object_reference+0x27/0x1ae
> [   37.992807]  RSP <ffff885079ca5860>
> [   37.993201] CR2: 0000000000050008
> [   37.993512] ---[ end trace 5003353dd8ff0030 ]---
> 
> bisected to:
> 
> dc10b7268e247ffef6fe23b54c1d8b1d016daa96 is the first bad commit
> commit dc10b7268e247ffef6fe23b54c1d8b1d016daa96
> Author: Bob Moore <robert.moore@intel.com>
> Date:   Fri Aug 6 09:09:33 2010 +0800
> 
>     ACPICA: Revert "Revert "Enable multi-byte EC transfers
>     
>     This reverts commit f23b9c7(http://git.moblin.org/cgit.cgi/acpica/commit/?id=f23b9c7)
>     The problem with this change was determined to be a problem with
>     the FreeBSD host OSL (OS services layer), not with this patch
>     itself. Therefore, re-introducing this change into the main ACPICA
>     code. See ACPICA bugzilla 863.
>     
>     http://www.acpica.org/bugzilla/show_bug.cgi?id=863
>     
>     Signed-off-by: Bob Moore <robert.moore@intel.com>
>     Signed-off-by: Lin Ming <ming.m.lin@intel.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> :040000 040000 5c0f644ddbab39510e8f394d451b65234127e041 b8c8c4c268a79aeecd475866b5673b7001422872 M	drivers
> 
> reverting that will fix the problem.

Would you please try below fix?

Thanks.

diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 5366a48..fa51450 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -472,6 +472,10 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 			}
 		}
 
+		/* An additional reference for the container */
+
+		acpi_ut_add_reference(obj_desc->field.region_obj);
+
 		ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
 				  "RegionField: BitOff %X, Off %X, Gran %X, Region %p\n",
 				  obj_desc->field.start_field_bit_offset,




