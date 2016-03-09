From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RESEND PATCH 1/2] device property: fwnode->secondary may contain ERR_PTR(-ENODEV)
Date: Wed, 09 Mar 2016 01:31:56 +0100
Message-ID: <16195699.4mKm5NeTHv@vostro.rjw.lan>
References: <1457444677-25645-1-git-send-email-heikki.krogerus@linux.intel.com> <1457444677-25645-2-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56060 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750902AbcCIAaG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2016 19:30:06 -0500
In-Reply-To: <1457444677-25645-2-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, John Youn <John.Youn@synopsys.com>, linux-acpi@vger.kernel.org

On Tuesday, March 08, 2016 03:44:36 PM Heikki Krogerus wrote:
> This fixes BUG that is trickered when fwnode->secondary is not null,
> but has ERR_PTR(-ENODEV) instead.
> 
> BUG: unable to handle kernel paging request at ffffffffffffffed
> IP: [<ffffffff81677b86>] __fwnode_property_read_string+0x26/0x160
> PGD 200e067 PUD 2010067 PMD 0
> Oops: 0000 [#1] SMP KASAN
> Modules linked in: dwc3_pci(+) dwc3
> CPU: 0 PID: 1138 Comm: modprobe Not tainted 4.5.0-rc5+ #61
> task: ffff88015aaf5b00 ti: ffff88007b958000 task.ti: ffff88007b958000
> RIP: 0010:[<ffffffff81677b86>]  [<ffffffff81677b86>] __fwnode_property_read_string+0x26/0x160
> RSP: 0018:ffff88007b95eff8  EFLAGS: 00010246
> RAX: fffffbfffffffffd RBX: ffffffffffffffed RCX: ffff88015999cd37
> RDX: dffffc0000000000 RSI: ffffffff81e11bc0 RDI: ffffffffffffffed
> RBP: ffff88007b95f020 R08: 0000000000000000 R09: 0000000000000000
> R10: ffff88007b90f7cf R11: 0000000000000000 R12: ffff88007b95f0a0
> R13: 00000000fffffffa R14: ffffffff81e11bc0 R15: ffff880159ea37a0
> FS:  00007ff35f46c700(0000) GS:ffff88015b800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: ffffffffffffffed CR3: 000000007b8be000 CR4: 00000000001006f0
> Stack:
>  ffff88015999cd20 ffffffff81e11bc0 ffff88007b95f0a0 ffff88007b383dd8
>  ffff880159ea37a0 ffff88007b95f048 ffffffff81677d03 ffff88007b952460
>  ffffffff81e11bc0 ffff88007b95f0a0 ffff88007b95f070 ffffffff81677d40
> Call Trace:
>  [<ffffffff81677d03>] fwnode_property_read_string+0x43/0x50
>  [<ffffffff81677d40>] device_property_read_string+0x30/0x40
> ...
> 
> Fixes: 362c0b30249e (device property: Fallback to secondary fwnode if primary misses the property)
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Applied, thanks!

Rafael

