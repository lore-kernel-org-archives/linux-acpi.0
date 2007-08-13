From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [patch 32/59] x86_64: get boot_cpu_id as early for k8_scan_nodes
Date: Sun, 12 Aug 2007 22:40:27 -0700
Message-ID: <86802c440708122240l4bd7ea69yc477aec2273755c4@mail.gmail.com>
References: <200708102200.l7AM019i011880@imap1.linux-foundation.org>
	 <200708112242.04946.lenb@kernel.org> <200708121216.36110.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:15649 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383AbXHMFk1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Aug 2007 01:40:27 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1094562rvb
        for <linux-acpi@vger.kernel.org>; Sun, 12 Aug 2007 22:40:27 -0700 (PDT)
In-Reply-To: <200708121216.36110.ak@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Len Brown <lenb@kernel.org>, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, clameter@sgi.com

On 8/12/07, Andi Kleen <ak@suse.de> wrote:
> On Sunday 12 August 2007 04:42, Len Brown wrote:
> I think it's because LinuxBIOS which Y.H. is working on is unable/unwilling
> to supply any ACPI tables. So he prefers to kludge around it in the kernel
> to adapt to the ever changing hardware.
>
> I already had this argument recently about k8topology.c. It's getting
> messier and messier and I would really like to retire it (it was originally
> only written for a very early BIOS without SRAT); the only
> reason not to is LinuxBIOS.
>
> Apparently one problem is that the Linux ACPI code is not very
> friendly to partial tables (e.g. only SRAT); perhaps that is something
> that could be improved.
>
> I skipped these hacks for now because I'm quite sceptical of them.

maybe for intel x86_64, it is hard to make kernel with numa enabled
with acpi=off.
but for amd k8 based system (even for later ...), it is rather simple
and clear to make numa enabled together bus enable... with acpi=off.

i don't think my patch has problem with intel platform.

I like to make the cluster (with two way above, with two ht chain) to
work properly with acpi=off.

also we can use that as good debug feature... it is good to verify
system/hw/bios could work with kernel (acpi=off). So other os without
acpi support or with broken acpi support still can work...

BTW: does any intel x86_64 system support numa/bus_numa?

YH
