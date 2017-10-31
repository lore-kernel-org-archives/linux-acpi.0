From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/RFT PATCH 0/6] Switch GHES ioremap_page_range() to use fixmap
Date: Tue, 31 Oct 2017 08:52:58 -0700
Message-ID: <CA+55aFxUYoiPgS_VaECsOCnieOUNir=tNB2jHznboo+CZFvO2w@mail.gmail.com>
References: <20171031153832.17746-1-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:51553 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbdJaPw7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Oct 2017 11:52:59 -0400
In-Reply-To: <20171031153832.17746-1-james.morse@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, Xie XiuQi <xiexiuqi@huawei.com>

On Tue, Oct 31, 2017 at 8:38 AM, James Morse <james.morse@arm.com> wrote:
>  7 files changed, 30 insertions(+), 85 deletions(-)

Lovely.

I obviously can't test it, but it looks fine. I *would* suggest just
making the "add fixmap entries" commits with the code that actually
uses them. There's no real reason to have two commits that just add
two entries that aren't used yet.

If it was some meaningful helper function where a split of the commits
makes each commit easier to read, that would be one thing.  As it is,
the split just makes it harder to look at the history of the code (ie
"I wonder where this was introduced - let's use 'git blame'. Oh,
that's not useful").

                  Linus
