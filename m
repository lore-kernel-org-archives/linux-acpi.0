From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V6 09/11] ACPI: introduce flag .is_master_device
Date: Wed, 21 May 2014 23:09:42 +0800
Message-ID: <1400684982.13930.39.camel@rzhang1-toshiba>
References: <1400136256-2218-1-git-send-email-rui.zhang@intel.com>
	 <1400136256-2218-10-git-send-email-rui.zhang@intel.com>
	 <20140521085207.GR1651@lahna.fi.intel.com>
	 <2394524.GkgpdWbBbP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2394524.GkgpdWbBbP@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, matthew.garrett@nebula.com, rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com
List-Id: linux-acpi@vger.kernel.org

On =E4=B8=89, 2014-05-21 at 13:10 +0200, Rafael J. Wysocki wrote:
> On Wednesday, May 21, 2014 11:52:07 AM Mika Westerberg wrote:
> > On Thu, May 15, 2014 at 02:44:14PM +0800, Zhang Rui wrote:
> > > For some ACPI device objects, they represent master devices,
> > > and their children devices are enumerated by bus controller drive=
rs
> > > for the buses they are on.
> > >=20
> > > In this case, we do not want to enumerate their children devices =
to
> > > platform bus explicitly in acpi scan code.
> > >=20
> > > Thus a new flag .is_master_device is introduced in this patch.
> > >=20
> > > For devices with this flag set, we will not do default enumeratio=
n
> > > for their children.
> >=20
> > Is there any particular reason we would like to enumerate everythin=
g
> > below the first device by default?
>=20
> Yes, there is.  Device objects without _ADR under the PCI host bridge=
=2E
>=20
I'm confused. Mika, what do you mean by saying "first device"?

thanks,
rui
> Or we can skip the children under every *platform* device created by =
this by
> default and mark the ones where we want the children to be enumerated=
 as
> platform devices too in a special way if needed.
>=20
> I guess we could try that (that was the Rui's original idea IIRC).
>=20
> Rafael
>=20
