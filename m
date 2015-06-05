From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V2 3/3] acpi, apei: use EFI memmap to map GHES memory
Date: Fri, 5 Jun 2015 19:12:10 +0200
Message-ID: <20150605171210.GM3679@pd.tnic>
References: <1433185940-24770-1-git-send-email-zjzhang@codeaurora.org>
 <1433185940-24770-4-git-send-email-zjzhang@codeaurora.org>
 <20150605095701.GA20042@codeblueprint.co.uk>
 <20150605102556.GC3679@pd.tnic>
 <5571D6C9.10903@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5571D6C9.10903@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Zhang, Jonathan Zhixiong" <zjzhang@codeaurora.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>, rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com, leif.lindholm@linaro.org, al.stone@linaro.org, fu.wei@linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linaro-acpi@lists.linaro.org, vgandhi@codeaurora.org, Tony Luck <tony.luck@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 05, 2015 at 10:05:13AM -0700, Zhang, Jonathan Zhixiong wrote:
> >What is DDR?
> >
> >I think this needs to be clarified first before we go any further.
> I thought the word "memory" might be confusing, because there are

So you mean normal RAM here?

> memories on the system that is not accessible by Linux. In this
> context, the APEI error data is accessed (read and write) by both Linux
> and platform firmware; hence both sides should access the memory using
> same cache attribute. I wanted to emphasize the idea that even though
> normally DDR is cachable, but in this case when platform access it with
> un-cached attribute, Linux should do the same.

Makes sense.

Btw, do we need synchronization between firmware and Linux then? Does
Linux need to know when it is ok to touch that memory?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
