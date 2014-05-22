From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 2/7 v3] trace, AER: Move trace into unified interface
Date: Wed, 21 May 2014 20:03:48 -0400
Message-ID: <20140522000348.GC1644@gchen.bj.intel.com>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
 <1400142646-10127-3-git-send-email-gong.chen@linux.intel.com>
 <20140521101903.GC21205@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:9373 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbaEVAbj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 May 2014 20:31:39 -0400
Content-Disposition: inline
In-Reply-To: <20140521101903.GC21205@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2014 at 12:19:03PM +0200, Borislav Petkov wrote:
> >  drivers/pci/pcie/aer/Kconfig           |  1 +
> >  drivers/pci/pcie/aer/aerdrv_errprint.c |  4 +-
> >  include/ras/ras_event.h                | 64 ++++++++++++++++++++++++++=
++
> >  include/trace/events/ras.h             | 77 --------------------------=
--------
>=20
> Ok, I don't understand: all the rest of the kernel holds tracepoints in
> include/trace/events/. Why are you moving this at all?
>=20
> Why can't the new extlog tracepoint in patch 5 be added to
> include/trace/events/ras.h too?
>=20
OMG. Again? Long time ago Mauro highly recommended me not putting new
tracepoints under include/trace/events/ras.h, on the contrary, it shoud
be put to include/ras/ras_event.h. But now the same story plays
again. :-(

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTfT7kAAoJEI01n1+kOSLH7l8P/3cBt++dwHJHhxeJ84L1kGFA
ZVyVNkq04W6lZpYcPiFC7nAfrgQGXK6Xk3D+MadxuUUWF34S2bW7Z57jBZSTc8bb
HCF1oeOMEPl3eXJodAIoufoN8OhnZVJ4Dy9XKWMZsxKbSo1KfTxe8vRmDMCm2V4o
V9tmzJL8Xgnccz18wsk2cMtNod/euKbcvYU0Edlbk7Iuzo+JZ3KYVJh4lhlpXLtF
A4DqpkMSB/7gRiG9rXffjuSdFJNzzfGHtaYEYniV/RwXt3HA57GLrdoy06kt6yf6
Dd1oxFDpNDeKWQwIx6iJI0cz4AIekISBacNlpaLYati40vBK37hg+B2oFHo7HDBz
iHfnEHDIqN+MNz1d1ZNv6pZaeun7NsWqZkkERU2LM0INaqV8cHYH8pSPPqwTFmHP
3cCE7PS4eTq6gkC9yuE+ocnAi3QQpd/63u36l1z6O5yulKb4d4Q8jCT2+RBELZtc
auPiaospXvHaZPTPKtH+uxeGPhiE0Wt7X1Mn9rpMSIL1jR75B/NLxp6mwvVELamy
5cNQcPaVajjam07N9/TSdN5v3JNx/Iibr1eLSVtgRDeMXgkVvaDmiP1D+FmCADvS
NKu7lJIpzR/q7V8SD7pqUeY+umUC8McfmB1DNpyV6N3uDBGIye6nohi+DSXuBIK0
a/E8+ZtKd8bGoJY0qiHx
=dd/s
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
