From: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>
Subject: RE: Compaq V2000 Fan Control
Date: Mon, 3 Apr 2006 19:38:22 +0400
Message-ID: <E124AAE027DA384D8B919F93E4D8C708018E7C5C@mssmsx402nb>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:402 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751735AbWDCPkn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Apr 2006 11:40:43 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Bonilla, Alejandro" <abonilla@linuxwireless.org>
Cc: linux-acpi@vger.kernel.org

Hi,

If you have any devices with 'PNP0C0B' ID in your DSDT then there is a
chance that you can assign it to _ALx method in thermal zone.

Anyway, posting your DSDT would help to clarify the issue. 

Regards.
Konstantin.

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Bonilla, Alejandro
>Sent: Tuesday, March 28, 2006 4:41 AM
>To: Karasyov, Konstantin A
>Cc: linux-acpi@vger.kernel.org
>Subject: RE: Compaq V2000 Fan Control
>
>On Mon, 2006-03-27 at 16:25 +0400, Karasyov, Konstantin A wrote:
>> Hi,
>>
>> >cat /proc/acpi/thermal_zone/THR1/trip_points
>> >critical (S5):           95 C
>> >passive:                 88 C: tc1=2 tc2=3 tsp=50 devices=0xdf64a940
>>
>> This means, that you don't have fan control (i.e. active cooling)
>> through ACPI functionality - only passive cooling (i.e. decreasing
>> frequency, using throttling) is possible for this thermal zone. So,
in
>> this string
>
>I know I don't have it. Is there a way to debug this and see if it
could
>occur or if it just could be that it needs a tweak? Or is definitely
not
>going to work?
>
>.Alejandro
>
>>
>> >echo 100:0:50:80:70:50 > /proc/acpi/thermal_zone/THR1/trip_points
>>
>> the only meaningful values are the first and the third (but at least
5
>> trip points are required -
>> <critical>:<hot>:<passive>:<active0>:<active1>)
>>
>>
>> Regards.
>> Konstantin.
>>
>> >-----Original Message-----
>> >From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>> >owner@vger.kernel.org] On Behalf Of Bonilla, Alejandro
>> >Sent: Friday, March 24, 2006 11:28 PM
>> >To: linux-acpi@vger.kernel.org
>> >Subject: Compaq V2000 Fan Control
>> >
>> >Hi,
>> >
>> >I'm trying to make my Compaq laptop give me control over the fan
using
>> >ACPI, but this ain't working. I have to be honest. I don't know much
>> >about debugging acpi or about tools that will tell me much more.
>> >
>> >Here is what I try:
>> >
>> >echo 100:0:50:80:70:50 > /proc/acpi/thermal_zone/THR1/trip_points
>> >
>> >If I set the critical to a value lower than what it is now, it will
>> halt
>> >the PC, which is good. (100)
>> >
>> >If I set the passive to 50, nothing occurs. The Fan is not kicked if
>> the
>> >temp is higher, like 60c.
>> >
>> >I was told the last value is the one that triggers the Fan. Still,
it
>> >just won't work for me.
>> >
>> >This is the value that comes up on boot:
>> >cat /proc/acpi/thermal_zone/THR1/trip_points
>> >critical (S5):           95 C
>> >passive:                 88 C: tc1=2 tc2=3 tsp=50 devices=0xdf64a940
>> >
>> >If I set the critical value to something really low, the Fan will
kick
>> >in at it's full power and will try to cool down the PC, but that is
>> >while it's already halting.
>> >
>> >Anyone has a clue for me?
>> >
>> >Thanks,
>> >.Alejandro
>> >
>> >
>> >-
>> >To unsubscribe from this list: send the line "unsubscribe
linux-acpi"
>> in
>> >the body of a message to majordomo@vger.kernel.org
>> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
