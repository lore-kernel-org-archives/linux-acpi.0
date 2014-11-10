From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 1/1] Mailbox: Add support for Platform Communication
 Channel
Date: Mon, 10 Nov 2014 20:13:10 +0000
Message-ID: <20141110201310.GQ3815@sirena.org.uk>
References: <CAJ5Y-eYbXT4rfkSXKV+jbAp=LHSZf-CHPyLuPjVdKULixO4PZA@mail.gmail.com>
 <CAJe_ZhcMvQyxZTyD+My23-Bi5pbfybCUhxN6PF3KBt8RtAS2iA@mail.gmail.com>
 <CAJ5Y-eZq7+LsnQSyiJq+rK5ib7uqsJuyx8pJaRXn91ei2aObVA@mail.gmail.com>
 <CAJe_ZhcSTvY=eYx67z=HxQ=VfSYzeKhA3+yhGwvccb208R7UFQ@mail.gmail.com>
 <CAJ5Y-eaXOq0qYYxGvZafFEoYWpuq7b1xh3jMdCQBkYnpqBgFAw@mail.gmail.com>
 <CAJe_Zhd1q=3r6So7XRYuAi9NSQvabpiuLqPiLpReoiFzUjX9QA@mail.gmail.com>
 <CAJ5Y-eZa4zukM4ai3n7Ei86PLaaCoF_w4PqFzAdrojg_rOGdig@mail.gmail.com>
 <CAJe_Zhd5DO=5DoQDOJySTseXG97mCYQZvb=yOR5boPBQ5fLR2w@mail.gmail.com>
 <CAJ5Y-eZhU3wX1bc8NA1ocFj92N=gAvrMOFjcunqPUskLEOOTTA@mail.gmail.com>
 <CAJe_Zhen65HwdyBPcBCjX7uD9BGBesHbQJeHdRmz3Bw2DdB5sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A+JrWpA8iZwaHvaR"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:57991 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbaKJUOe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Nov 2014 15:14:34 -0500
Content-Disposition: inline
In-Reply-To: <CAJe_Zhen65HwdyBPcBCjX7uD9BGBesHbQJeHdRmz3Bw2DdB5sw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, "lv.zheng" <lv.zheng@intel.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>


--A+JrWpA8iZwaHvaR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 10, 2014 at 11:14:48PM +0530, Jassi Brar wrote:
> On 10 November 2014 20:17, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> > On 10 November 2014 09:16, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> >> On 10 November 2014 19:23, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:

Folks, please delete unneeded context from mails - it can be quite
tedious to find the new content otherwise.

> > What is there to stop two users from coming up with the same signature
> > (0xdeadbeef / "string") for their mbox controllers? Things can break
> > at run time, because with your patch, the first mbox controller with
> > the duplicate signature/name will return a channel. The client may be
> > expecting a channel from the "other" mbox.

> Two channels with same signature are supposed to be _identical_ i.e,
> either channel could serve any client asking for a channel with that
> signature. So even if an "unexpected" instance of the channel is
> assigned, the client should still be happy.

> If a client differentiates between 2 instances of a channel, that's
> probably a sign of bad design. The knowledge behind client's
> preference of instance should actually lie on the provider(controller)
> side. I am open to some example on the contrary.

The problem here is that ACPI isn't defining the context in a way which
maps well onto the way Linux looks things up.  We may not like that and
think it's a bad design but the spec is a done deal here and we have to
address reality.  From an ACPI point of view the context is the fact
that this is a PCC channel (there's a globally unique namespace for PCC
channels) but Linux wants a struct device for the client to represent
the context with a mapping table of some kind behind that to do the
lookup.

There's nothing in the ACPI description of the channel or controller to
tie it to the client device, and there's nothing preventing some other
mailbox mechanism that gets added to an ACPI system from reusing similar
names (bear in mind that idiomatic naming for ACPI appears to be three
or four character strings).  If we have a PCC channel "FOO" and some new
mailbox type which also defines "FOO" the controllers aren't really
going to be able to tell them apart just on the string.

We could fit the maping into Linux a bit by having a struct device
representing the PCC controller that you use to do the lookup but at
that point you may as well have a PCC specific request function that
knows that device and does the lookup which is approximately what we
have in Ashwin's patch.  We could also require that the lookup be
something like "PCC:FOO" and use a global_xlate() but it's not clear to
me that this is making things clearer.

--A+JrWpA8iZwaHvaR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYRxVAAoJECTWi3JdVIfQA/wH/24N0GXxhxH26xvAxeUmFqM4
41RTAFcdGdzKW/TaO898A5ZblZuTBl4lf5UhKYEWftGjA9JvhWmwGjRzJkHBrtDR
PvSYCreUJCAIqfQk7s3s5xRBmrs0OVjdvKwrffkOoXBhH1ijK3EZkKRIDYJELR2m
vXCEWSVT0rmrfvtn7zO0iOgl7pwOgz3t7sJ4UFjeCW/y37iMl+WuT7SZgQGHGDwU
76nSmxvssIwDwmwEipm8GQLDw6mo/T53gXL9PfBTWt5/BRb7MIJc1DfKT6cMb8Po
7gPemUx2RKlB9vOBsWKv9UZ/yMvfUH6x6uO1zS+USXBG3qC0MkHutVJvriFuFyY=
=r+RE
-----END PGP SIGNATURE-----

--A+JrWpA8iZwaHvaR--
