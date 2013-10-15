From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: Extended H/W error log driver
Date: Tue, 15 Oct 2013 00:07:31 -0400
Message-ID: <20131015040731.GA887@gchen.bj.intel.com>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
 <20131011080427.GC18719@pd.tnic>
 <20131014064940.GD12189@gchen.bj.intel.com>
 <20131014105533.GF4009@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131014105533.GF4009@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2013 at 12:55:33PM +0200, Borislav Petkov wrote:
> Date: Mon, 14 Oct 2013 12:55:33 +0200
> From: Borislav Petkov <bp@alien8.de>
> To: Chen Gong <gong.chen@linux.intel.com>
> Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org,
>  linux-acpi@vger.kernel.org
> Subject: Re: Extended H/W error log driver
> User-Agent: Mutt/1.5.21 (2010-09-15)
>=20
> On Mon, Oct 14, 2013 at 02:49:40AM -0400, Chen Gong wrote:
> > On Fri, Oct 11, 2013 at 10:04:27AM +0200, Borislav Petkov wrote:
> > > > [56005.786154] {4}Hardware error detected on CPU0
> > > > [56005.786159] {4}event severity: corrected
> > > > [56005.786162] {4}sub_event[0], severity: corrected
> > >=20
> > > This sub_event[0] could use better decoding though.
> > >=20
> > What's your suggestion?
>=20
> Well, if this only enumerates the sections in CPER, then we can simply
> drop it.
>=20
Some errors have multiple sub sections like below:

[ 1442.070522] {2}[Hardware Error]: Hardware error from APEI Generic Hardwa=
re Error Source: 0
[ 1442.070528] {2}[Hardware Error]: event severity: corrected
[ 1442.070531] {2}[Hardware Error]: sub_event[0], severity: corrected
[ 1442.070534] {2}[Hardware Error]: section_type: memory error
[ 1442.070537] {2}[Hardware Error]: error_status: 0x0000000000000000
[ 1442.070539] {2}[Hardware Error]: sub_event[1], severity: corrected
[ 1442.070541] {2}[Hardware Error]: section_type: memory error
[ 1442.070543] {2}[Hardware Error]: error_status: 0x0000000000000000

> Btw, I was wondering, why are we dropping
> cper_estatus_section_flag_strs? This is again the same issue with
> changing output which people might already rely upon.
>=20

This depends on how we shrink the output information. Your reply in
another patch looks a good idea. Let me try it first.

> Thanks.
>=20
> --=20
> Regards/Gruss,
>     Boris.
>=20
> Sent from a fat crate under my desk. Formatting is fine.
> --

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSXL+DAAoJEI01n1+kOSLHc6UP/2QHsuOL+FECirW/RYShCyhD
dktXi4MadGdPyUES1dhcKb+OhvtIkb2JThvfL/Q/Dl/G0jPjlNz+bPUtdHzi3RWn
5Mhr0BzNetjdMFADG0DmWHGYT3O0lyvUwAmG1+xCfRr7u38ecC0X1lJtnVr5KwWr
IWci1IU+HpDpdr/D+GK7bi5YkECyZPTdJjRumL6ibglKCBm6FmtgLfEQ4lTk/WQb
sVNyF3a77vp4i8MW5/TfR1j9a5mVdnxZGhU/1HY59BgFi0ksE1Sy7Y2MYuot1u4m
YmgtbucSPBYp5KWqgrH2P3WelnG83lZqG/hbpJUhLkciJeFqwonydXpixawS6LFk
gJMXlxPAQ1h2glIIUDVnrE8OY6VtFmAY45jG+h3c1TlCFPeW77sGzEIiqU6edEzn
TMh72/WncLRe/r6mxpZLswwZsMludGp0pJ1mWaEOMH6Hmre5K3w6KMJjufAERQRJ
STTl3jtR6ks4xLVcweOpIL6W/OMWlgjW0S2WNMz2UTbPncgODrBHWp0RXQqdV9Yn
TcAimHqWVeYCRJgQuTI/iRQDMi91YIqf/pKL0hJ7J+LKKvM9PZbo0Xq55PpEq19l
ASsRs44o3kodx2Y1WbaP8yp/MNWTtt0KzvD/j7m0aZQjJna6MDBx5/CTgk9DVyv+
4Y2vhz0JuxhTsIYRj6QS
=CZtd
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
