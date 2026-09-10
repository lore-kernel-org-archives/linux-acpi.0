Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEF043498E
	for <linux-acpi@vger.kernel.org>; Thu, 10 Sep 2026 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038226; cv=none; b=UYSxHsgUiULjZ4HBdcQD1snle23S7C6LX/Y0DxhkQAYU7J7iGk+juP7Rkt1r8tl9GoE4cyGDQVT3EEkDMgOzVhLWF7W/xxXLkyjJMcwjRso9QIPhGulJCQsYjZC6LtzT9VdNJqv4ebyEFs17gAC64v9d+czJ3n3tzevGAnFD6IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038226; c=relaxed/simple;
	bh=09m9BcpaN3q+ASCDSpZj070GBGLeq+f9Ppn2JgpSzYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCCfSNdS6Ea9+uOYvh6vzrG4zh2HmLZQMLDqJVoAzgvE59y10VXz1flmg/T86LrRgarkoa1bNcC9/r3+WXyegrK/W7RMJvODw7ZqIjULRsZ43/7EBxAAjK+8iLX5eGmdx5LoDOYB0rWklcsFEMcLlpTqTZNcyBZr3Bw7RVdwMyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 45777c7ead0711f19a56ed5b684f684d-20260910
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:641f06fe-aeb9-461f-a88d-18c79e238145,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:df30dabc3cffd7d9f198215724e963ed,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 45777c7ead0711f19a56ed5b684f684d-20260910
X-User: lijun01@kylinos.cn
Received: from [172.30.70.202] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1667665250; Thu, 10 Sep 2026 19:03:36 +0800
Message-ID: <efe67e88-35d8-4f51-8ff5-a95053562b23@kylinos.cn>
Date: Thu, 10 Sep 2026 19:03:34 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: button: replace SIMPLE_DEV_PM_OPS with
 DEFINE_SIMPLE_DEV_PM_OPS
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org
References: <20260910014953.187180-1-lijun01@kylinos.cn>
 <CAJZ5v0gkhGdyoQ6t7yjY8LWJd12zVb9P1Ep3W1+kL48B=BgS5A@mail.gmail.com>
Content-Language: en-US
From: lijun <lijun01@kylinos.cn>
In-Reply-To: <CAJZ5v0gkhGdyoQ6t7yjY8LWJd12zVb9P1Ep3W1+kL48B=BgS5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Apologies missing your earlier point.

Thanks for the patience.

  2026/9/10 18:32, Rafael J. Wysocki (Intel) :
> On Thu, Sep 10, 2026 at 3:50 AM Li Jun <lijun01@kylinos.cn> wrote:
>> Replace `SIMPLE_DEV_PM_OPS` and `#ifdef CONFIG_PM_SLEEP`
>> boilerplate with the modern `DEFINE_SIMPLE_DEV_PM_OPS()`
>> macro in the acpi_button driver.
> So again, this is not a replacement as it actively makes the kernel
> waste memory in certain configurations.
>
>> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> I guess my previous comment that I didn't see any point in making
> these changes was not clear enough.
>
> I'm not going to apply this.
>
>> ---
>> Changes:
>> -Add pm_sleep_ptr for acpi_button_pm in acpi_button_driver.
>> -Fix the warning:
>>>> drivers/acpi/button.c:164:12: warning: function 'acpi_button_suspend' has internal linkage but is not defined [-Wundefined-internal]
>>       164 | static int acpi_button_suspend(struct device *dev);
>>           |            ^
>>     drivers/acpi/button.c:167:49: note: used here
>>       167 | static DEFINE_SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acpi_button_resume);
>>           |                                                 ^
>>>> drivers/acpi/button.c:165:12: warning: function 'acpi_button_resume' has internal linkage but is not defined [-Wundefined-internal]
>>       165 | static int acpi_button_resume(struct device *dev);
>>           |            ^
>>     drivers/acpi/button.c:167:70: note: used here
>>       167 | static DEFINE_SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acpi_button_resume);
>>           |                                                                      ^
>>     2 warnings generated.
>> ---
>>   drivers/acpi/button.c | 12 +++---------
>>   1 file changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
>> index cdbb1023a8ee..1df7e268c4dd 100644
>> --- a/drivers/acpi/button.c
>> +++ b/drivers/acpi/button.c
>> @@ -161,14 +161,10 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
>>   static int acpi_button_probe(struct platform_device *pdev);
>>   static void acpi_button_remove(struct platform_device *pdev);
>>
>> -#ifdef CONFIG_PM_SLEEP
>>   static int acpi_button_suspend(struct device *dev);
>>   static int acpi_button_resume(struct device *dev);
>> -#else
>> -#define acpi_button_suspend NULL
>> -#define acpi_button_resume NULL
>> -#endif
>> -static SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acpi_button_resume);
>> +
>> +static DEFINE_SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acpi_button_resume);
>>
>>   static struct platform_driver acpi_button_driver = {
>>          .probe = acpi_button_probe,
>> @@ -176,7 +172,7 @@ static struct platform_driver acpi_button_driver = {
>>          .driver = {
>>                  .name = "acpi-button",
>>                  .acpi_match_table = button_device_ids,
>> -               .pm = &acpi_button_pm,
>> +               .pm = pm_sleep_ptr(&acpi_button_pm),
>>          },
>>   };
>>
>> @@ -502,7 +498,6 @@ static u32 acpi_button_event(void *data)
>>          return ACPI_INTERRUPT_HANDLED;
>>   }
>>
>> -#ifdef CONFIG_PM_SLEEP
>>   static int acpi_button_suspend(struct device *dev)
>>   {
>>          struct acpi_button *button = dev_get_drvdata(dev);
>> @@ -532,7 +527,6 @@ static int acpi_button_resume(struct device *dev)
>>          }
>>          return 0;
>>   }
>> -#endif
>>
>>   static int acpi_lid_input_open(struct input_dev *input)
>>   {
>> --
>> 2.25.1
>>
