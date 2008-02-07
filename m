From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend to ram problem
Date: Thu, 7 Feb 2008 10:23:21 +0100
Message-ID: <20080207092321.GC1816@elf.ucw.cz>
References: <47A5C399.7010405@free.fr> <47A5DE60.1080402@free.fr> <200802031839.02397.rjw@sisk.pl> <20080203181855.GB1629@elf.ucw.cz> <47A60AA8.8050407@free.fr> <47A6B758.7070405@free.fr> <47A8EB02.90502@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38376 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756371AbYBGPTS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Feb 2008 10:19:18 -0500
Content-Disposition: inline
In-Reply-To: <47A8EB02.90502@free.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: matthieu castet <castet.matthieu@free.fr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>

Hi!

>>>> Hmm, maybe I know where problem could be. Try
>>>>
>>>>         movl     $(wakeup_stack - wakeup_code), %esp              # 
>>>> Private stack is needed for ASUS bo\
>>>>
>>>> instead of existing stack setup. That helped on one of my test-boxes
>>> Thanks, I will try that.
>>> Because clearing the flags imply pop/push in the stack it could be the 
>>> problem
>> That doesn't help : it still crash in pushl $0.
>>
> All stack stuff in wakeup_code crash for me.
> I tried to change the stack position, make sure upper bit of %esp are 
> clear, ... nothing work.
> What's are strange is that according to my x86 manual, in real mode the 
> failure can only happen if the stack wrap which is not the case here.
> Any x86 guru advice ?

Could you try the .c wakeup? I changed it a bit, perhaps that's enough.

> If I remove stack access (remove clearing flag stuff, not call to video 
> stuff) the resume works.

Actually, I see a possible problem:

_start:
        cli
        cld

        /* Set up segments */
        movw    %cs,%ax
        movw    %ax,%ds
        movw    %ax,%es
        movw    %ax,%ss

        movl    $wakeup_stack_end, %esp

        /* Clear the EFLAGS */
        pushl   $0
        popfl

...if someone calls start as 0x1234:0, we are okay. But if some broken
bios calls us as 0x1:0x234, we've got a problem.

One possible hack would be to movl 0, %esp. That should put the stack
at _start, corrupting memory but hopefully helping you diagnose it.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
