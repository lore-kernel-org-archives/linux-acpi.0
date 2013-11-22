From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH v2 4/6] ACPI: ARM: exclude DMI calls
Date: Fri, 22 Nov 2013 11:03:17 -0700
Message-ID: <528F9C65.7010302@linaro.org>
References: <1385080915-23430-1-git-send-email-al.stone@linaro.org>	<1385080915-23430-5-git-send-email-al.stone@linaro.org> <CAL_JsqKbL2Zhpbg8wp4qZekZwJO20njUO4nCzzz1KZexmK9tLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:62189 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab3KVSDU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2013 13:03:20 -0500
Received: by mail-ie0-f182.google.com with SMTP id as1so2660983iec.27
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2013 10:03:19 -0800 (PST)
In-Reply-To: <CAL_JsqKbL2Zhpbg8wp4qZekZwJO20njUO4nCzzz1KZexmK9tLQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-acpi@vger.kernel.org, Linaro Patches <patches@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, linaro-acpi@lists.linaro.org

On 11/22/2013 06:25 AM, Rob Herring wrote:
> On Thu, Nov 21, 2013 at 6:41 PM,  <al.stone@linaro.org> wrote:
>> From: Al Stone <al.stone@linaro.org>
>>
>> Modified #ifdef so that DMI is not used on ARM platforms which
>> are currently implementing ACPI reduced HW mode.
>
> It is really not allowed or is optional? There are various people that
> want DMI tables on ARM.
>
> Rob

True.  DMI is optional.  I see it as orthogonal to
reduced HW mode; I have to hope that when DMI patches
are forthcoming they'll do the right thing here.

Is there a better way to do this in the #if ?

>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> ---
>>   include/linux/dmi.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/dmi.h b/include/linux/dmi.h
>> index f820f0a..a03deb8 100644
>> --- a/include/linux/dmi.h
>> +++ b/include/linux/dmi.h
>> @@ -83,7 +83,7 @@ struct dmi_device {
>>          void *device_data;      /* Type specific data */
>>   };
>>
>> -#ifdef CONFIG_DMI
>> +#if IS_ENABLED(CONFIG_DMI) && !IS_ENABLED(CONFIG_ACPI_REDUCED_HARDWARE)
>>
>>   struct dmi_dev_onboard {
>>          struct dmi_device dev;
>> --
>> 1.8.3.1
>>
>>
>> _______________________________________________
>> linaro-kernel mailing list
>> linaro-kernel@lists.linaro.org
>> http://lists.linaro.org/mailman/listinfo/linaro-kernel


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
