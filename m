From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Thinkpad suspend-to-disk regression
Date: Thu, 3 May 2007 19:23:16 +0200
Message-ID: <200705031923.16436.rjw@sisk.pl>
References: <3d7cf86d0704241129i23da1b9fq93876573618e9dcd@mail.gmail.com> <200705022137.07346.rjw@sisk.pl> <3d7cf86d0705030645p2c2a2c4aib3fcfb8bad8deb0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53954 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648AbXECRS5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 May 2007 13:18:57 -0400
In-Reply-To: <3d7cf86d0705030645p2c2a2c4aib3fcfb8bad8deb0d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Guilherme Salgado <gsalgado@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Thursday, 3 May 2007 15:45, Guilherme Salgado wrote:
> On 5/2/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Wednesday, 2 May 2007 19:28, Guilherme Salgado wrote:
> > > On 4/25/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > > On Wednesday, 25 April 2007 04:25, Guilherme Salgado wrote:
> > > > > On 4/24/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > > > > On Tuesday, 24 April 2007 20:29, Guilherme Salgado wrote:
> > > > > > > (I've already sent this to linux-acpi but got no response so far, so I
> > > > > > > thought it could be a good idea to send directly to you)
> > > > > > >
> > > > > > > Hi there,
> > > > > > >
> > > > > > > I recently noticed that my thinkpad T60 would lose the sound after
> > > > > > > being suspended to disk (https://launchpad.net/bugs/80893), requiring
> > > > > > > a cold restart to fix it. After some git-bisect work I found this
> > > > > > > regression was a consequence of
> > > > > > > http://git.kernel.org/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=commitdiff;h=9185cfa92507d07ac787bc73d06c42222eec7239
> > > > > > > (patch inlined here)
> > > > > > >
> > > > > > > Is there any chance of fixing the regression this introduced without
> > > > > > > reverting it? Please let me know if you want any other info or have a
> > > > > > > patch for me to try.
> > > > > >
> > > > > > You don't need a patch, I think.  Please try
> > > > > >
> > > > > > # echo shutdown > /sys/power/disk
> > > > > >
> > > > > > before the suspend (assuming you use the built-in swsusp).  If that works,
> > > > > > just make your configuration scripts echo 'shutdown' to /sys/power/disk at
> > > > > > system startup.
> > > > > >
> > > > >
> > > > > I use Ubuntu's default /etc/acpi/hibernate.sh, which already sets
> > > > > /sys/power/disk to shutdown before echoing "disk" to /sys/power/state.
> > > >
> > > > In that case it's impossible that the commit you have identified causes the
> > > > problem to happen.
> > > >
> > > > It doesn't even touch the 'shutdown' code path.
> > >
> > > Is it be possible that the change to /sys/power/disk is not doing what
> > > it should? I think that's likely to be the case because I got a bunch
> > > of people to try a kernel with the patch reverted and it fixed the
> > > problem they were having.
> > >
> > > The most recent comments at https://bugs.launchpad.net/+bugs/80893 are
> > > all confirming that the kernel at
> > > http://rookery.ubuntu.com/~kyle/kernels/salgado/2007-04-25/ fixes
> > > their problem.
> > >
> > > I'd be glad to do anything to further debug this if you can give me
> > > some pointers.
> >
> > Well, the problem is that we have switched to the platform mode by default
> > and "echo shutdown > /sys/power/disk" before the suspend should get the old
> > behavior back
> >
> 
> Right, that's why I asked if it'd be possible that echoing "shutdown"
> to /sys/power/disk could somehow be a no-op in this case.
> 
> > Please try to apply the appended patch instead of reverting the entire commit
> > and see if the problem is still present.
> >
> 
> That works just fine, yes. Are you willing to change the default back
> to PM_DISK_SHUTDOWN or should we find out why "echo shutdown >
> /sys/power/disk" is not having the same effect as changing the
> default, as it should?

In fact, I'd rather would like to find out what's the reason for the
"echo shutdown > /sys/power/disk" not working.

Besides, could you please check if the problems with the 'platform' mode
suspend persist with the appended patch applied?

Greetings,
Rafael

---

 kernel/power/disk.c |    1 -
 kernel/power/user.c |   15 +++------------
 2 files changed, 3 insertions(+), 13 deletions(-)

Index: linux-2.6.21/kernel/power/disk.c
===================================================================
--- linux-2.6.21.orig/kernel/power/disk.c	2007-05-03 12:24:05.000000000 +0200
+++ linux-2.6.21/kernel/power/disk.c	2007-05-03 14:42:26.000000000 +0200
@@ -195,7 +195,6 @@ int hibernate(void)
 
 	if (in_suspend) {
 		enable_nonboot_cpus();
-		platform_finish();
 		device_resume();
 		resume_console();
 		pr_debug("PM: writing image.\n");
Index: linux-2.6.21/kernel/power/user.c
===================================================================
--- linux-2.6.21.orig/kernel/power/user.c	2007-05-03 12:22:57.000000000 +0200
+++ linux-2.6.21/kernel/power/user.c	2007-05-03 14:40:49.000000000 +0200
@@ -169,7 +169,7 @@ static inline int snapshot_suspend(int p
 	}
 	enable_nonboot_cpus();
  Resume_devices:
-	if (platform_suspend)
+	if (platform_suspend && (!in_suspend || error))
 		platform_finish();
 
 	device_resume();
@@ -179,17 +179,12 @@ static inline int snapshot_suspend(int p
 	return error;
 }
 
-static inline int snapshot_restore(int platform_suspend)
+static inline int snapshot_restore(void)
 {
 	int error;
 
 	mutex_lock(&pm_mutex);
 	pm_prepare_console();
-	if (platform_suspend) {
-		error = platform_prepare();
-		if (error)
-			goto Finish;
-	}
 	suspend_console();
 	error = device_suspend(PMSG_PRETHAW);
 	if (error)
@@ -201,12 +196,8 @@ static inline int snapshot_restore(int p
 
 	enable_nonboot_cpus();
  Resume_devices:
-	if (platform_suspend)
-		platform_finish();
-
 	device_resume();
 	resume_console();
- Finish:
 	pm_restore_console();
 	mutex_unlock(&pm_mutex);
 	return error;
@@ -272,7 +263,7 @@ static int snapshot_ioctl(struct inode *
 			error = -EPERM;
 			break;
 		}
-		error = snapshot_restore(data->platform_suspend);
+		error = snapshot_restore();
 		break;
 
 	case SNAPSHOT_FREE:
