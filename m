From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port
 acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
 kernel
Date: Mon, 9 Jan 2017 21:51:29 -0800
Message-ID: <20170110055129.GK3800@linux.vnet.ibm.com>
References: <1AE640813FDE7649BE1B193DEA596E886CE27BEE@SHSMSX101.ccr.corp.intel.com>
 <20170109093329.jd7uwlcpci4icpd3@pd.tnic>
 <20170109221831.GC3800@linux.vnet.ibm.com>
 <20170109231501.xrhwsv46mznw3kqt@pd.tnic>
 <20170109233204.GG3800@linux.vnet.ibm.com>
 <20170109234039.mfefmv5dv4shxnfn@pd.tnic>
 <20170109235211.yetponvbexvalkir@pd.tnic>
 <CAJZ5v0gRYcC5fJZF207iyehvPR9_2zqprSvWHA_Qt93W9njqAw@mail.gmail.com>
 <20170110022338.GJ3800@linux.vnet.ibm.com>
 <1AE640813FDE7649BE1B193DEA596E886CE286C3@SHSMSX101.ccr.corp.intel.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754232AbdAJFvg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Jan 2017 00:51:36 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id v0A5nDCg027478
        for <linux-acpi@vger.kernel.org>; Tue, 10 Jan 2017 00:51:35 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 27vkf6c0uw-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-acpi@vger.kernel.org>; Tue, 10 Jan 2017 00:51:35 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-acpi@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Jan 2017 22:51:34 -0700
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CE286C3@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, J?rg R?del <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Tue, Jan 10, 2017 at 05:41:45AM +0000, Zheng, Lv wrote:
> Hi, Rafael and Paul
> 
> > From: Paul E. McKenney [mailto:paulmck@linux.vnet.ibm.com]
> > Subject: Re: 174cc7187e6f ACPICA: Tables: Back port acpi_get_table_with_size() and
> > early_acpi_os_unmap_memory() from Linux kernel
> > 
> > On Tue, Jan 10, 2017 at 02:27:16AM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Jan 10, 2017 at 12:52 AM, Borislav Petkov <bp@alien8.de> wrote:
> > > > On Tue, Jan 10, 2017 at 12:40:39AM +0100, Borislav Petkov wrote:
> > > >> Lemme run it.
> > > >
> > > > Well, it boots but I get:
> > > >
> > > > [    0.291447] ------------[ cut here ]------------
> > > > [    0.291702] WARNING: CPU: 0 PID: 1 at kernel/rcu/tree.c:3993 rcu_scheduler_starting+0x5c/0x70
> > > > [    0.292107] Modules linked in:
> > > > [    0.292277] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.10.0-rc3+ #21
> > > > [    0.292540] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.08 01/28/2016
> > > > [    0.292893] Call Trace:
> > > > [    0.293072]  ? dump_stack+0x46/0x63
> > > > [    0.293285]  ? __warn+0xec/0x110
> > > > [    0.293487]  ? rcu_scheduler_starting+0x5c/0x70
> > > > [    0.293735]  ? kernel_init_freeable+0x58/0x19a
> > > > [    0.293976]  ? rest_init+0x80/0x80
> > > > [    0.294153]  ? kernel_init+0xa/0x100
> > > > [    0.294334]  ? ret_from_fork+0x22/0x30
> > > > [    0.294525] ---[ end trace 4c0fe009ed4dc740 ]---
> > > >
> > > > TBH, I like Rafael's suggestion in the other mail to stick with fixing
> > > > this in ACPI, especially this is an ACPI problem, not RCU. Well,
> > > > more or less: RCU could be taught to *not* do schedule_work() if
> > > > workqueue_init() hasn't happened yet but that's a tangential.
> > > >
> > > > So, I'm going to bed. When I wake up, I want to see working fixes!
> > > >
> > > > :-)))
> > >
> > > Well, if the https://patchwork.kernel.org/patch/9504277/ patch from Lv
> > > worked, the attached one should work too (please test), but it can be
> > > justified in a slightly more convincing way.
> > >
> > > Namely, the idea is that acpi_os_read/write_memory() should never be
> > > used before invoking acpi_os_initialize() and since those are the only
> > > places where the list of memory regions is walked under RCU without
> > > extra locking, it is safe to skip the RCU synchronization until that
> > > happens.
> > >
> > > Thanks,
> > > Rafael
> > 
> > Makes sense to me!
> 
> Also looks good to me.
> 
> > 
> > It looks like I can make the grace-period-free boot-time window
> > for CONFIG_PREEMPT=y kernels quite a bit narrower, but it does not
> > look like something suitable for jamming into 4.10.
> 
> OK, we can have this fixed in ACPI layer first.

Definitely.

I have the RCU changes written in ink on paper and they definitely are
-not- something that goes into 4.10.  4.11 at the earliest, and if no
one asks for it in 4.11, it goes into 4.12.  Serious testing needed.  ;-)

							Thanx, Paul

> Thanks
> Lv
> 
> > 
> > 							Thanx, Paul
> > 
> > > ---
> > >  drivers/acpi/osl.c |    8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > Index: linux-pm/drivers/acpi/osl.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/acpi/osl.c
> > > +++ linux-pm/drivers/acpi/osl.c
> > > @@ -378,7 +378,9 @@ static void acpi_os_drop_map_ref(struct
> > >  static void acpi_os_map_cleanup(struct acpi_ioremap *map)
> > >  {
> > >  	if (!map->refcount) {
> > > -		synchronize_rcu_expedited();
> > > +		if (acpi_os_initialized)
> > > +			synchronize_rcu_expedited();
> > > +
> > >  		acpi_unmap(map->phys, map->virt);
> > >  		kfree(map);
> > >  	}
> > > @@ -671,6 +673,8 @@ acpi_os_read_memory(acpi_physical_addres
> > >  	bool unmap = false;
> > >  	u64 dummy;
> > >
> > > +	WARN_ON_ONCE(!acpi_os_initialized);
> > > +
> > >  	rcu_read_lock();
> > >  	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
> > >  	if (!virt_addr) {
> > > @@ -716,6 +720,8 @@ acpi_os_write_memory(acpi_physical_addre
> > >  	unsigned int size = width / 8;
> > >  	bool unmap = false;
> > >
> > > +	WARN_ON_ONCE(!acpi_os_initialized);
> > > +
> > >  	rcu_read_lock();
> > >  	virt_addr = acpi_map_vaddr_lookup(phys_addr, size);
> > >  	if (!virt_addr) {
> 

