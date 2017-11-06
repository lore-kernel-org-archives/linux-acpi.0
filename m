From: Borislav Petkov <bp@suse.de>
Subject: Re: [v4.14-rc8 ghes_copy_tofrom_phys] BUG: sleeping function called
 from invalid context at lib/ioremap.c:165
Date: Tue, 7 Nov 2017 00:02:19 +0100
Message-ID: <20171106230219.szcckryg4lqghnvd@pd.tnic>
References: <CA+55aFxSJGeN=2X-uX-on1Uq2Nb8+v1aiMDz5H1+tKW_N5Q+6g@mail.gmail.com>
 <20171029225155.qcum5i75awrt5tzm@wfg-t540p.sh.intel.com>
 <20171029231835.3725fnd5yehlmqob@wfg-t540p.sh.intel.com>
 <20171030110511.scfrdtlnf5lbdhu5@pd.tnic>
 <CA+55aFy2c88wKndjRAds-3MZ+MsArGBySOog+Rxmd2AciGFGkA@mail.gmail.com>
 <CA+55aFwW7sbguREtVzKAUkNGb4cGh_eADqkEYcUurX5xS60_ww@mail.gmail.com>
 <526e7cf2-0672-e44b-c32f-26128a2dfd37@codeaurora.org>
 <20171106224635.qopgsszwxzuitkpf@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750917AbdKFXCj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Nov 2017 18:02:39 -0500
Content-Disposition: inline
In-Reply-To: <20171106224635.qopgsszwxzuitkpf@wfg-t540p.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tyler Baicar <tbaicar@codeaurora.org>, Linus Torvalds <torvalds@linux-foundation.org>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Huang Ying <ying.huang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>

On Tue, Nov 07, 2017 at 06:46:35AM +0800, Fengguang Wu wrote:
> I can see that in RC8, too:

https://lkml.kernel.org/r/20171106184427.31905-1-james.morse@arm.com

Rafael, you could still queue them for the merge window next week - they
look pretty straightforward and low risk to me.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
