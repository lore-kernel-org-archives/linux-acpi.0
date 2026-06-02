Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AE63F6603;
	Tue,  2 Jun 2026 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420639; cv=none; b=ckSTw2VKp2RxgfRwNiX9G/xjaLT2nih7OrYsfULNUBu7m9e2HUeCKaGUCufmmhzfEd2Hb51swZgI+1YkTc0fQcvS4Ksxg1zRycx281PocAUtCPy6eKUJMJjcYREHmkleWXDFpoF3+em8nK7vr+HuRZF0sTt3eQ0CBSw8HRql170=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420639; c=relaxed/simple;
	bh=mrNrRP0PPVo7879aiF5pSSWIrXY9bTzJClwlIQVOSHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jn96KO3xYjjpX88KDPufLA7zIj0gRk3uVsg3ONuqc3l37Y7nY0lTD5sa8J9Rn3uNL2z8Ts/fGKLuj/ymSeYvnRt/wBT/Johe78bU3zbdh8FTakjLMZ+78VuuEk9Xfj1mMeFJzJK5pl6qoAVNRdALmZG6lXj0f+iiOIYkPjhI2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5yhAiva; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5yhAiva"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FC91F00893;
	Tue,  2 Jun 2026 17:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780420637;
	bh=DcYA3VgXc3cftwWp+LN/xeWlVapn0ej/EDnHUZpHsVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P5yhAiva8Yiaek4AP8QJd6VhwgoGTbh2lZA/GQiM0vKwyRG5sAoXamFHveou/9pBj
	 M3FxfBX1p6v2plKQsDIHXxHNUyVVuE+yXS19V2hXqsrLm4WDbySoUTfwRJKb0JfktT
	 UHhog46FDQZzngWj61yKxOqaHFa5FyCnTQWV1CXAOEXtwXprNnbYdEAeu49qy8jQfJ
	 UG69e6NrNPbRbybkDUyyrws4Cb+2FtUoyNM9jO2fqqCdX5iMSpqmcw7BhD/LQsuvjN
	 C4qmv9BsPjdQo0tZE0h7pX6rl9wrekm2eL3oTDCYBYJxjCpoY72AyEgjZXZ0wE3I7Y
	 dpO1oYK3SkAOQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Mohan Yelugoti <ymd@arista.com>
Cc: linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com,
 mario.limonciello@amd.com, mika.westerberg@linux.intel.com,
 linux-kernel@vger.kernel.org
Subject:
 Re: [REGRESSION] ACPI: threaded SCI handler causes soft lockup in kdump
 capture kernel
Date: Tue, 02 Jun 2026 19:17:14 +0200
Message-ID: <10861813.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <ah3rlJrHviZHFt0+@vm-ymd.sjc.aristanetworks.com>
References: <ah3rlJrHviZHFt0+@vm-ymd.sjc.aristanetworks.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Monday, June 1, 2026 10:29:08 PM CEST Mohan Yelugoti wrote:
> Hi,
> 
> We ship SONiC[0] on top of Debian stable with a small set of patches
> on top (see [1]). After moving SONiC from Debian bookworm
> to trixie, we started seeing a regression where the kdump capture
> kernel hits a soft lockup while collecting the crash dump, so no
> vmcore is produced.
> 
> We trigger the original panic in the kernel with:
> 
>       echo c > /proc/sysrq-trigger
> 
> The capture kernel then boots and hangs. To capture a usable trace
> rather than waiting indefinitely, I added the following to the
> capture-kernel command line so that it panics on soft lockup (and
> dumps backtraces from all CPUs) when the hang is detected:
> 
>       debug=1 loglevel=7 softlockup_all_cpu_backtrace=1 softlockup_panic=1
> 
> With those in place, the capture kernel prints:
> 
>       watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [irq/9-acpi:39]
>       CPU: 0 UID: 0 PID: 39 Comm: irq/9-acpi Not tainted
>         6.12.41+deb13-sonic-amd64 #1 Debian 6.12.41-1
>       RIP: 0010:acpi_os_read_port+0x30/0xa0

I have no idea what possibly may lock up in that function, sorry.

In this particular case it is reading a byte from the I/O space via inb(),
that's all.

I'm wondering if it gets interrupted for some reason and then something
odd happens that prevents it from continuing.

>       Call Trace:
>        <TASK>
>        acpi_hw_gpe_read+0x61/0x80
>        acpi_ev_detect_gpe+0x74/0x180
>        acpi_ev_gpe_detect+0xe1/0x130
>        acpi_ev_sci_xrupt_handler+0x1d/0x40
>        acpi_irq+0x1c/0x40
>        irq_thread_fn+0x23/0x60
>        irq_thread+0x1b3/0x2f0
>        kthread+0xd2/0x100
>        ret_from_fork+0x34/0x50
>        ret_from_fork_asm+0x1a/0x30
>        </TASK>
>       Kernel panic - not syncing: softlockup: hung tasks
> 
> Between the bookworm and trixie kernels, the ACPI SCI handler was
> moved from a hardirq handler to a threaded handler by:
> 
>     7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler for SCI")

Maybe it exposed some latent issue.

It's too late to revert it from the mainline anyway.

> To confirm this is the trigger, I reverted that commit on top of
> 6.12.41 and re-ran the same sysrq-trigger reproducer. The capture
> kernel then completes the crash dump without tripping the soft
> lockup watchdog.
> 
> Happy to test patches or gather more data as this is reproducible
> consistently on our systems.

Does it always occur at the same spot?  If so, you could try to
instrument the code around it and look for clues.

> This issue has been raised in the SONiC project at [2].
> 
>   Context
>   -------
> - Kernel:        6.12.41+deb13-sonic-amd64 (Debian 6.12.41-1);
> - Last known good: Debian bookworm kernel (6.1.123), predates
>                      7a36b901a6eb.
> 
> - Default capture-kernel cmdline (from /etc/default/kdump-tools,
>   KDUMP_CMDLINE_APPEND):
> 
>       irqpoll nr_cpus=1 nousb systemd.unit=kdump-tools.service
>       ata_piix.prefer_ms_hyperv=0 panic=10 debug loglevel=4
>       hpet=disable pcie_port=compat pci=nommconf
> 
> For the trace above, loglevel was raised from 4 to 7 and the
> following were added:
> 
>      debug=1 softlockup_all_cpu_backtrace=1 softlockup_panic=1
> 
> [0]: https://github.com/sonic-net
> [1]: https://github.com/sonic-net/sonic-linux-kernel/tree/master/patches-sonic
> [2]: https://github.com/sonic-net/sonic-linux-kernel/pull/580
> 
> 




