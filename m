Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281623655DB
	for <linux-acpi@vger.kernel.org>; Tue,  2 Jun 2026 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780421206; cv=none; b=YJ8CWzC+c9fPiVu9Sl8InTXmdDufqGqNnnYEsjYYcLxB6g6ONyrSKCOnRtiwviHRPNb0hi8yJ5Be2hq011tUTb1hFV+koN4dB9mEYIdtrRLPEYmpANpW/bARoR7J1bWxN+pkQNZ/E/bombGHHalBHjwhgod9J7F9Lc9Wt1pnwCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780421206; c=relaxed/simple;
	bh=BqAg11MgOWM1slHgezk9I2gtO6LPBYTwQUxzGyYJs7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMgC+fkonmGiY0W4yLrOqeIQy8yU6qxGjvhK+FCOqkPXT/WVjvJNyI/Qb8mwnrV/+y8omRQuuKCoEotx8qk8Zb1V3ECuMjxCN7MQPFNAHYg0902DH1XOchoJ23f3CZHHBH/i9CkXyq73QW70hFcdEGikw7GfuxObf7+Fy4rddH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeA0et1/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeA0et1/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98611F0089C
	for <linux-acpi@vger.kernel.org>; Tue,  2 Jun 2026 17:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780421204;
	bh=7L4RB7txsoj759pHLIms7AQPKEY/nBA5pEtHjYmL5q0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XeA0et1/aJodZQUtuzQYUPhuHscromQcdRYSyIXYZJzeXO/Zk7Ae7S5n0QqhIRwyc
	 v3+AI9hkW/TvbUe9a3EJAtzAIvd5gu2I45tHXrnC4IB03/F4TX7Z8DDyInuHfHXdwq
	 2JyNsMkcjP5KdIWPq3tjHUwxIpkkW+hZLUoqD8YNVIg2p30HQKgpsMn+M7FubwC0KC
	 E95Qupznr6RbZyrOl67dxSVoYcbDk/FvE1XmuqJAxb54mOMfJ6wz6/2bzpPmZKP2q0
	 5XW5hwD37cqlJ7ei7J1EESjIcNDNt6xJCwsccXWkX5SJbcvRiqNJIfDwVqy2Dj7ae9
	 Sxv2LrYneYq2w==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39697a4e16cso17161731fa.3
        for <linux-acpi@vger.kernel.org>; Tue, 02 Jun 2026 10:26:44 -0700 (PDT)
X-Gm-Message-State: AOJu0YxZh3k0OgQoxaj5bXc5fDSOxNoZ4mz+g3KpbvjifHZT4mdmaqdp
	ls+qkCNNF/ndBb9UhJ2f/HPEYQwWweWfQ9xskOOtN7Y6p0+rTovzcMjkbMqZsJWa2Fqpghqg+hW
	8ETRMUQf1DUHz+45HZycgfaphbUXd9uE=
X-Received: by 2002:a05:6512:800a:10b0:5aa:7788:d1db with SMTP id
 2adb3069b0e04-5aa7bf3245amr19188e87.24.1780421203314; Tue, 02 Jun 2026
 10:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ah3rlJrHviZHFt0+@vm-ymd.sjc.aristanetworks.com>
 <10861813.nUPlyArG6x@rafael.j.wysocki> <175a9520-0262-494b-9020-a7fbf35b7a01@amd.com>
In-Reply-To: <175a9520-0262-494b-9020-a7fbf35b7a01@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Jun 2026 19:26:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gfZFxajpY_UC8=eGFONnJ8RpqOuf7L50xduuujwOnnFQ@mail.gmail.com>
X-Gm-Features: AVHnY4LXDIIEQojKaCXzpEvenZMIl416z8EC_ciB1kmV7bCHoEAA_NHwnNBAj4o
Message-ID: <CAJZ5v0gfZFxajpY_UC8=eGFONnJ8RpqOuf7L50xduuujwOnnFQ@mail.gmail.com>
Subject: Re: [REGRESSION] ACPI: threaded SCI handler causes soft lockup in
 kdump capture kernel
To: Mario Limonciello <mario.limonciello@amd.com>, Mohan Yelugoti <ymd@arista.com>
Cc: linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com, 
	mika.westerberg@linux.intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 7:20=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
