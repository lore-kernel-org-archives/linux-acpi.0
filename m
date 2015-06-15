From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH V3 4/4] acpi, apei: use EFI memmap to map GHES memory
Date: Mon, 15 Jun 2015 15:15:33 +0100
Message-ID: <20150615141533.GB17685@codeblueprint.co.uk>
References: <1434047160-23358-1-git-send-email-zjzhang@codeaurora.org>
 <1434047160-23358-5-git-send-email-zjzhang@codeaurora.org>
 <20150612162924.GH9084@pd.tnic>
 <557B6ED9.3020706@codeaurora.org>
 <20150613082750.GA3470@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36051 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbbFOOPi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jun 2015 10:15:38 -0400
Received: by wigg3 with SMTP id g3so79168914wig.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Jun 2015 07:15:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150613082750.GA3470@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Zhang, Jonathan Zhixiong" <zjzhang@codeaurora.org>, Matt Fleming <matt.fleming@intel.com>, Thomas Gleixner <tglx@linutronix.de>, fu.wei@linaro.org, al.stone@linaro.org, tony.luck@gmail.com, rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 13 Jun, at 10:27:51AM, Borislav Petkov wrote:
> On Fri, Jun 12, 2015 at 04:44:25PM -0700, Zhang, Jonathan Zhixiong wrote:
> > Since such function is only needed for APEI functionality, at least as
> > of today, I will name it arch_apei_get_mem_attribute().
> 
> Why?
> 
> It can be extended to be used generically too, no? Come to think of it,
> the different arches should already have a way to tell you with what mem
> attributes a physical address is mapped, no?
> 
> IOW, such functionality should be already present, you'd only have to
> find it and use it.

I did think about this, but I don't think we have a generic way to ask
the firmware for its memory map.

The problem on x86 of course is that we simply ignore what the firmware
tells us most of the time because everything gets funneled through the
e820 map and we eventually discard the EFI memmap.

-- 
Matt Fleming, Intel Open Source Technology Center
