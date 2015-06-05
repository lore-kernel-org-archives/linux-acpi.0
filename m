From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V2 3/3] acpi, apei: use EFI memmap to map GHES memory
Date: Fri, 5 Jun 2015 18:50:45 +0200
Message-ID: <20150605165045.GL3679@pd.tnic>
References: <1433185940-24770-1-git-send-email-zjzhang@codeaurora.org>
 <1433185940-24770-4-git-send-email-zjzhang@codeaurora.org>
 <20150605095701.GA20042@codeblueprint.co.uk>
 <5571D1AE.4050605@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5571D1AE.4050605@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zhang, Jonathan Zhixiong" <zjzhang@codeaurora.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>, rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com, leif.lindholm@linaro.org, al.stone@linaro.org, fu.wei@linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linaro-acpi@lists.linaro.org, vgandhi@codeaurora.org, Tony Luck <tony.luck@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 05, 2015 at 09:43:26AM -0700, Zhang, Jonathan Zhixiong wrote:
> Thanks Matt for the review. Yes, you are right on, I am following
> this:
> > modify ghes_ioremap_* to query the EFI memmap (if
> > it's available at runtime) to lookup the correct mapping attributes.

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

So please do not top-post.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
