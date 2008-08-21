From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [patch 2/2] acpi: Avoid dropping rapid hotkey events (or other
 GPEs) on Asus EeePC
Date: Thu, 21 Aug 2008 17:55:53 +0400
Message-ID: <48AD73E9.9090904@suse.de>
References: <200808202341.m7KNflv7005413@imap1.linux-foundation.org> <48AD5BBB.2050701@suse.de> <48AD6F14.9080700@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:36676 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752207AbYHUNzp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Aug 2008 09:55:45 -0400
In-Reply-To: <48AD6F14.9080700@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: akpm@linux-foundation.org, andi@firstfloor.org, linux-acpi@vger.kernel.org, hmh@hmh.eng.br, maxi@daemonizer.de, stable@kernel.org

Alan Jenkins wrote:
> Alexey Starikovskiy wrote:
>> Hi Andrew,
>>
>> As I understand, this patch is wrong according to comment #65 in bug
>> #9998.
>>
>> Regards,
>> Alex.
> 
> That's more likely to have been a problem with my other patches, ripping
> out the QUERY_PENDING flag and GPE polling, with (what were to Alex)
> predictably bad results.
Hi Alan,
I checked QUERY_PENDING removal, and it makes system with broken EC unusable, 
so you might stop considering it as an option.

> 
> You're right this patch needs testing on it's own.  But the current code
> is definitely wrong.
> 
> If the "GPE polling" workaround is triggered, and there is a series of
> events > one every 0.5s, the EC buffer can overflow.  All it needs is an
> ACPI hotkey with fast enough autorepeat.  And I bet it's not just my EC
> that breaks horribly when that happens.
Right now I am going to remove automatic switch to poll mode, so user could
choose, which EC mode is more tolerable.
> 
> Thanks
> Alan

Regards,
Alex.
