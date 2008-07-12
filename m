From: Andy Lutomirski <luto@myrealbox.com>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor register on resume
Date: Sat, 12 Jul 2008 16:39:17 -0400
Message-ID: <48791675.6060805@myrealbox.com>
References: <200807010148.02135.rjw@sisk.pl> <486A96C1.2020106@firstfloor.org> <48784F51.1010407@myrealbox.com> <200807122051.25634.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from THAUM.MIT.EDU ([18.95.3.27]:49484 "EHLO luto.stanford.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751925AbYGLUjR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Jul 2008 16:39:17 -0400
In-Reply-To: <200807122051.25634.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: luto@myrealbox.com, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, public-kernel-testers-u79uwXL29TY76Z2rM5mHXA@lo.gmane.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>

Rafael J. Wysocki wrote:
> On Saturday, 12 of July 2008, Andy Lutomirski wrote:
>> My Lenovo X61s fails to resume if I suspend it from within X, on both 
>> 2.6.26-rc9 and recent wireless-testing.  2.6.26-rc8 is fine, as is 
>> wireless-testing with 4b4f7280 reverted.  My in-progress bisect between 
>> -rc8 and -rc9 is also consistent with this being the problem.
>>
>> The symptom is that, when I push the power button to resume, the hard 
>> drive light turns on, the fan turns on, then the hard drive light turns 
>> off, the sleep light stays on, and the fan keeps running.  Sometimes the 
>> battery light will blink off very briefly (1/4 sec, maybe) every few 
>> seconds.  The system is locked hard at this point.
>>
>> I'm using Ubuntu Hardy userspace.
> 
> Well, that's bad.
> 
> There is the bugzilla entry at http://bugzilla.kernel.org/show_bug.cgi?id=11064
> for this bug and you've just confirmed my suspicion that this particular
> commit is to blame.
> 
> Can you please see if the appended patch changes anything?

More correctly:

If I suspend by typing pm-suspend or echo mem >/sys/power/state, then it 
resumes just fine.  If I log in to Gnome and push the suspend button, 
then it does not resume.  This seems to be the case with or without your 
patch.

-rc8 and -rc9 with the original patch 4b4f7280 resume fine no matter how 
I suspend.

--Andy
