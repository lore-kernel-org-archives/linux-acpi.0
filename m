From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH] ACPI:video: skip evaluating _DOD when it does not exist
Date: Mon, 6 Jun 2016 09:36:13 +0800
Message-ID: <CAJ=jqubsDwA610rLLfMdq6zDrwhBpe5_72T6RU6zh1S__G=zFQ@mail.gmail.com>
References: <1464335226-11212-1-git-send-email-alex.hung@canonical.com> <20160603060401.GA8618@aaronlu.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:33065 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbcFFBgP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Jun 2016 21:36:15 -0400
Received: by mail-vk0-f43.google.com with SMTP id d64so57295172vkb.0
        for <linux-acpi@vger.kernel.org>; Sun, 05 Jun 2016 18:36:14 -0700 (PDT)
In-Reply-To: <20160603060401.GA8618@aaronlu.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

On Fri, Jun 3, 2016 at 2:04 PM, Aaron Lu <aaron.lu@intel.com> wrote:
> On Fri, May 27, 2016 at 03:47:06PM +0800, Alex Hung wrote:
>> Some system supports hybrid graphics and its discrete VGA
>> does not have any connectors and therefore has no _DOD method.
>>
>> Signed-off-by: Alex Hung <alex.hung@canonical.com>
>> ---
>>  drivers/acpi/acpi_video.c |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
>> index 5fdac39..549cdbe 100644
>> --- a/drivers/acpi/acpi_video.c
>> +++ b/drivers/acpi/acpi_video.c
>> @@ -1211,6 +1211,9 @@ static int acpi_video_device_enumerate(struct acpi_video_bus *video)
>>       union acpi_object *dod = NULL;
>>       union acpi_object *obj;
>>
>> +     if (!video->cap._DOD)
>> +             return AE_NOT_EXIST;
>> +
>>       status = acpi_evaluate_object(video->device->handle, "_DOD", NULL, &buffer);
>>       if (!ACPI_SUCCESS(status)) {
>>               ACPI_EXCEPTION((AE_INFO, status, "Evaluating _DOD"));
>
> Is the patch supposed to avoid the above error message?
> I'm OK with the patch though, it's just not clear to me the point since
> the acpi_evaluate_object should probably also return AE_NOT_EXIST.

Yes it is to avoid the error message.  As _DOD is checked and it is
known a specific video device does not have it, the error message can
be confusing.


>
> Thanks,
> Aaron

-- 
Cheers,
Alex Hung
