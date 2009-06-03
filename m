From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [Resend] [PATCH]: ACPI: Rename ACPI processor device bus ID
Date: Wed, 03 Jun 2009 10:34:06 +0800
Message-ID: <1243996446.3558.202.camel@localhost.localdomain>
References: <1243737111.3634.168.camel@localhost.localdomain>
	 <200906021519.29217.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6399 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbZFCCct (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Jun 2009 22:32:49 -0400
In-Reply-To: <200906021519.29217.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2009-06-02 at 21:19 +0800, Thomas Renninger wrote:
> On Sunday 31 May 2009 04:31:51 yakui_zhao wrote:
>=20
> > +	/*
> > +	 * On some boxes several processors use the same processor bus id=
=2E
> > +	 * But they are located in different scope. For example:
> > +	 * \_SB.SCK0.CPU0
> > +	 * \_SB.SCK1.CPU0
> > +	 * Rename the processor device bus id. And the new bus id will be
> > +	 * generated as the following format:
> > +	 * CPU+CPU ID.
> > +	 */
> > +	sprintf(acpi_device_bid(device), "CPU%X", pr->id);
> Hm, there were several attempts to get rid of acpi_device_bid and=20
> friends.
> Especially here, sprintfing into something function like looks really=
=20
> wrong.
> Len, do you agree that not introducing new ones and at some point of
> time replacing:
> acpi_device_bid(device)
> with
> device->pnp.bus_id
> is the way to go?
=EF=BB=BFThe acpi_device_bid is not a function. It is equal to the
device->pnp.bus_id for the ACPI device.
#define acpi_device_bid(d)      ((d)->pnp.bus_id)

Thanks.
>=20
> Thanks,
>=20
>     Thomas
>=20
> >  	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Processor [%d:%d]\n", pr->id,
> >  			  pr->acpi_id));
> > =20
> >=20
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
