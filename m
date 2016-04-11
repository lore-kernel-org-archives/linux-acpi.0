From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3] device property: don't bother the drivers with struct
 property_set
Date: Mon, 11 Apr 2016 15:05:41 +0100
Message-ID: <20160411140541.GY8094@x1>
References: <1459252343-105426-1-git-send-email-heikki.krogerus@linux.intel.com>
 <20160411082027.GF4592@x1>
 <20160411095234.GA26606@kuha.fi.intel.com>
 <CAJZ5v0iHWvp1UvLx1X=MozD0EZ7+L2h7aJYKm6WGBYO0FzGj7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iHWvp1UvLx1X=MozD0EZ7+L2h7aJYKm6WGBYO0FzGj7g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Daniel Mack <daniel@zonque.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <treding@nvidia.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 11 Apr 2016, Rafael J. Wysocki wrote:

> On Mon, Apr 11, 2016 at 11:52 AM, Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> > On Mon, Apr 11, 2016 at 09:20:27AM +0100, Lee Jones wrote:
> >> On Tue, 29 Mar 2016, Heikki Krogerus wrote:
> >>
> >> > Since device_add_property_set() now always takes a copy of
> >> > the property_set, and also since the fwnode type is always
> >> > hard coded to be FWNODE_PDATA, there is no need for the
> >> > drivers to deliver the entire struct property_set. The
> >> > function can just create the instance of it on its own and
> >> > bind the properties from the drivers to it on the spot.
> >> >
> >> > This renames device_add_property_set() to
> >> > device_add_properties(). The function now takes struct
> >> > property_entry as its parameter instead of struct
> >> > property_set.
> >> >
> >> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >> > Acked-by: Thierry Reding <treding@nvidia.com>
> >> > Acked-by: Lee Jones <lee.jones@linaro.org>
> >> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >> > ---
> >> >  arch/arm/mach-pxa/raumfeld.c      | 12 ++++--------
> >
> > Daniel, I think we just need your ACK for this one.
> >
> > Otherwise I think we are covered.
> >
> >> >  arch/arm/mach-tegra/board-paz00.c |  6 +-----
> >> >  drivers/base/platform.c           | 19 ++++++++++---------
> >> >  drivers/base/property.c           | 34 +++++++++++++++++++++---=
----------
> >> >  drivers/mfd/intel-lpss-acpi.c     | 12 ++----------
> >> >  drivers/mfd/intel-lpss-pci.c      | 20 ++++----------------
> >> >  drivers/mfd/intel-lpss.c          |  2 +-
> >> >  drivers/mfd/intel-lpss.h          |  4 ++--
> >> >  drivers/mfd/mfd-core.c            |  4 ++--
> >> >  include/linux/mfd/core.h          |  4 ++--
> >> >  include/linux/platform_device.h   |  6 +++---
> >> >  include/linux/property.h          | 15 +++------------
> >> >  12 files changed, 55 insertions(+), 83 deletions(-)
> >>
> >> What's happening with this patch?  I believe we're still missing
> >> Acks.  Once they are collected someone needs to create an immutabl=
e
> >> branch and send out a pull-request.
> >
> > Rafael, have you had time to take a look at this?
>=20
> Yes, it's in my bleeding-edge branch now.  I'm planning to move it to
> linux-next this week

Please ensure you send out the relevant pull-requests.  Linus doesn't
look his best when he's angry.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
