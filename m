From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH V3 4/4] acpi, apei: use EFI memmap to map GHES memory
Date: Tue, 23 Jun 2015 10:50:33 +0100
Message-ID: <20150623095033.GC2815@codeblueprint.co.uk>
References: <1434047160-23358-1-git-send-email-zjzhang@codeaurora.org>
 <1434047160-23358-5-git-send-email-zjzhang@codeaurora.org>
 <20150612162924.GH9084@pd.tnic>
 <557B6ED9.3020706@codeaurora.org>
 <20150613082750.GA3470@pd.tnic>
 <20150615141533.GB17685@codeblueprint.co.uk>
 <20150615145908.GK4255@pd.tnic>
 <20150622051131.GA2815@codeblueprint.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36967 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbbFWJuh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jun 2015 05:50:37 -0400
Received: by wicgi11 with SMTP id gi11so11123278wic.0
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2015 02:50:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150622051131.GA2815@codeblueprint.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Zhang, Jonathan Zhixiong" <zjzhang@codeaurora.org>, Matt Fleming <matt.fleming@intel.com>, Thomas Gleixner <tglx@linutronix.de>, fu.wei@linaro.org, al.stone@linaro.org, tony.luck@gmail.com, rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 22 Jun, at 06:11:31AM, Matt Fleming wrote:
> 
> Right, but see my previous comment about x86 discarding a bunch of
> attributes for memory regions because the kernel "knows better".
> 
> And in most places, yes, the kernel really does know better. But this
> APEI case is special because irrespective of what the kernel says we
> want to be compatible with the firmware's memory map.
> 
> And we don't have an API for that.

Maybe what we want is a new PAGE_* protection that is compatible with
any firmware mappings? That'd be nice because we wouldn't have to
introduce a whole new API for this GHES case and ioremap_* could do
whatever it wanted under the hood.

Thougts?

-- 
Matt Fleming, Intel Open Source Technology Center
