From: Malte Doersam <malte.d-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: acpi_pci_link_check's attempt to find the _best_ irq p revents system from using ACPI irq routing
Date: Wed, 30 Apr 2003 20:36:49 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200304302036.49985.malte.d@gmx.net>
References: <D3A3AA459175A44CB5326F26DA7A189C1C3C33@orsmsx405.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <D3A3AA459175A44CB5326F26DA7A189C1C3C33-sBd4vmA9Se58QrAoInS571DQ4js95KgL@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Okay, unfortunatly there seems to be an endless loop, so it scrolled to much 
on my R31; I couldn't ready anything, so I used some busy_waits :-)

cheers Malte

These are the last lines before it enters the infinite loop (hand copied due 
to no serial port on this laptop):

     osl-0922 [37] os_isgnal_semaphore    : ----Entry
     osl-0934 [37] os_signal_semaphore    : ----Exit- AE_OK
utobject-0292 [36] ut_allocate_object_des : c13fa528 Size 28
utobject-0294 [36] ut_allocate_object_des : ----Exit- c13fa528
utobject-0131 [35] ut_create_internal_obj : ----Exit- c13fa528
 exstore-0087 [35] ex_store               : ----Entry cf704a48
 exstore-0422 [36] ex_store_object_to_nod : ----Entry c13fa528
 nsutils-0239 [37] ns_get_type            : ----Entry
 nsutils-0247 [37] ns_get_type            : ----Exit- 0000000000000011
nsobject-0263 [37] ns_get_attached_object : ----Entry cf704a48
nsobject-0278 [37] ns_get_attached_object: -----Exit- c12f23e8
 exstore-0433 [36] ex_store_object_to_nod : Storing c13fa528( Integer) into 
node cf704a48(region_field)
exstoren-0080 [37] ex_resolve_object      : ----Entry
exstoren-0152 [37] ex_resolve_object      : ----Exit- AE_OK
 exfield-0221 [37] ex_write_data_to_field : ----Entry c12f23e8
 exfield-0339 [37] ex_write_data_to_field : Obj=c12f23e8 Type=11 Buf=c13fa534 
Len=8
 exfield-0344 [37] ex_write_data_to_field : field_read: bit_len=8 byte_off=6A
 exutils-0202 [38] ex_acquire_global_lock : ----Entry
 exutils-0220 [38] ex_acquire_global_lock : ----Exit- 0000000000000000
 exfldio-0883 [38] ex_insert_into_field   : ----Entry
 exfldio-0906 [38] ex_insert_into_field   : byte_len=1, datum_len=1, 
byte_gran=1
 exfldio-0497 [39] ex_write_with_update_r : ----Entry FFFFFFFF
 exfldio-0317 [40] ex_field_datum_io      : ----Entry 00000000
 exfldio-0179 [41] ex_access_region       : ----Entry
 exfldio-0080 [42] ex_setup_region        : ----Entry 00000000
 exfldio-0145 [42] ex_setup_region        : ----Exit- AE_OK
 exfldio-0207 [41] ex_access_region       : [WRITE] Region[PCI_Config-2] 
Access 1 Base:Off 6A:0 at 000000000000006A
evregion-0240 [42] ev_adress_space_dispa  : ----Entry
nsobject-0299 [43] ns_get_secondary_objec : ----Entry cf704148
nsobject-0309 [43] ns_get_secondary_objec : ----Exit- cf704328
evregion-0320 [42] ev_address_space_dispa : Addrhandler c12ee8c8 (c01f54c1), 
Address 00000000000006A
 exutils-0127 [43] ex_exit_interpreter    : ----Entry
     osl-0922 [44] os_signal_semaphore    : ----Entry
     osl-0934 [44] os_signal_semaphore    : ----Exit- AE_OK
 exutils-0134 [43] ex_exit_interpreter    : ----Exit-
exregion-0350 [43] ex_pci_config_space_ha : ----Entry
exregion-0371 [43] ex_pci_config_space_ha : pci_config 1 (8) Seg(0000) 
Bus(0000) Dev(001f) Func(0000) Reg(006a)
   evsci-0074 [44] ex_sci_crupt_handler   : ----Entry
  hwregs-0477 [45] hw_register_read       : ----Entry
  hwregs-0560 [45] hw_register_read       : ----Exit- AE_OK
  hwregs-0477 [45] hw_register_read       : ----Entry
  hwregs-0560 [45] hw_register_read       : ----Exit- AE_OK
     osl-0734 [45] os_acquire_lock        : ----Entry
     osl-0746 [45] os_acquire_lock        : ----Exit-
     osl-0758 [45] os_release_lock        : ----Entry
     osl-0796 [45] os_release_lock        : ----Exit-
   evsci-0094 [44] ev_sci_xrupt_handler   : ----Exit- 0000000000000000
   evsci-0074 [44] ev_sci_xrupt_handler   : ----Entry
  hwregs-0477 [45] hw_register_read       : ----Entry
  hwregs-0560 [45] hw_register_read       : ----Exit- AE_OK
  hwregs-0477 [45] hw_register_read       : ----Entry
  hwregs-0560 [45] hw_register_read       : ----Exit- AE_OK
     osl-0734 [45] os_acquire_lock        : ----Entry
     osl-0746 [45] os_acquire_lock        : ----Exit-
     osl-0758 [45] os_release_lock        : ----Entry
     osl-0796 [45] os_release_lock        : ----Exit-
   evsci-0094 [44] ev_sci_xrupt_handler   : ----Exit- 0000000000000000
   evsci-0074 [44] ev_sci_xrupt_handler   : ----Entry
...
and so forth




Am Dienstag, 29. April 2003 19:14 schrieben Sie:
> if (walk_state->ascending_callback != NULL ) {
>   walk_state->op    = op;
>   walk_state->opcode = op->common.aml_opcode;
>   printk("Malte DEBUG: last seen line\n");
>
> >>> set acpi_dbg_level = 0x00FFFFFF here to enable tracing.
>
> Bob
>
>
>   status = walk_state->ascending_callback (walk_state);
>   printk("Malte DEBUG: never got to this point with IRQ9\n");
>   status = acpi_ps_next_parse_state (walk_state, op, status);
>   if (status == AE_CTRL_PENDING) {
>     status = AE_OK;
>     goto close_this_op;
>   }
> }
>


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
