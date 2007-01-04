From: Mattia Dongili <malattia@linux.it>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Thu, 4 Jan 2007 20:15:12 +0100
Message-ID: <20070104191512.GC25619@inferi.kami.home>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <200701040024.29793.lenb@kernel.org> <1167905384.7763.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:33792 "EHLO
	aa014msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbXADTVw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jan 2007 14:21:52 -0500
Content-Disposition: inline
In-Reply-To: <1167905384.7763.36.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stelian Pop <stelian@popies.net>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>, Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>

On Thu, Jan 04, 2007 at 11:09:44AM +0100, Stelian Pop wrote:
> Le jeudi 04 janvier 2007 =E0 00:24 -0500, Len Brown a =E9crit :
>=20
> > > > I'd like to keep this driver out-of-tree
> > > > until we prove that we can't enhance the
> > > > generic code to handle this hardware
> > > > without the addition of a new driver.
> > >=20
> > > How long is this going to take ?
> >=20
> > How about 2.6.21?
>=20
> Good news !
>=20
> > What needs to happen is
> > 1. a maintainer for sony_acpi.c needs to step forward
> >     I can't do this, I'm not allowed to be in the reverse engineeri=
ng business.
>=20
> Well, I can't do this either, because I just don't have the required
> hardware anymore.
>=20
> If someone want to step forward now it is a great time !

I have the hw and I'd be happy to do some basic working on the code
but:
- I'll probably need some help;
- I'll have an almost-blackout between the end of February and the end
  of April as I'm moving to a different country and I'll need some time
  before I can be active again (I hope I'll have at least easy mail
  access for all the time though).
Anyway if it is still ok I can maintain the thing, to months seems
enough to give the driver a shape.

> > 2. /proc/acpi/sony API needs to be deleted
> >=20
> > 3. source needs to move out of drivers/acpi, and into drivers/misc =
along with msi.

And turn extra-backlight features into platform_device stuff? So 2 and =
3
can come together.

Moreover, I own an SZ72B and an older GR7 and have come to the same
findings of Cacy, plus a patch to allow a smarter "debug" mode.
So, how to proceed? (I've just cloned the linux-acpi-2.6 tree)

Thanks Len, Thanks Stelian
--=20
mattia
:wq!
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
