From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 5/7 REVISION] trace, RAS: Add eMCA trace event interface
Date: Thu, 12 Jun 2014 22:19:57 -0400
Message-ID: <20140613021956.GA17509@gchen.bj.intel.com>
References: <1402475691-30045-1-git-send-email-gong.chen@linux.intel.com>
 <1402553517-30208-1-git-send-email-gong.chen@linux.intel.com>
 <20140612092808.5f7bec5e@gandalf.local.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14176 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbaFMCs2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jun 2014 22:48:28 -0400
Content-Disposition: inline
In-Reply-To: <20140612092808.5f7bec5e@gandalf.local.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com, linux-acpi@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2014 at 09:28:08AM -0400, Steven Rostedt wrote:
> > +	TP_STRUCT__entry(
> > +		__field(u32, err_seq)
> > +		__field(u8, etype)
> > +		__field(u8, sev)
> > +		__field(u64, pa)
> > +		__field(u8, pa_mask_lsb)
> > +		__array(u8, fru_id, sizeof(uuid_le))
> > +		__string(fru_text, fru_text)
> > +		__array(u8, data, sizeof(struct cper_mem_err_compact))
>=20
> The above array works, but I'm wondering why you don't just use the
> types themselves?
>=20
> That is:
>=20
> 		__field(uuid_le, fru_id)
> 		__field(struct cper_mem_err_compact, data)
>=20
Every time when I use above codes I will hit some compiler error like
"error: conversion to non-scalar type requested". It looks some
data types like above (unless typedef) can't be used in __field.
Is it true? How to fix that?


--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTml/MAAoJEI01n1+kOSLH2wwP/3YG6qZMEPdlkH8NBStZBg0t
oEteXA9YuqhXMKApFjnibKnff/3XWbkxvIEkJqcUwzJnviz2fT5ZxtmS7W5pKB52
t/xTiu+0cNQLzyGW2+2AcS6Z6KvsnEKNC65c7t8zW6jvBDwjafxWsR8/0DlJAvIh
D4DApQ4lDMzIEjJsGtyqkMhuxFBWVps69G0i2+p+2ANTVK38hC8NLlySzMJd05Dk
utMZixZxopiqLQXq9inyOX9/GuT6xR9AOq7OXISAz4AizJI+JaC0V+4JoMPy1PKv
5/2xFXKJGAfjOGEh1DO9VfnW5tIgj7sQjKMOWmqFY9U14/rrgRdkzO1j9nOY/Y38
4Eo4ML8D+3QlWwyPrktS+f5GB6hs1+aoWBOg0nqWw50dggWG+dWedqE1xRybuRcJ
yuSkp9Yz7HiBK+RAxMLXMalqA50SxEBRdcRd/Z8T7cAXOs3V76ATjjNTkh2Rl4Wb
vRxssGqUUF6S1cIPyDzFYJTRS3rUOMR+x2A/yaG5+uYj/3CO/SE+E/tkdIS1MW7Q
vgko/lUf4uamEqh7k9ai2CcURsLsaK83mkzB5PTSRha6isNjWqEOWOJG8hbEVFOs
FBsavSSXppfuqlcvq318M3KXDS0ExT0EiyzRC5C0fsxlzg8mLhSIiPcEXDSD5nl0
rWNzKaTZQ/UMmtgo6o+c
=/TBM
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
