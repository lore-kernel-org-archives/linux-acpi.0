From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Another bad usage of smp_processor_id
Date: Wed, 01 Sep 2010 13:25:36 +0300
Message-ID: <1283336736.3564.0.camel@maxim-laptop>
References: <1283077579.5529.2.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36089 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505Ab0IAKZm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Sep 2010 06:25:42 -0400
Received: by bwz11 with SMTP id 11so5165113bwz.19
        for <linux-acpi@vger.kernel.org>; Wed, 01 Sep 2010 03:25:40 -0700 (PDT)
In-Reply-To: <1283077579.5529.2.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sun, 2010-08-29 at 13:26 +0300, Maxim Levitsky wrote: 
> Hi,
> 
> Now that I applied the patch that makes NMI watchdog not trigger this,
> the amount of backtraces reduced, so I finally notice that on resume:
> 
> [ 3226.997285] Back to C!
> [ 3226.997285] PM: Restoring platform NVS memory
> [ 3226.997285] CPU0: Thermal monitoring handled by SMI
> [ 3226.997285] Enabling non-boot CPUs ...
> [ 3227.000076] BUG: using smp_processor_id() in preemptible [00000000] code: pm-suspend/5185
> [ 3227.000085] caller is thermal_throttle_add_dev+0x20/0xa4
> [ 3227.000091] Pid: 5185, comm: pm-suspend Tainted: P            2.6.36-rc2+ #132
> [ 3227.000096] Call Trace:
> [ 3227.000104]  [<ffffffff811e6242>] debug_smp_processor_id+0xd2/0xf0
> [ 3227.000110]  [<ffffffff813a0174>] thermal_throttle_add_dev+0x20/0xa4
> [ 3227.000117]  [<ffffffff813a0244>] thermal_throttle_cpu_callback+0x4c/0xb7
> [ 3227.000123]  [<ffffffff81063c61>] notifier_call_chain+0x51/0x80
> [ 3227.000130]  [<ffffffff810425d2>] ? cpu_maps_update_begin+0x12/0x20
> [ 3227.000136]  [<ffffffff81063d19>] __raw_notifier_call_chain+0x9/0x10
> [ 3227.000141]  [<ffffffff8104258b>] __cpu_notify+0x1b/0x30
> [ 3227.000147]  [<ffffffff813a29d4>] _cpu_up+0x6e/0x10d
> [ 3227.000153]  [<ffffffff81396335>] enable_nonboot_cpus+0x95/0xc0
> [ 3227.000160]  [<ffffffff8107ffcc>] suspend_devices_and_enter+0x10c/0x1e0
> [ 3227.000166]  [<ffffffff810801bc>] enter_state+0x11c/0x190
> [ 3227.000172]  [<ffffffff8107f821>] state_store+0x91/0x100
> [ 3227.000179]  [<ffffffff811d7a87>] kobj_attr_store+0x17/0x20
> [ 3227.000185]  [<ffffffff8114a392>] sysfs_write_file+0xf2/0x170
> [ 3227.000192]  [<ffffffff810df658>] vfs_write+0xc8/0x190
> [ 3227.000198]  [<ffffffff810df7ff>] sys_write+0x4f/0x90
> [ 3227.000205]  [<ffffffff81002deb>] system_call_fastpath+0x16/0x1b
> [ 3227.000328] lockdep: fixing up alternatives.
> [ 3227.000332] SMP alternatives: switching to SMP code
> 
> Best regards,
> 	Maxim Levitsky
> 

ping

