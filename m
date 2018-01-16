From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/acpi: check rsdp address received via bootparams to
 be valid
Date: Tue, 16 Jan 2018 16:46:30 +0100
Message-ID: <20180116154630.ke53suvokynj73qd@gmail.com>
References: <20180116135730.19216-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:42423 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbeAPPqf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jan 2018 10:46:35 -0500
Content-Disposition: inline
In-Reply-To: <20180116135730.19216-1-jgross@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com


* Juergen Gross <jgross@suse.com> wrote:

> There seem to exist several grub2 versions trashing
> boot_params.hdr.acpi_rsdp_addr.
> 
> So don't just believe this address to be valid, but verify it pointing
> to a valid RSDP table.

Exactly what kind of values do those Grub2 versions put into that field? Pointer 
to something, or random noise?

Also, what exactly does 'validation' mean, how robustly does it filter out of spec 
uses of the boot protocol?

Thanks,

	Ingo
