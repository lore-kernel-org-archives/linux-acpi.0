From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH] ACPI: clean up compiler warning about uninitialized field
Date: Wed, 20 Nov 2013 17:42:46 -0700
Message-ID: <528D5706.9080102@redhat.com>
References: <1384987551-13154-1-git-send-email-al.stone@linaro.org> <4847936.0VUS4BmLTm@vostro.rjw.lan> <6079837.5iZO4KGxNA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43697 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754052Ab3KUAmv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Nov 2013 19:42:51 -0500
In-Reply-To: <6079837.5iZO4KGxNA@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, al.stone@linaro.org
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org

On 11/20/2013 05:43 PM, Rafael J. Wysocki wrote:
> On Thursday, November 21, 2013 01:34:37 AM Rafael J. Wysocki wrote:
>> On Wednesday, November 20, 2013 03:45:51 PM al.stone@linaro.org wrote:
>>> From: Al Stone <ahs3@redhat.com>
>
> BTW, is it your intention to use different addresses for From: and
> Signed-off-by?
>
> I don't think it is formally invalid, but it certainly *is* confusing.

Ah, no, that was not the intent.  I'll fix my config problem.

>>> Initialize pwr_btn_status as disabled which (a) makes sure it is
>>> in a proper state to start, and (b) cleans up a compiler warning
>>> about an uninitialized variable.
>>>
>>> Signed-off-by: Al Stone <al.stone@linaro.org>
>>
>> Queued up for the next ACPI pull request, thanks!
>>
>>> ---
>>>   drivers/acpi/sleep.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
>>> index 14df305..721e949 100644
>>> --- a/drivers/acpi/sleep.c
>>> +++ b/drivers/acpi/sleep.c
>>> @@ -525,7 +525,7 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
>>>   	 * generate wakeup events.
>>>   	 */
>>>   	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3)) {
>>> -		acpi_event_status pwr_btn_status;
>>> +		acpi_event_status pwr_btn_status = ACPI_EVENT_FLAG_DISABLED;
>>>
>>>   		acpi_get_event_status(ACPI_EVENT_POWER_BUTTON, &pwr_btn_status);
>>>
>>>
>>


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
