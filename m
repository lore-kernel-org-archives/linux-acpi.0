From: Nick Nobody <me@nikosapi.org>
Subject: s2ram results from a toshiba portege 3110ct
Date: Sat, 23 May 2009 12:12:50 -0400
Message-ID: <200905231212.50757.me@nikosapi.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nikosapi.org ([209.123.162.110]:41397 "EHLO nikosapi.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751833AbZEWRNv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 23 May 2009 13:13:51 -0400
Received: from 76-10-138-162.dsl.teksavvy.com ([76.10.138.162] helo=nickworkstation.localnet)
	by nikosapi.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <nikosapi@nikosapi.org>)
	id 1M7tpO-0001bL-A8
	for linux-acpi@vger.kernel.org; Sat, 23 May 2009 12:12:06 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>

Hello,

I'm running ubuntu 9.04 on a 10 year old toshiba portege 3110ct and s2ram 
actually works! The laptop is not listed in the database, but here's the 
output from s2ram -i:

This machine can be identified by:
    sys_vendor   = "TOSHIBA"
    sys_product  = "PORTEGE 3110CT"
    sys_version  = "Version 1.0"
    bios_version = "Version 7.20"

Note: acpi=force has to be passed as a kernel option because the bios is quite 
old. Also, I'm not using the most recent version of the bios (v7.70) because 
it breaks booting off a cdrom for me.

The machine sleeps and wakes up by simply running "s2ram -f" but I get the 
following warning in my dmesg upon wakeup. I'm not sure if it's anything bad; 
the machine works fine despite the warning.

[  249.592803] WARNING: at 
/build/buildd/linux-2.6.28/arch/x86/mm/ioremap.c:226 
__ioremap_caller+0x251/0x2b0()              
[  249.592841] Modules linked in: lp pcmcia ppdev snd_es1968 gameport 
snd_ac97_codec ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_page_alloc 
snd_mpu401_uart snd_seq_dummy snd_seq_oss snd_seq_midi snd_rawmidi 
snd_seq_midi_event snd_seq snd_timer snd_seq_device donauboe snd psmouse 
yenta_socket pcspkr serio_raw rsrc_nonstatic soundcore irda pcmcia_core 
i2c_piix4 crc_ccitt toshiba_acpi input_polldev video output parport_pc parport 
e100 mii floppy fbcon tileblit font bitblit softcursor        
[  249.593302] Pid: 832, comm: ktoshkeyd Tainted: G        W  2.6.28-11-
generic #42-Ubuntu                                  
[  249.593336] Call Trace:                                                                                                  
[  249.593429]  [<c0500ac6>] ? printk+0x18/0x1a                                                                             
[  249.593493]  [<c0139b24>] warn_on_slowpath+0x54/0x80                                                                     
[  249.593559]  [<c0370020>] ? scsi_nl_rcv_msg+0xf0/0x1a0                                                                   
[  249.593609]  [<c0500ac6>] ? printk+0x18/0x1a                                                                             
[  249.593653]  [<c013feaf>] ? iomem_map_sanity_check+0xdf/0xf0                                                             
[  249.593709]  [<c0123d91>] __ioremap_caller+0x251/0x2b0                                                                   
[  249.593783]  [<c0123f06>] ioremap_nocache+0x16/0x20                                                                      
[  249.593863]  [<c04f2755>] ? acpi_os_map_memory+0x11/0x1a                                                                 
[  249.593910]  [<c04f2755>] acpi_os_map_memory+0x11/0x1a                                                                   
[  249.593991]  [<c0303500>] acpi_ex_system_memory_space_handler+0xd7/0x207                                                 
[  249.594043]  [<c0303429>] ? acpi_ex_system_memory_space_handler+0x0/0x207                                                
[  249.594094]  [<c02fcac5>] acpi_ev_address_space_dispatch+0x12f/0x16f                                                     
[  249.594145]  [<c0300880>] acpi_ex_access_region+0x3c/0x98                                                                
[  249.594193]  [<c03009f3>] acpi_ex_field_datum_io+0x117/0x1ae                                                             
[  249.594244]  [<c0300d41>] acpi_ex_write_with_update_rule+0xd5/0xde                                                       
[  249.594295]  [<c0300edb>] acpi_ex_insert_into_field+0x191/0x2c2                                                          
[  249.594355]  [<c0305a35>] ? acpi_ns_search_one_scope+0x15/0x3a                                                           
[  249.594406]  [<c02ff699>] acpi_ex_write_data_to_field+0x169/0x181                                                        
[  249.594456]  [<c03036b2>] acpi_ex_store_object_to_node+0x82/0xb7                                                         
[  249.594505]  [<c0303963>] acpi_ex_store+0x9f/0xf4                                                                        
[  249.594550]  [<c03018d8>] acpi_ex_opcode_1A_1T_1R+0x3d9/0x533                                                            
[  249.594599]  [<c0301fff>] ? acpi_ex_resolve_operands+0x18f/0x434                                                         
[  249.594682]  [<c02fa2c6>] acpi_ds_exec_end_op+0xe6/0x370                                                                 
[  249.594737]  [<c03092bb>] acpi_ps_parse_loop+0x24a/0x2a7                                                                 
[  249.594781]  [<c0308554>] acpi_ps_parse_aml+0x6d/0x267                                                                   
[  249.594828]  [<c0309845>] acpi_ps_execute_method+0x11c/0x1d3                                                             
[  249.594880]  [<c0306400>] acpi_ns_evaluate+0x11c/0x1e4                                                                   
[  249.594930]  [<c0305f9d>] acpi_evaluate_object+0xdd/0x1bc                                                                
[  249.595029]  [<c6913163>] hci_raw+0x60/0x98 [toshiba_acpi]                                                               
[  249.595101]  [<c012ad96>] ? dequeue_entity+0x16/0x2a0                                                                    
[  249.595146]  [<c01320f8>] ? dequeue_task_fair+0x68/0x70                                                                  
[  249.595190]  [<c012888f>] ? dequeue_task+0xcf/0x130                                                                      
[  249.595237]  [<c0102ab7>] ? __switch_to+0xb7/0x1a0                                                                       
[  249.595292]  [<c012f9cb>] ? finish_task_switch+0x2b/0xe0                                                                 
[  249.595362]  [<c69131d8>] hci_read1+0x3d/0x5b [toshiba_acpi]                                                             
[  249.595422]  [<c0143db0>] ? process_timeout+0x0/0x10                                                                     
[  249.595467]  [<c05016da>] ? schedule_timeout+0x7a/0xe0                                                                   
[  249.595536]  [<c6913b35>] toshiba_acpi_thread+0xf5/0x180 [toshiba_acpi]                                                  
[  249.595604]  [<c6913a40>] ? toshiba_acpi_thread+0x0/0x180 [toshiba_acpi]                                                 
[  249.595664]  [<c0105477>] kernel_thread_helper+0x7/0x10                                                                  
[  249.595696] ---[ end trace 4eaa2a86a8e2da22 ]---                                                                         
[  249.596058] resource map sanity check conflict: 0x100b6800 0x100b77ff 
0x100a0000 0x100b6dff reserved                  
