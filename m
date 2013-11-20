From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH 03/12] ACPI: clean up compiler warning about uninitialized
 field
Date: Wed, 20 Nov 2013 14:13:27 -0700
Message-ID: <528D25F7.1070409@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1384047382-20623-4-git-send-email-al.stone@linaro.org> <4042434.RvYhsSOGPS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:56508 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222Ab3KTVN3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Nov 2013 16:13:29 -0500
Received: by mail-ie0-f172.google.com with SMTP id qd12so5377299ieb.31
        for <linux-acpi@vger.kernel.org>; Wed, 20 Nov 2013 13:13:29 -0800 (PST)
In-Reply-To: <4042434.RvYhsSOGPS@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On 11/17/2013 02:58 PM, Rafael J. Wysocki wrote:
> On Saturday, November 09, 2013 06:36:13 PM al.stone@linaro.org wrote:
>> From: Al Stone <ahs3@redhat.com>
>
> Any changelog?  Some people use git logs to check what patches do and that
> is not particularly clear from the subject.

Argh.  Yup.  Stupid mistake on my part.  I'll fix it.

> Besides, this looks like a genuine fix not related directly to HW reduced,
> in which case why don't you submit it separately?

Fair enough.  I'll send this independently.

>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> ---
>>   drivers/acpi/sleep.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
>> index 14df305..721e949 100644
>> --- a/drivers/acpi/sleep.c
>> +++ b/drivers/acpi/sleep.c
>> @@ -525,7 +525,7 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
>>   	 * generate wakeup events.
>>   	 */
>>   	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3)) {
>> -		acpi_event_status pwr_btn_status;
>> +		acpi_event_status pwr_btn_status = ACPI_EVENT_FLAG_DISABLED;
>>
>>   		acpi_get_event_status(ACPI_EVENT_POWER_BUTTON, &pwr_btn_status);
>>
>>


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
