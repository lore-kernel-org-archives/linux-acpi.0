From: Thomas Renninger <trenn@suse.de>
Subject: Re: [Resend] [PATCH]: ACPI: Rename ACPI processor device bus ID
Date: Wed, 3 Jun 2009 11:14:32 +0200
Message-ID: <200906031114.33233.trenn@suse.de>
References: <1243737111.3634.168.camel@localhost.localdomain> <200906021519.29217.trenn@suse.de> <1243996446.3558.202.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59675 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753091AbZFCJOc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jun 2009 05:14:32 -0400
In-Reply-To: <1243996446.3558.202.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wednesday 03 June 2009 04:34:06 yakui_zhao wrote:
> On Tue, 2009-06-02 at 21:19 +0800, Thomas Renninger wrote:
> > On Sunday 31 May 2009 04:31:51 yakui_zhao wrote:
> >=20
> > > +	/*
> > > +	 * On some boxes several processors use the same processor bus =
id.
> > > +	 * But they are located in different scope. For example:
> > > +	 * \_SB.SCK0.CPU0
> > > +	 * \_SB.SCK1.CPU0
> > > +	 * Rename the processor device bus id. And the new bus id will =
be
> > > +	 * generated as the following format:
> > > +	 * CPU+CPU ID.
> > > +	 */
> > > +	sprintf(acpi_device_bid(device), "CPU%X", pr->id);
> > Hm, there were several attempts to get rid of acpi_device_bid and=20
> > friends.
> > Especially here, sprintfing into something function like looks real=
ly=20
> > wrong.
> > Len, do you agree that not introducing new ones and at some point o=
f
> > time replacing:
> > acpi_device_bid(device)
> > with
> > device->pnp.bus_id
> > is the way to go?
> =EF=BB=BFThe acpi_device_bid is not a function. It is equal to the
> device->pnp.bus_id for the ACPI device.
> #define acpi_device_bid(d)      ((d)->pnp.bus_id)
this #define should vanish sooner or later.
Several people suggested to get rid of these already.
Why don't you use:
sprintf(device->pnp.bus_id, "CPU%X", pr->id);
Unfortunately these constructs are rather common in drivers/acpi,
thus I ask whether these should be avoided or not.

   Thomas
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
