From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/4] randstruct: Disable randomization of ACPICA structs
Date: Tue, 20 Jun 2017 23:34:38 +0200
Message-ID: <CAJZ5v0hqRbsivmnG5iKMsR_ZMg+i_vxA7n-NOkuu3jh-TJ6pHw@mail.gmail.com>
References: <1497905801-69164-1-git-send-email-keescook@chromium.org>
 <1497905801-69164-4-git-send-email-keescook@chromium.org> <20170620065631.GA25354@infradead.org>
 <CAGXu5jLkvqbV1=xGrvwLZPiAbswA6M5C3BB0M5MytRabLtEfLg@mail.gmail.com> <20170620203549.GA4049@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:32998 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752151AbdFTVej (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Jun 2017 17:34:39 -0400
In-Reply-To: <20170620203549.GA4049@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Kees Cook <keescook@chromium.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

On Tue, Jun 20, 2017 at 10:35 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Jun 20, 2017 at 12:25:53PM -0700, Kees Cook wrote:
>> Can you send the patch to https://github.com/acpica/acpica ? My change
>> was finally accepted, so this whole issue will go away on the next
>> refresh. Until then, I don't want to block the entire automatic
>> structure selection logic of randstruct on a three-function table. :)
>
> I do not have a github account and no such thing is required for kernel
> development.

It isn't required for the ACPICA material either.

You just need to CC the ACPICA maintainers, as per MAINTAINERS, on
your ACPICA patches.  They pick up stuff that looks good to them.

And we tend to prefer routing ACPICA changes through the upstream,
because failing to do so usually turns out to be painful in the long
term.  I don't think it is unreasonable to ask for cooperation in that
respect.

Thanks,
Rafael
