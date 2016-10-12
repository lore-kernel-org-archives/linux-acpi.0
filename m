From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 12 Oct 2016 02:32:04 +0200
Message-ID: <2933991.PYcZctIsx9@vostro.rjw.lan>
References: <20161005092215.GA20248@red-moon> <CAJZ5v0iQtviVprbiY+rvVr1q9STbM9OmwYRG91BS=2wLxA0hAQ@mail.gmail.com> <20161011124429.ptizsviqiwzbmbxc@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3550884.CHGN3c6Y8d"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54946 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1751226AbcJLAZ1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Oct 2016 20:25:27 -0400
In-Reply-To: <20161011124429.ptizsviqiwzbmbxc@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>


--nextPart3550884.CHGN3c6Y8d
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, October 11, 2016 02:44:29 PM Mark Brown wrote:
> On Tue, Oct 11, 2016 at 01:44:46AM +0200, Rafael J. Wysocki wrote:
> > On Thu, Oct 6, 2016 at 11:37 PM, Mark Brown <broonie@kernel.org> wrote:
> 
> > > Personally I don't have that big a concern around per device
> > > properties other than the need to go through yet another round of
> > > churn for them (though it is just mechanical which will make it less
> > > painful).  I do worry when it goes to generic things and inter-device
> > > relationships.
> 
> > Well, that was my first reaction to this series, but then I thought
> > "Let's see what can go wrong with this specifically" and then I
> > couldn't find anything.
> 
> > If you see something like that, please let me know, because I may be
> > overlooking it, but otherwise I would prefer to focus on the technical
> > side of things instead of wast^Hspending time on theoretical worries.
> 
> My primary concern is the addition of what appear to be phandles
> introduced as part of this patch set.  The previous discussion had been
> that we'd enable simple DT bindings which don't need inter-device
> references and that those needed more careful study.  This appears to
> be changing that.

Yes, it does, but why exactly do you think this is wrong?

Is there any specific problem it creates that you can point to?

> > >> And it is not an option for those boards to use DT in the firmware.
> 
> > > There's nothing stopping these systems defining a DSD that contains a
> > > DTB which overrides some or all of the ACPI if the system supports it
> > > (or otherwise providing both system descriptions).  The two can coexist
> > > happily enough as arm64 has shown
> 
> > I'm not sure to what extent it has shown that and even so, it doesn't
> > mean this is a good idea.
> 
> People seem reasonably happy with it so far, YMMV.
> 
> > > and it seems like it ought to save a
> > > whole lot of work especially around the bits that need inter device
> > > links and are hence need some new ACPI bindings defining.
> 
> > There is at least one major problem with this approach.  If the ACPI
> > part needs to point to anything in the DTB or if the DTB part needs to
> > point to the ACPI part outside of it, there's no clean way that could
> > be done.  I actually am not aware of any way whatever, but if there
> > are some, I kind of don't expect them to be pretty.
> 
> The way ARM implements this is that you don't get the DT and ACPI
> simultaneously, they're both present in the firmware and the OS picks
> which one it wants to use at runtime.

So for the boards I'm talking about ACPI is the only realistic choice.

Thanks,
Rafael

--nextPart3550884.CHGN3c6Y8d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCAAGBQJX/YSKAAoJEILEb/54YlRx538P/0FyTksq8d3/ag301AnWvCNN
L3E5X0BvV/0jWgj7VemDsIqpWGgKC2yBhUtJJRWHqww1GVD+dBNmOK+iMq0TL6Ix
eW7wZRoyefQdniZvEFT3VGd72xLV8kfcr8inpbRB9XM2p1krTb6H1dHtUWb/9dHq
th7ME4jLiGYhmXoYqkG8tPd2DN5ODi2TQ4kx2hkWm/wH9WETRxtOsgUHJ2nUCRQa
VDRFn6hGjMQDHY9EGnMqPtYjO/x9i8ub5IzcS5uD1gZXTndk6W5j0d5kvm//7kQ6
JxjeROrng2xn9ipYtI1BxnCgqYPAdNTAx9VUh5jrvv/imOUA8aisZUVIVZpJVfU7
8f0urptMdwZW6ryu2EGOpCaLrjmnw2Zvewal/v6yA1C5avDibWpqiDvUycc5Vme+
FvXIrpkERCG5EjRW8p8oFwXea6yAsJNQAjd0LMUCohzqh3hnt2tE15pUqUjnfbvB
NYsd7HrQj3GWPd8sTNI/9lNcsv6L+1/w+Q2tIdePwMoHdSo/TpylRwQSmxl7Sl5+
ljwX/i7jsL9akKLTZdGIPnY+RfVtGGASGI8fr7sUq/dATJhZ4/GB1bybFF45Hnsn
XSjW6t/t3OkNtb7P7B6zBBbPKr14Tjwpu02Ul3bKqJ5VZAbgu2Nq/do7TOrOwFCX
Ml3JbR9qmZ+5d0wR7zh5
=NBgP
-----END PGP SIGNATURE-----

--nextPart3550884.CHGN3c6Y8d--

