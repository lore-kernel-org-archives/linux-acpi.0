From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH V9 0/5] map GHES memory region according to EFI memory map
Date: Wed, 5 Aug 2015 10:21:59 +0100
Message-ID: <20150805092159.GC4332@codeblueprint.co.uk>
References: <1438292109-4170-1-git-send-email-zjzhang@codeaurora.org>
 <20150803112658.GE10501@arm.com>
 <20150803162354.GQ2725@codeblueprint.co.uk>
 <20150804042552.GG31787@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34263 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbbHEJWB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Aug 2015 05:22:01 -0400
Received: by wibcd8 with SMTP id cd8so14985382wib.1
        for <linux-acpi@vger.kernel.org>; Wed, 05 Aug 2015 02:22:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150804042552.GG31787@nazgul.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Will Deacon <will.deacon@arm.com>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Matt Fleming <matt.fleming@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "tony.luck@gmail.com" <tony.luck@gmail.com>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "fu.wei@linaro.org" <fu.wei@linaro.org>, "al.stone@linaro.org" <al.stone@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "ying.huang@intel.com" <ying.huang@intel.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "leif.lindholm@linaro.org" <leif.lindholm@linaro.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 04 Aug, at 06:25:52AM, Borislav Petkov wrote:
> On Mon, Aug 03, 2015 at 05:23:54PM +0100, Matt Fleming wrote:
> > Rafael, Boris?
> 
> The ghes.c change looks fine I guess. The whole patchset makes sense
> now, with the arch bits extracted. So
> 
> Acked-by: Borislav Petkov <bp@suse.de>
 
Thanks Boris.

> However, we probably should work towards adhering to EFI memory
> attributes on x86, long term, as we talked. But that's a future thing.

Yeah, it's on my TODO list.

-- 
Matt Fleming, Intel Open Source Technology Center
