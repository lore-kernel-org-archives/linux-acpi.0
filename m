From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Mon, 27 Apr 2015 10:46:31 +0200
Message-ID: <20150427084631.GA6774@pd.tnic>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
 <1427448178-20689-6-git-send-email-bp@alien8.de>
 <1AE640813FDE7649BE1B193DEA596E880270F2B2@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:42509 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932133AbbD0Iqt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Apr 2015 04:46:49 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E880270F2B2@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Luck, Tony" <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Apr 27, 2015 at 03:16:00AM +0000, Zheng, Lv wrote:
> > @@ -840,7 +840,9 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
> >  	struct ghes *ghes;
> >  	int sev, ret = NMI_DONE;
> > 
> > -	raw_spin_lock(&ghes_nmi_lock);
> > +	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
> > +		return ret;
> > +
> 
> Just a simple question.
> Why not just using cmpxchg here instead of atomic_add_unless so that no atomic_dec will be needed.

What do you think atomic_add_unless ends up doing:

#APP
# 177 "./arch/x86/include/asm/atomic.h" 1
	.pushsection .smp_locks,"a"
.balign 4
.long 671f - .
.popsection
671:
	lock; cmpxchgl %edx,ghes_in_nmi(%rip)	# D.37056, MEM[(volatile u32 *)&ghes_in_nmi]
# 0 "" 2
#NO_APP

And you need to atomic_dec() so that another reader can enter, i.e. how
the exclusion primitive works.

Or did you have something else in mind?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
