From: "Dave Young" <hidave.darkstar@gmail.com>
Subject: Re: 2.6.25-rc5-mm1
Date: Wed, 12 Mar 2008 09:14:55 +0800
Message-ID: <a8e1da0803111814h3192f856oe4ffa6e92d1d7a92@mail.gmail.com>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:39732 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbYCLBO5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2008 21:14:57 -0400
Received: by wr-out-0506.google.com with SMTP id 50so1672150wra.13
        for <linux-acpi@vger.kernel.org>; Tue, 11 Mar 2008 18:14:56 -0700 (PDT)
In-Reply-To: <20080311011434.ad8c8d7d.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

Hi, I got the following lockdep warning:
(add linux-acpi to cc)

[    0.097109] ACPI: Core revision 20070126
[    0.097282] INFO: trying to register non-static key.
[    0.097355] the code is fine but needs lockdep annotation.
[    0.097428] turning off the locking correctness validator.
[    0.097503] Pid: 0, comm: swapper Not tainted 2.6.25-rc5-mm1 #3
[    0.097578]  [<c0127bf8>] ? printk+0x18/0x20
[    0.097716]  [<c014b01c>] __lock_acquire+0x40c/0x760
[    0.097822]  [<c0181ba0>] ? alloc_debug_processing+0xb0/0x140
[    0.097959]  [<c014b969>] lock_acquire+0x79/0xb0
[    0.098063]  [<c0140204>] ? down_trylock+0x14/0x40
[    0.098197]  [<c03df9e8>] _spin_lock_irqsave+0x48/0xa0
[    0.098303]  [<c0140204>] ? down_trylock+0x14/0x40
[    0.098436]  [<c0140204>] down_trylock+0x14/0x40
[    0.098540]  [<c027c7ea>] acpi_os_wait_semaphore+0x3e/0xb9
[    0.098647]  [<c029263e>] acpi_ut_acquire_mutex+0x34/0x72
[    0.098753]  [<c0289ab1>] acpi_ns_root_initialize+0x19/0x250
[    0.098859]  [<c05453e6>] acpi_initialize_subsystem+0x42/0x64
[    0.098966]  [<c0545725>] acpi_early_init+0x50/0xef
[    0.099070]  [<c052b7f6>] start_kernel+0x1e6/0x250
[    0.099175]  [<c052b1a0>] ? unknown_bootoption+0x0/0x130
[    0.099310]  [<c052b008>] __init_begin+0x8/0x10
[    0.099414]  =======================
