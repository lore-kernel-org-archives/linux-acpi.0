From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [patch 2/2] acpi: Avoid dropping rapid hotkey events (or other
 GPEs) on Asus EeePC
Date: Thu, 21 Aug 2008 15:42:05 +0100
Message-ID: <48AD7EBD.9030507@tuffmail.co.uk>
References: <200808202341.m7KNflv7005413@imap1.linux-foundation.org> <48AD5BBB.2050701@suse.de> <48AD6F14.9080700@tuffmail.co.uk> <48AD73E9.9090904@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:26048 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756049AbYHUOmL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Aug 2008 10:42:11 -0400
Received: by ug-out-1314.google.com with SMTP id c2so9124ugf.37
        for <linux-acpi@vger.kernel.org>; Thu, 21 Aug 2008 07:42:09 -0700 (PDT)
In-Reply-To: <48AD73E9.9090904@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: akpm@linux-foundation.org, andi@firstfloor.org, linux-acpi@vger.kernel.org, hmh@hmh.eng.br, maxi@daemonizer.de, stable@kernel.org

Alexey Starikovskiy wrote:
> Alan Jenkins wrote:
>> Alexey Starikovskiy wrote:
>>> Hi Andrew,
>>>
>>> As I understand, this patch is wrong according to comment #65 in bug
>>> #9998.
>>>
>>> Regards,
>>> Alex.
>>
>> That's more likely to have been a problem with my other patches, ripping
>> out the QUERY_PENDING flag and GPE polling, with (what were to Alex)
>> predictably bad results.
> Hi Alan,
> I checked QUERY_PENDING removal, and it makes system with broken EC
> unusable, so you might stop considering it as an option.
>
In hindsight, the bad results were predictable to me also.  I don't
advocate that any more.

>>
>> You're right this patch needs testing on it's own.  But the current code
>> is definitely wrong.
>>
>> If the "GPE polling" workaround is triggered, and there is a series of
>> events > one every 0.5s, the EC buffer can overflow.  All it needs is an
>> ACPI hotkey with fast enough autorepeat.  And I bet it's not just my EC
>> that breaks horribly when that happens.
> Right now I am going to remove automatic switch to poll mode, so user
> could
> choose, which EC mode is more tolerable.

Sounds sensible.  Hopefully we're right that most systems with these
broken EC's don't want the workaround.  I assume you will still notify
the user automatically, something like "acpi: ec: GPE storm detected,
try booting with ec=poll".

Thanks
Alan
