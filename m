From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.21.1 problems during suspend-to-ram
Date: Mon, 30 Apr 2007 22:01:15 +0200
Message-ID: <200704302201.15586.rjw@sisk.pl>
References: <200704292348.33869.marv@der-marv.de> <20070430174309.GA1405@srcf.ucam.org> <200704302027.27244.marv@der-marv.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42798 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031585AbXD3T5D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Apr 2007 15:57:03 -0400
In-Reply-To: <200704302027.27244.marv@der-marv.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marvin Stark <marv@der-marv.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

On Monday, 30 April 2007 20:27, Marvin Stark wrote:
> On Monday 30 April 2007 19:43, Matthew Garrett wrote:
> > On Mon, Apr 30, 2007 at 07:31:11PM +0200, Marvin Stark wrote:
> > > On Monday 30 April 2007 00:32, Matthew Garrett wrote:
> > > > On Sun, Apr 29, 2007 at 11:48:29PM +0200, Marvin Stark wrote:
> > > > > Hi,
> > > > >
> > > > > I'm trying to suspend my MacBook2,1 to ram and always get following
> > > > > error during suspend:
> > > > >
> > > > > ACPI: PCI interrupt for device 0000:00.1f.2 disabled.
> > > >
> > > > That's not an error - what problems do you think it's causing?
> > >
> > > I realy dont know... Maybe you can give me some hints?
> > > Is there a way to get more debug info except enable debugging in the
> > > kernel?
> >
> > Well, uh, to start with it might help if you actually told us what the
> > problem is.
> 
> Main problem is, that the maschine is not shutting down (suspend consoles).
> I tried s2ram and s2disk with both programs I'm not able to suspend my 
> maschine. All devices (nic, firewire, usb etc) except hdd were suspended 
> without any problems. After that the maschine freezes, showing this message:
> 
> ------- 8< -------
> ACPI: PCI interrupt for device 0000:00.1f.2 disabled.
> ------- 8< -------
> 
> As 00:1f.2 is my S-ATA controller, I think my harddisk will not get 
> suspended...
> 
> ------- 8< -------
> 00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial ATA 
> Storage Controller IDE (rev 02)
> ------- 8< -------
> 
> The only possibly way to suspend my system to disk is using sysfs.
> But this also only works when I set /sys/power/disk to "shutdown".
> If it's set to "platform" my system will not suspend.
> 
> So there must be a problem with ACPI. Am I right with this suspicion?

Probably, but the stack trace that you have quoted is likely unrelated to this
problem.

Please try the appended patch and see if you can suspend to disk in the
platform mode with it.

Greetings,
Rafael

---
---
 kernel/power/disk.c |    4 ++--
 kernel/power/user.c |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.21-rc7/kernel/power/disk.c
===================================================================
--- linux-2.6.21-rc7.orig/kernel/power/disk.c
+++ linux-2.6.21-rc7/kernel/power/disk.c
@@ -170,9 +170,9 @@ int pm_suspend_disk(void)
 
 	if (in_suspend) {
 		enable_nonboot_cpus();
-		platform_finish();
 		device_resume();
 		resume_console();
+		platform_finish();
 		pr_debug("PM: writing image.\n");
 		error = swsusp_write();
 		if (!error)
@@ -189,9 +189,9 @@ int pm_suspend_disk(void)
  Enable_cpus:
 	enable_nonboot_cpus();
  Resume_devices:
-	platform_finish();
 	device_resume();
 	resume_console();
+	platform_finish();
  Thaw:
 	unprepare_processes();
  Finish:
Index: linux-2.6.21-rc7/kernel/power/user.c
===================================================================
--- linux-2.6.21-rc7.orig/kernel/power/user.c
+++ linux-2.6.21-rc7/kernel/power/user.c
@@ -170,11 +170,11 @@ static inline int snapshot_suspend(int p
 	}
 	enable_nonboot_cpus();
  Resume_devices:
+	device_resume();
+	resume_console();
 	if (platform_suspend)
 		platform_finish();
 
-	device_resume();
-	resume_console();
  Finish:
 	mutex_unlock(&pm_mutex);
 	return error;
@@ -202,11 +202,11 @@ static inline int snapshot_restore(int p
 
 	enable_nonboot_cpus();
  Resume_devices:
+	device_resume();
+	resume_console();
 	if (platform_suspend)
 		platform_finish();
 
-	device_resume();
-	resume_console();
  Finish:
 	pm_restore_console();
 	mutex_unlock(&pm_mutex);
