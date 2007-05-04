From: "Guilherme Salgado" <gsalgado@gmail.com>
Subject: Re: Thinkpad suspend-to-disk regression
Date: Fri, 4 May 2007 09:37:32 -0300
Message-ID: <3d7cf86d0705040537n7bd6dfabocf5210a2f32ddc3b@mail.gmail.com>
References: <3d7cf86d0704241129i23da1b9fq93876573618e9dcd@mail.gmail.com>
	 <200705031923.16436.rjw@sisk.pl>
	 <3d7cf86d0705031634j5dc116fbwf2870773713f3b92@mail.gmail.com>
	 <200705041107.45968.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:52394 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbXEDMhd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 May 2007 08:37:33 -0400
Received: by an-out-0708.google.com with SMTP id b33so811660ana
        for <linux-acpi@vger.kernel.org>; Fri, 04 May 2007 05:37:33 -0700 (PDT)
In-Reply-To: <200705041107.45968.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org

On 5/4/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, 4 May 2007 01:34, Guilherme Salgado wrote:
> > On 5/3/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > On Thursday, 3 May 2007 15:45, Guilherme Salgado wrote:
> > > > On 5/2/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > > > On Wednesday, 2 May 2007 19:28, Guilherme Salgado wrote:
> > > > > > On 4/25/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > > > > > On Wednesday, 25 April 2007 04:25, Guilherme Salgado wrote:
> > > > > > > > On 4/24/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > > > > > > > On Tuesday, 24 April 2007 20:29, Guilherme Salgado wrote:
> > > > > > > > > > (I've already sent this to linux-acpi but got no response so far, so I
> > > > > > > > > > thought it could be a good idea to send directly to you)
> > > > > > > > > >
> > > > > > > > > > Hi there,
> > > > > > > > > >
> > > > > > > > > > I recently noticed that my thinkpad T60 would lose the sound after
> > > > > > > > > > being suspended to disk (https://launchpad.net/bugs/80893), requiring
> > > > > > > > > > a cold restart to fix it. After some git-bisect work I found this
> > > > > > > > > > regression was a consequence of
> > > > > > > > > > http://git.kernel.org/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=commitdiff;h=9185cfa92507d07ac787bc73d06c42222eec7239
> > > > > > > > > > (patch inlined here)
> > > > > > > > > >
> > > > > > > > > > Is there any chance of fixing the regression this introduced without
> > > > > > > > > > reverting it? Please let me know if you want any other info or have a
> > > > > > > > > > patch for me to try.
> > > > > > > > >
> > > > > > > > > You don't need a patch, I think.  Please try
> > > > > > > > >
> > > > > > > > > # echo shutdown > /sys/power/disk
> > > > > > > > >
> > > > > > > > > before the suspend (assuming you use the built-in swsusp).  If that works,
> > > > > > > > > just make your configuration scripts echo 'shutdown' to /sys/power/disk at
> > > > > > > > > system startup.
> > > > > > > > >
> > > > > > > >
> > > > > > > > I use Ubuntu's default /etc/acpi/hibernate.sh, which already sets
> > > > > > > > /sys/power/disk to shutdown before echoing "disk" to /sys/power/state.
> > > > > > >
> > > > > > > In that case it's impossible that the commit you have identified causes the
> > > > > > > problem to happen.
> > > > > > >
> > > > > > > It doesn't even touch the 'shutdown' code path.
> > > > > >
> > > > > > Is it be possible that the change to /sys/power/disk is not doing what
> > > > > > it should? I think that's likely to be the case because I got a bunch
> > > > > > of people to try a kernel with the patch reverted and it fixed the
> > > > > > problem they were having.
> > > > > >
> > > > > > The most recent comments at https://bugs.launchpad.net/+bugs/80893 are
> > > > > > all confirming that the kernel at
> > > > > > http://rookery.ubuntu.com/~kyle/kernels/salgado/2007-04-25/ fixes
> > > > > > their problem.
> > > > > >
> > > > > > I'd be glad to do anything to further debug this if you can give me
> > > > > > some pointers.
> > > > >
> > > > > Well, the problem is that we have switched to the platform mode by default
> > > > > and "echo shutdown > /sys/power/disk" before the suspend should get the old
> > > > > behavior back
> > > > >
> > > >
> > > > Right, that's why I asked if it'd be possible that echoing "shutdown"
> > > > to /sys/power/disk could somehow be a no-op in this case.
> > > >
> > > > > Please try to apply the appended patch instead of reverting the entire commit
> > > > > and see if the problem is still present.
> > > > >
> > > >
> > > > That works just fine, yes. Are you willing to change the default back
> > > > to PM_DISK_SHUTDOWN or should we find out why "echo shutdown >
> > > > /sys/power/disk" is not having the same effect as changing the
> > > > default, as it should?
> > >
> > > In fact, I'd rather would like to find out what's the reason for the
> > > "echo shutdown > /sys/power/disk" not working.
> > >
> >
> > So do I, but I'm sort of short on ideas for how to debug this (IANAKD
> > :-); that's why I asked if you'd have any pointers.
>
> Hmm, can you try to start the hibernation manually?  I mean, do
>
> # echo 5 > /proc/sys/kernel/printk
> # echo shutdown > /sys/power/disk
>
> and check what it shows:
>
> # cat /sys/power/disk
>
> If this is 'shutdown', then do
>
> # echo disk > /sys/power/state
>
> and see if that works.
>
> If you've done it already, please let me know and I'll prepare a debug patch
> for you.
>

This is what my hibernation script does, but I did it manually hoping
that waiting a few seconds between changing /sys/power/disk and
/sys/power/state could solve the problem. Unfortunately, it didn't; I
still get no sound after resuming.

> >
> > > Besides, could you please check if the problems with the 'platform' mode
> > > suspend persist with the appended patch applied?
> > >
> >
> > Yep, the problem persists, unfortunately.
>
> OK, so much for that.  Thanks for testing.
>

Thank you!
