From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V6 1/2] introduce ALS sysfs class
Date: Thu, 03 Sep 2009 10:45:18 +0800
Message-ID: <1251945918.3483.267.camel@rzhang-dt>
References: <1251789947.3483.215.camel@rzhang-dt>
	 <9b2b86520909021222k6cc49456vc3232e488eef9e37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:65198 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753499AbZICCrg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Sep 2009 22:47:36 -0400
In-Reply-To: <9b2b86520909021222k6cc49456vc3232e488eef9e37@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>

On Thu, 2009-09-03 at 03:22 +0800, Alan Jenkins wrote:
> On 9/1/09, Zhang Rui <rui.zhang@intel.com> wrote:
> >
> > Introduce ALS sysfs class.
> >
> > ALS sysfs class provides a standard sysfs interface for
> > Ambient Light Sensor devices.
> >
> > please read Documentation/ABI/testing/sysfs-class-als for
> > detailed sysfs designs.
> >
> > =EF=BB=BFCC: Pavel Machek <pavel@ucw.cz>
> > Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
>=20
> > +++ linux-2.6/drivers/als/Kconfig
> > @@ -0,0 +1,10 @@
> > +#
> > +# Ambient Light Sensor sysfs device configuration
> > +#
> > +
> > +menuconfig ALS
> > +	tristate "Ambient Light Sensor sysfs device"
> > +	help
> > +	  This framework provides a generic sysfs interface for
> > +	  Ambient Light Sensor devices.
> > +	  If you want this support, you should say Y or M here.
>=20
> Gratuitous nitpick:
> Can this option be made non-visible (or hidden behind CONFIG_EMBEDDED=
)?
>=20
> Maybe you copied the pattern of the thermal sysfs interface - but the
> ACPI thermal driver is useful to keep your computer cool even without
> the sysfs interface.  ALS drivers are useless without the sysfs
> interface, no?
>=20
ACPI ALS device driver is the first user of this sysfs class.
I think there will be more native ALS device drivers in the future,
which locate at drivers/als/ and depends on CONFIG_ALS.

thanks,
rui


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
