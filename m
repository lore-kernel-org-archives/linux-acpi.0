From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v5 00/12] Add ACPI _DSD and unified device properties
 support
Date: Sat, 18 Oct 2014 10:49:59 +0200
Message-ID: <20141018084959.23AB3C40A02@trevor.secretlab.ca>
References: <2660541.BycO7TFnA2@vostro.rjw.lan>
	<11223831.j9KAEfSQsY@vostro.rjw.lan>
	<D04C5E60-527A-4CA9-954D-60A82AF0413A@arndb.de>
	<22806489.J415p1md4u@vostro.rjw.lan>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <22806489.J415p1md4u@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Darren Hart <dvhart@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-acpi@vger.kernel.org

On Sat, 18 Oct 2014 00:50 +0200
, "Rafael J. Wysocki" <rjw@rjwysocki.net>
 wrote:
> On Friday, October 17, 2014 08:04:52 PM Arnd Bergmann wrote:
> > 
> > On October 17, 2014 2:01:33 PM CEST, "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> > >Hi Everyone,
> > >
> > >Hving had a couple of chats with Grant and Arnd during LinuxCon EU/LPC,
> > >we
> > >now have version 5 taking all feedback into account (hopefully).
> > 
> > Awesome, that was really fast. I'm currently on my way his me in
> > the train, replying from my phone, but it looks good now. I'll have a more
> > detailed look next week but I'm definitely happy to see this go in (to next
> > and 3.19) now, any details we still find can be fixed on top.
> > 
> > > In
> > >short, if
> > >we are passed a struct fwnode_handle pointer, we can get from it to the
> > >appropriate device node pointer (either struct acpi_device or struct
> > >device_node)
> > >using container_of() after we've checked the type.  This is needed for
> > >the code
> > >that needs to access child nodes of a device in case when they don't
> > >have
> > >struct device representations (whatever the reason).  This has been
> > >suggested
> > >by Grant and pretty much everyone involved agrees that it's better that
> > >the
> > >alternatives presented so far.
> > 
> > Yes, it's nice enough that I now take back all the objections I had for the
> > child accessory API.
> 
> Cool, thanks!
> 
> I've just refreshed the device-properties branch of the linux-pm.git tree
> and it contains the current material now (including a couple of build
> fixes reported by the autobuild robot in patches [02/12] and [09/12]).
> 
> My plan is to merge this into the linux-next branch when 3.18-rc1 is out.

Wait for my ack please, but I should be able to review it this weekend
or on Monday. I'm actually reviewing now, but I'm on a plane near the
end of the flight. As soon as I get on the ground SIGFAMILY will
interrupt me for a bit. :-)

g.
