Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDA634D90C
	for <linux-acpi@vger.kernel.org>; Sat,  9 May 2026 06:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778307233; cv=none; b=h2G7iDB5erI8cV1/yEvNgW3FocLtK6wqD6TUHtxriMTB+afVp3p8M/zThUVQM6VQQjtuiM8oLH2HMKHvfRTMDL7Lb+OG2b/gtK9LhXaDZ7zlatF0HXyuTj8v7vhw7hkuMIFq0rsjdhvn1ufC3G4wDUAgI6AdP3+LerkGnRvKl4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778307233; c=relaxed/simple;
	bh=n052d3NVCe5oHiNU8UFzJ9RFVjS6QHAGJvTysQcfJTc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B+QmDKaZnN49E9XUplzOlFEPhcL4Dw5IgTX3tH+09ZmQ7jrtU4sDJRbpiw9XTXA7YM5JP+X+eA/MWxLA+q2G96fgu21XpSlFg0ikBsIh/PcuLze71SDuLKjPuAgPylS1zs+4nG/ZswRRBKrIVqhX/VgfDl9f3Eb4DprI+2V76oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=KdSFcvQB; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="KdSFcvQB"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id C2E5A2403D1
	for <linux-acpi@vger.kernel.org>; Sat,  9 May 2026 08:13:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1778307228; bh=mAcUMe0hg/2h6gimSEzcs9+8vqeg9sk3Taf5JO7Z4Nk=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=KdSFcvQBYVpiW7QCQZB7UJRHbV2gO00wDCcnN6dltucxiX9AqxWyu8gCbleg4RoJW
	 lThzXA9llLO/idUEXVJXUoJj12lQGces60bh+5oyH0GtDuob9/GLb068GWpDzQO07s
	 6dML3AdfO6EYi2Vgxnbfa7iJyi3UYrjaPRMEBxwXogBk+VUZd9Aka2iEpQvV/ZB3ZQ
	 rXtbmaplywfu2jLnwaq9yRudN9iqEzKLmydhm/dJgghyR/fOvv4pGfKhv6l8j9+Sg+
	 4XzNlDRdUdSy5V3ObhLpkHCNTN6qBucIEbBye1euNj2dB1v9NwWY5mFc3Zcxa/+K6F
	 gg8RKujd7szcg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gCFzw0fQgz6txc;
	Sat,  9 May 2026 08:13:48 +0200 (CEST)
Message-ID: <813b3d417d04904080629c65111a57133ffd767a.camel@posteo.de>
Subject: Re: [PATCH] ACPI: SPCR: Support UART clock frequency field
From: Markus Probst <markus.probst@posteo.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 09 May 2026 06:13:48 +0000
In-Reply-To: <CAJZ5v0jzgDgw1eMugtSPc7ceeTXUM17=3uUaVY8OBkV7nBLsvg@mail.gmail.com>
References: <20260505-acpi_spcr-v1-1-fd4bc6f4eb53@posteo.de>
	 <CAJZ5v0jzgDgw1eMugtSPc7ceeTXUM17=3uUaVY8OBkV7nBLsvg@mail.gmail.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-iiR/tfIbR7HqXJlKJs1S"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-iiR/tfIbR7HqXJlKJs1S
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-05-08 at 21:19 +0200, Rafael J. Wysocki wrote:
> On Tue, May 5, 2026 at 9:36=E2=80=AFPM Markus Probst <markus.probst@poste=
o.de> wrote:
> >=20
> > The Microsoft Serial Port Console Redirection (SPCR) specification
> > revision 1.08 comprises additional field: UART Clock Frequency [1].
> >=20
> > It contains a non-zero value indicating the UART clock frequency in Hz.
> >=20
> > Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serpor=
ts/serial-port-console-redirection-table [1]
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> >  drivers/acpi/spcr.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> > index 73cb933fdc89..d80ad87efae0 100644
> > --- a/drivers/acpi/spcr.c
> > +++ b/drivers/acpi/spcr.c
> > @@ -220,6 +220,9 @@ int __init acpi_parse_spcr(bool enable_earlycon, bo=
ol enable_console)
> >         if (!baud_rate) {
> >                 snprintf(opts, sizeof(opts), "%s,%s,0x%llx", uart, ioty=
pe,
> >                          table->serial_port.address);
> > +       } else if (table->header.revision >=3D 3 && table->uart_clk_fre=
q) {
> > +               snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d,%u", uart=
, iotype,
> > +                       table->serial_port.address, baud_rate, table->u=
art_clk_freq);
> >         } else {
> >                 snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, i=
otype,
> >                          table->serial_port.address, baud_rate);
> >=20
> > ---
>=20
> Please have a look at the sashiko.dev feedback at
>=20
> https://sashiko.dev/#/patchset/20260505-acpi_spcr-v1-1-fd4bc6f4eb53%40pos=
teo.de
>=20
> and let me know what you think.
For the first comment, I don't think thats an issue, as there is no
length check for the other fields either.


The second comment however seems true.

while earlycon parses

<baudrate>,<uartclk>

regular uart parses

<baudrate><parity><bits><flow>

This is strange, because according to kernel documentation, options for
uart should be identical for earlycon and console kernel parameters.
[1] [2].

Thanks
- Markus Probst


[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/tty/serial/serial_core.c?h=3Dv7.1-rc1#n2097

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/admin-guide/kernel-parameters.txt?h=3Dv7.1-rc1#n1451


--=-iiR/tfIbR7HqXJlKJs1S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmn+0JobFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS85kQALF5skHMNhTETz3p9yG8
MlPsT2+KQQ2u5x4Kew/lj20Sj5TWHu/LTmRZPTt9rdmz03cCFC4YHJPx/Fc5jii6
SawLDAf2fts+ZLc37bRb7SHvqzZistCBhapfpEbPdh3IkFmgG6yaaMvHbk22vc5G
/u82q5E9bPpsztlGuuzzqJ8WoH/3VvsJfPan9tH+tL6m4PFxrBR0GX7x7bNqzbCz
zmV0oj/+cB1UauyAZAOpIkF1AaZ8u/QlNCjjXXDHrrqzIpyPAk0JInYoj3KZE+dc
re6KQMy7GI22kZno/Oabc1IRj9M+5hzx/f5QwwP9aVquGOk5UYJ5YGyORmqUF0/9
mGLYVXYepN1HweUDixotakzranwJbnXMWD2sj/QgJ5PNgSgmONKkQUGIkmjKLXnY
jXpsDnw3EVxWhbHgtRkwsJQGQYMMb7hyIxeN5ZST9lot27QH5Rw8O/2ZI3QhPsSy
9ZtRnpl+J5b+MFPNi6fYV0z7VD2EYMMWKPb2ud6NEewYPs6H2C2Np/zaIa323l80
E2U9f9kOq/H0p2gV3BMdlD0QAFfvLXUzsSwqh873zswVNSFI6RcYENQ3LyxRDju2
TG7Q6SjUEVse1emsOjkBIs9HQqJYQKvk5Oa3CewwYfH7AYg/hza/7kO9vxszF6qW
0hcLMegQbWONp4MOf1U3+HZ+
=e1hF
-----END PGP SIGNATURE-----

--=-iiR/tfIbR7HqXJlKJs1S--
