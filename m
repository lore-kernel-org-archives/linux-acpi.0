From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/acpi: check rsdp address received via bootparams to
 be valid
Date: Tue, 16 Jan 2018 16:56:21 +0100
Message-ID: <432c21ab-24d8-1e70-a471-ad8a14357d4e@suse.com>
References: <20180116135730.19216-1-jgross@suse.com>
 <20180116154630.ke53suvokynj73qd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39641 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750811AbeAPP4Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 Jan 2018 10:56:24 -0500
In-Reply-To: <20180116154630.ke53suvokynj73qd@gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com

On 16/01/18 16:46, Ingo Molnar wrote:
> 
> * Juergen Gross <jgross@suse.com> wrote:
> 
>> There seem to exist several grub2 versions trashing
>> boot_params.hdr.acpi_rsdp_addr.
>>
>> So don't just believe this address to be valid, but verify it pointing
>> to a valid RSDP table.
> 
> Exactly what kind of values do those Grub2 versions put into that field? Pointer 
> to something, or random noise?

Looks like random noise. On Mike's system it was 0x000000000151.

> Also, what exactly does 'validation' mean, how robustly does it filter out of spec 
> uses of the boot protocol?

It validates the RSDP has the correct 8 byte eye catcher in it and
the checksum of the structure is correct. Searching the RSDP by
scanning memory is using the same checks, so I guess this ought to
be okay. Odds are about 1 : 2^80 for false positives.


Juergen

