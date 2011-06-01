From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH] ACPI: Fixes device power states array overflow
Date: Wed, 01 Jun 2011 23:55:13 +0800
Message-ID: <1306943713.2873.12.camel@hp6530s>
References: <1306762961.2244.13.camel@localhost>
	 <201105312309.46344.oldium.pro@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41795 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757142Ab1FAOzt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Jun 2011 10:55:49 -0400
In-Reply-To: <201105312309.46344.oldium.pro@seznam.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Old <oldium.pro@seznam.cz>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Dan Carpenter <error27@gmail.com>

=E5=9C=A8 2011-06-01=E4=B8=89=E7=9A=84 05:09 +0800=EF=BC=8COld=C5=99ich=
 Jedli=C4=8Dka=E5=86=99=E9=81=93=EF=BC=9A
> Hi Lin,
>=20
> On Monday 30 May 2011 at 15:42:41, Lin Ming wrote:
> > Commit 28c2103 added new state ACPI_STATE_D3_COLD, so the device po=
wer
> > states array must be expanded by one also.
> >=20
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> > ---
> >  include/acpi/acpi_bus.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 3a10ef5..ff246e8 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -210,7 +210,7 @@ struct acpi_device_power_state {
> >  struct acpi_device_power {
> >  	int state;		/* Current state */
> >  	struct acpi_device_power_flags flags;
> > -	struct acpi_device_power_state states[4];	/* Power states (D0-D3)=
 */
> > +	struct acpi_device_power_state states[5];	/* Power states (D0-D3C=
old)=20
> */
>=20
> Wouldn't it be better to use some constant, so that the same problem =
would not=20
> appear again in future - something like ACPI_D_STATE_COUNT or (maybe =
better)=20
> ACPI_D_STATES_MAX+1 instead of magic number 5?

Nice catch, I have updated the patch.

Thanks.

>=20
> Cheers,
> Old=C5=99ich.
>=20
>=20
> >  };
> >=20
> >  /* Performance Management */


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
