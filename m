From: Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH] rtc: don't write RTC century when setting a wake alarm
Date: Sun, 04 Nov 2007 14:42:38 -0500
Message-ID: <472E20AE.3000906@rtr.ca>
References: <200710160828.l9G8SLYi018406@imap1.linux-foundation.org> <200711031414.03407.david-b@pacbell.net> <472D2B63.9010608@rtr.ca> <200711041050.53261.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2290 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753708AbXKDTmk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 4 Nov 2007 14:42:40 -0500
In-Reply-To: <200711041050.53261.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: akpm@linux-foundation.org, Linus Torvalds <torvalds@osdl.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

David Brownell wrote:
> On Saturday 03 November 2007, Mark Lord wrote:
>> David Brownell wrote:
>> ..
>>> While you're fixing goofs in this general area, you might make that
>>> /proc/acpi/alarm file not write the century when it changes the
>>> alarm.  That field isn't relevant to the alarm triggering.
>> You mean like this?
> 
> Yes, but you found another little nest of bugs.  I'm
> surprised this little bit of ACPI code is so buggy!!
> 
> I Cc'd Len Brown; ACPI patches should be submitted
> through the ACPI team, as a rule.  Even for code they
> are slowly getting rid of.  ;)
> 
>> This patch (against 2.6.24-rc1-git12) fixes /proc/acpi/alarm to not
>> overwrite the RTC century field when setting a wake alarm.
>> The alarm hardware doesn't have a century field, and we really
>> should not be fiddling with the RTC century field here.
>>
>> Signed-off-by: Mark Lord <mlord@pobox.com>
>> ---
>> --- a/drivers/acpi/sleep/proc.c	2007-11-03 16:24:15.000000000 -0400
>> +++ b/drivers/acpi/sleep/proc.c	2007-11-03 22:10:14.000000000 -0400
>> @@ -268,7 +268,6 @@
>>  		day -= 31;
>>  	}
>>  	if (mo > 12) {
>> -		yr += 1;
> 
> This is an unrelated nest of bugs; I'd not change that with
> this patch.  I think that whole block of code trying to fix
..

I'm not trying to fix anything other than removing the write
to the century register (near the bottom).  However, once that
write has been removed, there is no other use for the "yr",
so the rest of the patch is simply getting rid of it everywhere
where it looked safe to do so.

..

> broken alarm times is dubious, and I can't see why broken
> values shouldn't just cause an "-EINVAL" return.  Notice it
> accepts illegal dates like November 31 (or February 30) too..
> 
> 
>>  		mo -= 12;
>>  	}
>>  
>> @@ -277,7 +276,6 @@
>>  	rtc_control = CMOS_READ(RTC_CONTROL);
>>  
>>  	if (adjust) {
>> -		yr += cmos_bcd_read(RTC_YEAR, rtc_control);
>>  		mo += cmos_bcd_read(RTC_MONTH, rtc_control);
>>  		day += cmos_bcd_read(RTC_DAY_OF_MONTH, rtc_control);
>>  		hr += cmos_bcd_read(RTC_HOURS, rtc_control);
>> @@ -304,7 +302,6 @@
>>  		day -= 31;
>>  	}
>>  	if (mo > 12) {
>> -		yr++;
> 
> Not the same.  This block of code would make more sense if
> it were in that "if (adjust) ..." block.  If the preceding
> block returns an error, this one will become a NOP unless
> the alarm was adjusted; it's more just ugly code than a
> set of bugs.
> 
> However ... this code is missing range validation checks.
> 
> If I try to set an alarm two days in the future, and this
> chip only supports 24 hour alarms (FADT.day_alarm is zero),
> that would seem to be a case where this legacy code should
> report an error.  Likewise with two months in the future
> (with FADT.month_alarm or FADT.day_alarm zero) ... or over
> one year from now, in every case.
> 
> 
>>  		mo -= 12;
>>  	}
>>  
>> @@ -331,8 +328,6 @@
>>  		cmos_bcd_write(day, acpi_gbl_FADT.day_alarm, rtc_control);
>>  	if (acpi_gbl_FADT.month_alarm)
>>  		cmos_bcd_write(mo, acpi_gbl_FADT.month_alarm, rtc_control);
>> -	if (acpi_gbl_FADT.century)
>> -		cmos_bcd_write(yr / 100, acpi_gbl_FADT.century, rtc_control);
> 
> This is what I was referring to, and that change is correct.
> 
> You're right to strip out use of the "year" field entirely,
> unless range validation gets added.
> 
> 
>>  	/* enable the rtc alarm interrupt */
>>  	rtc_control |= RTC_AIE;
>>  	CMOS_WRITE(rtc_control, RTC_CONTROL);
>>
> 

