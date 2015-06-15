From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V3 4/4] acpi, apei: use EFI memmap to map GHES memory
Date: Mon, 15 Jun 2015 16:59:08 +0200
Message-ID: <20150615145908.GK4255@pd.tnic>
References: <1434047160-23358-1-git-send-email-zjzhang@codeaurora.org>
 <1434047160-23358-5-git-send-email-zjzhang@codeaurora.org>
 <20150612162924.GH9084@pd.tnic>
 <557B6ED9.3020706@codeaurora.org>
 <20150613082750.GA3470@pd.tnic>
 <20150615141533.GB17685@codeblueprint.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:56637 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755373AbbFOO7P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Jun 2015 10:59:15 -0400
Content-Disposition: inline
In-Reply-To: <20150615141533.GB17685@codeblueprint.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: "Zhang, Jonathan Zhixiong" <zjzhang@codeaurora.org>, Matt Fleming <matt.fleming@intel.com>, Thomas Gleixner <tglx@linutronix.de>, fu.wei@linaro.org, al.stone@linaro.org, tony.luck@gmail.com, rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jun 15, 2015 at 03:15:33PM +0100, Matt Fleming wrote:
> On Sat, 13 Jun, at 10:27:51AM, Borislav Petkov wrote:
> > On Fri, Jun 12, 2015 at 04:44:25PM -0700, Zhang, Jonathan Zhixiong wrote:
> > > Since such function is only needed for APEI functionality, at least as
> > > of today, I will name it arch_apei_get_mem_attribute().
> > 
> > Why?
> > 
> > It can be extended to be used generically too, no? Come to think of it,
> > the different arches should already have a way to tell you with what mem
> > attributes a physical address is mapped, no?
> > 
> > IOW, such functionality should be already present, you'd only have to
> > find it and use it.
> 
> I did think about this, but I don't think we have a generic way to ask
> the firmware for its memory map.

Not the firmware but the OS. Like on x86, for example, we have MTRRs
and PAT and they cover the whole range. Basically what lookup_memtype()
does. We already have that info, why not query it instead of growing
more stuff ontop.

I mean, we do ioremap* which does reserve_memtype() and sticks the range
in the rbtree which we query after. Can't be better than that...

Hmmm.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
