From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: [PATCH 1/7] apei, mce: Call MCE-specific code only for X86 architecture.
Date: Mon, 05 May 2014 17:36:48 +0200
Message-ID: <5367B010.9060506@linaro.org>
References: <1397056476-9183-1-git-send-email-tomasz.nowicki@linaro.org> <1397056476-9183-2-git-send-email-tomasz.nowicki@linaro.org> <20140505114445.GB4373@pd.tnic> <5367A181.3060300@linaro.org> <20140505145331.GC4373@pd.tnic> <5367AEF7.40804@linaro.org> <20140505153348.GD4373@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:60112 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530AbaEEPge (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 May 2014 11:36:34 -0400
Received: by mail-ee0-f43.google.com with SMTP id d17so885571eek.30
        for <linux-acpi@vger.kernel.org>; Mon, 05 May 2014 08:36:32 -0700 (PDT)
In-Reply-To: <20140505153348.GD4373@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@suse.de, m.chehab@samsung.com, linux-edac@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 05.05.2014 17:33, Borislav Petkov wrote:
> On Mon, May 05, 2014 at 05:32:07PM +0200, Tomasz Nowicki wrote:
>> You are right! I will fix that big misunderstanding from my side in
>> next patch version.
>
> Ok, but pls wait with resubmitting until I take a look at the rest of
> your patches.

Sure, I will.
