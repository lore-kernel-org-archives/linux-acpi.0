From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Occasional (too common) suspend problem
Date: Sat, 22 Jan 2011 01:31:11 +0100
Message-ID: <201101220131.11688.rjw@sisk.pl>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com> <201101220016.46227.rjw@sisk.pl> <AANLkTi=Tkf9MYmSmCX6CZ9Ymgqo8S1HmRkBn+Uvr2KUb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41340 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754933Ab1AVAb6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Jan 2011 19:31:58 -0500
In-Reply-To: <AANLkTi=Tkf9MYmSmCX6CZ9Ymgqo8S1HmRkBn+Uvr2KUb@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Saturday, January 22, 2011, Linus Torvalds wrote:
> On Fri, Jan 21, 2011 at 3:16 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >
> > I wonder if you can reproduce the failure with the
> >
> > # echo core > /sys/power/pm_test
> > # echo mem > /sys/power/state
> >
> > test?  I think you can even try to run the second command in a tight loop
> > (the first one simply triggers a switch) and see what happens.
> 
> I don't think I can. I did 60 of those "echo mem > /sys/power/state"
> in a row on top of current -git.
> 
> So I do think that the problem is connected to the actual sleeping part.
> 
> Or - and perhaps more likely - it's connected to the lid event, and
> how that interacts with user space and then eventually triggers the
> sleep event (which is quite likely - as mentioned, I think I've only
> ever seen the problem when I'm physically at the machine).

Does opening the lid wake up the machine normally?

(You probably said that already, but I can't find the answer right now,
very likely because it's 1:30 AM here and I'm a little tired).
