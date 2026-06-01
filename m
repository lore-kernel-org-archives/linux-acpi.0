Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DDC3806C4
	for <linux-acpi@vger.kernel.org>; Mon,  1 Jun 2026 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780345753; cv=none; b=hTv6GYFjI2lm7lJvQ/fNJLm80ltZolEgG3OXE9E/Al2pVwKBPj8cHcpAnUWi3oIxYFlUr3489f0rpaL55kdcaIkEKceea7dqndCHphBLQRct574nUF4IbrQ/wJfoDylIDLFLjcAiy4YGCdNWvRLMkm7JBxHOiAyRjNaYVYxi7LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780345753; c=relaxed/simple;
	bh=wujH18UNsauBGw2rzT6IwfdOl4oOYdohexeVU5B2YQc=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition; b=q3ylSVmljMiOsG9Ejlx0ZmF3pPNh9n4XQfWKZPLNHtxiCc5xk7hDcIk/EYp7Q3oljLNpJ1LGuOzY9lnaJS4L7BT34gakGx8jLnLiTBzc8Pb3IUvX5Vn0wIyATKr8KXkQMljcT54ZTKbN13Z0TmriapOggEIhb5mQQ+C9sgiNgTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=dsjluN2C; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="dsjluN2C"
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-7e1c3f47d78so22157887b3.0
        for <linux-acpi@vger.kernel.org>; Mon, 01 Jun 2026 13:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780345750; x=1780950550;
        h=content-disposition:message-id:subject:cc:to:from:date
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzcnnb4ft/sHGmWhq3YYu19yrHmbVI8yyzjWSZ/LZK8=;
        b=IM6+mEdkCbrp0L7l2+YGDtGtovNikr1Gf1yhmYlMt1wZnQriQ8RPYxufpHtJrcnwdw
         XHP78JbPaPWkBSxfUw8Jl3gT3gZWrDMcVBIOgsMcPunf22Z648fGwT4nA6IINW/U4Xtn
         jPJ/sef3tSP/Xn0ipj51tAfCgJqSX8S+aS5CNPZ04BUVEqimnGqNBYn5DgyJAuoqkLvW
         HcJwu4HpvUI9HCczjQk2ov2jBqYO18jGyZwJuwBFVbdoBeZVnJB3xU7RF0hY8kMyUJlP
         1iQgMckPr4jaVoh19YLVNxAvws/LMPzYU57zP5Dvni+liJRh5XbZU6y7B0fQ3AnmLN2I
         4Fmg==
X-Gm-Message-State: AOJu0YxbVENd/a3sSGKvl2sOhqW++bf+TWjiIvBTYYLd6AWI68FCxy9i
	pTa171pY6jN6YZ7LLUDRYc3bNKRPjg0cQrD7PKYBYJvXfMSzTIutBisdZSwNSU8y4Y/wMMDN0NK
	r4U8MvkaT/F0Co6Aa7US8mmzSy0hAiq8VDg==
X-Gm-Gg: Acq92OFYYSL90dMF0z1+5/zZXRqvZXvnyxlewoB0fjPRKvh8NWx3nFqyp8VL3Ui4w39
	8qQ5QzXPPoM0Z+rPzI9q/1gKIWri2QitXl7+jGgjsmd/EuzemPM/SPjaADAF/pogIdMVS8EVEKR
	31nfxpb7F6usb1/+4KAWgESY2H1PXKEWT/8Rd2Z6d3OON6dsTaWulGHQYuavWF/06EMDEc3dLPn
	J81scT3Jgziq41EhRfvYzfto1aEB0yYTtGy55YcntPnJTa21eCA3c8ApaQIqHpqMIIKYgpn2+wH
	fkHDmZrJzUlki8auX6QslNgD+vysQapQzP1cK3KpfJDN1+2I6OOusrfsqi/3Sc5Y6vAsMinsV0A
	eNk9tW71XYdwGT3O1bDT0U5nhtoauCV/rY1mkOiAtEnxUWFFz1SeRCE+ZwTwhPYMkYSYJHmqW4w
	KDFGlEe0BW5cSDftK6
X-Received: by 2002:a05:690c:e0d:b0:7d1:8eec:5b34 with SMTP id 00721157ae682-7e0593001acmr122685297b3.12.1780345750073;
        Mon, 01 Jun 2026 13:29:10 -0700 (PDT)
