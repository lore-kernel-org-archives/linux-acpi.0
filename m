From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [ghes_copy_tofrom_phys] BUG: sleeping function called from
 invalid context at mm/page_alloc.c:4150
Date: Mon, 30 Oct 2017 11:00:36 -0700
Message-ID: <CA+55aFwkcHhE45y3CeM2ujeqyx6okt30rF+ipVg4RsGUse_XhQ@mail.gmail.com>
References: <CA+55aFxSJGeN=2X-uX-on1Uq2Nb8+v1aiMDz5H1+tKW_N5Q+6g@mail.gmail.com>
 <20171029225155.qcum5i75awrt5tzm@wfg-t540p.sh.intel.com> <20171029231835.3725fnd5yehlmqob@wfg-t540p.sh.intel.com>
 <20171030110511.scfrdtlnf5lbdhu5@pd.tnic> <CA+55aFy2c88wKndjRAds-3MZ+MsArGBySOog+Rxmd2AciGFGkA@mail.gmail.com>
 <CA+55aFwW7sbguREtVzKAUkNGb4cGh_eADqkEYcUurX5xS60_ww@mail.gmail.com> <20171030174952.GC1705@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:43123 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932538AbdJ3SAh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Oct 2017 14:00:37 -0400
In-Reply-To: <20171030174952.GC1705@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Fengguang Wu <fengguang.wu@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Huang Ying <ying.huang@intel.com>, Chen Gong <gong.chen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>

On Mon, Oct 30, 2017 at 10:49 AM, Will Deacon <will.deacon@arm.com> wrote:
>
> FWIW, we discussed some of this back in 2015, because the TLB invalidation
> looks busted to me too:

Yeah, I think the basic issue is that ioremap() is not supposed to map
*over* an existing mapping, it's designed to map pages into a new
mapping.

I think *every* other user of "ioremap_page_range()" is literally the
architecture-specific implementation of "ioremap()" (which does the
whole "allocate new VM area, then remap page range into that".

So the GHES driver use of this function really looks very wrong on so
many levels.

Checking..

Oh, git grep shows "drivers/pci/host/pci-tegra.c".

I'm afraid to even look into that file.

And pci_remap_iospace() looks potentially like a problem spot too -
but hopefully is done only at driver init time (but it could possibly
have the TLB issue).

              Linus
