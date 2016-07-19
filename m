From: Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 1/3] pmem: clarify a debug print in pmem_clear_poison
Date: Tue, 19 Jul 2016 11:56:39 -0600
Message-ID: <20160719175639.GE12960@omniknight.lm.intel.com>
References: <1468889100-30698-1-git-send-email-vishal.l.verma@intel.com>
 <1468889100-30698-2-git-send-email-vishal.l.verma@intel.com>
 <CAPcyv4gpRGJLVfoC3o-rVypQtppkAKg1hObr=1EhcT3Y3g8KUw@mail.gmail.com>
 <1468948496.30121.60.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40440 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752981AbcGSR5H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Jul 2016 13:57:07 -0400
Content-Disposition: inline
In-Reply-To: <1468948496.30121.60.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Williams, Dan J" <dan.j.williams@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>

On 07/19, Verma, Vishal L wrote:
> On Tue, 2016-07-19 at 08:53 -0700, Dan Williams wrote:
> > On Mon, Jul 18, 2016 at 5:44 PM, Vishal Verma <vishal.l.verma@intel=
=2Eco
> > m> wrote:
> > > Prefix the sector number being cleared with a '0x' to make it cle=
ar
> > > that
> > > this is a hex value.
> > >=20
> > > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > > ---
> > > =A0drivers/nvdimm/pmem.c | 2 +-
> > > =A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> > > index 608fc44..29ab25b 100644
> > > --- a/drivers/nvdimm/pmem.c
> > > +++ b/drivers/nvdimm/pmem.c
> > > @@ -57,7 +57,7 @@ static void pmem_clear_poison(struct pmem_devic=
e
> > > *pmem, phys_addr_t offset,
> > > =A0=A0=A0=A0=A0=A0=A0=A0cleared =3D nvdimm_clear_poison(dev, pmem=
->phys_addr + offset,
> > > len);
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0=A0if (cleared > 0 && cleared / 512) {
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_dbg(dev, "%s: %=
llx clear %ld sector%s\n",
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_dbg(dev, "%s: 0=
x%llx clear %ld sector%s\n",
> >=20
> > %#llx is a bit smaller / more readable.=A0=A0Shall I just fix this =
up on
> > applying?
>=20
> TIL :) Yes you can do the fixup, thanks!

Or since I'm reworking the other two, I'lll fix this up too.

> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
