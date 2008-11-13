From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [Devel] Re: [RESEND] [PATCH 2/3] Introduce
	acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Thu, 13 Nov 2008 16:27:09 +0800
Message-ID: <1226564829.15014.225.camel@rzhang-dt>
References: <200810192350.57993.trenn@suse.de>
	 <20081111005856.GA10535@srcf.ucam.org> <200811121758.39105.trenn@suse.de>
	 <1226542860.15014.187.camel@rzhang-dt>
	 <20081113022409.GA25298@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63451 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053AbYKMI0r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Nov 2008 03:26:47 -0500
In-Reply-To: <20081113022409.GA25298@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, "Moore, Robert" <robert.moore@intel.com>, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "me@markdoughty.co.uk" <me@markdoughty.co.uk>, "Zhao, Yakui" <yakui.zhao@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "devel@acpica.org" <devel@acpica.org>

On Thu, 2008-11-13 at 10:24 +0800, Matthew Garrett wrote:
> On Thu, Nov 13, 2008 at 10:21:00AM +0800, Zhang Rui wrote:
> > =EF=BB=BFI have a test box which suspends well, but always reboots =
instead of
> > resuming when pressing the power button.
> > I found that there are two FACS tables on this platform,
> > XSDT-->FADT1-->Xfacs------>FACS1
> > 	|----->facs-----|
> > 			|->FACS2
> > RSDT-->FADT2-->facs-----|
> > Linux uses XSDT on this platform and sets the waking vector in FACS=
1
> > when suspending. But it seems that the BIOS only cares for the waki=
ng
> > vector in FACS2, thus it reboots when resuming because the waking v=
ector
> > is not set at all.
>=20
> That makes it sound like we should be using the 32-bit value in this=20
> case as well.

>=20
> > My original proposal is to install both FADT1.Xfacs and FADT1.facs =
in to
> > the global table list and set the waking vectors on both of them.
> > now it seems that switching back to RSDT if multiple valid FACS tab=
les
> > exists is also a solution for this issue.
>=20
> Why? If there's a FADT entry in the XSDT we might as well use it - al=
l=20
> the machines I've checked contain valid information in the 32-bit ent=
ry=20
> of the FADT there.
>=20
do you mean =EF=BB=BFalways using FADT1.facs and ignore the FADT.Xfacs =
in Linux?

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
