From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/RFT PATCH 0/6] Switch GHES ioremap_page_range() to use fixmap
Date: Tue, 31 Oct 2017 09:05:42 -0700
Message-ID: <CA+55aFxgcMULjiGSnuk33chsqSkf9-+aJwVNDzx5=Tf+eSK2sg@mail.gmail.com>
References: <20171031153832.17746-1-james.morse@arm.com> <CA+55aFxUYoiPgS_VaECsOCnieOUNir=tNB2jHznboo+CZFvO2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:52087 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753404AbdJaQFo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Oct 2017 12:05:44 -0400
In-Reply-To: <CA+55aFxUYoiPgS_VaECsOCnieOUNir=tNB2jHznboo+CZFvO2w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Dongjiu Geng <gengdongjiu@huawei.com>, Xie XiuQi <xiexiuqi@huawei.com>

On Tue, Oct 31, 2017 at 8:52 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Oct 31, 2017 at 8:38 AM, James Morse <james.morse@arm.com> wrote:
>>  7 files changed, 30 insertions(+), 85 deletions(-)
>
> Lovely.

Side note: it wasn't entirely obvious what restricted the ghes driver
to only x86 and arm64. I had to look up the whole HAVE_ACPI_APEI
dependency.

So it might be worth mentioning in the commit message why it's ok to
only add the fixmap entries for those two architectures and why it's
not an issue for anything else.

           Linus