Received: from smtp.aristanetworks.com (ec2-52-52-135-65.us-west-1.compute.amazonaws.com. [52.52.135.65])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7e17b446f64sm4902517b3.20.2026.06.01.13.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 13:29:10 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1780345749;
	bh=qzcnnb4ft/sHGmWhq3YYu19yrHmbVI8yyzjWSZ/LZK8=;
	h=Date:From:To:Cc:Subject:From;
	b=dsjluN2CMjxRnHeBxRFRQuOG/hIdciKtX5vqGx80+kiwfXlMp/V8cUwRSgrgBK6F+
	 NOUTdNpbTAwjGyqtaLF8kU0HXULGdehLMpd4VOu8p16yA0tNxG5Mts4vTRp8BCYZv6
	 s+WRP2AqyqEXDKrCEk/qiGze5fmDUmUECcxPYPhKJ9hBSKKcBkrI5jIkUsuCFfS1R0
	 iC3DjMcmc0I1dMatYdM8nrOiTFEyscY/w+Ja1qnSkQpJvRXt9VdNTTkphvLg2OxL6q
	 0wNMbOi+pZXXH0FV+dDqHwuN/0wV+/9IK+JABB8cnTjv3tj/lVLimL8WyRpzuukMp0
	 4heJhQ/fdiQIQ==
Received: from vm-ymd.sjc.aristanetworks.com (dhcp-244-52-81.sjc.aristanetworks.com [10.244.52.81])
	by smtp.aristanetworks.com (Postfix) with ESMTPS id 42028C265C;
	Mon,  1 Jun 2026 20:29:09 +0000 (UTC)
Date: Mon, 1 Jun 2026 20:29:08 +0000
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Mohan Yelugoti <ymd@arista.com>
To: linux-acpi@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, mario.limonciello@amd.com,
	mika.westerberg@linux.intel.com, linux-kernel@vger.kernel.org
Subject: [REGRESSION] ACPI: threaded SCI handler causes soft lockup in kdump
 capture kernel
Message-ID: <ah3rlJrHviZHFt0+@vm-ymd.sjc.aristanetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

Hi,

We ship SONiC[0] on top of Debian stable with a small set of patches
on top (see [1]). After moving SONiC from Debian bookworm
to trixie, we started seeing a regression where the kdump capture
kernel hits a soft lockup while collecting the crash dump, so no
vmcore is produced.

We trigger the original panic in the kernel with:

      echo c > /proc/sysrq-trigger

The capture kernel then boots and hangs. To capture a usable trace
rather than waiting indefinitely, I added the following to the
capture-kernel command line so that it panics on soft lockup (and
dumps backtraces from all CPUs) when the hang is detected:

      debug=1 loglevel=7 softlockup_all_cpu_backtrace=1
softlockup_panic=1

With those in place, the capture kernel prints:

      watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [irq/9-acpi:39]
      CPU: 0 UID: 0 PID: 39 Comm: irq/9-acpi Not tainted
        6.12.41+deb13-sonic-amd64 #1 Debian 6.12.41-1
      RIP: 0010:acpi_os_read_port+0x30/0xa0
      Call Trace:
       <TASK>
       acpi_hw_gpe_read+0x61/0x80
       acpi_ev_detect_gpe+0x74/0x180
       acpi_ev_gpe_detect+0xe1/0x130
       acpi_ev_sci_xrupt_handler+0x1d/0x40
       acpi_irq+0x1c/0x40
       irq_thread_fn+0x23/0x60
       irq_thread+0x1b3/0x2f0
       kthread+0xd2/0x100
       ret_from_fork+0x34/0x50
       ret_from_fork_asm+0x1a/0x30
       </TASK>
      Kernel panic - not syncing: softlockup: hung tasks

Between the bookworm and trixie kernels, the ACPI SCI handler was
moved from a hardirq handler to a threaded handler by:

    7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler for SCI")

To confirm this is the trigger, I reverted that commit on top of
6.12.41 and re-ran the same sysrq-trigger reproducer. The capture
kernel then completes the crash dump without tripping the soft
lockup watchdog.

Happy to test patches or gather more data as this is reproducible
consistently on our systems.

This issue has been raised in the SONiC project at [2].

  Context
  -------
- Kernel:        6.12.41+deb13-sonic-amd64 (Debian 6.12.41-1);
- Last known good: Debian bookworm kernel (6.1.123), predates
                     7a36b901a6eb.

- Default capture-kernel cmdline (from /etc/default/kdump-tools,
  KDUMP_CMDLINE_APPEND):

      irqpoll nr_cpus=1 nousb systemd.unit=kdump-tools.service
      ata_piix.prefer_ms_hyperv=0 panic=10 debug loglevel=4
      hpet=disable pcie_port=compat pci=nommconf

For the trace above, loglevel was raised from 4 to 7 and the
following were added:

     debug=1 softlockup_all_cpu_backtrace=1 softlockup_panic=1

[0]: https://github.com/sonic-net
[1]: https://github.com/sonic-net/sonic-linux-kernel/tree/master/patches-sonic
[2]: https://github.com/sonic-net/sonic-linux-kernel/pull/580
