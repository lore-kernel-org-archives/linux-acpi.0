From: James Morse <james.morse@arm.com>
Subject: Re: [RFC/RFT PATCH 0/6] Switch GHES ioremap_page_range() to use fixmap
Date: Mon, 06 Nov 2017 18:43:38 +0000
Message-ID: <5A00AD5A.1070601@arm.com>
References: <20171031153832.17746-1-james.morse@arm.com>         <59F9E119.6040700@arm.com> <20171101153043.xgzepqbxsblmppp5@pd.tnic> <1509559730.30483.19.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753806AbdKFSp3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Nov 2017 13:45:29 -0500
In-Reply-To: <1509559730.30483.19.camel@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "bp@suse.de" <bp@suse.de>, "gengdongjiu@huawei.com" <gengdongjiu@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "mingo@redhat.com" <mingo@redhat.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "tbaicar@codeaurora.org" <tbaicar@codeaurora.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 01/11/17 18:20, Kani, Toshimitsu wrote:
> On Wed, 2017-11-01 at 16:30 +0100, Borislav Petkov wrote:
>> On Wed, Nov 01, 2017 at 02:58:33PM +0000, James Morse wrote:
>>> Does anyone have an x86 machine that does firmware-first using NOTIFY_NMI?

>> AFAIK, the only one who has access to a reportedly somewhat working GHES
>> implementation is Toshi. CCed.
> 
> Thanks for the heads-up.  My x86 system only supports GHES with SCI
> error sources.  It uses MCE for synchronous error events.
> 
> So, for x86 SCI error sources:
> 
> Tested-by: Toshi Kani <toshi.kani@hpe.com>

Thanks Toshi!


> nit: I think ghes_ioremap_pfn_[nmi|irq] should be renamed since they no
> longer use ioremap. 

I thought that would be too noisy...

I have some more rework to do in here before we can merge the other arm64 RAS
stuff, I can take that into account then.


Thanks,

James


