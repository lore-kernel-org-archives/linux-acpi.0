From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 2/3] acpi, apei, ghes: Make NMI error notification to
 be GHES architecture extension.
Date: Fri, 4 Jul 2014 12:37:31 +0200
Message-ID: <20140704103731.GA9246@pd.tnic>
References: <1403610095-5354-1-git-send-email-tomasz.nowicki@linaro.org>
 <1403610095-5354-3-git-send-email-tomasz.nowicki@linaro.org>
 <20140702121645.GF1318@pd.tnic>
 <53B64F3C.6080502@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:42664 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757696AbaGDKhn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Jul 2014 06:37:43 -0400
Content-Disposition: inline
In-Reply-To: <53B64F3C.6080502@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>, rjw@rjwysocki.net
Cc: lenb@kernel.org, tony.luck@intel.com, m.chehab@samsung.com, bp@suse.de, linux-edac@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, rric@kernel.org

On Fri, Jul 04, 2014 at 08:52:44AM +0200, Tomasz Nowicki wrote:
> Right, I will fix that and thanks for all you acks.
> 
> BTW, who else should I asked for review to move upstream process one step
> further?

I think you have enough people on CC and if they would find cycles to
review them, they're welcome to do so.

But the patches have gotten pretty neat and clean in the meantime so I
think Rafael could go over them quickly and maybe even pick them up...

:-)

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
