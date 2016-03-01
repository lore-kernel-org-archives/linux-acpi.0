From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 1/3] ACPI/NFIT: Update Control Region Structure to
 comply ACPI 6.1
Date: Tue, 01 Mar 2016 09:38:04 -0700
Message-ID: <1456850284.15454.23.camel@hpe.com>
References: <1456178130-26468-1-git-send-email-toshi.kani@hpe.com>
	 <1456178130-26468-2-git-send-email-toshi.kani@hpe.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E37E44D64B@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:21223 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734AbcCAP6a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2016 10:58:30 -0500
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E44D64B@ORSMSX110.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Williams, Dan J" <dan.j.williams@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "elliott@hpe.com" <elliott@hpe.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

On Tue, 2016-03-01 at 15:13 +0000, Moore, Robert wrote:
>=20
> > -----Original Message-----
> > From: Toshi Kani [mailto:toshi.kani@hpe.com]
> > Sent: Monday, February 22, 2016 1:55 PM
> > To: rjw@rjwysocki.net; Williams, Dan J
> > Cc: Moore, Robert; Zheng, Lv; elliott@hpe.com; linux-nvdimm@lists.0=
1.or
> > g;
> > linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
> > devel@acpica.org; Toshi Kani
> > Subject: [PATCH v2 1/3] ACPI/NFIT: Update Control Region Structure =
to
> > comply ACPI 6.1
> >=20
> > ACPI 6.1, Table 5-133, updates NVDIMM Control Region Structure as
> > follows.
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
>=20
>=20
> I don't think we are going to start changing the ACPI tables defined =
in
> the ACPICA headers because of this. We do in fact have macros for thi=
s
> purpose.

Can you elaborate what macros you suggest to use for this purpose?

Thanks,
-Toshi
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
