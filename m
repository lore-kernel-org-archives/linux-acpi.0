From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v5 09/14] ACPI: platform: setup MSI domain for ACPI based
 platform device
Date: Mon, 02 Jan 2017 20:02:29 +0800
Message-ID: <586A4155.3090905@linaro.org>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com> <1482384922-21507-10-git-send-email-guohanjun@huawei.com> <CAJZ5v0g4AoU-g4UWZFxLgQ_yfTC7KSBnZ_Ve945d+i58e=GuDQ@mail.gmail.com> <585E24FB.9050805@huawei.com> <CAJZ5v0itKF-uo7vGxK3+-X4OwBVYPdBw-b8v-8-CTBygpKMGoQ@mail.gmail.com> <586072E9.3060609@huawei.com> <58663C04.9000603@huawei.com> <CAJZ5v0h3d5ZUxJXhgz74fSDR=AKTg_Of2knaONF_e2dr6Q-PsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35109 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdABMCo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Jan 2017 07:02:44 -0500
Received: by mail-pg0-f46.google.com with SMTP id i5so138609239pgh.2
        for <linux-acpi@vger.kernel.org>; Mon, 02 Jan 2017 04:02:44 -0800 (PST)
In-Reply-To: <CAJZ5v0h3d5ZUxJXhgz74fSDR=AKTg_Of2knaONF_e2dr6Q-PsA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Sinan Kaya <okaya@codeaurora.org>, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, huxinwei@huawei.com, yimin@huawei.com, linuxarm@huawei.com, Jon Masters <jcm@redhat.com>

On 01/01/2017 04:45 AM, Rafael J. Wysocki wrote:
> On Fri, Dec 30, 2016 at 11:50 AM, Hanjun Guo <guohanjun@huawei.com> wrote:
[...]
>>
>> So how about just add the code as below?
>
> Works for me.

OK, will send out the updated patch set soon.

>
>> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
>> index 11e63dd..37a8dfe 100644
>> --- a/drivers/acpi/glue.c
>> +++ b/drivers/acpi/glue.c
>> @@ -316,7 +316,8 @@ static int acpi_platform_notify(struct device *dev)
>>          if (!adev)
>>                  goto out;
>>
>> + if (dev->bus == &platform_bus_type)
>> +         acpi_configure_pmsi_domain(dev);
>>
>>          if (type && type->setup)
>>                  type->setup(dev);

Thanks for your comments.

Hanjun
