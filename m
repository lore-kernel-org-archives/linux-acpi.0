From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: reverted battery current conversion fix
Date: Tue, 16 Dec 2008 11:40:11 +0100
Message-ID: <87tz94h08k.fsf@tac.ki.iif.hu>
References: <87zlixxaht.fsf@szonett.ki.iif.hu> <49476A1B.7020107@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:54229 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502AbYLPKkP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Dec 2008 05:40:15 -0500
In-Reply-To: <49476A1B.7020107@suse.de> (Alexey Starikovskiy's message of
	"Tue, 16 Dec 2008 11:43:07 +0300")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux-acpi@vger.kernel.org, "Rafael J.Wysocki" <rjw@sisk.pl>

Alexey Starikovskiy <astarikovskiy@suse.de> writes:

> Ferenc Wagner wrote:
>
>> the wild values probably came from some application, which
>> previously worked around the wrong sysfs current value (supposedly
>> correctly interpreting it as power) and thus got broken by the fix.
>
> Yes, the application is kpowersaved and it is written with the
> assumption that it could get remaining time by dividing either
> energy_now or charge_now by current_now.

So the first choice depends on the current buggy kernel behaviour.
What's the plan of action in such cases?  I found some notes that
kpowersaved can or could use HAL for getting this information, in
which case HAL also should be fixed.  At least their bug tracker[1] on
SF doesn't contain any such issue, maybe one should be added by
somebody actually using it if the kernel is to be fixed.

[1]  http://sourceforge.net/tracker/?atid=700009&group_id=124576&func=browse
-- 
Cheers,
Feri.
