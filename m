From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: Question about ACPI 6 and the Linux kernel
Date: Tue, 04 Aug 2015 18:05:50 +0800
Message-ID: <55C08E7E.50102@linaro.org>
References: <CAGXs5wVGn1DUXPw94cEXp5KZWq=bUCBpNPE_irgO32y94V8C0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:32828 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755162AbbHDKFz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Aug 2015 06:05:55 -0400
Received: by padck2 with SMTP id ck2so5004264pad.0
        for <linux-acpi@vger.kernel.org>; Tue, 04 Aug 2015 03:05:55 -0700 (PDT)
In-Reply-To: <CAGXs5wVGn1DUXPw94cEXp5KZWq=bUCBpNPE_irgO32y94V8C0g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kevin Wilson <wkevils@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Kevin,

On 08/04/2015 12:35 PM, Kevin Wilson wrote:
> Hi all,
> Is the current ACPI linux subsystem, that you find in the official Linus tree,
>   compliant (even partially) with ACPI 6 ? (which was released in April 2015)
>
> or is it now compliant only with ACPI 5 ?

ACPI 6 have lots of new features, such as add support for NVDIMM
(persistent memory), hierarchical lower-power idle states of CPUs, CPU
clusters, and some support for ARM platforms (GIC, SMMU and etc.),
and more...

so what the specific features are you referring to?

>
> What are the plans for ACPI 6? Is there already some git branch for it ?

For all the ACPI 6 new features, ACPICA already add its support in 4.2,
and some of the ACPI driver support also is ready, such as support for
persistent memory [1] is ready, and Linaro is leading the ACPI 6.0 for
ARM support, but as far as I can know, some of ACPI 6.0 features are
still under development at now.

I think the main support for ACPI 6.0 is in Rafael's tree:
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git

[1]: https://lwn.net/Articles/640891/

Thanks
Hanjun