> On 6/2/26 12:17, Rafael J. Wysocki wrote:
> > On Monday, June 1, 2026 10:29:08 PM CEST Mohan Yelugoti wrote:
> >> Hi,
> >>
> >> We ship SONiC[0] on top of Debian stable with a small set of patches
> >> on top (see [1]). After moving SONiC from Debian bookworm
> >> to trixie, we started seeing a regression where the kdump capture
> >> kernel hits a soft lockup while collecting the crash dump, so no
> >> vmcore is produced.
> >>
> >> We trigger the original panic in the kernel with:
> >>
> >>        echo c > /proc/sysrq-trigger
> >>
> >> The capture kernel then boots and hangs. To capture a usable trace
> >> rather than waiting indefinitely, I added the following to the
> >> capture-kernel command line so that it panics on soft lockup (and
> >> dumps backtraces from all CPUs) when the hang is detected:
> >>
> >>        debug=3D1 loglevel=3D7 softlockup_all_cpu_backtrace=3D1 softloc=
kup_panic=3D1
> >>
> >> With those in place, the capture kernel prints:
> >>
> >>        watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [irq/9-acpi:3=
9]
> >>        CPU: 0 UID: 0 PID: 39 Comm: irq/9-acpi Not tainted
> >>          6.12.41+deb13-sonic-amd64 #1 Debian 6.12.41-1
> >>        RIP: 0010:acpi_os_read_port+0x30/0xa0
> >
> > I have no idea what possibly may lock up in that function, sorry.
> >
> > In this particular case it is reading a byte from the I/O space via inb=
(),
> > that's all.
> >
> > I'm wondering if it gets interrupted for some reason and then something
> > odd happens that prevents it from continuing.
> >
> >>        Call Trace:
> >>         <TASK>
> >>         acpi_hw_gpe_read+0x61/0x80
> >>         acpi_ev_detect_gpe+0x74/0x180
> >>         acpi_ev_gpe_detect+0xe1/0x130
> >>         acpi_ev_sci_xrupt_handler+0x1d/0x40
> >>         acpi_irq+0x1c/0x40
> >>         irq_thread_fn+0x23/0x60
> >>         irq_thread+0x1b3/0x2f0
> >>         kthread+0xd2/0x100
> >>         ret_from_fork+0x34/0x50
> >>         ret_from_fork_asm+0x1a/0x30
> >>         </TASK>
> >>        Kernel panic - not syncing: softlockup: hung tasks
> >>
> >> Between the bookworm and trixie kernels, the ACPI SCI handler was
> >> moved from a hardirq handler to a threaded handler by:
> >>
> >>      7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler for SC=
I")
> >
> > Maybe it exposed some latent issue.
> >
> > It's too late to revert it from the mainline anyway.
> >
> >> To confirm this is the trigger, I reverted that commit on top of
> >> 6.12.41 and re-ran the same sysrq-trigger reproducer. The capture
> >> kernel then completes the crash dump without tripping the soft
> >> lockup watchdog.
> >>
> >> Happy to test patches or gather more data as this is reproducible
> >> consistently on our systems.
> >
> > Does it always occur at the same spot?  If so, you could try to
> > instrument the code around it and look for clues.
>
> Especially if it's just a latent exposed issue before spending too much
> time intrumenting it's probably worth cross referencing 7.1-rc6 as well
> to see if the same issue can occur.

Good idea.

> >
> >> This issue has been raised in the SONiC project at [2].
> >>
> >>    Context
> >>    -------
> >> - Kernel:        6.12.41+deb13-sonic-amd64 (Debian 6.12.41-1);
> >> - Last known good: Debian bookworm kernel (6.1.123), predates
> >>                       7a36b901a6eb.
> >>
> >> - Default capture-kernel cmdline (from /etc/default/kdump-tools,
> >>    KDUMP_CMDLINE_APPEND):
> >>
> >>        irqpoll nr_cpus=3D1 nousb systemd.unit=3Dkdump-tools.service
> >>        ata_piix.prefer_ms_hyperv=3D0 panic=3D10 debug loglevel=3D4
> >>        hpet=3Ddisable pcie_port=3Dcompat pci=3Dnommconf

Also, I would try to remove irqpoll from this command line and retest.

> >> For the trace above, loglevel was raised from 4 to 7 and the
> >> following were added:
> >>
> >>       debug=3D1 softlockup_all_cpu_backtrace=3D1 softlockup_panic=3D1
> >>
> >> [0]: https://github.com/sonic-net
> >> [1]: https://github.com/sonic-net/sonic-linux-kernel/tree/master/patch=
es-sonic
> >> [2]: https://github.com/sonic-net/sonic-linux-kernel/pull/580
