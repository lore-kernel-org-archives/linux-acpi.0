From: James Morse <james.morse@arm.com>
Subject: Re: [RFC/RFT PATCH 0/6] Switch GHES ioremap_page_range() to use fixmap
Date: Wed, 01 Nov 2017 14:58:54 +0000
Message-ID: <59F9E12E.4030302@arm.com>
References: <20171031153832.17746-1-james.morse@arm.com> <CA+55aFxUYoiPgS_VaECsOCnieOUNir=tNB2jHznboo+CZFvO2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753119AbdKAPAl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Nov 2017 11:00:41 -0400
In-Reply-To: <CA+55aFxUYoiPgS_VaECsOCnieOUNir=tNB2jHznboo+CZFvO2w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, Xie XiuQi <xiexiuqi@huawei.com>

Hi Linus,

On 31/10/17 15:52, Linus Torvalds wrote:
> On Tue, Oct 31, 2017 at 8:38 AM, James Morse <james.morse@arm.com> wrote:
>>  7 files changed, 30 insertions(+), 85 deletions(-)
> 
> Lovely.
> 
> I obviously can't test it, but it looks fine. I *would* suggest just
> making the "add fixmap entries" commits with the code that actually
> uses them. There's no real reason to have two commits that just add
> two entries that aren't used yet.
> 
> If it was some meaningful helper function where a split of the commits
> makes each commit easier to read, that would be one thing.  As it is,
> the split just makes it harder to look at the history of the code (ie
> "I wonder where this was introduced - let's use 'git blame'. Oh,
> that's not useful").

I will squash the first three patches together to fix this, and add something
about HAVE_ACPI_APEI to the commit message.

(I'm still holding out for someone to test this on an x86 system with NOTIFY_NMI)


Thanks,

James
