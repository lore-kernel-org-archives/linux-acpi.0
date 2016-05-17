From: Augusto Mecking Caringi <augustocaringi@gmail.com>
Subject: ACPI related warnings during boot
Date: Tue, 17 May 2016 15:14:55 -0300
Message-ID: <CADFy_4H1B2g0WL0hdStrFSxeAwVQdGpj7bBuC7xUng3tt6qgzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:33344 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbcEQSO5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 May 2016 14:14:57 -0400
Received: by mail-vk0-f47.google.com with SMTP id z184so30842393vkg.0
        for <linux-acpi@vger.kernel.org>; Tue, 17 May 2016 11:14:56 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

    After I've upgraded to the latest kernel (4.6), I'm getting some
ACPI related warnings during startup like that:

[ 5897.966583] WARNING: CPU: 0 PID: 8240 at
drivers/cpufreq/cpufreq.c:2173 cpufreq_update_policy+0xcf/0xf0
[ 5897.966586] Modules linked in: iptable_nat nf_nat_ipv4 nf_nat
x86_pkg_temp_thermal apple_gmux
[ 5897.966589] CPU: 0 PID: 8240 Comm: kworker/0:1 Not tainted
4.6.0-00442-gcf6ed9a #13
[ 5897.966589] Hardware name: Apple Inc.
MacBookPro8,1/Mac-94245B3640C91C81, BIOS
MBP81.88Z.0047.B27.1201241646 01/24
/12
[ 5897.966593] Workqueue: kacpi_notify acpi_os_execute_deferred
[ 5897.966595]  0000000000000000 ffff8800347b3ba8 ffffffff8153d118
0000000000000000
[ 5897.966596]  0000000000000000 ffff8800347b3be8 ffffffff810a9b06
0000087d810e4eb2
[ 5897.966598]  ffff880169384a00 00000000fffffffb ffff880169384b10
0000000000000000
[ 5897.966598] Call Trace:
[ 5897.966602]  [<ffffffff8153d118>] dump_stack+0x4d/0x65
[ 5897.966604]  [<ffffffff810a9b06>] __warn+0xc6/0xe0
[ 5897.966606]  [<ffffffff810a9bd8>] warn_slowpath_null+0x18/0x20
[ 5897.966607]  [<ffffffff8189ba3f>] cpufreq_update_policy+0xcf/0xf0
[ 5897.966608]  [<ffffffff8189ba60>] ? cpufreq_update_policy+0xf0/0xf0
[ 5897.966611]  [<ffffffff815d28a6>] acpi_processor_ppc_has_changed+0x6f/0x77
[ 5897.966614]  [<ffffffff815cf96f>] acpi_processor_notify+0x51/0xdc
[ 5897.966616]  [<ffffffff815b5468>] acpi_ev_notify_dispatch+0x3f/0x57
[ 5897.966617]  [<ffffffff815a0b32>] acpi_os_execute_deferred+0xf/0x1b
[ 5897.966620]  [<ffffffff810c0d98>] process_one_work+0x158/0x470
[ 5897.966621]  [<ffffffff810c10f3>] worker_thread+0x43/0x4d0
[ 5897.966623]  [<ffffffff810c10b0>] ? process_one_work+0x470/0x470
[ 5897.966625]  [<ffffffff810c6404>] kthread+0xc4/0xe0
[ 5897.966628]  [<ffffffff81b47412>] ret_from_fork+0x22/0x40
[ 5897.966630]  [<ffffffff810c6340>] ? kthread_worker_fn+0x160/0x160
[ 5897.966631] ---[ end trace f45cd8737fc1698b ]---

    This message appears 6 times at each boot.

    Are they normal? Maybe wrong ACPI kernel options configured?

    Thanks,

-- 
Augusto Mecking Caringi
