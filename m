From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V6 09/11] ACPI: introduce flag .is_master_device
Date: Thu, 22 May 2014 22:26:48 +0800
Message-ID: <1400768808.27343.4.camel@rzhang1-toshiba>
References: <1400136256-2218-1-git-send-email-rui.zhang@intel.com>
	 <1400136256-2218-10-git-send-email-rui.zhang@intel.com>
	 <20140521085207.GR1651@lahna.fi.intel.com>
	 <1400683387.13930.26.camel@rzhang1-toshiba>
	 <20140522085135.GC1651@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140522085135.GC1651@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, matthew.garrett@nebula.com, rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com, "Lan, Tianyu" <tianyu.lan@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2014-05-22 at 11:51 +0300, Mika Westerberg wrote:
> On Wed, May 21, 2014 at 10:43:07PM +0800, Zhang Rui wrote:
> > On =E4=B8=89, 2014-05-21 at 11:52 +0300, Mika Westerberg wrote:
> > > On Thu, May 15, 2014 at 02:44:14PM +0800, Zhang Rui wrote:
> > > > For some ACPI device objects, they represent master devices,
> > > > and their children devices are enumerated by bus controller dri=
vers
> > > > for the buses they are on.
> > > >=20
> > > > In this case, we do not want to enumerate their children device=
s to
> > > > platform bus explicitly in acpi scan code.
> > > >=20
> > > > Thus a new flag .is_master_device is introduced in this patch.
> > > >=20
> > > > For devices with this flag set, we will not do default enumerat=
ion
> > > > for their children.
> > >=20
> > > Is there any particular reason we would like to enumerate everyth=
ing
> > > below the first device by default?
> >=20
> > we do not enumerate everything below the first device by default, w=
e
> > just enumerate all the devices with _HID.
>=20
> OK.
>=20
> > But if a device has _HID and it is enumerated by its parents to a
> > separate bus, we need this flag set for its parent.
>=20
> How about checking if the device has *SerialBus() connector and in su=
ch
> case skip the device (given that it is not listed in a special list,
> like acpi_platform_device_ids)?

This sounds like a good idea.
I think we can just ignore devices with ACPI_RESOURCE_TYPE_SERIAL_BUS
resources, and this can be done in drivers/acpi/scan.c for all _HID
devices w/o handler attached, right?

thanks,
rui
