From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Problem with ACPI video
Date: Thu, 04 Sep 2008 09:19:09 +0800
Message-ID: <1220491149.24775.229.camel@rzhang-dt>
References: <g9n0h0$ru8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30207 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752377AbYIDBTw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Sep 2008 21:19:52 -0400
In-Reply-To: <g9n0h0$ru8$1@ger.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luis Henriques <henrix@sapo.pt>
Cc: linux-acpi@vger.kernel.org

On Wed, 2008-09-03 at 22:45 +0100, Luis Henriques wrote:
> It seems that there is a problem with my video card.  I got the
> following message:
> 
> [...]
> 
> [   14.705248] input: Video Bus as /class/input/input4
> [   14.757151] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
> [   14.757624] proc_dir_entry 'VGA' already registered
> [   14.757673] Pid: 3093, comm: modprobe Not tainted
> 2.6.27-rc5-00006-gbef69ea #1
> [   14.757723]
> [   14.757724] Call Trace:
> [   14.757816]  [<ffffffff8032199c>] proc_register+0x1dc/0x210
> [   14.757866]  [<ffffffff80321bed>] proc_mkdir_mode+0x3d/0x60
> [   14.757913]  [<ffffffff80321c21>] proc_mkdir+0x11/0x20
> [   14.757963]  [<ffffffffa01d27cc>] acpi_video_bus_add+0x1e9/0xd55 [video]
> [   14.758011]  [<ffffffff8032cb98>] ? sysfs_do_create_link+0xc8/0x160
> [   14.758060]  [<ffffffff803bfa16>] acpi_device_probe+0x49/0x8c
> [   14.758108]  [<ffffffff803f7f02>] driver_probe_device+0xa2/0x1e0
> [   14.758156]  [<ffffffff803f80cb>] __driver_attach+0x8b/0x90
> [   14.758202]  [<ffffffff803f8040>] ? __driver_attach+0x0/0x90
> [   14.758249]  [<ffffffff803f76ab>] bus_for_each_dev+0x6b/0xa0
> [   14.758297]  [<ffffffff802c9636>] ? kmem_cache_alloc+0x86/0xc0
> [   14.758344]  [<ffffffff803f7d4c>] driver_attach+0x1c/0x20
> [   14.758391]  [<ffffffff803f6ef8>] bus_add_driver+0x1f8/0x270
> [   14.758439]  [<ffffffffa00e5000>] ? acpi_video_init+0x0/0x5e [video]
> [   14.758487]  [<ffffffff803f82b0>] driver_register+0x70/0x160
> [   14.758535]  [<ffffffffa00e5000>] ? acpi_video_init+0x0/0x5e [video]
> [   14.758582]  [<ffffffff803bfd4e>] acpi_bus_register_driver+0x3e/0x40
> [   14.758630]  [<ffffffffa00e503c>] acpi_video_init+0x3c/0x5e [video]
> [   14.758677]  [<ffffffff80209040>] _stext+0x40/0x1a0
> [   14.758726]  [<ffffffff802704cd>] sys_init_module+0xad/0x1e0
> [   14.758772]  [<ffffffff8020c62a>] system_call_fastpath+0x16/0x1b
> [   14.758818]
> [   14.768981] acpi device:29: registered as cooling_device3
> [   14.769252] input: Video Bus as /class/input/input5
> [   14.817141] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
> [   14.905143] ACPI: Battery Slot [BAT1] (battery present)
> [...]
> 
> It seems that acpi_video_bus_add function is invoked twice and, the
> second time, it fails (maybe it is supposed to be invoked twice...).
> 
There are two ACPI video bus devices both named "VGA" in the ACPI
namespace, and each of them tries to create an entry "VGA"
under /proc/acpi/video/.
that's why this message is printed out.

> Anyway, I can not tell you what was the first kernel where this problem
> occured since the laptop is new and had this problem on all kernels I
> tried (this one is Linus git-tree 2.6.27-rc5-00006-gbef69ea).
> 
> Also found out that I have two directories /proc/acpi/video/VGA/.
> 
> After looking at the code, I found the following code:
> 
>   if (!strcmp(device->pnp.bus_id, "VID")) {
>         if (instance)
>               device->pnp.bus_id[3] = '0' + instance;
>         instance ++;
>   }
> 
> in drivers/acpi/video.c.  Is this code supposed to solve a similar
> problem as the one I am facing?
> 
yes.

> Please let me know whether you need any additional information to help
> me solving this problem.
There is a patch from Matthew that should solve this problem, which has
already hit the acpi test tree.
it would be great if you can get the source code and give it a try. :)

how to get the source code:
> git-clone git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-acpi-2.6 acpi_test
> git-branch -r
> git-branch --track test origin/test
> git-checkout test

thanks,
rui

