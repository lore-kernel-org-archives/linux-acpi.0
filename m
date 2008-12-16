From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: reverted battery current conversion fix
Date: Tue, 16 Dec 2008 12:39:40 +0100
Message-ID: <87ljuggxhf.fsf@tac.ki.iif.hu>
References: <87zlixxaht.fsf@szonett.ki.iif.hu> <49476A1B.7020107@suse.de>
	<87tz94h08k.fsf@tac.ki.iif.hu> <49478749.8000900@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:33556 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752908AbYLPLjl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Dec 2008 06:39:41 -0500
In-Reply-To: <49478749.8000900@suse.de> (Alexey Starikovskiy's message of
	"Tue, 16 Dec 2008 13:47:37 +0300")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux-acpi@vger.kernel.org, "Rafael J.Wysocki" <rjw@sisk.pl>

Alexey Starikovskiy <astarikovskiy@suse.de> writes:

> Ferenc Wagner wrote:
>
>> Alexey Starikovskiy <astarikovskiy@suse.de> writes:
>>
>>> Ferenc Wagner wrote:
>>>
>>>> the wild values probably came from some application, which
>>>> previously worked around the wrong sysfs current value (supposedly
>>>> correctly interpreting it as power) and thus got broken by the fix.
>>>
>>> Yes, the application is kpowersaved and it is written with the
>>> assumption that it could get remaining time by dividing either
>>> energy_now or charge_now by current_now.
>>
>> So the first choice depends on the current buggy kernel behaviour.
>> What's the plan of action in such cases?  I found some notes that
>> kpowersaved can or could use HAL for getting this information, in
>> which case HAL also should be fixed.  At least their bug tracker[1] on
>> SF doesn't contain any such issue, maybe one should be added by
>> somebody actually using it if the kernel is to be fixed.
>
> Currently, Rafael suggests, that it is too late to fix the kernel...

Too late for 2.6.28 or too late for ever?  The ACPI sysfs interface
appeared about one year ago, if I read the git log right,
documentation followed this spring.  If the supposedly clean sysfs
interface can't live up to its very precise and well thought out
documentation, that should be documented at least.  :(  What a pity.
-- 
Regards,
Feri.
