From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/9] device core: add BUS_NOTIFY_DRIVER_NOT_BOUND notification
Date: Mon, 07 Dec 2015 23:59:42 +0100
Message-ID: <1633564.Gyf7bPvX3K@vostro.rjw.lan>
References: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com> <3490462.ARevfiQkZD@vostro.rjw.lan> <1449485853.15393.193.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449485853.15393.193.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, dmaengine <dmaengine@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Monday, December 07, 2015 12:57:33 PM Andy Shevchenko wrote:
> On Mon, 2015-12-07 at 02:31 +0100, Rafael J. Wysocki wrote:
> > On Saturday, December 05, 2015 08:36:22 AM Greg Kroah-Hartman wrote:
> > > On Sat, Dec 05, 2015 at 06:24:05PM +0200, Andy Shevchenko wrote:
> > > > On Sat, Dec 5, 2015 at 6:14 PM, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > > On Fri, Dec 04, 2015 at 11:49:17PM +0200, Andy Shevchenko
> > > > > wrote:
> > > > > > The users of BUS_NOTIFY_BIND_DRIVER have no chance to do any
> > > > > > cleanup in case of
> > > > > > a probe failure. In the result there might be problems, such
> > > > > > as some resources
> > > > > > that had been allocated will continue to be allocated and
> > > > > > therefore lead to a
> > > > > > resource leak.
> > > > > > 
> > > > > > Introduce a new notification to inform the subscriber that
> > > > > > ->probe() failed. Do
> > > > > > the same in case of failed device_bind_driver() call.
> > > > > 
> > > > > Ugh, I hate all these notifiers, but this one does make
> > > > > sense...
> > > > 
> > > > Yeah, I'm not a fan of them either.
> > > > 
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > 
> > > > You meant Acked-by, didn't you?
> > > 
> > > Either works :)
> > 
> > Thanks!
> > 
> > Andy, what about if I put patches [1-6/9] into my queue for v4.5 now
> > and
> > the remaining ones will wait for Vinod to comment?
> 
> Yes, it's possible, but please don't forget the patch from http://www.s
> pinics.net/lists/kernel/msg2119229.html. There also formally Acks from
> Thomas and Ong, Boon Leong.

Well, if Thomas prefers to take this one into tip, I guess the series should
go along with it or wait for when that one is merged.

Thanks,
Rafael
