From: James Morse <james.morse@arm.com>
Subject: Re: [RFC/RFT PATCH 3/6] ACPI / APEI: Replace ioremap_page_range()
 with fixmap
Date: Mon, 06 Nov 2017 18:41:58 +0000
Message-ID: <5A00ACF6.2010200@arm.com>
References: <20171031153832.17746-1-james.morse@arm.com> <20171031153832.17746-4-james.morse@arm.com> <3b796e66-1618-0a6e-e57e-99323514b84d@huawei.com> <59F9E0DF.20006@arm.com> <459a2731-b7eb-5836-93fd-57b7feaa5e40@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752240AbdKFSns (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Nov 2017 13:43:48 -0500
In-Reply-To: <459a2731-b7eb-5836-93fd-57b7feaa5e40@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Xie XiuQi <xiexiuqi@huawei.com>, torvalds@linux-foundation.org, "Zhengqiang (turing)" <zhengqiang10@huawei.com>, "lijinyue@huawei.com" <lijinyue@huawei.com>

Hi gengdongjiu

On 02/11/17 12:01, gengdongjiu wrote:
> James Morse wrote:
>> Can I take that as a 'Tested-by:'?
>>
>> These tags also let us record who has a system that can test changes to this driver.
> 
> sure.
> Thanks for the fixing.
> Qiang Zheng who is my colleague have tested it.
> 
> CC  Qiang.
> 
> Tested-by:  Qiang Zheng <zhengqiang10@huawei.com>

I can't do anything with this unless Qiang posts it. (I'll add to the CC list in
the next version)

>From Documentation/process/5.Posting.rst:
> Be careful in the addition of tags to your patches: only Cc: is appropriate
> for addition without the explicit permission of the person named.



Thanks,

James
