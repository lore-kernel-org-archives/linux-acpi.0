From: Olivier Berger <oberger@ouvaton.org>
Subject: Re: Incorrect ACPI blacklisting of ASUS P4B266 ?
Date: Wed, 06 May 2009 08:11:14 +0200
Message-ID: <8763gepxq5.fsf@olivierberger.com>
References: <87k5691x3y.fsf@olivierberger.com>
	<200904281339.15689.trenn@suse.de> <877i14aed8.fsf@olivierberger.com>
	<200904281956.50640.trenn@suse.de> <87preupy80.fsf@olivierberger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:44078 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843AbZEFGLY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 May 2009 02:11:24 -0400
In-Reply-To: <87preupy80.fsf@olivierberger.com> (Olivier Berger's message of "Thu\, 30 Apr 2009 06\:22\:23 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

Hi.

Olivier Berger <oberger@ouvaton.org> writes:

> Thomas Renninger <trenn@suse.de> writes:
>
>> On Tuesday 28 April 2009 19:15:47 Olivier Berger wrote:
>>> Thomas Renninger <trenn@suse.de> writes:
>>
>>
>>> I'm thinking about some kind of warning message that might be provided
>>> by the kernel.
>>> 
>>> Currently, the blacklisting issues something like : 
>>>  xxx detected : force use of acpi=ht 
>>> 
>>> Maybe in some greylisted cases (like such ASUS P4B266), an additional
>>> message may be issued, something like :
>>>  xxx detected : may work with acpi=force (test at own risk)
>>> or something like that ?
>> Sounds like a good idea.
>> Something like that (not tested at all).
>> I could imagine Len adds this one if you give it a try and see
>> the message popping up in dmesg.
>
> I can confirm this works.
>

May I ask you to review the patch provided here :
http://marc.info/?l=linux-acpi&m=124094144423277&w=2 ?

I'm asking directly as I saw no response on the list. Sorry to bother
you.

Thanks in advance.

Best regards,
-- 
Olivier BERGER 
(OpenPGP: 1024D/B4C5F37F)
http://www.olivierberger.com/weblog/
