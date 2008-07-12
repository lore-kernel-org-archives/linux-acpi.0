From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor register on resume
Date: Sat, 12 Jul 2008 22:53:31 +0200
Message-ID: <200807122253.32382.rjw@sisk.pl>
References: <200807010148.02135.rjw@sisk.pl> <200807122051.25634.rjw@sisk.pl> <48791675.6060805@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36069 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbYGLUvJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Jul 2008 16:51:09 -0400
In-Reply-To: <48791675.6060805@myrealbox.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@myrealbox.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>, public-kernel-testers-u79uwXL29TY76Z2rM5mHXA@lo.gmane.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>

On Saturday, 12 of July 2008, Andy Lutomirski wrote:
> Rafael J. Wysocki wrote:
> > On Saturday, 12 of July 2008, Andy Lutomirski wrote:
> >> My Lenovo X61s fails to resume if I suspend it from within X, on both 
> >> 2.6.26-rc9 and recent wireless-testing.  2.6.26-rc8 is fine, as is 
> >> wireless-testing with 4b4f7280 reverted.  My in-progress bisect between 
> >> -rc8 and -rc9 is also consistent with this being the problem.
> >>
> >> The symptom is that, when I push the power button to resume, the hard 
> >> drive light turns on, the fan turns on, then the hard drive light turns 
> >> off, the sleep light stays on, and the fan keeps running.  Sometimes the 
> >> battery light will blink off very briefly (1/4 sec, maybe) every few 
> >> seconds.  The system is locked hard at this point.
> >>
> >> I'm using Ubuntu Hardy userspace.
> > 
> > Well, that's bad.
> > 
> > There is the bugzilla entry at http://bugzilla.kernel.org/show_bug.cgi?id=11064
> > for this bug and you've just confirmed my suspicion that this particular
> > commit is to blame.
> > 
> > Can you please see if the appended patch changes anything?
> 
> More correctly:
> 
> If I suspend by typing pm-suspend or echo mem >/sys/power/state, then it 
> resumes just fine.  If I log in to Gnome and push the suspend button, 
> then it does not resume.  This seems to be the case with or without your 
> patch.

Is there an Intel graphics in your box?

> -rc8 and -rc9 with the original patch 4b4f7280 resume fine no matter how 
> I suspend.

That's _really_ strange.

In fact I have only one explanation, which is that the Gnome suspend button
causes some user-space quirks to be applied, which are harmful and break the
resume.  Also, without commit 4b4f7280 those quirks might have not been really
executed.  Peter, does it sound reasonable?

Thanks,
Rafael
