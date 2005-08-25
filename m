From: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: utmisc-0131: *** Error: Invalid owner_id: 00
Date: Thu, 25 Aug 2005 09:56:52 +0400
Message-ID: <6694B22B6436BC43B429958787E454983CBB62@mssmsx402nb>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5A939.CA6BD1A3"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mattia Dongili <malattia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, ACPI Devel Maling List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5A939.CA6BD1A3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Could you please try attached patch? It was made for
2.6.12+acpica-unix-20050729.patch, but it should apply cleanly to mm
tree as well.

Regards,
	Alex.=20

-----Original Message-----
From: Mattia Dongili [mailto:malattia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]=20
Sent: Wednesday, August 24, 2005 11:20 PM
To: Starikovskiy, Alexey Y
Cc: Thomas Renninger; ACPI Devel Maling List
Subject: Re: [ACPI] utmisc-0131: *** Error: Invalid owner_id: 00

On Wed, Aug 24, 2005 at 02:51:38PM +0400, Starikovskiy, Alexey Y wrote:
> Hi Mattia,
>=20
> Thanks for helping with this issue...
> There are can be two causes to this -- we either overwrite allocated
> owner_id (this can be checked with the WARN_ON (owner_id !=3D 0)
> in acpi_ut_allocate_owner_id -- we never copy owner_id) or we give
just
> released owner_id location instead of right one to release_owner_id
> function.

As I suspected :)

