From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v6 02/14] irqchip: gic-v3-its: keep the head file include
 in alphabetic order
Date: Wed, 11 Jan 2017 22:16:40 +0800
Message-ID: <58763E48.9050006@linaro.org>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org> <1483363905-2806-3-git-send-email-hanjun.guo@linaro.org> <ef759a3a-bbdb-2586-24a8-6ad650b07d41@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35865 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967195AbdAKOQy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jan 2017 09:16:54 -0500
Received: by mail-pf0-f175.google.com with SMTP id 189so50479612pfu.3
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2017 06:16:53 -0800 (PST)
In-Reply-To: <ef759a3a-bbdb-2586-24a8-6ad650b07d41@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Brugger <mbrugger@suse.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: huxinwei@huawei.com, Kefeng Wang <wangkefeng.wang@huawei.com>, charles.garcia-tobin@arm.com, Jon Masters <jcm@redhat.com>, yimin@huawei.com, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, Tomasz Nowicki <tn@semihalf.com>, Thomas Gleixner <tglx@linutronix.de>, Agustin Vega-Frias <agustinv@codeaurora.org>, linux-arm-kernel@lists.infradead.org, Ma Jun <majun258@huawei.com>

On 01/11/2017 06:20 PM, Matthias Brugger wrote:
>
>
> On 02/01/17 14:31, Hanjun Guo wrote:
>> The head file is strictly in alphabetic order now, so let's
>> be the rule breaker. As acpi_iort.h includes acpi.h so remove
>> the duplidate acpi.h inclusion as well.
>>
>
> Sounds strange, maybe someting like:
> Rearrange header file includes to alphabetic order. As acpi_iort.h...

It's better, will update the patch.

Thanks
Hanjun
