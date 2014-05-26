From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 3/7 v4] CPER: Adjust code flow of some functions
Date: Sun, 25 May 2014 22:07:45 -0400
Message-ID: <20140526020745.GB31035@gchen.bj.intel.com>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
 <1400142646-10127-4-git-send-email-gong.chen@linux.intel.com>
 <20140521110521.GF21205@pd.tnic>
 <20140521235159.GB1644@gchen.bj.intel.com>
 <20140522105242.GG4383@pd.tnic>
 <20140523014910.GB16945@gchen.bj.intel.com>
 <20140523093703.GB21332@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7135 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752AbaEZKK5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 May 2014 06:10:57 -0400
Content-Disposition: inline
In-Reply-To: <20140523093703.GB21332@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2014 at 11:37:03AM +0200, Borislav Petkov wrote:
> Date: Fri, 23 May 2014 11:37:03 +0200
> From: Borislav Petkov <bp@alien8.de>
> To: "Chen, Gong" <gong.chen@linux.intel.com>
> Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org
> Subject: Re: [PATCH 3/7 v4] CPER: Adjust code flow of some functions
> User-Agent: Mutt/1.5.23 (2014-03-12)
>=20
> On Thu, May 22, 2014 at 09:49:10PM -0400, Chen, Gong wrote:
> > If so, it has been there already. Maybe you should check patch
> > 5/7. I merge pa/pa_mask into pa_info as a whole to avoid too much
> > calculation/logic in trace.
>=20
> My bad, how did I miss that:
>=20
> > +static void __trace_mem_error(const uuid_le *fru_id, char *fru_text,
> > +                              u64 err_count, u32 severity,
> > +                              struct cper_sec_mem_err *mem)
> > +{
> > +       u32 etype =3D ~0U;
> > +       char pa_info[64];
> > +       u8 n =3D 0;
> > +
> > +       if (mem->validation_bits & CPER_MEM_VALID_ERROR_TYPE)
> > +               etype =3D mem->error_type;
>=20
> More SNAFU: mem->error_type is u8 and you're saving it into a u32. What
> possible reason can you have for that?
OK, I will fix it.
>=20
> > +
> > +       memset(pa_info, 0, 64);
> > +       if (mem->validation_bits & CPER_MEM_VALID_PA)
> > +               n =3D snprintf(pa_info, 63, "physical addr: 0x%016llx ",
> > +                            mem->physical_addr);
> > +
> > +       if (mem->validation_bits & CPER_MEM_VALID_PA_MASK)
> > +               snprintf(pa_info + n, 63 - n, "addr LSB: 0x%x ",
> > +                        (u8)__ffs64(mem->physical_addr_mask));
>=20
> So pa_info is 64 bytes!!! For what, a u64 and a u8? That's 9 bytes.
>=20
Oh, in my subconscious I am always afraid some kind of buffer overflow atta=
ch.
You are right, here it is obviously too wasteful. I can shrink it to 10
bytes. Please see my another reply for why I hope to use a string.

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTgqHxAAoJEI01n1+kOSLHttoQAIwZIvkkCTlsQqf8lgp1qfty
kdaFzzzTJTLgpRXbsvCDwqie5LMV6wOLu1RJoqsHlG++9/QLaY5BDtCO6tGhkbwB
0L/6I0sd2Z2vqPMBjEr7hLaVcmOe0wu8Y3CMf+Q21piOYDUEocUdU4Yn0QeoxXCs
7UlVs76wowIwymQlJbNojiZSZJxAAWdGTgk/LBRgd+KrBaK1NVfePiGwsdGBUNGX
957n8olNpd1aNWZWginoqu4W0V3KXfVoch0ygvMfdZjxWtT+eBXF0pIdAPxqntsg
/F7Vifp3R8QIxvuKxpOWMsQXs5/i40xWm+VpOujJyOxmam6+KLNUpg67ZmZsqtDB
pNfCFMl+sQsOKPQHeWUGGmaAWACa16KcH9wTZKRs+o8QzGX+cvnV7IAck/E6Sou7
UZJKg8bXroDAIj+msKG/CjUHoB/ZbX/jagv66noHqa4F1o/dO7Ghb5/HeCzlWPLj
DqUPQ/4Ka8FHHp/VLtj3AZcgBk6+KR+KFsJb+EH9+cSuRXqZmlRI+g4U+nD3hkru
y8RpgBt3HJsz3KsLgw1cLYMj89GY7YrXsK5yd9WBAMTeCAsnN11C+UqOs0kvqu4A
MaAKuxaee0dGvzFPo1GaSjjlGmfBHo996rfkGnWdXngy5uRLwTBNM7+WwEmZn2CK
vKU6m3Mha4wIXK+pgn4u
=l7XI
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
