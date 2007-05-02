From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Thinkpad suspend-to-disk regression
Date: Wed, 2 May 2007 21:37:07 +0200
Message-ID: <200705022137.07346.rjw@sisk.pl>
References: <3d7cf86d0704241129i23da1b9fq93876573618e9dcd@mail.gmail.com> <200704251447.53288.rjw@sisk.pl> <3d7cf86d0705021028k6ec2770eh3e4ae68385353442@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50708 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993151AbXEBTcc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 May 2007 15:32:32 -0400
In-Reply-To: <3d7cf86d0705021028k6ec2770eh3e4ae68385353442@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Guilherme Salgado <gsalgado@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday, 2 May 2007 19:28, Guilherme Salgado wrote:
> On 4/25/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Wednesday, 25 April 2007 04:25, Guilherme Salgado wrote:
> > > On 4/24/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > > On Tuesday, 24 April 2007 20:29, Guilherme Salgado wrote:
> > > > > (I've already sent this to linux-acpi but got no response so far, so I
> > > > > thought it could be a good idea to send directly to you)
> > > > >
> > > > > Hi there,
> > > > >
> > > > > I recently noticed that my thinkpad T60 would lose the sound after
> > > > > being suspended to disk (https://launchpad.net/bugs/80893), requiring
> > > > > a cold restart to fix it. After some git-bisect work I found this
> > > > > regression was a consequence of
> > > > > http://git.kernel.org/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=commitdiff;h=9185cfa92507d07ac787bc73d06c42222eec7239
> > > > > (patch inlined here)
> > > > >
> > > > > Is there any chance of fixing the regression this introduced without
> > > > > reverting it? Please let me know if you want any other info or have a
> > > > > patch for me to try.
> > > >
> > > > You don't need a patch, I think.  Please try
> > > >
> > > > # echo shutdown > /sys/power/disk
> > > >
> > > > before the suspend (assuming you use the built-in swsusp).  If that works,
> > > > just make your configuration scripts echo 'shutdown' to /sys/power/disk at
> > > > system startup.
> > > >
> > >
> > > I use Ubuntu's default /etc/acpi/hibernate.sh, which already sets
> > > /sys/power/disk to shutdown before echoing "disk" to /sys/power/state.
> >
> > In that case it's impossible that the commit you have identified causes the
> > problem to happen.
> >
> > It doesn't even touch the 'shutdown' code path.
> 
> Is it be possible that the change to /sys/power/disk is not doing what
> it should? I think that's likely to be the case because I got a bunch
> of people to try a kernel with the patch reverted and it fixed the
> problem they were having.
> 
> The most recent comments at https://bugs.launchpad.net/+bugs/80893 are
> all confirming that the kernel at
> http://rookery.ubuntu.com/~kyle/kernels/salgado/2007-04-25/ fixes
> their problem.
> 
> I'd be glad to do anything to further debug this if you can give me
> some pointers.

Well, the problem is that we have switched to the platform mode by default
and "echo shutdown > /sys/power/disk" before the suspend should get the old
behavior back

Please try to apply the appended patch instead of reverting the entire commit
and see if the problem is still present.

Greetings,
Rafael

---
 kernel/power/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.21-rc7/kernel/power/main.c
===================================================================
--- linux-2.6.21-rc7.orig/kernel/power/main.c
+++ linux-2.6.21-rc7/kernel/power/main.c
@@ -30,7 +30,7 @@
 DEFINE_MUTEX(pm_mutex);
 
 struct pm_ops *pm_ops;
-suspend_disk_method_t pm_disk_mode = PM_DISK_PLATFORM;
+suspend_disk_method_t pm_disk_mode = PM_DISK_SHUTDOWN;
 
 /**
  *	pm_set_ops - Set the global power method table. 
