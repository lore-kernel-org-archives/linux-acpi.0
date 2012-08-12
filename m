From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Kernel stops at "PM: Preparing system for mem sleep", never makes it to "Freezing user space processes ... "
Date: Sun, 12 Aug 2012 23:03:53 +0200
Message-ID: <201208122303.53318.rjw@sisk.pl>
References: <CACfp4335KJQ8Zjj0TJNj65Va9K-t_iEHLEGEi8QuWyQj5dVT0g@mail.gmail.com> <CACfp433X1KwvDu+5ytVVOk6K4pc2vzKxMgEZaCsNwLz0o+Mj9Q@mail.gmail.com> <CACfp431Zj33YtSZJ5rDHACOuHRePKHX7CPYZRCdDxLS27sC=pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:34787 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570Ab2HLU55 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Aug 2012 16:57:57 -0400
In-Reply-To: <CACfp431Zj33YtSZJ5rDHACOuHRePKHX7CPYZRCdDxLS27sC=pg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Athlion <athlion@gmail.com>
Cc: linux-pm@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Sunday, August 12, 2012, Athlion wrote:
> On Sun, Aug 12, 2012 at 2:01 PM, Athlion <athlion@gmail.com> wrote:
> > On Sun, Aug 12, 2012 at 1:08 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> This seems to be the last kernel message you've got.
> >>
> >> It looks like there's a problem with a power management notifier within
> >> the kernel.  Perhaps a race condition, since it is not reproducible 100%
> >> of the time.
> >>
> >> Does it happen if you don't use the lid to trigger suspend?
> >>
> >> Rafael
> >
> > No, it does not.
> >
> > If I don't use the lid, the suspend succeeds 100% of the time (at
> > least, I have achieved over 4 days of uptime by using the
> > logout/suspend button of xfce, I never could stand not closing the lid
> > for more...)
> >
> > What I don't know exactly is how to begin tracking this problem down.
> 
> Furthermore, the suspend actually *happens* if I initiate a shutdown
> or reboot procedure, right after the point where the system says
> killing all processes. On resume, the shutdown/reboot resumes
> normally.

There seems to be an input event handling race condition with system suspend
on your machine.  I wonder if it's related to the specific system configuration,
though, because no one else has reported anything like this before.

I'm not sure what to do to debug this further at the moment.

Please attach dmesg output from a clean boot.

Thanks,
Rafael
