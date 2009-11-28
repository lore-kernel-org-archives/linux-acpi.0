From: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
Subject: Re: rfkill: persistent device suspend/resume
Date: Sat, 28 Nov 2009 14:39:49 +0100
Message-ID: <1259415589.5428.22.camel@johannes.local>
References: <4A37A3E1.8060606@tuffmail.co.uk>
	 <1245161645.13461.3.camel@johannes.local> <4A37AEB7.6060405@tuffmail.co.uk>
	 <20090618030806.GE29569@khazad-dum.debian.net>
	 <20091128124158.GB17373@khazad-dum.debian.net>
	 <1259413945.5428.21.camel@johannes.local>
	 <20091128132752.GD17373@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-p/jXZQ+dRDEX7xjYl9Rp"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091128132752.GD17373-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Molton <ian.molton-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Corentin Chary <corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-p/jXZQ+dRDEX7xjYl9Rp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2009-11-28 at 11:27 -0200, Henrique de Moraes Holschuh wrote:

> > static int rfkill_resume(struct device *dev)
> > {
> >         struct rfkill *rfkill =3D to_rfkill(dev);
> >         bool cur;
> >=20
> >         if (!rfkill->persistent) {
> >                 cur =3D !!(rfkill->state & RFKILL_BLOCK_SW);
> >                 rfkill_set_block(rfkill, cur);
> >         }
>=20
> The issue I am reporting is _only_ about persistent devices, so it is the
> if(!rfkill->persistent) that is the problem.  It works perfectly for the
> other devices.

So then I don't understand -- if the device specifically said that it
was persistent, what kind of help does it need, and why does it not just
unset persistent if it needs it?

johannes


--=-p/jXZQ+dRDEX7xjYl9Rp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJLESgiAAoJEODzc/N7+Qma2TQQAIDyK0af5ZPF0dVRS9cJRDwB
tq51TN0Oi6zFcDXWHO3BUTA6noRHqltZfHSn31pm/fFVbs151XjX5NM7UG/GE8gr
ijpSBSTd9Nljwkn5USxBi/7ffHkDiBoWnXzfRU2WodTfoi3/GJTDe9c6S88Jqhkc
Lml/LzyXBOaRDNJDPW/iK0ywl70HpzHdiGZ2ExkWmN/Cx2x/E9GoRuybphNL2AfJ
pDRoEvkgPHxPFEPs2yi5oT1w80Ya213zXThbvj2jntWDEQdfy6fasnRJBgN6PhGM
D6imGfkk7EaZ5XIjw2fUb5BRBTa1Gd92192G5pkKBwFOtoyab0pVUnXqANqpR47e
Vmi0lD3S6K1XtsxXnnfTGhkfYwRBvOJh4rrrRTVPpTLTczvB4qBDnpHQ1pz+3J0H
GTCT4s7Hi2KfRmUO2vZvWGQJ+VWaMmf01PPkKhouBBrDNOMwGCh29O5bhHPM++cV
h9MExFG5JnPnCyzLEmTqswLvNPWkyyMgstwDHg1mub5Fbag4Td8y3PPCGUu7v3h8
sb4gQDXmq19pYgwQG/zgoRQfwKnN6rp6DEA6/wDhYHuqpf71adajY7q/E2YpA5Tm
35aHVmDP83SAf4OiCY4SmHsanUIVM62ZHVoLnm5WrFPAVLI6gnZCpPCheOnlWm3G
RRZ8icCgvOu8nHjiTKmw
=u9fF
-----END PGP SIGNATURE-----

--=-p/jXZQ+dRDEX7xjYl9Rp--

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
