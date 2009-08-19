From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC][PATCH 0/7] PM: Asynchronous suspend and resume (updated)
Date: Wed, 19 Aug 2009 09:05:29 +0800
Message-ID: <1250643929.17853.11.camel@rzhang-dt>
References: <200908122218.13975.rjw@sisk.pl>
	 <1250579793.5351.79.camel@rzhang-dt> <200908182201.11489.rjw@sisk.pl>
	 <200908190158.09623.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47656 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbZHSBHI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Aug 2009 21:07:08 -0400
In-Reply-To: <200908190158.09623.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, Greg KH <gregkh@suse.de>

On Wed, 2009-08-19 at 07:58 +0800, Rafael J. Wysocki wrote:
> On Tuesday 18 August 2009, Rafael J. Wysocki wrote:
> > On Tuesday 18 August 2009, Zhang Rui wrote:
> > > On Mon, 2009-08-17 at 08:15 +0800, Rafael J. Wysocki wrote:
> > > > On Wednesday 12 August 2009, Rafael J. Wysocki wrote:
> > > > > Hi,
> > > > >=20
> > > > > The following patches introduce a mechanism allowing us to ex=
ecute device
> > > > > drivers' suspend and resume callbacks asynchronously during s=
ystem sleep
> > > > > transitions, such as suspend to RAM.  The idea is explained i=
n the [1/1] patch
> > > > > message.
> > > >=20
> > > > Changes:
> > > >=20
> > > > * Added [1/7] that fixes kerneldoc comments in drivers/base/pow=
er/main.c
> > > >   (this is a 2.6.32 candidate).
> > > >=20
> > > > * Added [2/7] adding a framework for representing PM link (idea=
 described
> > > >   in the patch message).
> > > >=20
> > > > * [3/7] is the async resume patch (idea described in the patch =
message).
> > > >=20
> > > > * [4/7] is the async suspend patch.
> > > >=20
> > > > * [5/7] - [7/7] set async_suspend for devices in a few selected=
 subsystems.
> > > >=20
> > > > The patches have been tested on HP nx6325.
> > > >=20
> > > I tried this patch set and it does work. :)
> > > But unfortunately it doesn't save too much time.
> > >=20
> > > I still think that the child device should inherit its parent's
> > > async_suspend flag to do the asynchronous resume more efficiently=
=2E
> > >=20
> > > or at least we should provide such an interface
> > > in =EF=BB=BFdrivers/base/power/common.c, so that device can tell =
the device core
> > > to inherit this flag if there is no off-tree dependency.
> >=20
> > Well, I'd prefer to identify all of the off-tree dependencies that =
have to be
> > taken into account and handle all devices asynchronously.
>=20
> Anyway, I have tested the appended patch on top of [1/7]-[7/7] and my=
 test box
> appears to work fine with it, although it doesn't work in the "async =
for all"
> case.
>=20
> I guess the next step will be to see which devices are not handled
> asynchronously with the patch below and try to figure out which of th=
em
> break(s) things.
>=20
> Thanks,
> Rafael
>=20
> ---
>  drivers/base/power/common.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> Index: linux-2.6/drivers/base/power/common.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/base/power/common.c
> +++ linux-2.6/drivers/base/power/common.c
> @@ -32,7 +32,11 @@ void device_pm_add(struct device *dev)
>  	pr_debug("PM: Adding info for %s:%s\n",
>  		 dev->bus ? dev->bus->name : "No Bus",
>  		 kobject_name(&dev->kobj));
> -	pm_link_add(dev, dev->parent);
> +	if (dev->parent) {
> +		pm_link_add(dev, dev->parent);
> +		if (dev->parent->power.async_suspend)
> +			dev->power.async_suspend =3D true;
> +	}

to use this, we must make sure that =EF=BB=BFdevice_enable_async_suspen=
d is
called before any of its child device being registered, right?
should we check this in =EF=BB=BF=EF=BB=BFdevice_enable_async_suspend?
or at least we should add the comments stating this issue.

thanks,
rui

>  	device_pm_list_add(dev);
>  }
> =20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
