From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 2/5] CPER: Adjust code flow of some functions
Date: Wed, 16 Apr 2014 01:01:58 -0400
Message-ID: <20140416050158.GA11297@gchen.bj.intel.com>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
 <1395985981-20476-3-git-send-email-gong.chen@linux.intel.com>
 <20140414133924.GC3663@pd.tnic>
 <20140414140514.GD3663@pd.tnic>
 <20140415092442.GC29868@gchen.bj.intel.com>
 <20140415180259.GE4826@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21002 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027AbaDPF1K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Apr 2014 01:27:10 -0400
Content-Disposition: inline
In-Reply-To: <20140415180259.GE4826@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, m.chehab@samsung.com, rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2014 at 08:02:59PM +0200, Borislav Petkov wrote:
> this question. Do we even *need* the locking? If so, why? What paths are
> going to end there?
>=20
Yes, The sync can be avoided via separating buffers. I will update my patch
in the next version.

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTTg7GAAoJEI01n1+kOSLH7akP/3kWrjC5YJe3SiKNZYXMkMlm
wQ3PBhgspU4G1ovVPlQxtTjADOZZ5l62lEO6JqOZmJr7G42gs9e2wjGy2I0331yP
RhTgYsVnG33I9OMWkEt88vJpB/iQkZRbH05ZyByB/qaFye4R9MFqF5j1iHnwUiKw
nBk2r2DrmLAVL5wcFRun+46iPXGjuW8f562tWmaYsX+WVRc+ILPkOfaWvPzE4PjG
F1+/YgmzQg5elMUaD1aXZpfDLJS1kbJ19Aj5O50bEWw7OkMcKnzeUl1fMtES97tg
jmcNX73anBiqVw2RmuPaTBmBMUolUWPv9sIMN5kAgh2cmz06TQ3mYgWdfjME6h+j
jnD+GY1kH/FTv2668ycxPVlC4DF4cPJ+qxBXSvjRpwcWp6MhNtBnsiJzRIBcHFiM
KILs35ecShCe1qE46g7+g9993GXWGkbUOKSjDzjUJ1JgNPKsxiSNzMV83D2dGiak
FWqbxUPIfdmxvKbYVoUq8VvAoL1A7S2lpyuN6NYigJgQQkxPdKsfD29ROHIj2ae4
oe5VbmzSJLDGwJbjFDKgfVG+5E0fWBYkFo47o1AvEWQI7RHm572WX9ZYRTXZxuw1
Nfj93bOqJ98uhvhVQRtivIvYzNCs2cm1c3VQqFftDgc3tPUwT8LyTDdnBjhANgaK
CykoR8V6mie8C1+zzYf5
=yhFd
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
