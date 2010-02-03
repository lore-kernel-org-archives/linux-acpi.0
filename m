From: Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] drivers/acpi/ec.c fix a small memory leak
Date: Wed, 3 Feb 2010 09:12:26 +0300
Message-ID: <20100203061225.GB32535@bicker>
References: <1265112730.4804.8.camel@ICE-BOX> <4B684650.9070807@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:11625 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab0BCGMl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2010 01:12:41 -0500
Content-Disposition: inline
In-Reply-To: <4B684650.9070807@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Darren Jenkins <darrenrjenkins@gmail.com>, Kernel Janitors <kernel-janitors@vger.kernel.org>, Len Brown <lenb@kernel.org>, linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Feb 02, 2010 at 06:35:44PM +0300, Alexey Starikovskiy wrote:
> NAK
>=20
> saved_ec is allocated if flag EC_FLAGS_VALIDATE_ECDT is true.
> EC_FLAGS_SKIP_DSDT_SCAN have no sense in such case, thus this new cod=
e path
> is never executed.
> On the other hand, unconditionally freeing pointer, which is might be=
 NULL, is not
> right either.

As near as I can tell you are right that the code cannot leak memory.  =
But Darren=20
is right to think that it's calling kfree() on a NULL pointer is OK.  H=
is patch does=20
not introduce any errors.

The logic here is basically spaghetti.  Every person who looks at it is=
 going to=20
think it's a leak.  Lots of people are going to look at it, because the=
 static
checkers all think it's a leak too.  Someone could send a cleanup patch=
 that makes it
readable.

regards,
dan carpenter

> So, this patch introduced more problems as it tries to solve...
>=20
> Regards,
> Alex.
>=20
> Darren Jenkins =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Plug a very small leak in acpi_ec_ecdt_probe()
> >=20
> > Coverity CID: 13319
> >=20
> > Signed-off-by: Darren Jenkins <darrenrjenkins@gmail.com>=20
> >=20
> > diff --git drivers/acpi/ec.c drivers/acpi/ec.c
> > index d6471bb..13061dc 100644
> > --- drivers/acpi/ec.c
> > +++ drivers/acpi/ec.c
> > @@ -1009,8 +1009,10 @@ int __init acpi_ec_ecdt_probe(void)
> >  	/* fall through */
> >  	}
> > =20
> > -	if (EC_FLAGS_SKIP_DSDT_SCAN)
> > +	if (EC_FLAGS_SKIP_DSDT_SCAN) {
> > +		kfree(saved_ec);
> >  		return -ENODEV;
> > +	}
> > =20
> >  	/* This workaround is needed only on some broken machines,
> >  	 * which require early EC, but fail to provide ECDT */
> >=20
> >=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-jani=
tors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
