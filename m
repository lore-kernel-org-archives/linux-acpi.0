From: James Morse <james.morse@arm.com>
Subject: Re: [RFC/RFT PATCH 0/6] Switch GHES ioremap_page_range() to use fixmap
Date: Wed, 01 Nov 2017 14:58:33 +0000
Message-ID: <59F9E119.6040700@arm.com>
References: <20171031153832.17746-1-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753119AbdKAPAU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Nov 2017 11:00:20 -0400
In-Reply-To: <20171031153832.17746-1-james.morse@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, Xie XiuQi <xiexiuqi@huawei.com>, torvalds@linux-foundation.org, Chen Gong <gong.chen@linux.intel.com>, Huang Ying <ying.huang@intel.com>

Hi guys,

(+CC: Chen Gong and Huang Ying from the git log of [0])

On 31/10/17 15:38, James Morse wrote:
> RFC as I've only build-tested this on x86.

Does anyone have an x86 machine that does firmware-first using NOTIFY_NMI?


> Any more testing would be welcome.

('ls /sys/firmware/acpi/tables/', if you have a HEST and EINJ we should be able
to work something out)


Thanks,

James

[0] https://www.kernel.org/doc/Documentation/acpi/apei/einj.txt
