From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async suspend-resume patch w/ completions (was: Re: Async
 suspend-resume patch w/ rwsems)
Date: Wed, 16 Dec 2009 10:22:55 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912161018100.2909-100000@iolanthe.rowland.org>
References: <200912160311.05915.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:52571 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758694AbZLPPW4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 10:22:56 -0500
In-Reply-To: <200912160311.05915.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Wed, 16 Dec 2009, Rafael J. Wysocki wrote:

> I measured the total time of suspending and resuming devices as shown by the
> code added by this patch:
> http://git.kernel.org/?p=linux/kernel/git/rafael/suspend-2.6.git;a=commitdiff_plain;h=c1b8fc0a8bff7707c10f31f3d26bfa88e18ccd94;hp=087dbf5f079f1b55cbd3964c9ce71268473d5b67
> on two boxes, HP nx6325 and MSI Wind U100 (hardware-wise they are quite
> different and the HP was running 64-bit kernel and user space).

> I carried out 5 consecutive suspend-resume cycles (started from under X) on
> each box in each case, and the raw data are here (all times in milliseconds):
> http://www.sisk.pl/kernel/data/async-suspend.pdf

I'd like to see much more detailed data.  For each device, let's get 
the device name, the parent's name, and the start time, end time, and 
duration for suspend or resume.  The start time should be measured when 
you have finished waiting for the children.  The end time should be 
measured just before the complete_all().

Alan Stern

