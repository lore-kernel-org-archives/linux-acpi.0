From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH V3 4/4] acpi, apei: use EFI memmap to map GHES memory
Date: Mon, 22 Jun 2015 06:11:31 +0100
Message-ID: <20150622051131.GA2815@codeblueprint.co.uk>
References: <1434047160-23358-1-git-send-email-zjzhang@codeaurora.org>
 <1434047160-23358-5-git-send-email-zjzhang@codeaurora.org>
 <20150612162924.GH9084@pd.tnic>
 <557B6ED9.3020706@codeaurora.org>
 <20150613082750.GA3470@pd.tnic>
 <20150615141533.GB17685@codeblueprint.co.uk>
 <20150615145908.GK4255@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33001 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbbFVFLf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2015 01:11:35 -0400
Received: by wgck11 with SMTP id k11so3775994wgc.0
        for <linux-acpi@vger.kernel.org>; Sun, 21 Jun 2015 22:11:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150615145908.GK4255@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Zhang, Jonathan Zhixiong" <zjzhang@codeaurora.org>, Matt Fleming <matt.fleming@intel.com>, Thomas Gleixner <tglx@linutronix.de>, fu.wei@linaro.org, al.stone@linaro.org, tony.luck@gmail.com, rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 15 Jun, at 04:59:08PM, Borislav Petkov wrote:
> On Mon, Jun 15, 2015 at 03:15:33PM +0100, Matt Fleming wrote:
> > On Sat, 13 Jun, at 10:27:51AM, Borislav Petkov wrote:
> > > On Fri, Jun 12, 2015 at 04:44:25PM -0700, Zhang, Jonathan Zhixiong wrote:
> > > > Since such function is only needed for APEI functionality, at least as
> > > > of today, I will name it arch_apei_get_mem_attribute().
> > > 
> > > Why?
> > > 
> > > It can be extended to be used generically too, no? Come to think of it,
> > > the different arches should already have a way to tell you with what mem
> > > attributes a physical address is mapped, no?
> > > 
> > > IOW, such functionality should be already present, you'd only have to
> > > find it and use it.
> > 
> > I did think about this, but I don't think we have a generic way to ask
> > the firmware for its memory map.
> 
> Not the firmware but the OS. Like on x86, for example, we have MTRRs
> and PAT and they cover the whole range. Basically what lookup_memtype()
> does. We already have that info, why not query it instead of growing
> more stuff ontop.
> 
> I mean, we do ioremap* which does reserve_memtype() and sticks the range
> in the rbtree which we query after. Can't be better than that...

Right, but see my previous comment about x86 discarding a bunch of
attributes for memory regions because the kernel "knows better".

And in most places, yes, the kernel really does know better. But this
APEI case is special because irrespective of what the kernel says we
want to be compatible with the firmware's memory map.

And we don't have an API for that.

-- 
Matt Fleming, Intel Open Source Technology Center
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
