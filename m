From: Borislav Petkov <bp@suse.de>
Subject: Re: [ghes_copy_tofrom_phys] BUG: sleeping function called from
 invalid context at mm/page_alloc.c:4150
Date: Mon, 30 Oct 2017 18:42:35 +0100
Message-ID: <20171030174234.humpxetnqkfdcfsh@pd.tnic>
References: <CA+55aFxSJGeN=2X-uX-on1Uq2Nb8+v1aiMDz5H1+tKW_N5Q+6g@mail.gmail.com>
 <20171029225155.qcum5i75awrt5tzm@wfg-t540p.sh.intel.com>
 <20171029231835.3725fnd5yehlmqob@wfg-t540p.sh.intel.com>
 <20171030110511.scfrdtlnf5lbdhu5@pd.tnic>
 <CA+55aFy2c88wKndjRAds-3MZ+MsArGBySOog+Rxmd2AciGFGkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50963 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932128AbdJ3Rmo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 30 Oct 2017 13:42:44 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFy2c88wKndjRAds-3MZ+MsArGBySOog+Rxmd2AciGFGkA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Fengguang Wu <fengguang.wu@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Huang Ying <ying.huang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>

On Mon, Oct 30, 2017 at 10:20:40AM -0700, Linus Torvalds wrote:
> I think this whole driver is garbage.

This "driver" was supposed to implement the handle-hw-errors-in-fw glue
crap. The thing is, no one has been using it properly because there's
not even a single firmware vendor who has managed to produce a working
fw glue reporting errors properly. At least I haven't seen one.

Which means, no one is really using this. And now ARM start using it for
real and shit hits fan.

And I'd love to fix it but finding a box which *actually* has a usable
GHES glue is, as I mentioned above, almost impossible so testing fixes
would be hard. I need to figure out something...

Thanks.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
