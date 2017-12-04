From: "Cherian, George" <George.Cherian@cavium.com>
Subject: Re: KASAN: global-out-of-bounds in cppc_get_perf_caps+0xf3/0x3b0
Date: Mon, 4 Dec 2017 14:07:28 +0000
Message-ID: <CY1PR0701MB1709D330F584CB93BF815DA5F93C0@CY1PR0701MB1709.namprd07.prod.outlook.com>
References: <20171204101944.ppktvwcuf2md6kzt@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-by2nam03on0062.outbound.protection.outlook.com ([104.47.42.62]:24864
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754132AbdLDOHa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 Dec 2017 09:07:30 -0500
In-Reply-To: <20171204101944.ppktvwcuf2md6kzt@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Du, Changbin" <changbin.du@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Changbin,

Thanks for pointing it out.
I have sent out a fix for the same.

Regards,
-George

________________________________________
From: Du, Changbin <changbin.du@intel.com>
Sent: Monday, December 4, 2017 3:49:45 PM
To: Cherian, George
Cc: changbin.du@intel.com; linux-acpi@vger.kernel.org; linux-kernel@vger.ke=
rnel.org
Subject: BUG: KASAN: global-out-of-bounds in cppc_get_perf_caps+0xf3/0x3b0

Hi Cherian,
Your patch 'ACPI / CPPC: Make CPPC ACPI driver aware of PCC subspace IDs'
introduced a out-of-bounds BUG in kernel. The code need to check
cpu_pcc_subspace_idx before use it since it can be -1. Thanks.

[   15.113449] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   15.116983] BUG: KASAN: global-out-of-bounds in cppc_get_perf_caps+0xf3/=
0x3b0
[   15.116983] Read of size 8 at addr ffffffffb9a5c0d8 by task swapper/0/1

[   15.116983] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc2+ #2
[   15.116983] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.2.8 01=
/26/2016
[   15.116983] Call Trace:
[   15.116983]  dump_stack+0x7c/0xbb
[   15.116983]  print_address_description+0x1df/0x290
[   15.116983]  kasan_report+0x28a/0x370
[   15.116983]  ? cppc_get_perf_caps+0xf3/0x3b0
[   15.116983]  cppc_get_perf_caps+0xf3/0x3b0
[   15.116983]  ? cpc_read+0x210/0x210
[   15.116983]  ? __rdmsr_on_cpu+0x90/0x90
[   15.116983]  ? rdmsrl_on_cpu+0xa9/0xe0
[   15.116983]  ? rdmsr_on_cpu+0x100/0x100
[   15.116983]  ? wrmsrl_on_cpu+0x9c/0xd0
[   15.116983]  ? wrmsrl_on_cpu+0x9c/0xd0
[   15.116983]  ? wrmsr_on_cpu+0xe0/0xe0
[   15.116983]  __intel_pstate_cpu_init.part.16+0x3a2/0x530
[   15.116983]  ? intel_pstate_init_cpu+0x197/0x390
[   15.116983]  ? show_no_turbo+0xe0/0xe0
[   15.116983]  ? __lockdep_init_map+0xa0/0x290
[   15.116983]  intel_pstate_cpu_init+0x30/0x60
[   15.116983]  cpufreq_online+0x155/0xac0
[   15.116983]  cpufreq_add_dev+0x9b/0xb0
[   15.116983]  subsys_interface_register+0x1ae/0x290
[   15.116983]  ? bus_unregister_notifier+0x40/0x40
[   15.116983]  ? mark_held_locks+0x83/0xb0
[   15.116983]  ? _raw_write_unlock_irqrestore+0x32/0x60
[   15.116983]  ? intel_pstate_setup+0xc/0x104
[   15.116983]  ? intel_pstate_setup+0xc/0x104
[   15.116983]  ? cpufreq_register_driver+0x1ce/0x2b0
[   15.116983]  cpufreq_register_driver+0x1ce/0x2b0
[   15.116983]  ? intel_pstate_setup+0x104/0x104
[   15.116983]  intel_pstate_register_driver+0x3a/0xa0
[   15.116983]  intel_pstate_init+0x3c4/0x434
[   15.116983]  ? intel_pstate_setup+0x104/0x104
[   15.116983]  ? intel_pstate_setup+0x104/0x104
[   15.116983]  do_one_initcall+0x9c/0x206
[   15.116983]  ? parameq+0xa0/0xa0
[   15.116983]  ? initcall_blacklisted+0x150/0x150
[   15.116983]  ? lock_downgrade+0x2c0/0x2c0
[   15.116983]  kernel_init_freeable+0x327/0x3f0
[   15.116983]  ? start_kernel+0x612/0x612
[   15.116983]  ? _raw_spin_unlock_irq+0x29/0x40
[   15.116983]  ? finish_task_switch+0xdd/0x320
[   15.116983]  ? finish_task_switch+0x8e/0x320
[   15.116983]  ? rest_init+0xd0/0xd0
[   15.116983]  kernel_init+0xf/0x11a
[   15.116983]  ? rest_init+0xd0/0xd0
[   15.116983]  ret_from_fork+0x24/0x30

[   15.116983] The buggy address belongs to the variable:
[   15.116983]  __key.36299+0x38/0x40

[   15.116983] Memory state around the buggy address:
[   15.116983]  ffffffffb9a5bf80: fa fa fa fa 00 fa fa fa fa fa fa fa 00 fa=
 fa fa
[   15.116983]  ffffffffb9a5c000: fa fa fa fa 00 fa fa fa fa fa fa fa 00 fa=
 fa fa
[   15.116983] >ffffffffb9a5c080: fa fa fa fa 00 fa fa fa fa fa fa fa 00 00=
 00 00
[   15.116983]                                                     ^
[   15.116983]  ffffffffb9a5c100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00
[   15.116983]  ffffffffb9a5c180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00
[   15.116983] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--
Thanks,
Changbin Du
