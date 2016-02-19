From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH 1/2] ACPI/NFIT: Update Control Region Structure per ACPI
 6.1
Date: Fri, 19 Feb 2016 16:44:44 -0700
Message-ID: <1455925484.15454.2.camel@hpe.com>
References: <1455923333-13629-1-git-send-email-toshi.kani@hpe.com>
	 <1455923333-13629-2-git-send-email-toshi.kani@hpe.com>
	 <CAPcyv4jUj=NzEHbZjiOUAqOva2ujwWfGSQHcFR-HVXdBwB2LvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:51667 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422953AbcBSWvs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2016 17:51:48 -0500
In-Reply-To: <CAPcyv4jUj=NzEHbZjiOUAqOva2ujwWfGSQHcFR-HVXdBwB2LvA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devel@acpica.org, Lv Zheng <lv.zheng@intel.com>

On Fri, 2016-02-19 at 14:34 -0800, Dan Williams wrote:
> On Fri, Feb 19, 2016 at 3:08 PM, Toshi Kani <toshi.kani@hpe.com> wrot=
e:
> > ACPI 6.1, Table 5-133, updates NVDIMM Control Region Structure
> > as follows.
> > =C2=A0- Valid Fields, Manufacturing Location, and Manufacturing Dat=
e
> > =C2=A0=C2=A0=C2=A0are added from reserved range.=C2=A0=C2=A0No chan=
ge in the structure size.
> > =C2=A0- IDs defined as SPD values are arrays of bytes.=C2=A0=C2=A0T=
he spec
> > =C2=A0=C2=A0=C2=A0clarified that they need to be represented as arr=
ays of bytes
> > =C2=A0=C2=A0=C2=A0as well.
> >=20
> > This patch makes the following changes to support this update.
> > =C2=A0- Change 'struct acpi_nfit_control_region' to reflect the upd=
ate.
> > =C2=A0=C2=A0=C2=A0SPD IDs are defined as arrays of bytes, so that t=
hey can be
> > =C2=A0=C2=A0=C2=A0treated in the same way regardless of CPU endiann=
ess and are
> > =C2=A0=C2=A0=C2=A0not miss-treated as little-endian numeric values.
> > =C2=A0- Change the NFIT driver to show SPD ID values as array of by=
tes
> > =C2=A0=C2=A0=C2=A0in sysfs.
> > =C2=A0- Change the NFIT driver to show Manufacturing Location and
> > =C2=A0=C2=A0=C2=A0Manufacturing Date when they are valid.
> > =C2=A0- Change the NFIT driver to show an NVDIMM unique ID as defin=
ed
> > =C2=A0=C2=A0=C2=A0in section 5.2.25.9 of the spec.
> > =C2=A0- Change sprintf format to use "0x" instead of "#" since "%#0=
2x"
> > =C2=A0=C2=A0=C2=A0does not prepend '0' in some reason.
> >=20
> > link: http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pd=
f
> > Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Robert Moore <robert.moore@intel.com>
> > Cc: Robert Elliott <elliott@hpe.com>
> > Cc: <devel@acpica.org>
> > ---
> > =C2=A0drivers/acpi/nfit.c=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A075
> > ++++++++++++++++++++++++++++++++++++++++++-------
> > =C2=A0include/acpi/actbl1.h |=C2=A0=C2=A0=C2=A024 ++++++++++------
> > =C2=A02 files changed, 80 insertions(+), 19 deletions(-)
>=20
> Hi Toshi,
>=20
> I general looks good, but note that changes to include/acpi/actbl1.h
> need to go through the ACPICA project.=C2=A0=C2=A0Then their normal i=
mport
> process will bring it into the kernel.=C2=A0=C2=A0I added Lv to the c=
c.

Right. Thanks for adding Lv.

