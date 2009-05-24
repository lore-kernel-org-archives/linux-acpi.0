From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Boot problems with 2.6.29.1 - cannot smoothly boot on battery
Date: Sun, 24 May 2009 22:36:21 +0200
Message-ID: <200905242236.22715.rjw@sisk.pl>
References: <3d2f29dc0905180125x5e7ef51dqf10955a3d44336e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33801 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751820AbZEXUgS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 May 2009 16:36:18 -0400
In-Reply-To: <3d2f29dc0905180125x5e7ef51dqf10955a3d44336e2@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Howie <cdhowie@gmail.com>
Cc: linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, "H. Anvin" <hpa@zytor.com>, Greg KH <gregkh@suse.de>

On Monday 18 May 2009, Chris Howie wrote:
> Folks:
> 
> I've been running 2.6.29.1 for some time and reported an issue to this
> mailing list a while ago about the boot process.  I believe I have now
> nailed down the one factor that determines whether I see this issue.
> 
> The problem arises only when booting or halting my laptop when there
> is no power plugged in, e.g. the system is running on battery.
> Sometime after init begins starting services I must hold down a key on
> the keyboard to convince it to continue booting, otherwise it just
> hangs.  If the system is running on AC then it boots fine.  This same
> problem repeats itself during the halt process if running on battery.
> 
> This also happens when resuming a suspend-to-disk image, after loading
> the data from the hard drive, but before control is returned to
> userspace.  The keyboard has no effect on this hang, presumably
> because the kernel is not listening to the keyboard at this point.
> When this happens the only solution is to hold the power button and
> boot normally instead.
> 
> An issue like this is a serious usability problem for me.  I am
> neither a kernel developer nor hacker, my coding skills applying
> mostly to userspace applications.  If there is anything you need from
> me to help diagnose this problem please let me know.
> 
> I am not subscribed so please CC me on replies.

Let's try to make your report a bit more visible (some CCs added).

Best,
Rafael
