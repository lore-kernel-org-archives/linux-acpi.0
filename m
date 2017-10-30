From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [ghes_copy_tofrom_phys] BUG: sleeping function called from
 invalid context at mm/page_alloc.c:4150
Date: Mon, 30 Oct 2017 10:46:31 -0700
Message-ID: <CA+55aFwW7sbguREtVzKAUkNGb4cGh_eADqkEYcUurX5xS60_ww@mail.gmail.com>
References: <CA+55aFxSJGeN=2X-uX-on1Uq2Nb8+v1aiMDz5H1+tKW_N5Q+6g@mail.gmail.com>
 <20171029225155.qcum5i75awrt5tzm@wfg-t540p.sh.intel.com> <20171029231835.3725fnd5yehlmqob@wfg-t540p.sh.intel.com>
 <20171030110511.scfrdtlnf5lbdhu5@pd.tnic> <CA+55aFy2c88wKndjRAds-3MZ+MsArGBySOog+Rxmd2AciGFGkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:50979 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932115AbdJ3Rqc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Oct 2017 13:46:32 -0400
In-Reply-To: <CA+55aFy2c88wKndjRAds-3MZ+MsArGBySOog+Rxmd2AciGFGkA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Huang Ying <ying.huang@intel.com>, Chen Gong <gong.chen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>

On Mon, Oct 30, 2017 at 10:20 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I will add a "might_sleep()" to ioremap_page_range() itself, so that
> we get this warning more reliably and much eailer. Right now it has
> been hidden by the fact that most of the time the time the page tables
> may be already allocated, but even then it's broken.

Done. It doesn't report anything for me, so _hopefully_ the GHES
driver is the only one that does games like this. See commit
b39ab98e2f47 ("Mark 'ioremap_page_range()' as possibly sleeping").

So now it should hopefully warn about this bad usage of page remapping
reliably, at least if you have CONFIG_DEBUG_ATOMIC_SLEEP enabled.

Can somebody who has a working GHES setup (although Borislav seems to
think no such thing exists) verify?

This obviously won't _fix_ anything, but at least it should make it
clear it's not that recent change that broke things - that just
happened to expose it. And hopefully somebody who knows that driver
will do the proper fixmap thing (or just ioremap once at probe time,
rather than at run-time).

                    Linus
