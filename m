From: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [RFC/RFT PATCH 3/6] ACPI / APEI: Replace ioremap_page_range()
 with fixmap
Date: Wed, 1 Nov 2017 12:13:35 +0800
Message-ID: <3b796e66-1618-0a6e-e57e-99323514b84d@huawei.com>
References: <20171031153832.17746-1-james.morse@arm.com>
 <20171031153832.17746-4-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:9985 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbdKAEQL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Nov 2017 00:16:11 -0400
In-Reply-To: <20171031153832.17746-4-james.morse@arm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Xie XiuQi <xiexiuqi@huawei.com>, torvalds@linux-foundation.org

On 2017/10/31 23:38, James Morse wrote:
> CC'd people I've seen posting CPER log fragments, could you give this a
> test on your platforms?
Thanks for the fixing, not found obviously issue.

