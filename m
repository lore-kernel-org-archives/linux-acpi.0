From: Stelian Pop <stelian@popies.net>
Subject: Re: [PATCH 1/2] Add new sony laptop drivers maintainer
Date: Fri, 09 Feb 2007 14:34:58 +0100
Message-ID: <1171028098.6387.15.camel@localhost.localdomain>
References: <11709622011964-git-send-email-malattia@linux.it>
	 <11709622013582-git-send-email-malattia@linux.it>
	 <200702090144.13237.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sd291.sivit.org ([194.146.225.122]:4390 "EHLO sd291.sivit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946449AbXBINfD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Feb 2007 08:35:03 -0500
In-Reply-To: <200702090144.13237.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: malattia@linux.it, linux-acpi@vger.kernel.org

Le vendredi 09 f=E9vrier 2007 =E0 01:44 -0500, Len Brown a =E9crit :
> On Thursday 08 February 2007 14:16, malattia@linux.it wrote:
> > From: Mattia Dongili <malattia@linux.it>
> >=20
> > Signed-off-by: Mattia Dongili <malattia@linux.it>
> > ---
> >  MAINTAINERS |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index efca26a..ec97723 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3012,6 +3012,8 @@ S:	Maintained
> >  SONY VAIO CONTROL DEVICE DRIVER
> >  P:	Stelian Pop
> >  M:	stelian@popies.net
> > +P:	Mattia Dongili
> > +M:	malattia@linux.it
> >  W:	http://popies.net/sonypi/
> >  S:	Maintained
>=20
> Stelian, are you still actively maintaining Sony support,

Actively definately not, though I still answer a lot of support
questions about sonypi.

I even receive patches from time to time :)

> or should we simply replace your name here with Mattia?

>From what I recall, Mattia took over sony_acpi but didn't want to hand=
le
sonypi as well, at least not for the time being.=20

If he changed his mind I'm hapily handing over the maintenance to him.

If not, maybe the MAINTAINERS entry should be clarified to say that
Mattia maintains sony_acpi and sonypi is currently not maintained.

--=20
Stelian Pop <stelian@popies.net>

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
