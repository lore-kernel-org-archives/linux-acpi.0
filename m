From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 32/59] x86_64: get boot_cpu_id as early for k8_scan_nodes
Date: Sun, 12 Aug 2007 12:16:35 +0200
Message-ID: <200708121216.36110.ak@suse.de>
References: <200708102200.l7AM019i011880@imap1.linux-foundation.org> <200708112242.04946.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49962 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753286AbXHLKSa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Aug 2007 06:18:30 -0400
In-Reply-To: <200708112242.04946.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org, yhlu.kernel@gmail.com, clameter@sgi.com

On Sunday 12 August 2007 04:42, Len Brown wrote:
> I hate to burst this bubble,
> but we have evidence that the only reliable way to enumerate
> processors on an ACPI systems is to parse the DSDT.

Yes I agree MADT parsing is in this case significantly simpler
and likely safer and the MADT has to be already correct anyways.

The later fixing up of tables in CPU detect was always not very reliable
and constant maintenance issue.

>
> No, this has nothing to do with the actual ACPI specification,
> but "common industry practice".  ie. what the BIOS vendors are
> shipping that works with Windows but confuses Linux.
>
> This means that all the "parse the MADT early" stuff
> is basically a waste of effort in the long term
> where we will have to change when Linux enumerates
> (and thus enables) the processors in the boot sequence.

I think it's because LinuxBIOS which Y.H. is working on is unable/unwilling
to supply any ACPI tables. So he prefers to kludge around it in the kernel
to adapt to the ever changing hardware.

I already had this argument recently about k8topology.c. It's getting
messier and messier and I would really like to retire it (it was originally
only written for a very early BIOS without SRAT); the only
reason not to is LinuxBIOS.

Apparently one problem is that the Linux ACPI code is not very 
friendly to partial tables (e.g. only SRAT); perhaps that is something
that could be improved.

I skipped these hacks for now because I'm quite sceptical of them.

-Andi
