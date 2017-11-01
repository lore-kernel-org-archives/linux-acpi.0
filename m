From: Borislav Petkov <bp@suse.de>
Subject: Re: [RFC/RFT PATCH 0/6] Switch GHES ioremap_page_range() to use
 fixmap
Date: Wed, 1 Nov 2017 16:30:43 +0100
Message-ID: <20171101153043.xgzepqbxsblmppp5@pd.tnic>
References: <20171031153832.17746-1-james.morse@arm.com>
 <59F9E119.6040700@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754593AbdKAPaz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Nov 2017 11:30:55 -0400
Content-Disposition: inline
In-Reply-To: <59F9E119.6040700@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, Xie XiuQi <xiexiuqi@huawei.com>, torvalds@linux-foundation.org, Huang Ying <ying.huang@intel.com>, Toshi Kani <toshi.kani@hpe.com>

On Wed, Nov 01, 2017 at 02:58:33PM +0000, James Morse wrote:
> Does anyone have an x86 machine that does firmware-first using NOTIFY_NMI?

AFAIK, the only one who has access to a reportedly somewhat working GHES
implementation is Toshi. CCed.

> ('ls /sys/firmware/acpi/tables/', if you have a HEST and EINJ we should be able
> to work something out)

That's not enough. All the EINJ boxes I have would stop accepting EINJ
writes after a couple of injections, i.e., BIOS would get "stuffed". :-)))

Maybe Tony has something better. He's already on CC.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
