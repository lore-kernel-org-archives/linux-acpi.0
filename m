From: Olivier Berger <oberger@ouvaton.org>
Subject: Re: Incorrect ACPI blacklisting of ASUS P4B266 ?
Date: Thu, 30 Apr 2009 06:22:23 +0200
Message-ID: <87preupy80.fsf@olivierberger.com>
References: <87k5691x3y.fsf@olivierberger.com>
	<200904281339.15689.trenn@suse.de> <877i14aed8.fsf@olivierberger.com>
	<200904281956.50640.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:35267 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763AbZD3EWd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Apr 2009 00:22:33 -0400
In-Reply-To: <200904281956.50640.trenn@suse.de> (Thomas Renninger's message of "Tue\, 28 Apr 2009 19\:56\:49 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org

Thomas Renninger <trenn@suse.de> writes:

> On Tuesday 28 April 2009 19:15:47 Olivier Berger wrote:
>> Thomas Renninger <trenn@suse.de> writes:
>
>
>> I'm thinking about some kind of warning message that might be provided
>> by the kernel.
>> 
>> Currently, the blacklisting issues something like : 
>>  xxx detected : force use of acpi=ht 
>> 
>> Maybe in some greylisted cases (like such ASUS P4B266), an additional
>> message may be issued, something like :
>>  xxx detected : may work with acpi=force (test at own risk)
>> or something like that ?
> Sounds like a good idea.
> Something like that (not tested at all).
> I could imagine Len adds this one if you give it a try and see
> the message popping up in dmesg.

I can confirm this works.

Here's the dmesg :
Apr 29 23:17:42 asustour kernel: [    0.000000] ASUS P4B266 detected: force use of acpi=ht
Apr 29 23:17:42 asustour kernel: [    0.000000] Latest BIOSes might work better with acpi=force

Hope this is would be at least better than previous state.

Thanks for your help.

Best regards,
-- 
Olivier BERGER 
(OpenPGP: 1024D/B4C5F37F)
http://www.olivierberger.com/weblog/