> >=20
> > diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> > index ad6d8c6..06677d9 100644
> > --- a/drivers/acpi/nfit.c
> > +++ b/drivers/acpi/nfit.c
> > @@ -722,7 +722,8 @@ static ssize_t vendor_show(struct device *dev,
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct acpi_nfit_co=
ntrol_region *dcr =3D to_nfit_dcr(dev);
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sprintf(buf, "%#x=
\n", dcr->vendor_id);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sprintf(buf, "0x%=
02x%02x\n",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dcr->vendor_id[0], dcr-=
>vendor_id[1]);
> > =C2=A0}
> > =C2=A0static DEVICE_ATTR_RO(vendor);
> >=20
> > @@ -731,7 +732,8 @@ static ssize_t rev_id_show(struct device *dev,
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct acpi_nfit_co=
ntrol_region *dcr =3D to_nfit_dcr(dev);
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sprintf(buf, "%#x=
\n", dcr->revision_id);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sprintf(buf, "0x%=
02x%02x\n",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dcr->revision_id[0], dc=
r-
> > >revision_id[1]);
> > =C2=A0}
> > =C2=A0static DEVICE_ATTR_RO(rev_id);
> >=20
> > @@ -740,7 +742,8 @@ static ssize_t device_show(struct device *dev,
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct acpi_nfit_co=
ntrol_region *dcr =3D to_nfit_dcr(dev);
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sprintf(buf, "%#x=
\n", dcr->device_id);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sprintf(buf, "0x%=
02x%02x\n",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dcr->device_id[0], dcr-=
>device_id[1]);
> > =C2=A0}
> > =C2=A0static DEVICE_ATTR_RO(device);
> >=20
> > @@ -749,7 +752,7 @@ static ssize_t format_show(struct device *dev,
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct acpi_nfit_co=
ntrol_region *dcr =3D to_nfit_dcr(dev);
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sprintf(buf, "%#x=
\n", dcr->code);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sprintf(buf, "0x%=
02x%02x\n", dcr->code[0], dcr-
> > >code[1]);
> > =C2=A0}
> > =C2=A0static DEVICE_ATTR_RO(format);
> >=20
> > @@ -758,7 +761,9 @@ static ssize_t serial_show(struct device *dev,
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct acpi_nfit_co=
ntrol_region *dcr =3D to_nfit_dcr(dev);
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sprintf(buf, "%#x=
\n", dcr->serial_number);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sprintf(buf, "0x%=
02x%02x%02x%02x\n",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dcr->serial_number[0], dcr->serial_number[1],
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dcr->serial_number[2], dcr->serial_number[3]);
> > =C2=A0}
> > =C2=A0static DEVICE_ATTR_RO(serial);
>=20
> These fixups look good.
>=20
> Can we split the new sysfs attributes below into their own patch?

Will do.

> One more comments below:
>=20
> >=20
> > @@ -776,6 +781,45 @@ static ssize_t flags_show(struct device *dev,
> > =C2=A0}
> > =C2=A0static DEVICE_ATTR_RO(flags);
> >=20
> > +static ssize_t mfg_location_show(struct device *dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0struct device_attribute *attr, char *buf)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct acpi_nfit_control=
_region *dcr =3D to_nfit_dcr(dev);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sprintf(buf, "0x%=
02x\n", dcr->manufacturing_location);
> > +}
> > +static DEVICE_ATTR_RO(mfg_location);
> > +
> > +static ssize_t mfg_date_show(struct device *dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0struct device_attribute *attr, char *buf)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct acpi_nfit_control=
_region *dcr =3D to_nfit_dcr(dev);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sprintf(buf, "0x%=
02x%02x\n",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dcr->manufacturing_date[0], dcr-
> > >manufacturing_date[1]);
> > +}
> > +static DEVICE_ATTR_RO(mfg_date);
> > +
> > +static ssize_t unique_id_show(struct device *dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0struct device_attribute *attr, char *buf)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct acpi_nfit_control=
_region *dcr =3D to_nfit_dcr(dev);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (dcr->valid_fields & =
ACPI_NFIT_CONTROL_MFG_INFO_VALID)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return sprintf(buf, "%02x%02x-%02x-%02x%02x-
> > %02x%02x%02x%02x\n",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dcr->vendor_id[0], dcr->vendor_id[1],
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dcr->manufacturing_location,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dcr->manufacturing_date[0], dcr-
> > >manufacturing_date[1],
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dcr->serial_number[0], dcr->serial_number[1],
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dcr->serial_number[2], dcr->serial_number[3]);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return sprintf(buf, "%02x%02x-%02x%02x%02x%02x\=
n",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dcr->vendor_id[0], dcr->vendor_id[1],
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dcr->serial_number[0], dcr->serial_number[1],
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dcr->serial_number[2], dcr->serial_number[3]);
> > +}
> > +static DEVICE_ATTR_RO(unique_id);
>=20
> Let's just call it 'id' as not to confuse it with a 'uuid'.=C2=A0=C2=A0=
Also if
> the manufacturing info is incorporated into the id then I don't think
> we need separate 'mfg_location' and 'mfg_date' attributes.=C2=A0=C2=A0=
If
> userspace really wants those separately it can just dump the NFIT
> table.

Make sense. I will remove=C2=A0'mfg_location' and 'mfg_date', and renam=
e
'unique_id' to 'id'.

Thanks!
-Toshi

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
