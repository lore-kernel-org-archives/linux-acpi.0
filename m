From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/9] device core: add BUS_NOTIFY_DRIVER_NOT_BOUND
 notification
Date: Tue, 8 Dec 2015 14:32:00 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1512081318520.3595@nanos>
References: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com> <3490462.ARevfiQkZD@vostro.rjw.lan> <1449485853.15393.193.camel@linux.intel.com> <1633564.Gyf7bPvX3K@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49442 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756349AbbLHNcx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2015 08:32:53 -0500
In-Reply-To: <1633564.Gyf7bPvX3K@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, dmaengine <dmaengine@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Mon, 7 Dec 2015, Rafael J. Wysocki wrote:
> On Monday, December 07, 2015 12:57:33 PM Andy Shevchenko wrote:
> > > Andy, what about if I put patches [1-6/9] into my queue for v4.5 now
> > > and
> > > the remaining ones will wait for Vinod to comment?
> > 
> > Yes, it's possible, but please don't forget the patch from http://www.s
> > pinics.net/lists/kernel/msg2119229.html. There also formally Acks from
> > Thomas and Ong, Boon Leong.
> 
> Well, if Thomas prefers to take this one into tip, I guess the series should
> go along with it or wait for when that one is merged.

Works either way. I have no changes pending against that iosf_mbi stuff.

Thanks,

	tglx
