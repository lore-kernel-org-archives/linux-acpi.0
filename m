From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: Re: [RFC/RFT PATCH 0/6] Switch GHES ioremap_page_range() to use
 fixmap
Date: Tue, 31 Oct 2017 14:46:36 -0400
Message-ID: <6373c223-5b53-f6a0-6867-a2be8bb9f44c@codeaurora.org>
References: <20171031153832.17746-1-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:40734 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdJaSqk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Oct 2017 14:46:40 -0400
In-Reply-To: <20171031153832.17746-1-james.morse@arm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Dongjiu Geng <gengdongjiu@huawei.com>, Xie XiuQi <xiexiuqi@huawei.com>, torvalds@linux-foundation.org

On 10/31/2017 11:38 AM, James Morse wrote:
> GHES is doing ioremap_page_range() in both NMI and irq context, neither
> are safe as it may sleep to allocate intermediate levels of page table.
>
> Replace the NMI/irq GHES_IOREMAP_PAGES to use a fixmap entry each.
>
> After this nothing uses ghes_ioremap_area or arch_apei_flush_tlb_one(),
> rip them out.
>
> RFC as I've only build-tested this on x86. For arm64 I've tested it on a
> software model. Any more testing would be welcome. These patches are based
> on rc7.
For the arm64 and APEI patches:
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>

Verified on arm64. I no longer see the BUGs in the GHES code. Thanks!

Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

