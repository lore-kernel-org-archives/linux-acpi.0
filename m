From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/9] device core: add BUS_NOTIFY_DRIVER_NOT_BOUND
 notification
Date: Mon, 07 Dec 2015 12:57:33 +0200
Message-ID: <1449485853.15393.193.camel@linux.intel.com>
References: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <CAHp75VfaqaXVx+Y4zvLXHJ9KR0zmZo+fzU36-CToioHYKYReyg@mail.gmail.com>
	 <20151205163622.GA2237@kroah.com> <3490462.ARevfiQkZD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3490462.ARevfiQkZD@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, dmaengine <dmaengine@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2015-12-07 at 02:31 +0100, Rafael J. Wysocki wrote:
> On Saturday, December 05, 2015 08:36:22 AM Greg Kroah-Hartman wrote:
> > On Sat, Dec 05, 2015 at 06:24:05PM +0200, Andy Shevchenko wrote:
> > > On Sat, Dec 5, 2015 at 6:14 PM, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > On Fri, Dec 04, 2015 at 11:49:17PM +0200, Andy Shevchenko
> > > > wrote:
> > > > > The users of BUS_NOTIFY_BIND_DRIVER have no chance to do any
> > > > > cleanup in case of
> > > > > a probe failure. In the result there might be problems, such
> > > > > as some resources
> > > > > that had been allocated will continue to be allocated and
> > > > > therefore lead to a
> > > > > resource leak.
> > > > >=20
> > > > > Introduce a new notification to inform the subscriber that
> > > > > ->probe() failed. Do
> > > > > the same in case of failed device_bind_driver() call.
> > > >=20
> > > > Ugh, I hate all these notifiers, but this one does make
> > > > sense...
> > >=20
> > > Yeah, I'm not a fan of them either.
> > >=20
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >=20
> > > You meant Acked-by, didn't you?
> >=20
> > Either works :)
>=20
> Thanks!
>=20
> Andy, what about if I put patches [1-6/9] into my queue for v4.5 now
> and
> the remaining ones will wait for Vinod to comment?

Yes, it's possible, but please don't forget the patch from=C2=A0http://=
www.s
pinics.net/lists/kernel/msg2119229.html. There also formally Acks from
Thomas and=C2=A0Ong, Boon Leong.

>=20
> Thanks,
> Rafael
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
