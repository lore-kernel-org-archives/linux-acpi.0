From: keith mannthey <kmannth@us.ibm.com>
Subject: Re: [Lhms-devel] [RFC] Patch [1/2] for acpi_memhotplug.c
Date: Wed, 21 Jun 2006 16:23:47 -0700
Message-ID: <1150932228.9235.6.camel@keithlap>
References: <971FCB6690CD0E4898387DBF7552B90E0378BEE7@orsmsx403.amr.corp.intel.com>
	 <437F1766.8090705@jp.fujitsu.com> <1150853300.5873.49.camel@keithlap>
	 <20060621114334.1b954854.kamezawa.hiroyu@jp.fujitsu.com>
	 <1150863525.7865.6.camel@keithlap>
	 <20060621194832.37124aae.kamezawa.hiroyu@jp.fujitsu.com>
	 <1150915426.5830.21.camel@keithlap>
Reply-To: kmannth@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:15803 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751484AbWFUXXu
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Jun 2006 19:23:50 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5LNNodq016456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2006 19:23:50 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5LNNQPI285112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2006 17:23:26 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5LNNnvq019796
	for <linux-acpi@vger.kernel.org>; Wed, 21 Jun 2006 17:23:50 -0600
In-Reply-To: <1150915426.5830.21.camel@keithlap>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Prarit Bhargava--redhat <prarit@redhat.com>, linux acpi <linux-acpi@vger.kernel.org>, lhms-devel <lhms-devel@lists.sourceforge.net>, konrad <darnok@us.ibm.com>, robert.moore@intel.com

On Wed, 2006-06-21 at 11:43 -0700, keith mannthey wrote: 
> On Wed, 2006-06-21 at 19:48 +0900, KAMEZAWA Hiroyuki wrote:
> > On Tue, 20 Jun 2006 21:18:45 -0700
> > keith mannthey <kmannth@us.ibm.com> wrote:
> > 
> > > On Wed, 2006-06-21 at 11:43 +0900, KAMEZAWA Hiroyuki wrote:
> > > > On Tue, 20 Jun 2006 18:28:19 -0700
> > > > keith mannthey <kmannth@us.ibm.com> wrote: 
> > > > > 1. The current driver is unable to created the mem_device from the hot-
> > > > > add event and the hot-add fails with out adding any memory to the
> > > > > system. I have address_resources attached to the acpi handle but in
> > > > > acpi_memory_get_device calling the path of 
> > > > > 
> > > > > acpi_bus_get_device
> > > > > acpi_get_parent
> > > > > acpi_bus_get_device /*for parent*/
> > > > > acpi_bus_add /*to created the memory device */
> > > > > 
> > > > 
> > > > Do you know where it fails ? 

Update.  I have moved to 2.6.17-rc6-mm2 to work with the development
acpi_memhotplug driver there. I have added various debug statements and
this is what I know. 

  acpi_memory_get_device calls acpi_bus_add
  acpi_bus_add calls acpi_add_single_object (fails)
  acpi_add_single_object passes acpi_bus_get_flags
				finds the device present
				passes acpi_device_set_context
				calls acpi_device_register
				after calling acpi_bus_find_driver
				ends up 
				if (!result) *child = device;
				and returns. 
   
  I do know know much of the call path of what acpi_bus_scan called from
acpi_bus_add does but the result from acpi_bus_add  is not an
ACPI_FAILURE. There is still no memory_device attached to the device and
the same condition occurs (no memory_device added). 

I patched 2.6.17-rc6-mm2 with my patch to check out the rest of the
driver and the system Oopsed. Calling acpi_memory_get_resource caused a
panic (where as this call structure in the non -mm driver works). 
  
Unable to handle kernel NULL pointer dereference at 0000000000000000
RIP:
 [<ffffffff80345bf8>] acpi_memory_get_resource+0x5b/0xdb
PGD 0
Oops: 0000 [2] SMP
last sysfs file: /devices/pci0000:00/0000:00:01.0/resource
CPU 1
Modules linked in: xt_pkttype ipt_LOG xt_limit acpi_cpufreq freq_table
button battery ac ip6t_REJECT xt_tcpudp ipt_REJECT xt_state
iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle
ip_conntrack nfnetlink ip_tables ip6table_filter ip6_tables x_tables
ipv6 loop dm_mod tg3 reiserfs edd fan thermal processor sg ips aacraid
serverworks sd_mod scsi_mod ide_disk ide_core
Pid: 4282, comm: kacpid_notify Not tainted 2.6.17-rc6-mm2-smp #10
RIP: 0010:[<ffffffff80345bf8>]  [<ffffffff80345bf8>]
acpi_memory_get_resource+0x5b/0xdb
RSP: 0018:ffff81017b44dda8  EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffffffff8040b040 RSI: 0000000200000000 RDI: ffff81017b440001
RBP: ffff81017e0f4580 R08: ffff81017b440000 R09: ffffffff8042983e
R10: ffff81017f6044c0 R11: ffffffff8042a921 R12: ffffffff80428e41
R13: ffff81017ff8cc5c R14: ffffffff80345b9d R15: ffff81017e0f4580
FS:  0000000000000000(0000) GS:ffff81017fcb1ac0(0000)
knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000201000 CR4: 00000000000006e0
Process kacpid_notify (pid: 4282, threadinfo ffff81017b44c000, task
ffff81017d1957d0)
Stack:  0000010101000000 0000000000000000 0000020000000000
0000027fffffff00
 0000000000000000 0000008000000000 0000000000000000 ffffffff00000000
 ffff81017fc74240 ffff81017ff8cbc0
Call Trace:
 [<ffffffff803348c2>] acpi_walk_resources+0xf3/0x152
 [<ffffffff8024402d>] keventd_create_kthread+0x0/0x61
 [<ffffffff803453b2>] acpi_memory_get_device_resources+0x22/0x50
 [<ffffffff80345930>] acpi_memory_device_notify+0x1c5/0x3ef
 [<ffffffff8032ce3d>] acpi_get_data+0x5d/0x6e
 [<ffffffff8031379b>] acpi_os_execute_thread+0x0/0x1e
 [<ffffffff8031379b>] acpi_os_execute_thread+0x0/0x1e
 [<ffffffff8031d5ce>] acpi_ev_notify_dispatch+0x5c/0x65
 [<ffffffff803137aa>] acpi_os_execute_thread+0xf/0x1e
 [<ffffffff8024417a>] kthread+0xec/0x120
 [<ffffffff8020a122>] child_rip+0x8/0x12
 [<ffffffff8024402d>] keventd_create_kthread+0x0/0x61
 [<ffffffff8024408e>] kthread+0x0/0x120
 [<ffffffff8020a11a>] child_rip+0x0/0x12


Code: 48 8b 0b 0f 18 09 48 8d 45 10 48 39 c3 75 d1 48 8b 3d 52 1b
RIP  [<ffffffff80345bf8>] acpi_memory_get_resource+0x5b/0xdb
 RSP <ffff81017b44dda8>
CR2: 0000000000000000



-- 
keith mannthey <kmannth@us.ibm.com>
Linux Technology Center IBM

