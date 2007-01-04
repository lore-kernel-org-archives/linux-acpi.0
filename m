From: Stelian Pop <stelian@popies.net>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Thu, 04 Jan 2007 11:09:44 +0100
Message-ID: <1167905384.7763.36.camel@localhost.localdomain>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
	 <200701040024.29793.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sd291.sivit.org ([194.146.225.122]:3265 "EHLO sd291.sivit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932352AbXADKlP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Jan 2007 05:41:15 -0500
In-Reply-To: <200701040024.29793.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Le jeudi 04 janvier 2007 =E0 00:24 -0500, Len Brown a =E9crit :

> > > I'd like to keep this driver out-of-tree
> > > until we prove that we can't enhance the
> > > generic code to handle this hardware
> > > without the addition of a new driver.
> >=20
> > How long is this going to take ?
>=20
> How about 2.6.21?

Good news !

> What needs to happen is
> 1. a maintainer for sony_acpi.c needs to step forward
>     I can't do this, I'm not allowed to be in the reverse engineering=
 business.

Well, I can't do this either, because I just don't have the required
hardware anymore.

If someone want to step forward now it is a great time !
>=20
> 2. /proc/acpi/sony API needs to be deleted
>=20
> 3. source needs to move out of drivers/acpi, and into drivers/misc al=
ong with msi.

Sensible suggestions, the new maintainer will have to work on this.

Thanks Len.

--=20
Stelian Pop <stelian@popies.net>

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
