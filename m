From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 5/5] GHES: Make NMI handler have a single reader
Date: Tue, 28 Apr 2015 09:38:20 +0200
Message-ID: <20150428073819.GA19025@pd.tnic>
References: <1427448178-20689-1-git-send-email-bp@alien8.de>
 <1427448178-20689-6-git-send-email-bp@alien8.de>
 <1AE640813FDE7649BE1B193DEA596E880270F2B2@SHSMSX101.ccr.corp.intel.com>
 <20150427084631.GA6774@pd.tnic>
 <1AE640813FDE7649BE1B193DEA596E880270F5C8@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:42260 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932105AbbD1Hii (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Apr 2015 03:38:38 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E880270F5C8@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Luck, Tony" <tony.luck@intel.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "Chen, Gong" <gong.chen@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Apr 28, 2015 at 02:24:16AM +0000, Zheng, Lv wrote:
> > > #APP
> > > # 177 "./arch/x86/include/asm/atomic.h" 1
> > > 	.pushsection .smp_locks,"a"
> > > .balign 4
> > > .long 671f - .
> > > .popsection
> > > 671:
> > > 	lock; cmpxchgl %edx,ghes_in_nmi(%rip)	# D.37056, MEM[(volatile u32 *)&ghes_in_nmi]
> > > # 0 "" 2
> > > #NO_APP
> > >
> > > And you need to atomic_dec() so that another reader can enter, i.e. how
> > > the exclusion primitive works.
> > >
> > > Or did you have something else in mind?
> > 
> > My mistake.
> > I mean cmpxchg() and xchg() (or atomic_cmpxchg() and atomic_xchg()) pair here, so nothing can be reduced.
> 
> Let me correct, it should be atomic_cmpxchg() and atomic_set() here as you only need to switch between 0 and 1.
> Sorry for the noise.

I still don't understand what you want from me here. You need to go into
more detail.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
