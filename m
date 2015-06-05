From: "Zhang, Jonathan Zhixiong" <zjzhang@codeaurora.org>
Subject: Re: [PATCH V2 3/3] acpi, apei: use EFI memmap to map GHES memory
Date: Fri, 05 Jun 2015 10:06:57 -0700
Message-ID: <5571D731.4000809@codeaurora.org>
References: <1433185940-24770-1-git-send-email-zjzhang@codeaurora.org> <1433185940-24770-4-git-send-email-zjzhang@codeaurora.org> <20150605095701.GA20042@codeblueprint.co.uk> <5571D1AE.4050605@codeaurora.org> <20150605165045.GL3679@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54591 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422948AbbFERHA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jun 2015 13:07:00 -0400
In-Reply-To: <20150605165045.GL3679@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Matt Fleming <matt@codeblueprint.co.uk>, rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com, leif.lindholm@linaro.org, al.stone@linaro.org, fu.wei@linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linaro-acpi@lists.linaro.org, vgandhi@codeaurora.org, Tony Luck <tony.luck@gmail.com>

On 6/5/2015 9:50 AM, Borislav Petkov wrote:
> On Fri, Jun 05, 2015 at 09:43:26AM -0700, Zhang, Jonathan Zhixiong wrote:
>> Thanks Matt for the review. Yes, you are right on, I am following
>> this:
>>> modify ghes_ioremap_* to query the EFI memmap (if
>>> it's available at runtime) to lookup the correct mapping attributes.
>
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> So please do not top-post.
>
> Thanks.
>
Will do. Thanks for the advise, Borislav.

-- 
Jonathan (Zhixiong) Zhang
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
