From: Sebastian Herbszt <herbszt@gmx.de>
Subject: Re: 4.4-rc2: NMI watchdog: BUG: soft lockup - CPU#0 stuck for 23s!
Date: Fri, 4 Dec 2015 23:19:31 +0100
Message-ID: <20151204231931.000014f6@localhost>
References: <20151129155213.00004e71@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:61117 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754120AbbLDWTn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Dec 2015 17:19:43 -0500
In-Reply-To: <20151129155213.00004e71@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sebastian Herbszt <herbszt@gmx.de>, Jeff Mahoney <jeffm@suse.com>

I wrote:
> Linux kernel 4.4-rc2 (openSUSE:Kernel of the day) fails to boot on my
> FUJITSU SIEMENS ESPRIMO E. Both kernel-default-4.4.rc2-1.1.g7eabae5.i586
> and kernel-vanilla-4.4.rc2-1.1.g7eabae5.i686 generate the following
> transcribed log:
> 
> [ 0.159147] SCSI subsystem initialized
> [content scrolled of screen?]
> [28.076000] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [swapper/0
> [content scrolled of screen]
> [28.076000] 0003f6ee f623d760 3f6ee000 f000c000 f68e5eec c0249225 00000173
> [28.076000] 00000002 f68e5edc 00000000 c09d2644 f60e5ed4 3f6ee000 00000173
> [28.076000] Call Trace:
> [28.076000]  [<c051742f>] ? ioremap_page_range+0xef/0x160
> [28.076000]  [<c0249225>] __ioremap_caller+0x285/0x350
> [28.076000]  [<c0b2c293>] ? print_filtered+0x5c/0x5c
> [28.076000]  [<c024930b>] ioremap_nocache+0x1b/0x20
> [28.076000]  [<c0b2c2eb>] ? dmi_init+0x58/0xec
> [28.076000]  [<c0b2c2eb>] dmi_init+0x58/0xec
> [28.076000]  [<c0b2c293>] ? print_filtered+0x5c/0x5c
> [28.076000]  [<c020048a>] do_one_initcall+0xaa/0x200
> [28.076000]  [<c0b2c293>] ? print_filtered+0x5c/0x5c
> [28.076000]  [<c027187f>] ? parse_args+0x2bf/0x560
> [28.076000]  [<c0aeec81>] kernel_init_freeable+0x137/0x1b9
> [28.076000]  [<c07dd890>] kernel_init+0x10/0xe0
> [28.076000]  [<c027df81>] ? schedule_tail+0x11/0x50
> [28.076000]  [<c07e3051>] ret_from_kernel_thread+0x21/0x40
> [28.076000]  [<c07dd880>] ? rest_init+0x70/0x70
> 
> kernel-debug-4.4.rc2-1.1.g7eabae5.i686 does not exhibit this issue.
> kernel-vanilla-4.4.rc2-1.1.g7eabae5.i686 with acpi=off also boots fine.

The issue seems fixed with kernel-vanilla-4.4.rc3-1.1.g3d7391b.i686
but not with kernel-default-4.4.rc3-1.1.g3d7391b.i586. That one still
needs acpi=off.

Sebastian
