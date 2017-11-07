From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [v4.14-rc8 ghes_copy_tofrom_phys] BUG: sleeping function called
 from invalid context at lib/ioremap.c:165
Date: Tue, 7 Nov 2017 21:39:33 +0800
Message-ID: <20171107133933.xnuulshxt3sxgibf@wfg-t540p.sh.intel.com>
References: <CA+55aFxSJGeN=2X-uX-on1Uq2Nb8+v1aiMDz5H1+tKW_N5Q+6g@mail.gmail.com>
 <20171029225155.qcum5i75awrt5tzm@wfg-t540p.sh.intel.com>
 <20171029231835.3725fnd5yehlmqob@wfg-t540p.sh.intel.com>
 <20171030110511.scfrdtlnf5lbdhu5@pd.tnic>
 <CA+55aFy2c88wKndjRAds-3MZ+MsArGBySOog+Rxmd2AciGFGkA@mail.gmail.com>
 <CA+55aFwW7sbguREtVzKAUkNGb4cGh_eADqkEYcUurX5xS60_ww@mail.gmail.com>
 <526e7cf2-0672-e44b-c32f-26128a2dfd37@codeaurora.org>
 <20171106224635.qopgsszwxzuitkpf@wfg-t540p.sh.intel.com>
 <20171106230219.szcckryg4lqghnvd@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:59046 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932631AbdKGNjk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Nov 2017 08:39:40 -0500
Content-Disposition: inline
In-Reply-To: <20171106230219.szcckryg4lqghnvd@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tyler Baicar <tbaicar@codeaurora.org>, Linus Torvalds <torvalds@linux-foundation.org>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Huang Ying <ying.huang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>

On Tue, Nov 07, 2017 at 12:02:19AM +0100, Borislav Petkov wrote:
>On Tue, Nov 07, 2017 at 06:46:35AM +0800, Fengguang Wu wrote:
>> I can see that in RC8, too:
>
>https://lkml.kernel.org/r/20171106184427.31905-1-james.morse@arm.com
>
>Rafael, you could still queue them for the merge window next week - they
>look pretty straightforward and low risk to me.

Tested-by: Fengguang Wu <fengguang.wu@intel.com>

I tried 100 boots with various test jobs and there is no
more GHES errors.

Thanks,
Fengguang
