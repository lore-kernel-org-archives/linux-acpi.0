From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] ACPI: Fix potential NULL pointer dereference in acpi_processor_add()
Date: Wed, 29 May 2013 09:38:51 +0800
Message-ID: <51A55C2B.7050805@linaro.org>
References: <519E0F2A.4070602@linaro.org> <1693841.iH9OWSxHyo@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:53770 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932863Ab3E2BkJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 May 2013 21:40:09 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so8634247pab.27
        for <linux-acpi@vger.kernel.org>; Tue, 28 May 2013 18:40:09 -0700 (PDT)
In-Reply-To: <1693841.iH9OWSxHyo@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org

On 2013-5-29 7:30, Rafael J. Wysocki wrote:
> On Thursday, May 23, 2013 08:44:26 PM Hanjun Guo wrote:
>> In acpi_processor_add(), get_cpu_device() will return NULL sometimes,
>> although the chances are small, I think it should be fixed.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> 
> This patch isn't necessary any more after the changes queued up for 3.11
> in the acpi-hotplug branch of the linux-pm.git tree.

Ok, I noticed your patch set, just drop my patch.

Thanks
Hanjun

> 
> Thanks,
> Rafael
> 
> 
>> ---
>>  drivers/acpi/processor_driver.c |    4 ++++
>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
>> index bec717f..dd64f23 100644
>> --- a/drivers/acpi/processor_driver.c
>> +++ b/drivers/acpi/processor_driver.c
>> @@ -579,6 +579,10 @@ static int __cpuinit acpi_processor_add(struct acpi_device
>> *device)
>>         per_cpu(processors, pr->id) = pr;
>>
>>         dev = get_cpu_device(pr->id);
>> +       if (!dev) {
>> +               result = -ENODEV;
>> +               goto err_clear_processor;
>> +       }
>>         if (sysfs_create_link(&device->dev.kobj, &dev->kobj, "sysdev")) {
>>                 result = -EFAULT;
>>                 goto err_clear_processor;
>>

