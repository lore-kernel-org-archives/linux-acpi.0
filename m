From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/9] device core: add BUS_NOTIFY_DRIVER_NOT_BOUND notification
Date: Tue, 08 Dec 2015 15:05:45 +0100
Message-ID: <4559667.zZkzgz1dlB@vostro.rjw.lan>
References: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com> <1633564.Gyf7bPvX3K@vostro.rjw.lan> <alpine.DEB.2.11.1512081318520.3595@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43725 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752182AbbLHNfq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2015 08:35:46 -0500
In-Reply-To: <alpine.DEB.2.11.1512081318520.3595@nanos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, dmaengine <dmaengine@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Tuesday, December 08, 2015 02:32:00 PM Thomas Gleixner wrote:
> On Mon, 7 Dec 2015, Rafael J. Wysocki wrote:
> > On Monday, December 07, 2015 12:57:33 PM Andy Shevchenko wrote:
> > > > Andy, what about if I put patches [1-6/9] into my queue for v4.5 now
> > > > and
> > > > the remaining ones will wait for Vinod to comment?
> > > 
> > > Yes, it's possible, but please don't forget the patch from http://www.s
> > > pinics.net/lists/kernel/msg2119229.html. There also formally Acks from
> > > Thomas and Ong, Boon Leong.
> > 
> > Well, if Thomas prefers to take this one into tip, I guess the series should
> > go along with it or wait for when that one is merged.
> 
> Works either way. I have no changes pending against that iosf_mbi stuff.

Cool.  I'll take that patch and the series then.

Thanks,
Rafael

