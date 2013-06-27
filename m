From: Naresh Bhat <naresh.bhat@linaro.org>
Subject: Re: [PATCH] ACPI/fan: Initialize acpi_state variable
Date: Thu, 27 Jun 2013 18:37:35 +0530
Message-ID: <CAFoFrHaUbjHbvDDVO0+1j4WSTdhdrWF64MrNvzKNJXaLKSv_jw@mail.gmail.com>
References: <1372331314-31010-1-git-send-email-naresh.bhat@linaro.org>
	<6743122.cV0P3hQa28@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:59867 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab3F0NHg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jun 2013 09:07:36 -0400
Received: by mail-ob0-f170.google.com with SMTP id ef5so704994obb.15
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jun 2013 06:07:36 -0700 (PDT)
In-Reply-To: <6743122.cV0P3hQa28@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org

Hi Rafael,

You mean I need to initialize using ACPI_STATE_D0 ? and resend the patc=
h ?

Thanks
-Naresh Bhat

On 27 June 2013 17:58, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, June 27, 2013 04:38:34 PM naresh.bhat@linaro.org wrote:
>> From: Naresh Bhat <naresh.bhat@linaro.org>
>>
>>   CC      drivers/acpi/fan.o
>> drivers/acpi/fan.c: In function =91fan_get_cur_state=92:
>> drivers/acpi/fan.c:96:9: warning: =91acpi_state=92 may be used unini=
tialized in this function [-Wuninitialized]
>> ---
>>  drivers/acpi/fan.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
>> index f815da8..f61f7fd 100644
>> --- a/drivers/acpi/fan.c
>> +++ b/drivers/acpi/fan.c
>> @@ -84,7 +84,7 @@ static int fan_get_cur_state(struct thermal_coolin=
g_device *cdev, unsigned long
>>  {
>>       struct acpi_device *device =3D cdev->devdata;
>>       int result;
>> -     int acpi_state;
>> +     int acpi_state =3D 0;
>
> Please use an appropriate symbol here.
>
>>
>>       if (!device)
>>               return -EINVAL;
>>
>
> Thanks,
> Rafael
>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
