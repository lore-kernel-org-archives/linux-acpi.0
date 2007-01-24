From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: make checkstack | grep acpi
Date: Tue, 23 Jan 2007 21:46:03 -0800
Message-ID: <20070123214603.a4fa0be9.randy.dunlap@oracle.com>
References: <200701232107.13296.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet02.oracle.com ([141.146.126.229]:44818 "EHLO
	agminet02.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030226AbXAXF56 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jan 2007 00:57:58 -0500
Received: from agminet01.oracle.com (agminet01.oracle.com [141.146.126.228])
	by agminet02.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id l0O5vuBZ028032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jan 2007 23:57:56 -0600
In-Reply-To: <200701232107.13296.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown L <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Tue, 23 Jan 2007 21:07:13 -0500 Len Brown L wrote:

> FYI,

Well, depending on call chains (trees), I don't see anything
here that is a problem in isolation.

Do you?

> 2.6.20-rc5, i386:
> 
> 0x00000bee asus_hotk_add [asus_acpi]:                   232
> 0x000018fc asus_hotk_add [asus_acpi]:                   232
> 0x00cf hci_raw [toshiba_acpi]:                          228
> 0x0166 hci_raw [toshiba_acpi]:                          228
> 0xc026af95 acpi_processor_write_performance [vmlinux]:  200
> 0xc026b091 acpi_processor_write_performance [vmlinux]:  200
> 0xc02695ea acpi_processor_get_power_info [vmlinux]:     160
> 0xc0269cf5 acpi_processor_get_power_info [vmlinux]:     160
> 0xc02867d0 hpet_acpi_add [vmlinux]:                     152
> 0xc0286830 hpet_acpi_add [vmlinux]:                     152
> 0xc02388c5 acpi_evaluate_reference [vmlinux]:           140
> 0xc0238c12 acpi_evaluate_reference [vmlinux]:           140
> 0xc0238c2a acpi_evaluate_integer [vmlinux]:             140
> 0xc0238e20 acpi_evaluate_integer [vmlinux]:             140
> 0xc025c89f acpi_tb_get_required_tables [vmlinux]:       132
> 0xc025ccbb acpi_tb_get_required_tables [vmlinux]:       132
> 0x0644 acpi_cpufreq_cpu_init [acpi-cpufreq]:            124
> 0x0be5 acpi_cpufreq_cpu_init [acpi-cpufreq]:            124
> 0x0000017a acpi_evalf [ibm_acpi]:                       120
> 0x00000305 acpi_evalf [ibm_acpi]:                       120
> 0x000026d1 video_write [ibm_acpi]:                      116
> 0x00002c25 video_write [ibm_acpi]:                      116
> 0xc024548c acpi_ex_load_op [vmlinux]:                   104
> 0xc024586a acpi_ex_load_op [vmlinux]:                   104
> 0x00000fb0 acpi_sbs_generate_event [sbs]:               100
> 0x00001022 acpi_sbs_generate_event [sbs]:               100
> 0x0000040c acpi_thermal_check [thermal]:                100
> 0x000007fd acpi_thermal_check [thermal]:                100
> 0x00001782 thermal_read [ibm_acpi]:                     100
> 0x00001992 thermal_read [ibm_acpi]:                     100
> 
> 
> acpi-test, x86_64
> 
> 0xffffffff8036cdb0 acpi_os_printf [vmlinux]:            216
> 0xffffffff8036cdfe acpi_os_printf [vmlinux]:            216
> 0xffffffff803905d9 acpi_ut_debug_print_raw [vmlinux]:   216
> 0xffffffff80390622 acpi_ut_debug_print_raw [vmlinux]:   216
> 0xffffffff8039063e acpi_ut_debug_print [vmlinux]:       208
> 0xffffffff80390729 acpi_ut_debug_print [vmlinux]:       208
> 0xffffffff803916f3 acpi_ut_info [vmlinux]:              208
> 0xffffffff8039174d acpi_ut_info [vmlinux]:              208
> 0xffffffff80391768 acpi_ut_warning [vmlinux]:           208
> 0xffffffff803917c7 acpi_ut_warning [vmlinux]:           208
> 0xffffffff803917e2 acpi_ut_error [vmlinux]:             208
> 0xffffffff80391841 acpi_ut_error [vmlinux]:             208
> 0xffffffff80391859 acpi_ut_exception [vmlinux]:         208
> 0xffffffff803918c9 acpi_ut_exception [vmlinux]:         208
> 0xffffffff8036d0a8 acpi_evaluate_reference [vmlinux]:   168
> 0xffffffff8036d3cc acpi_evaluate_reference [vmlinux]:   168
> 0xffffffff8039eb75 acpi_processor_get_power_info [vmlinux]:168
> 0xffffffff8039f21b acpi_processor_get_power_info [vmlinux]:168
> 0xffffffff803bb743 hpet_acpi_add [vmlinux]:             168
> 0xffffffff803bb7aa hpet_acpi_add [vmlinux]:             168
> 0xffffffff8036d3fc acpi_evaluate_integer [vmlinux]:     152
> 0xffffffff8036d5dd acpi_evaluate_integer [vmlinux]:     152
> 0xffffffff8039ffdb acpi_processor_register_performance [vmlinux]:152
> 0xffffffff803a045f acpi_processor_register_performance [vmlinux]:152
> 0x000011a5 acpi_video_bus_add [video]:                  152
> 0x00001cf2 acpi_video_bus_add [video]:                  152
> 0xffffffff8034af28 acpi_query_osc [vmlinux]:            136
> 0xffffffff8034b054 acpi_query_osc [vmlinux]:            136
> 0xffffffff8038a283 acpi_ps_get_next_namepath [vmlinux]: 136
> 0xffffffff8038a51f acpi_ps_get_next_namepath [vmlinux]: 136
> 0x015b bay_create_acpi_device [bay]:                    136
> 0x0248 bay_create_acpi_device [bay]:                    136
> 0xffffffff80387e12 acpi_ns_get_node [vmlinux]:          120
> 0xffffffff80387f39 acpi_ns_get_node [vmlinux]:          120
> 0xffffffff8039763c acpi_add_single_object [vmlinux]:    120
> 0xffffffff80398258 acpi_add_single_object [vmlinux]:    120
> 0xffffffff80374595 acpi_ds_initialize_objects [vmlinux]:104
> 0xffffffff80374773 acpi_ds_initialize_objects [vmlinux]:104
> 0xffffffff8037cd5c acpi_ex_write_with_update_rule [vmlinux]:104
> 0xffffffff8037cf0b acpi_ex_write_with_update_rule [vmlinux]:104
> 0x00d5 acpi_bay_add [bay]:                              104
> 0x0141 acpi_bay_add [bay]:                              104

---
~Randy
