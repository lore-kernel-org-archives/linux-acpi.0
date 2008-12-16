From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: reverted battery current conversion fix
Date: Tue, 16 Dec 2008 13:47:37 +0300
Message-ID: <49478749.8000900@suse.de>
References: <87zlixxaht.fsf@szonett.ki.iif.hu> <49476A1B.7020107@suse.de> <87tz94h08k.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:35175 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752276AbYLPKri (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Dec 2008 05:47:38 -0500
In-Reply-To: <87tz94h08k.fsf@tac.ki.iif.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-acpi@vger.kernel.org, "Rafael J.Wysocki" <rjw@sisk.pl>

Ferenc Wagner wrote:
> Alexey Starikovskiy <astarikovskiy@suse.de> writes:
> 
>> Ferenc Wagner wrote:
>>
>>> the wild values probably came from some application, which
>>> previously worked around the wrong sysfs current value (supposedly
>>> correctly interpreting it as power) and thus got broken by the fix.
>> Yes, the application is kpowersaved and it is written with the
>> assumption that it could get remaining time by dividing either
>> energy_now or charge_now by current_now.
> 
> So the first choice depends on the current buggy kernel behaviour.
> What's the plan of action in such cases?  I found some notes that
> kpowersaved can or could use HAL for getting this information, in
> which case HAL also should be fixed.  At least their bug tracker[1] on
> SF doesn't contain any such issue, maybe one should be added by
> somebody actually using it if the kernel is to be fixed.
Currently, Rafael suggests, that it is too late to fix the kernel...

Regards,
Alex.
> 
> [1]  http://sourceforge.net/tracker/?atid=700009&group_id=124576&func=browse

