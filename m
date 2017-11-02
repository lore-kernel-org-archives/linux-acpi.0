From: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [RFC/RFT PATCH 3/6] ACPI / APEI: Replace ioremap_page_range()
 with fixmap
Date: Thu, 2 Nov 2017 20:01:16 +0800
Message-ID: <459a2731-b7eb-5836-93fd-57b7feaa5e40@huawei.com>
References: <20171031153832.17746-1-james.morse@arm.com>
 <20171031153832.17746-4-james.morse@arm.com>
 <3b796e66-1618-0a6e-e57e-99323514b84d@huawei.com> <59F9E0DF.20006@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:45648 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751370AbdKBMCg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Nov 2017 08:02:36 -0400
In-Reply-To: <59F9E0DF.20006@arm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Xie XiuQi <xiexiuqi@huawei.com>, torvalds@linux-foundation.org, "Zhengqiang (turing)" <zhengqiang10@huawei.com>, "lijinyue@huawei.com" <lijinyue@huawei.com>

Hi James,

> 
> Can I take that as a 'Tested-by:'?
> 
> These tags also let us record who has a system that can test changes to this driver.

sure.
Thanks for the fixing.
Qiang Zheng who is my colleague have tested it.

CC  Qiang.

Tested-by:  Qiang Zheng <zhengqiang10@huawei.com>

> 
> 
> Thanks,
> 
> James
> 
> 
> 
> .
> 

