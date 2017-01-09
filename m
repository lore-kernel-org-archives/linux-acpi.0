From: Borislav Petkov <bp@alien8.de>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port
 acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
 kernel
Date: Tue, 10 Jan 2017 00:52:11 +0100
Message-ID: <20170109235211.yetponvbexvalkir@pd.tnic>
References: <CAJZ5v0hxrz9os4ZpS=EHbdFp8rd7D+BU10bSyfBV-FE6UHQ6FA@mail.gmail.com>
 <CAJZ5v0idFBHG=OKRiBqvsYPgUrWQsqjTKYXfKxfdG023qsCbkw@mail.gmail.com>
 <20170108130355.vxhjmj6dlkqw6hyq@pd.tnic>
 <1AE640813FDE7649BE1B193DEA596E886CE27B7E@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CE27BEE@SHSMSX101.ccr.corp.intel.com>
 <20170109093329.jd7uwlcpci4icpd3@pd.tnic>
 <20170109221831.GC3800@linux.vnet.ibm.com>
 <20170109231501.xrhwsv46mznw3kqt@pd.tnic>
 <20170109233204.GG3800@linux.vnet.ibm.com>
 <20170109234039.mfefmv5dv4shxnfn@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:40565 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764424AbdAIXwP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Jan 2017 18:52:15 -0500
Content-Disposition: inline
In-Reply-To: <20170109234039.mfefmv5dv4shxnfn@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, J?rg R?del <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Tue, Jan 10, 2017 at 12:40:39AM +0100, Borislav Petkov wrote:
> Lemme run it.

Well, it boots but I get:

[    0.291447] ------------[ cut here ]------------
[    0.291702] WARNING: CPU: 0 PID: 1 at kernel/rcu/tree.c:3993 rcu_scheduler_starting+0x5c/0x70
[    0.292107] Modules linked in:
[    0.292277] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.10.0-rc3+ #21
[    0.292540] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.08 01/28/2016
[    0.292893] Call Trace:
[    0.293072]  ? dump_stack+0x46/0x63
[    0.293285]  ? __warn+0xec/0x110
[    0.293487]  ? rcu_scheduler_starting+0x5c/0x70
[    0.293735]  ? kernel_init_freeable+0x58/0x19a
[    0.293976]  ? rest_init+0x80/0x80
[    0.294153]  ? kernel_init+0xa/0x100
[    0.294334]  ? ret_from_fork+0x22/0x30
[    0.294525] ---[ end trace 4c0fe009ed4dc740 ]---

TBH, I like Rafael's suggestion in the other mail to stick with fixing
this in ACPI, especially this is an ACPI problem, not RCU. Well,
more or less: RCU could be taught to *not* do schedule_work() if
workqueue_init() hasn't happened yet but that's a tangential.

So, I'm going to bed. When I wake up, I want to see working fixes!

:-)))

Thanks dudes!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