Anyway it seems to be the former, see the log (with
WARN_ON(*owner_id!=3D0) it'll hopefully give a better idea on what's
happening:
...
evgpeblk-0996 [06] ev_create_gpe_block   : Found 1 Wake, Enabled 0
Runtime GPEs in this block
Badness in acpi_ut_allocate_owner_id at
drivers/acpi/utilities/utmisc.c:70
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

here you are, with=20
	if (*owner_id!=3D0) {
		WARN_ON(1);
		return_ACPI_STATUS(1);
	}
the log is:
...
evgpeblk-0996 [06] ev_create_gpe_block   : Found 1 Wake, Enabled 0
Runtime GPEs in this block
Badness in acpi_ut_allocate_owner_id at
drivers/acpi/utilities/utmisc.c:71
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
evregion-0509 [28] ev_detach_region      : AE_ERROR from region _REG,
[PCI_Config]
Badness in acpi_ut_allocate_owner_id at
drivers/acpi/utilities/utmisc.c:71
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
evrgnini-0236: *** Error: Could not install pci_config handler for Root
Bridge PCI0, AE_ERROR
Completing Region/Field/Buffer/Package
initialization:.........................................................
.....
Initialized 20/21 Regions 0/0 Fields 25/25 Buffers 17/27 Packages (564
nodes)

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

--=20
mattia
:wq!

------_=_NextPart_001_01C5A939.CA6BD1A3
Content-Type: application/octet-stream;
	name="owner_id.patch"
Content-Transfer-Encoding: base64
Content-Description: owner_id.patch
Content-Disposition: attachment;
	filename="owner_id.patch"

ZGlmZiAtcnUgLi9kcml2ZXJzL2FjcGkvZGlzcGF0Y2hlci9kc21ldGhvZC5jIC9ob21lL2F5c3Rh
cmlrL2xpbnV4LTIuNi4xMi9kcml2ZXJzL2FjcGkvZGlzcGF0Y2hlci9kc21ldGhvZC5jCi0tLSAu
L2RyaXZlcnMvYWNwaS9kaXNwYXRjaGVyL2RzbWV0aG9kLmMJMjAwNS0wOC0yNSAxMzo0MToxNS4w
MDAwMDAwMDAgKzA0MDAKKysrIC9ob21lL2F5c3RhcmlrL2xpbnV4LTIuNi4xMi9kcml2ZXJzL2Fj
cGkvZGlzcGF0Y2hlci9kc21ldGhvZC5jCTIwMDUtMDgtMjQgMTc6NTA6MjUuMDAwMDAwMDAwICsw
NDAwCkBAIC0yOTksMTEgKzI5OSw2IEBACiAJCXJldHVybl9BQ1BJX1NUQVRVUyAoQUVfTlVMTF9P
QkpFQ1QpOwogCX0KIAotCXN0YXR1cyA9IGFjcGlfdXRfYWxsb2NhdGVfb3duZXJfaWQgKCZvYmpf
ZGVzYy0+bWV0aG9kLm93bmVyX2lkKTsKLQlpZiAoQUNQSV9GQUlMVVJFIChzdGF0dXMpKSB7Ci0J
CXJldHVybl9BQ1BJX1NUQVRVUyAoc3RhdHVzKTsKLQl9Ci0KIAkvKiBJbml0IGZvciBuZXcgbWV0
aG9kLCB3YWl0IG9uIGNvbmN1cnJlbmN5IHNlbWFwaG9yZSAqLwogCiAJc3RhdHVzID0gYWNwaV9k
c19iZWdpbl9tZXRob2RfZXhlY3V0aW9uIChtZXRob2Rfbm9kZSwgb2JqX2Rlc2MsCkBAIC0zMTIs
NiArMzA3LDEzIEBACiAJCWdvdG8gY2xlYW51cDsKIAl9CiAKKwlpZiAob2JqX2Rlc2MtPm1ldGhv
ZC50aHJlYWRfY291bnQgPT0gMSkgeworCQlzdGF0dXMgPSBhY3BpX3V0X2FsbG9jYXRlX293bmVy
X2lkICgmb2JqX2Rlc2MtPm1ldGhvZC5vd25lcl9pZCk7CisJCWlmIChBQ1BJX0ZBSUxVUkUgKHN0
YXR1cykpIHsKKwkJCXJldHVybl9BQ1BJX1NUQVRVUyAoc3RhdHVzKTsKKwkJfQorCX0KKwogCWlm
ICghKG9ial9kZXNjLT5tZXRob2QubWV0aG9kX2ZsYWdzICYgQU1MX01FVEhPRF9JTlRFUk5BTF9P
TkxZKSkgewogCQkvKiAxKSBQYXJzZTogQ3JlYXRlIGEgbmV3IHdhbGsgc3RhdGUgZm9yIHRoZSBw
cmVlbXB0aW5nIHdhbGsgKi8KIApAQCAtMzQzLDYgKzM0NSw4IEBACiAJCWFjcGlfcHNfZGVsZXRl
X3BhcnNlX3RyZWUgKG9wKTsKIAl9CiAKKwlvYmpfZGVzYy0+bWV0aG9kLnRocmVhZF9jb3VudC0t
OworCiAJLyogMikgRXhlY3V0ZTogQ3JlYXRlIGEgbmV3IHN0YXRlIGZvciB0aGUgcHJlZW1wdGlu
ZyB3YWxrICovCiAKIAluZXh0X3dhbGtfc3RhdGUgPSBhY3BpX2RzX2NyZWF0ZV93YWxrX3N0YXRl
IChvYmpfZGVzYy0+bWV0aG9kLm93bmVyX2lkLApAQCAtMzk2LDcgKzQwMCw5IEBACiAJLyogT24g
ZXJyb3IsIHdlIG11c3QgZGVsZXRlIHRoZSBuZXcgd2FsayBzdGF0ZSAqLwogCiBjbGVhbnVwOgot
CWFjcGlfdXRfcmVsZWFzZV9vd25lcl9pZCAoJm9ial9kZXNjLT5tZXRob2Qub3duZXJfaWQpOwor
CWlmICghb2JqX2Rlc2MtPm1ldGhvZC50aHJlYWRfY291bnQgJiYgb2JqX2Rlc2MtPm1ldGhvZC5v
d25lcl9pZCkgeworCQlhY3BpX3V0X3JlbGVhc2Vfb3duZXJfaWQgKCZvYmpfZGVzYy0+bWV0aG9k
Lm93bmVyX2lkKTsKKwl9CiAJaWYgKG5leHRfd2Fsa19zdGF0ZSAmJiAobmV4dF93YWxrX3N0YXRl
LT5tZXRob2RfZGVzYykpIHsKIAkJLyogRGVjcmVtZW50IHRoZSB0aHJlYWQgY291bnQgb24gdGhl
IG1ldGhvZCBwYXJzZSB0cmVlICovCiAKZGlmZiAtcnUgLi9kcml2ZXJzL2FjcGkvcGFyc2VyL3Bz
cGFyc2UuYyAvaG9tZS9heXN0YXJpay9saW51eC0yLjYuMTIvZHJpdmVycy9hY3BpL3BhcnNlci9w
c3BhcnNlLmMKLS0tIC4vZHJpdmVycy9hY3BpL3BhcnNlci9wc3BhcnNlLmMJMjAwNS0wOC0yNSAx
Mzo0MToxNS4wMDAwMDAwMDAgKzA0MDAKKysrIC9ob21lL2F5c3RhcmlrL2xpbnV4LTIuNi4xMi9k
cml2ZXJzL2FjcGkvcGFyc2VyL3BzcGFyc2UuYwkyMDA1LTA4LTI0IDE3OjUxOjMwLjAwMDAwMDAw
MCArMDQwMApAQCAtNTIzLDE0ICs1MjMsNiBAQAogCQkJfQogCQl9CiAKLQkJaWYgKHdhbGtfc3Rh
dGUtPm1ldGhvZF9kZXNjKSB7Ci0JCQkvKiBEZWNyZW1lbnQgdGhlIHRocmVhZCBjb3VudCBvbiB0
aGUgbWV0aG9kIHBhcnNlIHRyZWUgKi8KLQotCQkJaWYgKHdhbGtfc3RhdGUtPm1ldGhvZF9kZXNj
LT5tZXRob2QudGhyZWFkX2NvdW50KSB7Ci0JCQkJd2Fsa19zdGF0ZS0+bWV0aG9kX2Rlc2MtPm1l
dGhvZC50aHJlYWRfY291bnQtLTsKLQkJCX0KLQkJfQotCiAJCS8qIFdlIGFyZSBkb25lIHdpdGgg
dGhpcyB3YWxrLCBtb3ZlIG9uIHRvIHRoZSBwYXJlbnQgaWYgYW55ICovCiAKIAkJd2Fsa19zdGF0
ZSA9IGFjcGlfZHNfcG9wX3dhbGtfc3RhdGUgKHRocmVhZCk7CmRpZmYgLXJ1IC4vZHJpdmVycy9h
Y3BpL3BhcnNlci9wc3hmYWNlLmMgL2hvbWUvYXlzdGFyaWsvbGludXgtMi42LjEyL2RyaXZlcnMv
YWNwaS9wYXJzZXIvcHN4ZmFjZS5jCi0tLSAuL2RyaXZlcnMvYWNwaS9wYXJzZXIvcHN4ZmFjZS5j
CTIwMDUtMDgtMjUgMTM6NDE6MTUuMDAwMDAwMDAwICswNDAwCisrKyAvaG9tZS9heXN0YXJpay9s
aW51eC0yLjYuMTIvZHJpdmVycy9hY3BpL3BhcnNlci9wc3hmYWNlLmMJMjAwNS0wOC0yNCAxNzo1
NDozOC4wMDAwMDAwMDAgKzA0MDAKQEAgLTExNCw5ICsxMTQsMTIgQEAKIAkgKiBvYmplY3RzIChz
dWNoIGFzIE9wZXJhdGlvbiBSZWdpb25zKSBjYW4gYmUgY3JlYXRlZCBkdXJpbmcgdGhlCiAJICog
Zmlyc3QgcGFzcyBwYXJzZS4KIAkgKi8KLQlzdGF0dXMgPSBhY3BpX3V0X2FsbG9jYXRlX293bmVy
X2lkICgmaW5mby0+b2JqX2Rlc2MtPm1ldGhvZC5vd25lcl9pZCk7Ci0JaWYgKEFDUElfRkFJTFVS
RSAoc3RhdHVzKSkgewotCQlyZXR1cm5fQUNQSV9TVEFUVVMgKHN0YXR1cyk7CisKKwlpZiAoaW5m
by0+b2JqX2Rlc2MtPm1ldGhvZC50aHJlYWRfY291bnQgPT0gMSkgeworCQlzdGF0dXMgPSBhY3Bp
X3V0X2FsbG9jYXRlX293bmVyX2lkICgmaW5mby0+b2JqX2Rlc2MtPm1ldGhvZC5vd25lcl9pZCk7
CisJCWlmIChBQ1BJX0ZBSUxVUkUgKHN0YXR1cykpIHsKKwkJCXJldHVybl9BQ1BJX1NUQVRVUyAo
c3RhdHVzKTsKKwkJfQogCX0KIAogCS8qCkBAIC0xNDksOSArMTUyLDExIEBACiAJaW5mby0+cGFz
c19udW1iZXIgPSAzOwogCXN0YXR1cyA9IGFjcGlfcHNfZXhlY3V0ZV9wYXNzIChpbmZvKTsKIAor
CWluZm8tPm9ial9kZXNjLT5tZXRob2QudGhyZWFkX2NvdW50LS07CiAKIGNsZWFudXA6Ci0JaWYg
KGluZm8tPm9ial9kZXNjLT5tZXRob2Qub3duZXJfaWQpIHsKKwlpZiAoIWluZm8tPm9ial9kZXNj
LT5tZXRob2QudGhyZWFkX2NvdW50ICYmIAorCSAgICBpbmZvLT5vYmpfZGVzYy0+bWV0aG9kLm93
bmVyX2lkKSB7CiAJCWFjcGlfdXRfcmVsZWFzZV9vd25lcl9pZCAoJmluZm8tPm9ial9kZXNjLT5t
ZXRob2Qub3duZXJfaWQpOwogCX0KIApkaWZmIC1ydSAuL2RyaXZlcnMvYWNwaS91dGlsaXRpZXMv
dXRtaXNjLmMgL2hvbWUvYXlzdGFyaWsvbGludXgtMi42LjEyL2RyaXZlcnMvYWNwaS91dGlsaXRp
ZXMvdXRtaXNjLmMKLS0tIC4vZHJpdmVycy9hY3BpL3V0aWxpdGllcy91dG1pc2MuYwkyMDA1LTA4
LTI1IDEzOjQxOjE1LjAwMDAwMDAwMCArMDQwMAorKysgL2hvbWUvYXlzdGFyaWsvbGludXgtMi42
LjEyL2RyaXZlcnMvYWNwaS91dGlsaXRpZXMvdXRtaXNjLmMJMjAwNS0wOC0yNCAxNzo1NjoyMi4w
MDAwMDAwMDAgKzA0MDAKQEAgLTc0LDYgKzc0LDcgQEAKIAogCUFDUElfRlVOQ1RJT05fVFJBQ0Ug
KCJ1dF9hbGxvY2F0ZV9vd25lcl9pZCIpOwogCisJV0FSTl9PTiAoKm93bmVyX2lkKTsKIAogCS8q
IE11dGV4IGZvciB0aGUgZ2xvYmFsIElEIG1hc2sgKi8KIAo=

------_=_NextPart_001_01C5A939.CA6BD1A3--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
