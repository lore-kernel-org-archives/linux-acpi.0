From: Len Brown <lenb@kernel.org>
Subject: Re: acpi_battery_init() boot speed
Date: Thu, 16 Dec 2010 23:31:18 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012162329360.20940@x980>
References: <alpine.LFD.2.00.1012150308260.4878@x980>
 <20101215030054.0aae9e1e@infradead.org>
 <alpine.LFD.2.00.1012151517090.21167@x980>
 <20101215205845.3e13fad2@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:49493 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab0LQEbY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Dec 2010 23:31:24 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LDK00BG61W8X824@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 16 Dec 2010 22:31:21 -0600 (CST)
In-reply-to: <20101215205845.3e13fad2@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-acpi@vger.kernel.org


> make it a module, and run "perf top" while in an other terminal you do
> 
> while :; do modprobe acpi_battery ; rmmod acpi_battery  ; done

----------------------------------------------------------------------
   PerfTop:     747 irqs/sec  kernel:94.5%  exact:  0.0% [1000Hz cycles],  
(all, 2 CPUs)
----------------------------------------------------------------------

             samples  pcnt function            DSO
             _______ _____ ___________________ _______________________

             2502.00 28.4% intel_idle          [kernel.kallsyms]      
              802.00  9.1% acpi_os_read_port   [kernel.kallsyms]      
              735.00  8.4% read_hpet           [kernel.kallsyms]      
              559.00  6.4% check_poison_obj    [kernel.kallsyms]      
              286.00  3.3% acpi_ec_gpe_handler [kernel.kallsyms]      
              208.00  2.4% cache_free_debugche [kernel.kallsyms]      
              200.00  2.3% cache_alloc_debugch [kernel.kallsyms]      
              169.00  1.9% kmem_cache_alloc    [kernel.kallsyms]      
              138.00  1.6% acpi_debug_print    [kernel.kallsyms]      
               90.00  1.0% hpet_next_event     [kernel.kallsyms]      
               88.00  1.0% kmem_cache_free     [kernel.kallsyms]      
               83.00  0.9% acpi_os_write_port  [kernel.kallsyms]      
               74.00  0.8% acpi_ps_parse_loop  [kernel.kallsyms]      
               72.00  0.8% find_busiest_group  [kernel.kallsyms]      
               72.00  0.8% schedule            [kernel.kallsyms]      
               58.00  0.7% _raw_spin_lock_irqs [kernel.kallsyms]      
               58.00  0.7% acpi_ps_get_opcode_ [kernel.kallsyms]      
               56.00  0.6% advance_transaction [kernel.kallsyms]      
               54.00  0.6% menu_select         [kernel.kallsyms]      
               52.00  0.6% __might_sleep       [kernel.kallsyms]      
               47.00  0.5% ktime_get           [kernel.kallsyms]      
               41.00  0.5% __virt_addr_valid   [kernel.kallsyms]      
               38.00  0.4% start_transaction   [kernel.kallsyms]      
               38.00  0.4% acpi_ec_transaction [kernel.kallsyms]      
               36.00  0.4% dbg_redzone2        [kernel.kallsyms]      
               36.00  0.4% _raw_spin_unlock_ir [kernel.kallsyms]      
               35.00  0.4% tick_nohz_stop_sche [kernel.kallsyms]      
               33.00  0.4% acpi_ps_complete_op [kernel.kallsyms]      
               32.00  0.4% sched_clock         [kernel.kallsyms]      
               32.00  0.4% getnstimeofday      [kernel.kallsyms]      
               32.00  0.4% __switch_to         [kernel.kallsyms]      
               31.00  0.4% acpi_ds_exec_end_op [kernel.kallsyms]      
               31.00  0.4% ec_check_ibf0       [kernel.kallsyms]      
               31.00  0.4% irq_entries_start   [kernel.kallsyms]      
               30.00  0.3% acpi_hw_read        [kernel.kallsyms]      
               30.00  0.3% acpi_ev_gpe_detect  [kernel.kallsyms]      
               29.00  0.3% acpi_ec_transaction [kernel.kallsyms]      
               28.00  0.3% acpi_ut_update_obje [kernel.kallsyms]      
               27.00  0.3% acpi_ut_update_ref_ [kernel.kallsyms]      
               26.00  0.3% acpi_hw_validate_io [kernel.kallsyms]      
               25.00  0.3% acpi_hw_read_port   [kernel.kallsyms]      
               24.00  0.3% find_symbol_in_sect [kernel.kallsyms]      
               24.00  0.3% __GI___strcmp_ssse3 /lib64/libc-2.12.90.so 
               23.00  0.3% __phys_addr         [kernel.kallsyms]      
               23.00  0.3% acpi_ex_resolve_ope [kernel.kallsyms]      
               21.00  0.2% select_task_rq_fair [kernel.kallsyms]      
               21.00  0.2% acpi_hw_validate_re [kernel.kallsyms]      
               21.00  0.2% enqueue_task_fair   [kernel.kallsyms]      
               20.00  0.2% cpuidle_idle_call   [kernel.kallsyms]      
               19.00  0.2% find_next_bit       [kernel.kallsyms]      
               19.00  0.2% ns_to_timeval       [kernel.kallsyms]      
               19.00  0.2% _raw_spin_lock      [kernel.kallsyms]      
               19.00  0.2% acpi_ut_allocate_ob [kernel.kallsyms]      
               19.00  0.2% acpi_ut_create_gene [kernel.kallsyms]      
               19.00  0.2% g_hash_table_lookup libglib-2.0.so.0.2600.0
               18.00  0.2% sched_clock_local   [kernel.kallsyms] 
