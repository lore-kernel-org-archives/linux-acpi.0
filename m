From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI:video: skip evaluating _DOD when it does not exist
Date: Mon, 6 Jun 2016 09:52:29 +0800
Message-ID: <41d58f4f-329d-e21b-22b2-67d329adc7b8@intel.com>
References: <1464335226-11212-1-git-send-email-alex.hung@canonical.com>
 <20160603060401.GA8618@aaronlu.sh.intel.com>
 <CAJ=jqubsDwA610rLLfMdq6zDrwhBpe5_72T6RU6zh1S__G=zFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:16108 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878AbcFFBwc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 5 Jun 2016 21:52:32 -0400
In-Reply-To: <CAJ=jqubsDwA610rLLfMdq6zDrwhBpe5_72T6RU6zh1S__G=zFQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

On 06/06/2016 09:36 AM, Alex Hung wrote:
> On Fri, Jun 3, 2016 at 2:04 PM, Aaron Lu <aaron.lu@intel.com> wrote:
>> On Fri, May 27, 2016 at 03:47:06PM +0800, Alex Hung wrote:
>>> Some system supports hybrid graphics and its discrete VGA
>>> does not have any connectors and therefore has no _DOD method.
>>>
>>> Signed-off-by: Alex Hung <alex.hung@canonical.com>
>>> ---
>>>  drivers/acpi/acpi_video.c |    3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
>>> index 5fdac39..549cdbe 100644
>>> --- a/drivers/acpi/acpi_video.c
>>> +++ b/drivers/acpi/acpi_video.c
>>> @@ -1211,6 +1211,9 @@ static int acpi_video_device_enumerate(struct acpi_video_bus *video)
>>>       union acpi_object *dod = NULL;
>>>       union acpi_object *obj;
>>>
>>> +     if (!video->cap._DOD)
>>> +             return AE_NOT_EXIST;
>>> +
>>>       status = acpi_evaluate_object(video->device->handle, "_DOD", NULL, &buffer);
>>>       if (!ACPI_SUCCESS(status)) {
>>>               ACPI_EXCEPTION((AE_INFO, status, "Evaluating _DOD"));
>>
>> Is the patch supposed to avoid the above error message?
>> I'm OK with the patch though, it's just not clear to me the point since
>> the acpi_evaluate_object should probably also return AE_NOT_EXIST.
> 
> Yes it is to avoid the error message.  As _DOD is checked and it is
> known a specific video device does not have it, the error message can
> be confusing.

I see, thanks.

Reviewed-by: Aaron Lu <aaron.lu@intel.com>

Thanks,
Aaron
