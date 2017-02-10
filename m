From: Ganapatrao Kulkarni <gpkulkarni@gmail.com>
Subject: Re: [PATCH v14 0/6] Enable PMUs in ACPI systems
Date: Fri, 10 Feb 2017 11:36:36 +0530
Message-ID: <CAFpQJXVjMuEKE-LqN57v8Txzj6A=Hccj07XWbBaR_dRgiCLNQg@mail.gmail.com>
References: <1485210765-9422-1-git-send-email-jeremy.linton@arm.com> <cea38f4f-4696-baab-b539-f9d0a8db3f42@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32908 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbdBJGG6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2017 01:06:58 -0500
Received: by mail-oi0-f67.google.com with SMTP id j15so1896058oih.0
        for <linux-acpi@vger.kernel.org>; Thu, 09 Feb 2017 22:06:37 -0800 (PST)
In-Reply-To: <cea38f4f-4696-baab-b539-f9d0a8db3f42@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, steve.capper@arm.com, mlangsdorf@redhat.com, Punit Agrawal <punit.agrawal@arm.com>, Will Deacon <will.deacon@arm.com>, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, "msalter@redhat.com" <msalter@redhat.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, Jayachandran.Nair@cavium.com

On Tue, Jan 24, 2017 at 1:19 PM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>
>
> On 2017/1/24 6:32, Jeremy Linton wrote:
>>
>> This patch expands and reworks the patches published by Mark Salter
>> in order to clean up a few of the previous review comments, as well as
>> add support for newer CPUs and big/little configurations.
>>
>> v14:
>> - drop rename patch requested for v6
>> - Shuffle couple include lines from one patch to a later
>>   patch.
>
>
> Test again on D03 and works fine as before,
>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
>
> Hanjun

Tested this series on Cavium's ThunderX2 CN99XX platform.

Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

thanks
Ganapat
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
