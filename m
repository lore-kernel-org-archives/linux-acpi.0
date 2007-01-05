From: Mattia Dongili <malattia@linux.it>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Fri, 5 Jan 2007 13:13:10 +0100
Message-ID: <20070105121310.GB13533@inferi.kami.home>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <200701040024.29793.lenb@kernel.org> <1167905384.7763.36.camel@localhost.localdomain> <20070104191512.GC25619@inferi.kami.home> <1167991323.8985.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:58963 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965101AbXAEMN6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jan 2007 07:13:58 -0500
Content-Disposition: inline
In-Reply-To: <1167991323.8985.23.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stelian Pop <stelian@popies.net>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>, Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>

On Fri, Jan 05, 2007 at 11:02:03AM +0100, Stelian Pop wrote:
> Le jeudi 04 janvier 2007 =E0 20:15 +0100, Mattia Dongili a =E9crit :
>=20
> > > > What needs to happen is
> > > > 1. a maintainer for sony_acpi.c needs to step forward
> > > >     I can't do this, I'm not allowed to be in the reverse engin=
eering business.
> > >=20
> > > Well, I can't do this either, because I just don't have the requi=
red
> > > hardware anymore.
> > >=20
> > > If someone want to step forward now it is a great time !
> >=20
> > I have the hw and I'd be happy to do some basic working on the code
>=20
> FYI, sonypi is also searching for a new maintainer, and it is quite
> closely related to sony_acpi...

Yes, probably the FnKeys stuff needs to worked out into a single driver
to ease it usage (I still remember some very old discussion about makin=
g
sonypi use the acpi methods to access the hw).

> If you are interested by the job, it is all yours. :)

Let's see if I can come up with something, I have also an ux50 that is
not very happy with current sonypi

Thanks
--=20
mattia
:wq!
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
