From: James Morse <james.morse@arm.com>
Subject: Re: [RFC/RFT PATCH 3/6] ACPI / APEI: Replace ioremap_page_range()
 with fixmap
Date: Wed, 01 Nov 2017 14:57:35 +0000
Message-ID: <59F9E0DF.20006@arm.com>
References: <20171031153832.17746-1-james.morse@arm.com> <20171031153832.17746-4-james.morse@arm.com> <3b796e66-1618-0a6e-e57e-99323514b84d@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3b796e66-1618-0a6e-e57e-99323514b84d@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Xie XiuQi <xiexiuqi@huawei.com>, torvalds@linux-foundation.org
List-Id: linux-acpi@vger.kernel.org

Hi gengdonjiu,

On 01/11/17 04:13, gengdongjiu wrote:
> On 2017/10/31 23:38, James Morse wrote:
>> CC'd people I've seen posting CPER log fragments, could you give this a
>> test on your platforms?

> Thanks for the fixing, not found obviously issue.

Can I take that as a 'Tested-by:'?

These tags also let us record who has a system that can test changes to this driver.


Thanks,

James
