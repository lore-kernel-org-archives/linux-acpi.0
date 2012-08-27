From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Kernel stops at "PM: Preparing system for mem sleep", never makes it to "Freezing user space processes ... "
Date: Mon, 27 Aug 2012 09:28:05 +0200
Message-ID: <201208270928.05619.rjw@sisk.pl>
References: <CACfp4335KJQ8Zjj0TJNj65Va9K-t_iEHLEGEi8QuWyQj5dVT0g@mail.gmail.com> <CACfp4313iKrhYQCjvObPnALUN+fV=jD-EkVZiXCnVGVoAcpKVw@mail.gmail.com> <CACfp431n1og++vMinpJxFU79FmoqGKpvn0CA3v8cuZ1xM-EEYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:34272 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386Ab2H0HWB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Aug 2012 03:22:01 -0400
In-Reply-To: <CACfp431n1og++vMinpJxFU79FmoqGKpvn0CA3v8cuZ1xM-EEYg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Athlion <athlion@gmail.com>
Cc: linux-pm@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Saturday, August 25, 2012, Athlion wrote:
> I have managed to track where the kernel stops and generate sort of a backtrace.
> The result is this (line numbers against linux-3.4.9)
> 
> drivers/tty/vt/vt_ioctl.c:133: wait_event_interruptible
> drivers/tty/vt/vt_ioctl.c:1426: vt_waitactive
> kernel/power/console.c:19: vt_move_to_console
> kernel/power/suspend.c:98: pm_prepare_console
> suspend_prepare called
> 
> Execution stops at wait_event_interruptible. Any ideas why this might be?

Not at the moment, but this is an important data point.

Thanks a lot for tracing this down!

Rafael


> On Thu, Aug 16, 2012 at 6:01 PM, Athlion <athlion@gmail.com> wrote:
> > Some new information, if that is helpful at all.
> >
> > I have managed to circumvent the problem (I am not at 68 hours uptime
> > with proper suspend/resume by closing the lid) by killing the X server
> > every now and then (every 10-12 hours). Anyway, this afternoon, my
> > battery was drained and the system hibernated. On resume I saw this:
> >
> > Aug 16 17:45:55 localhost kernel: [28755.912618] Uhhuh. NMI received
> > for unknown reason 3d on CPU 0.
> > Aug 16 17:45:55 localhost kernel: [28755.912622] Do you have a strange
> > power saving mode enabled?
> > Aug 16 17:45:55 localhost kernel: [28755.912623] Dazed and confused,
> > but trying to continue
> >
> > Is this maybe related to my problem?
> >
> > Thanks!
> >
> > On Mon, Aug 13, 2012 at 10:27 AM, Athlion <athlion@gmail.com> wrote:
> >> And this is the dmesg with pci=nocrs acpi_osi=Linux
> >>
> >> https://dl.dropbox.com/u/63420/dmesg2.txt
> >>
> >> On Mon, Aug 13, 2012 at 10:13 AM, Athlion <athlion@gmail.com> wrote:
> >>> Thanks,
> >>>
> >>> Here is my dmesg from a clean boot:
> >>>
> >>> https://dl.dropbox.com/u/63420/dmesg.txt
> >>>
> >>> Now that I scanned it more thoroughly I found these:
> >>>
> >>> [    0.363136] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
> >>> and
> >>> [    0.387856] PCI: Using host bridge windows from ACPI; if necessary,
> >>> use "pci=nocrs" and report a bug
> >>>
> >>> my /proc/cmdline is:
> >>> BOOT_IMAGE=/boot/vmlinuz-linux
> >>> root=UUID=44cf687d-4827-4765-8758-98d44a745d07 ro quiet
> >>> resume=/dev/sda2
> >>>
> >>> maybe they indicate a lurking problem?
> >>>
> >>> (in parallel, I will try booting with pci=nocrs and report back)
> >>>
> >>> And there are other people having this issue, some from way back, as
> >>> can be seen here
> >>> https://bbs.archlinux.org/viewtopic.php?id=144381
> >>> (Don't be fooled by the linux 3.4.x reference in the title, it happens
> >>> with older kernels, too)
> >>>
> >>> Some of them have found the "solution" to be "never close the lid" but
> >>> this is unacceptable, for me.
> >>>
> >>> Again, thanks!
> >>>
> >>> On Mon, Aug 13, 2012 at 12:03 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >>>> On Sunday, August 12, 2012, Athlion wrote:
> >>>>> On Sun, Aug 12, 2012 at 2:01 PM, Athlion <athlion@gmail.com> wrote:
> >>>>> > On Sun, Aug 12, 2012 at 1:08 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >>>>> >> This seems to be the last kernel message you've got.
> >>>>> >>
> >>>>> >> It looks like there's a problem with a power management notifier within
> >>>>> >> the kernel.  Perhaps a race condition, since it is not reproducible 100%
> >>>>> >> of the time.
> >>>>> >>
> >>>>> >> Does it happen if you don't use the lid to trigger suspend?
> >>>>> >>
> >>>>> >> Rafael
> >>>>> >
> >>>>> > No, it does not.
> >>>>> >
> >>>>> > If I don't use the lid, the suspend succeeds 100% of the time (at
> >>>>> > least, I have achieved over 4 days of uptime by using the
> >>>>> > logout/suspend button of xfce, I never could stand not closing the lid
> >>>>> > for more...)
> >>>>> >
> >>>>> > What I don't know exactly is how to begin tracking this problem down.
> >>>>>
> >>>>> Furthermore, the suspend actually *happens* if I initiate a shutdown
> >>>>> or reboot procedure, right after the point where the system says
> >>>>> killing all processes. On resume, the shutdown/reboot resumes
> >>>>> normally.
> >>>>
> >>>> There seems to be an input event handling race condition with system suspend
> >>>> on your machine.  I wonder if it's related to the specific system configuration,
> >>>> though, because no one else has reported anything like this before.
> >>>>
> >>>> I'm not sure what to do to debug this further at the moment.
> >>>>
> >>>> Please attach dmesg output from a clean boot.
> >>>>
> >>>> Thanks,
> >>>> Rafael
> 
> 

