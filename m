From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/9] device core: add BUS_NOTIFY_DRIVER_NOT_BOUND notification
Date: Wed, 09 Dec 2015 02:20:25 +0100
Message-ID: <1860832.P1KhQB5H7z@vostro.rjw.lan>
References: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com> <4559667.zZkzgz1dlB@vostro.rjw.lan> <CAHp75VcRHogfSfQQSvcQhU2eW8rWzY1AJPGTSK7KYh69gKgHXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcRHogfSfQQSvcQhU2eW8rWzY1AJPGTSK7KYh69gKgHXA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, dmaengine <dmaengine@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, December 08, 2015 03:50:06 PM Andy Shevchenko wrote:
> On Tue, Dec 8, 2015 at 4:05 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, December 08, 2015 02:32:00 PM Thomas Gleixner wrote:
> >> On Mon, 7 Dec 2015, Rafael J. Wysocki wrote:
> >> > On Monday, December 07, 2015 12:57:33 PM Andy Shevchenko wrote:
> >> > > > Andy, what about if I put patches [1-6/9] into my queue for v4.5 now
> >> > > > and
> >> > > > the remaining ones will wait for Vinod to comment?
> >> > >
> >> > > Yes, it's possible, but please don't forget the patch from http://www.s
> >> > > pinics.net/lists/kernel/msg2119229.html. There also formally Acks from
> >> > > Thomas and Ong, Boon Leong.
> >> >
> >> > Well, if Thomas prefers to take this one into tip, I guess the series should
> >> > go along with it or wait for when that one is merged.
> >>
> >> Works either way. I have no changes pending against that iosf_mbi stuff.
> >
> 
> Thanks, Thomas!
> 
> > Cool.  I'll take that patch and the series then.
> 
> Please, also put patch 5 before patch 4. It will go smoothly,

It didn't, but that's not a big deal.

> or I can send an updated version.

No need.

I've put the entire series (including the three last patches with Vinod's ACKs)
into my bleeding-edge branch, please check it in there and let me know if
anything is not right.

Thanks,
Rafael
