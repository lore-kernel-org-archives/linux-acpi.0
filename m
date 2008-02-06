From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend to ram problem
Date: Wed, 6 Feb 2008 23:43:08 +0100
Message-ID: <20080206224308.GA1630@elf.ucw.cz>
References: <47A5C399.7010405@free.fr> <47A6B758.7070405@free.fr> <47A8EB02.90502@free.fr> <200802060020.12289.rjw@sisk.pl> <47AA3763.7000106@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56693 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756756AbYBFWmu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Feb 2008 17:42:50 -0500
Content-Disposition: inline
In-Reply-To: <47AA3763.7000106@free.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: matthieu castet <castet.matthieu@free.fr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>

Hi!

>>>>>> instead of existing stack setup. That helped on one of my test-boxes
>>>>> Thanks, I will try that.
>>>>> Because clearing the flags imply pop/push in the stack it could be the 
>>>>> problem
>>>> That doesn't help : it still crash in pushl $0.
>>>>
>>> All stack stuff in wakeup_code crash for me.
>>> I tried to change the stack position, make sure upper bit of %esp are 
>>> clear, ... nothing work.
>>> What's are strange is that according to my x86 manual, in real mode the 
>>> failure can only happen if the stack wrap which is not the case here.
>>> Any x86 guru advice ?
>>>
>>> If I remove stack access (remove clearing flag stuff, not call to video 
>>> stuff) the resume works.
>>
>> Hm, can you place a "pushl %eax; popl %eax;" in place of the removed code and
>> see if that breaks?
> Yes that also break.

Not sure what is going on... but if you remove all the stack
references, does it go up to 32-bit mode?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
