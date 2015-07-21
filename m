From: "Zhang, Jonathan Zhixiong" <zjzhang@codeaurora.org>
Subject: Re: [PATCH V3 4/4] acpi, apei: use EFI memmap to map GHES memory
Date: Mon, 20 Jul 2015 17:22:06 -0700
Message-ID: <55AD90AE.6030804@codeaurora.org>
References: <E1ZG8Pn-0002uB-2C@feisty.vs19.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42603 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932178AbbGUAWJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jul 2015 20:22:09 -0400
In-Reply-To: <E1ZG8Pn-0002uB-2C@feisty.vs19.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matt Fleming <matt@codeblueprint.co.uk>, bp@alien8.de
Cc: Thomas Gleixner <tglx@linutronix.de>, fu.wei@linaro.org, al.stone@linaro.org, tony.luck@gmail.com, rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

Hi Matt/Borislav, thanks for the discussion. I am sorry that somehow
I did not see this message in my inbox. I found it by surprise through
an internet search.

> On Mon, 22 Jun, at 06:11:31AM, Matt Fleming wrote:
>>
>> Right, but see my previous comment about x86 discarding a bunch of
>> attributes for memory regions because the kernel "knows better".
>>
>> And in most places, yes, the kernel really does know better. But this
>> APEI case is special because irrespective of what the kernel says we
>> want to be compatible with the firmware's memory map.
>>
>> And we don't have an API for that.
>
> Maybe what we want is a new PAGE_* protection that is compatible with
> any firmware mappings? That'd be nice because we wouldn't have to
> introduce a whole new API for this GHES case and ioremap_* could do
> whatever it wanted under the hood.
>
> Thougts?
>
Agree. That being said, I do not know if this GHES case is the only
user case that will benefit from such framework. If it is, then it may
be controversial to introduce a framework for only one use case.

To me, there are two ways that will help GHES case:
a. Define ioremap_page_range_[no]cache() functions for archs, similar
like the case for ioremap_[no]cache.
b. Define a set of PAGE_* protection types (in particular
PAGE_KERNEL_NOCACHE). Right now it seems like only a few protection
types (such as PAGE_KERNEL) are defined across the archs.

-- 
Jonathan (Zhixiong) Zhang
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
