From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v9 00/15] ACPI platform MSI support and its example mbigen
Date: Thu, 9 Mar 2017 21:22:41 +0800
Message-ID: <67f52db7-c7b4-1c60-e844-28fd406d14d5@linaro.org>
References: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
 <20170307144334.GB26990@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34869 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdCINXT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Mar 2017 08:23:19 -0500
Received: by mail-pf0-f172.google.com with SMTP id j5so28881517pfb.2
        for <linux-acpi@vger.kernel.org>; Thu, 09 Mar 2017 05:23:18 -0800 (PST)
In-Reply-To: <20170307144334.GB26990@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Sinan Kaya <okaya@codeaurora.org>, huxinwei@huawei.com, yimin@huawei.com, linuxarm@huawei.com

Hi Marc,

On 2017/3/7 22:43, Lorenzo Pieralisi wrote:
> On Tue, Mar 07, 2017 at 08:39:55PM +0800, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> With platform msi support landed in the kernel, and the introduction
>> of IORT for GICv3 ITS (PCI MSI) and SMMU, the framework for platform msi
>> is ready, this patch set add few patches to enable the ACPI platform
>> msi support.
>>
>> For platform device connecting to ITS on arm platform, we have IORT
>> table with the named componant node to describe the mappings of paltform
>> device and ITS, so we can retrieve the dev id and find its parent
>> irqdomain (ITS) from IORT table (simlar with the ACPI ITS support).
>>
>> v8 -> v9:
>> 	- Rebased on top of 4.11-rc1 and retest;
>> 	- Some of patch's commit message was updated by Lorenzo and
>> 	  it's clearer (thanks!)
>>
>> No update in the code, hope it's the final revision.
>
> I will be off the radar till -rc3 but I do not expect major changes
> to the series in its current form given that dependencies were merged
> in the merge window (ACPI IRQ probe deferral and IORT fixes).

What's your opinion on this patch set? especially for the last 3
patches for mbigen driver, please comment on it to see if I need
to take further steps.

Thanks
Hanjun
