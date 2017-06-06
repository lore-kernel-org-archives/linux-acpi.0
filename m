From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2] platform/x86: wmi-bmof: New driver to expose embedded Binary WMI MOF metadata
Date: Tue, 6 Jun 2017 22:50:52 +0200
Message-ID: <201706062250.52564@pali>
References: <cd020900567e5c26af29e0735a3945a855d26a30.1496718529.git.dvhart@infradead.org> <20170606100440.GA4690@pali> <20170606170201.GC32509@fury>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1637567.GHILeTuNXC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34151 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbdFFUu4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2017 16:50:56 -0400
In-Reply-To: <20170606170201.GC32509@fury>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

--nextPart1637567.GHILeTuNXC
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 06 June 2017 19:02:01 Darren Hart wrote:
> On Tue, Jun 06, 2017 at 12:04:40PM +0200, Pali Roh=C3=A1r wrote:
> > On Monday 05 June 2017 20:16:44 Andy Lutomirski wrote:
> > > +#define WMI_BMOF_GUID "05901221-D566-11D1-B2F0-00A0C9062910"
> > > +MODULE_ALIAS("wmi:" WMI_BMOF_GUID);
> >=20
> > Cannot we generate MODULE_ALIAS from module_wmi_driver()? IIRC it
> > is working for i2c drivers.
>=20
> I could see this being automated since we always use wmi:GUID, but it
> isn't currently. Happy to consider it as a follow on.
>=20
> Do you have a specific i2c example you think we should consider
> following?

=46or i2c you can specify in driver code:

MODULE_DEVICE_TABLE(i2c, id_table);

And it automatically provides (via file.mod.c) all needed MODULE_ALIAS.

So when we have wmi_bmof_id_table in driver, cannot we use this?

MODULE_DEVICE_TABLE(wmi, wmi_bmof_id_table);

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1637567.GHILeTuNXC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlk3FawACgkQi/DJPQPkQ1LIJQCgxOZDFt8Aq+3oCe0ywEgQc+X3
5dEAn3Cx0LqfH6T436SFjZL6WDGqXDP4
=BDP8
-----END PGP SIGNATURE-----

--nextPart1637567.GHILeTuNXC--
