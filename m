From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 2/5] CPER: Adjust code flow of some functions
Date: Tue, 15 Apr 2014 05:19:44 -0400
Message-ID: <20140415091944.GB29868@gchen.bj.intel.com>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
 <1395985981-20476-3-git-send-email-gong.chen@linux.intel.com>
 <20140414133924.GC3663@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5330 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972AbaDOJon (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Apr 2014 05:44:43 -0400
Content-Disposition: inline
In-Reply-To: <20140414133924.GC3663@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, m.chehab@samsung.com, rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2014 at 03:39:24PM +0200, Borislav Petkov wrote:
> > +char *cper_mem_err_location(const struct cper_sec_mem_err *mem)
> > +{
> > +	char *p;
> > +	u32 n =3D 0;
> > +
> > +	memset(mem_location, 0, CPER_REC_LEN);
> > +	p =3D mem_location;
> >  	if (mem->validation_bits & CPER_MEM_VALID_NODE)
> > -		pr_debug("node: %d\n", mem->node);
> > +		n +=3D sprintf(p + n, " node: %d", mem->node);
> > +	if (n >=3D CPER_REC_LEN)
> > +		goto end;
>=20
> 	n +=3D vscnprintf(p + n, CPER_REC_LEN - n - 1, "... ", ...);
>=20
> and you can drop those
>=20
> 	if (n >=3D CPER_REC_LEN)
>=20
> tests.
>=20
> vscnprintf() because it returns the actual number of characters written
> and not what snprintf does and return the chars count it would've
> written. (Thx Richard for the hint!).
You are absolutely right. This function is perfect for this usage.

> > +char *cper_dimm_err_location(const struct cper_sec_mem_err *mem)
> > +{
> > +	const char *bank =3D NULL, *device =3D NULL;
> > +
> > +	memset(dimm_location, 0, CPER_REC_LEN);
> > +	if (!(mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE))
> > +		goto end;
>=20
> a goto label which is used only once?? What's wrong with
>=20
> 		return dimm_location;
>=20
I just feel repeating the same words looks ugly. OK, it is fine to me
to adopt your suggestion.

> > +	dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
> > +	if (bank !=3D NULL && device !=3D NULL)
>=20
> 	if (bank && device)
>=20
> > +		snprintf(dimm_location, CPER_REC_LEN - 1,
> > +			 "DIMM location: %s %s", bank, device);
> > +	else
> > +		snprintf(dimm_location, CPER_REC_LEN - 1, "DMI handle: 0x%.4x",
>=20
> Why the DMI handle? Why not say: "unable to find location" or "location
> not present in DMI" or something more user-friendly.
In essential, I use the suggestion from Tony Luck. DMI handle can't be found
so I just list the original info for it. Maybe I can merge them into one.

> > +#define CPER_REC_LEN				512
>=20
> How did we come up with this? Some spec? 512 chars for an error record?
> That's a bit too much in my book.
>=20
Because 128 is not enough once all fields in error record exist, and 256 lo=
oks
a little bit tough so I choose a bigger value. No spec for it. I just hope
it can contain everything.

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTTPmwAAoJEI01n1+kOSLHbK0P/iZoPKZBssszCIMwQFT0MUiA
JFRsWIoehcWmiIFZcFiL9G/kaMrhLCDyIc35++Obr3YL4bMdtylaGfJEKvegBuWr
NnVC7bgNo8eBzI3hWdBYKIog8W+O5f9F03+vN2sUebMrdgd5jHlpD67gAjKVMq/o
uV8G6r8NVTkyl75Wg0pEzZhI0bqkcWRlV5YChOFm39W0MGFRf7Jfk2aj2ueby1eZ
ugT0SrQLv7hVHcWUY9K8YapFw/Ovr55oh21sz9gfI+F8/bOv6gIi3nVF+gQC8IZg
1Kjhr/KHiM8tgnf4VuDQmHLFaP6+06vCQ4T1hu993eF2rYdRA4+DuftRXpQjCZxK
OJwq8/Z24y7pPAbaNzHAkNStfIN8Q+OvPqGn2eDePdb4dMZ9CZrtuTVJJdUUcsw0
rS6Q/mqKFP3lax+RVR4xp2Wmgjg/73MvpKjoq1w9MlE7O3vx1LekcgAXMoWy9/tb
2iVZpuip9nskhuUVZDBg1EQXrf1cS9SZjWAfNwWkpFZkQQ2EQsU1tLot27AgRwXm
ZpSbcauP2ayO5BfpqtnYvLMTd2pVBprLtMxa+HJ7r8WFrtD5o44rpTucwrHOjEWh
CRFD1AbJTG3CusG5yuSWuUOquSHF0Xa2Ou3ARHlwuyL48dECXaPljiyUjv0FiyA7
P9H1OqtkIPgugp6fquSj
=grB0
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
