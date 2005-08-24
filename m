From: Mattia Dongili <malattia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: utmisc-0131: *** Error: Invalid owner_id: 00
Date: Wed, 24 Aug 2005 21:20:29 +0200
Message-ID: <20050824192029.GA3380@inferi.kami.home>
References: <6694B22B6436BC43B429958787E454983CB7B8@mssmsx402nb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6694B22B6436BC43B429958787E454983CB7B8@mssmsx402nb>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, ACPI Devel Maling List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 24, 2005 at 02:51:38PM +0400, Starikovskiy, Alexey Y wrote:
> Hi Mattia,
> 
> Thanks for helping with this issue...
> There are can be two causes to this -- we either overwrite allocated
> owner_id (this can be checked with the WARN_ON (owner_id != 0)
> in acpi_ut_allocate_owner_id -- we never copy owner_id) or we give just
> released owner_id location instead of right one to release_owner_id
> function.

As I suspected :)

Anyway it seems to be the former, see the log (with
WARN_ON(*owner_id!=0) it'll hopefully give a better idea on what's
happening:
...
evgpeblk-0996 [06] ev_create_gpe_block   : Found 1 Wake, Enabled 0 Runtime GPEs in this block
Badness in acpi_ut_allocate_owner_id at drivers/acpi/utilities/utmisc.c:70
 [<c02170b5>] acpi_ut_allocate_owner_id+0x3d/0xdb
 [<c020f7f0>] acpi_ps_execute_method+0x7c/0x195
 [<c020b141>] acpi_ns_execute_control_method+0x10b/0x132
 [<c020affd>] acpi_ns_evaluate_by_handle+0x104/0x13d
 [<c01f97f7>] acpi_ev_execute_reg_method+0x12f/0x16a
 [<c01f9bfe>] acpi_ev_detach_region+0x104/0x225
 [<c01f9e59>] acpi_ev_install_handler+0x7f/0xd7
 [<c020d440>] acpi_ns_walk_namespace+0xbb/0x1b7
 [<c020506a>] acpi_ex_pci_config_space_handler+0x0/0xd8
 [<c01fa12d>] acpi_ev_install_space_handler+0x27c/0x2b8
 [<c01f9dda>] acpi_ev_install_handler+0x0/0xd7
 [<c01fc42d>] acpi_install_address_space_handler+0x9d/0xd7
 [<c01fb396>] acpi_ev_pci_config_region_setup+0x0/0x2c7
 [<c01fb4eb>] acpi_ev_pci_config_region_setup+0x155/0x2c7
 [<c01fb396>] acpi_ev_pci_config_region_setup+0x0/0x2c7
 [<c01f9954>] acpi_ev_address_space_dispatch+0x122/0x2c8
 [<c0200950>] acpi_ex_access_region+0x149/0x1e9
 [<c0200b9e>] acpi_ex_field_datum_io+0x177/0x31f
 [<c0200f20>] acpi_ex_write_with_update_rule+0x1da/0x204
 [<c02013bc>] acpi_ex_insert_into_field+0x1ac/0x31c
 [<c0216358>] acpi_ut_value_exit+0x2d/0x37
 [<c01feacb>] acpi_ex_write_data_to_field+0x39b/0x3f4
 [<c0205b60>] acpi_ex_store_object_to_node+0x10b/0x217
 [<c02056d0>] acpi_ex_store+0x9c/0x27d
 [<c0201bdb>] acpi_ex_opcode_1A_1T_1R+0x460/0x660
 [<c01f5926>] acpi_ds_exec_end_op+0x140/0x5d2
 [<c01f5935>] acpi_ds_exec_end_op+0x14f/0x5d2
 [<c020edb5>] acpi_ps_parse_loop+0x75d/0xb6c
 [<c020e43c>] acpi_ps_parse_aml+0xc8/0x2e4
 [<c020f9e8>] acpi_ps_execute_pass+0xa9/0xd5
 [<c020f878>] acpi_ps_execute_method+0x104/0x195
 [<c020b141>] acpi_ns_execute_control_method+0x10b/0x132
 [<c020affd>] acpi_ns_evaluate_by_handle+0x104/0x13d
 [<c01f97f7>] acpi_ev_execute_reg_method+0x12f/0x16a
 [<c020d440>] acpi_ns_walk_namespace+0xbb/0x1b7
 [<c01fa1a4>] acpi_ev_execute_reg_methods+0x3b/0x5f
 [<c01fa1c8>] acpi_ev_reg_run+0x0/0x50
 [<c01f9695>] acpi_ev_initialize_op_regions+0x5b/0x8e
 [<c0217cbc>] acpi_initialize_objects+0x4e/0x132
 [<c038eaa2>] acpi_bus_init+0x40/0xe5
 [<c038ebc1>] acpi_init+0x7a/0x11e
 [<c037e914>] do_initcalls+0x54/0xd0
 [<c0397875>] netfilter_init+0x65/0xa0
 [<c01002a0>] init+0x0/0x170
 [<c01002cf>] init+0x2f/0x170
 [<c0101394>] kernel_thread_helper+0x0/0xc
 [<c0101399>] kernel_thread_helper+0x5/0xc
  utmisc-0133: *** Error: Invalid owner_id: 00


> Could you please try suggested check in acpi_ut_allocate_owner_id ?
> Also it can be extremely helpful if you can print the name of the AML
> method there this fault accurs, for this you need to turn the check
> above into return error code.

here you are, with 
	if (*owner_id!=0) {
		WARN_ON(1);
		return_ACPI_STATUS(1);
	}
the log is:
...
evgpeblk-0996 [06] ev_create_gpe_block   : Found 1 Wake, Enabled 0 Runtime GPEs in this block
Badness in acpi_ut_allocate_owner_id at drivers/acpi/utilities/utmisc.c:71
 [<c02170ba>] acpi_ut_allocate_owner_id+0x42/0xfb
 [<c020f7f0>] acpi_ps_execute_method+0x7c/0x195
 [<c020b141>] acpi_ns_execute_control_method+0x10b/0x132
 [<c020affd>] acpi_ns_evaluate_by_handle+0x104/0x13d
 [<c01f97f7>] acpi_ev_execute_reg_method+0x12f/0x16a
 [<c01f9bfe>] acpi_ev_detach_region+0x104/0x225
 [<c01f9e59>] acpi_ev_install_handler+0x7f/0xd7
 [<c020d440>] acpi_ns_walk_namespace+0xbb/0x1b7
 [<c020506a>] acpi_ex_pci_config_space_handler+0x0/0xd8
 [<c01fa12d>] acpi_ev_install_space_handler+0x27c/0x2b8
 [<c01f9dda>] acpi_ev_install_handler+0x0/0xd7
 [<c01fc42d>] acpi_install_address_space_handler+0x9d/0xd7
 [<c01fb396>] acpi_ev_pci_config_region_setup+0x0/0x2c7
 [<c01fb4eb>] acpi_ev_pci_config_region_setup+0x155/0x2c7
 [<c01fb396>] acpi_ev_pci_config_region_setup+0x0/0x2c7
 [<c01f9954>] acpi_ev_address_space_dispatch+0x122/0x2c8
 [<c0200950>] acpi_ex_access_region+0x149/0x1e9
 [<c0200b9e>] acpi_ex_field_datum_io+0x177/0x31f
 [<c0200f20>] acpi_ex_write_with_update_rule+0x1da/0x204
 [<c02013bc>] acpi_ex_insert_into_field+0x1ac/0x31c
 [<c0216358>] acpi_ut_value_exit+0x2d/0x37
 [<c01feacb>] acpi_ex_write_data_to_field+0x39b/0x3f4
 [<c0205b60>] acpi_ex_store_object_to_node+0x10b/0x217
 [<c02056d0>] acpi_ex_store+0x9c/0x27d
 [<c0201bdb>] acpi_ex_opcode_1A_1T_1R+0x460/0x660
 [<c01f5926>] acpi_ds_exec_end_op+0x140/0x5d2
 [<c01f5935>] acpi_ds_exec_end_op+0x14f/0x5d2
 [<c020edb5>] acpi_ps_parse_loop+0x75d/0xb6c
 [<c020e43c>] acpi_ps_parse_aml+0xc8/0x2e4
 [<c020f9e8>] acpi_ps_execute_pass+0xa9/0xd5
 [<c020f878>] acpi_ps_execute_method+0x104/0x195
 [<c020b141>] acpi_ns_execute_control_method+0x10b/0x132
 [<c020affd>] acpi_ns_evaluate_by_handle+0x104/0x13d
 [<c01f97f7>] acpi_ev_execute_reg_method+0x12f/0x16a
 [<c020d440>] acpi_ns_walk_namespace+0xbb/0x1b7
 [<c01fa1a4>] acpi_ev_execute_reg_methods+0x3b/0x5f
 [<c01fa1c8>] acpi_ev_reg_run+0x0/0x50
 [<c01f9695>] acpi_ev_initialize_op_regions+0x5b/0x8e
 [<c0217cdc>] acpi_initialize_objects+0x4e/0x132
 [<c038eaa2>] acpi_bus_init+0x40/0xe5
 [<c038ebc1>] acpi_init+0x7a/0x11e
 [<c037e914>] do_initcalls+0x54/0xd0
 [<c0397875>] netfilter_init+0x65/0xa0
 [<c01002a0>] init+0x0/0x170
 [<c01002cf>] init+0x2f/0x170
 [<c0101394>] kernel_thread_helper+0x0/0xc
 [<c0101399>] kernel_thread_helper+0x5/0xc
evregion-0509 [28] ev_detach_region      : AE_ERROR from region _REG, [PCI_Config]
Badness in acpi_ut_allocate_owner_id at drivers/acpi/utilities/utmisc.c:71
 [<c02170ba>] acpi_ut_allocate_owner_id+0x42/0xfb
 [<c020f7f0>] acpi_ps_execute_method+0x7c/0x195
 [<c020b141>] acpi_ns_execute_control_method+0x10b/0x132
 [<c020affd>] acpi_ns_evaluate_by_handle+0x104/0x13d
 [<c01f97f7>] acpi_ev_execute_reg_method+0x12f/0x16a
 [<c020d440>] acpi_ns_walk_namespace+0xbb/0x1b7
 [<c01fa1a4>] acpi_ev_execute_reg_methods+0x3b/0x5f
 [<c01fa1c8>] acpi_ev_reg_run+0x0/0x50
 [<c01fc43d>] acpi_install_address_space_handler+0xad/0xd7
 [<c01fb4eb>] acpi_ev_pci_config_region_setup+0x155/0x2c7
 [<c01fb396>] acpi_ev_pci_config_region_setup+0x0/0x2c7
 [<c01f9954>] acpi_ev_address_space_dispatch+0x122/0x2c8
 [<c0200950>] acpi_ex_access_region+0x149/0x1e9
 [<c0200b9e>] acpi_ex_field_datum_io+0x177/0x31f
 [<c0200f20>] acpi_ex_write_with_update_rule+0x1da/0x204
 [<c02013bc>] acpi_ex_insert_into_field+0x1ac/0x31c
 [<c0216358>] acpi_ut_value_exit+0x2d/0x37
 [<c01feacb>] acpi_ex_write_data_to_field+0x39b/0x3f4
 [<c0205b60>] acpi_ex_store_object_to_node+0x10b/0x217
 [<c02056d0>] acpi_ex_store+0x9c/0x27d
 [<c0201bdb>] acpi_ex_opcode_1A_1T_1R+0x460/0x660
 [<c01f5926>] acpi_ds_exec_end_op+0x140/0x5d2
 [<c01f5935>] acpi_ds_exec_end_op+0x14f/0x5d2
 [<c020edb5>] acpi_ps_parse_loop+0x75d/0xb6c
 [<c020e43c>] acpi_ps_parse_aml+0xc8/0x2e4
 [<c020f9e8>] acpi_ps_execute_pass+0xa9/0xd5
 [<c020f878>] acpi_ps_execute_method+0x104/0x195
 [<c020b141>] acpi_ns_execute_control_method+0x10b/0x132
 [<c020affd>] acpi_ns_evaluate_by_handle+0x104/0x13d
 [<c01f97f7>] acpi_ev_execute_reg_method+0x12f/0x16a
 [<c020d440>] acpi_ns_walk_namespace+0xbb/0x1b7
 [<c01fa1a4>] acpi_ev_execute_reg_methods+0x3b/0x5f
 [<c01fa1c8>] acpi_ev_reg_run+0x0/0x50
 [<c01f9695>] acpi_ev_initialize_op_regions+0x5b/0x8e
 [<c0217cdc>] acpi_initialize_objects+0x4e/0x132
 [<c038eaa2>] acpi_bus_init+0x40/0xe5
 [<c038ebc1>] acpi_init+0x7a/0x11e
 [<c037e914>] do_initcalls+0x54/0xd0
 [<c0397875>] netfilter_init+0x65/0xa0
 [<c01002a0>] init+0x0/0x170
 [<c01002cf>] init+0x2f/0x170
 [<c0101394>] kernel_thread_helper+0x0/0xc
 [<c0101399>] kernel_thread_helper+0x5/0xc
evrgnini-0236: *** Error: Could not install pci_config handler for Root Bridge PCI0, AE_ERROR
Completing Region/Field/Buffer/Package initialization:..............................................................
Initialized 20/21 Regions 0/0 Fields 25/25 Buffers 17/27 Packages (564 nodes)

Ah, note that all of the above is with 2.6.13-rc6-mm2						

Last question: what am I doing wrong in the following?
# acpidump -o dsdt.dat
# iasl -d dsdt.dat

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20050624 [Aug 24
2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

Loading Acpi table from file dsdt.dat
TableHeader length [0x30204020] greater than the input file size
[0x14CF9]
Could not get table from the file
#

-- 
mattia
:wq!


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
