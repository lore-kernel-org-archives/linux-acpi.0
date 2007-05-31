From: Andrew Morton <akpm@linux-foundation.org>
Subject: acpi exception with current -mm lineup
Date: Wed, 30 May 2007 21:17:59 -0700
Message-ID: <20070530211759.aa083623.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:37034 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751042AbXEaESB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 May 2007 00:18:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4V4Hwt0019039
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Wed, 30 May 2007 21:18:00 -0700
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id l4V4HwgV012174
	for <linux-acpi@vger.kernel.org>; Wed, 30 May 2007 21:17:58 -0700
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

initcall 0xffffffff8066281b: rtc_init+0x0/0x1aa() returned 0.
initcall 0xffffffff8066281b ran for 0 msecs: rtc_init+0x0/0x1aa()
Calling initcall 0xffffffff806629c5: hpet_init+0x0/0x69()
hpet_resources: 0xfed00000 is busy
ACPI Error (utglobal-0126): Unknown exception code: 0xFFFFFFF0 [20070126]

Call Trace:
 [<ffffffff80384004>] acpi_format_exception+0x38/0x43
 [<ffffffff80380ac9>] acpi_ut_status_exit+0x43/0x85
 [<ffffffff803ad958>] hpet_resources+0x0/0x138
 [<ffffffff8037e341>] acpi_walk_resources+0x13c/0x14e
 [<ffffffff803ad907>] hpet_acpi_add+0x40/0x91
 [<ffffffff80387a27>] acpi_device_probe+0x51/0x109
 [<ffffffff803bca00>] driver_probe_device+0xdd/0x164
 [<ffffffff803bcbc7>] __driver_attach+0x89/0xc9
 [<ffffffff803bcb3e>] __driver_attach+0x0/0xc9
 [<ffffffff803bbaaa>] bus_for_each_dev+0x49/0x7a
 [<ffffffff803bc76b>] driver_attach+0x1c/0x1e
 [<ffffffff803bc0b2>] bus_add_driver+0x7f/0x184
 [<ffffffff803bcf94>] driver_register+0x73/0x77
 [<ffffffff80387bbd>] acpi_bus_register_driver+0x3e/0x40
 [<ffffffff80662a00>] hpet_init+0x3b/0x69
 [<ffffffff8064f8fb>] kernel_init+0x171/0x2e1
 [<ffffffff804ed953>] _spin_unlock_irq+0x14/0x30
 [<ffffffff8020a618>] child_rip+0xa/0x12
 [<ffffffff8064f78a>] kernel_init+0x0/0x2e1
 [<ffffffff8020a60e>] child_rip+0x0/0x12

initcall 0xffffffff806629c5: hpet_init+0x0/0x69() returned 0.

This is with a git pull from this morning.  The machine is one
of those Intel Noncna boxen.  I'm not sure how it identifies itself.

I put a copy of /proc/acpi/dsdt at http://userweb.kernel.org/~akpm/dsdt
if that's any help.

Full dmesg at http://userweb.kernel.org/~akpm/dmesg-x.txt
