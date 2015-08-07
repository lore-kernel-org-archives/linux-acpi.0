From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 09/10] PCI: ACPI: Bind GIC MSI frame to PCI host bridge
Date: Fri, 7 Aug 2015 11:48:03 +0100
Message-ID: <20150807104803.GO20873@sirena.org.uk>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
 <1438164539-29256-10-git-send-email-hanjun.guo@linaro.org>
 <55C4826C.80600@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sRqvTRKLZJ0/FE92"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60910 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbbHGKsl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Aug 2015 06:48:41 -0400
Content-Disposition: inline
In-Reply-To: <55C4826C.80600@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Timur Tabi <timur@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Wei Huang <wei@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org


--sRqvTRKLZJ0/FE92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2015 at 12:03:24PM +0200, Tomasz Nowicki wrote:

> >@@ -670,6 +671,8 @@ static struct irq_domain *pci_host_bridge_msi_domain=
(struct pci_bus *bus)
> >  	 * should be called from here.
> >  	 */
> >  	d =3D pci_host_bridge_of_msi_domain(bus);
> >+	if (!d)
> >+		d =3D pci_host_bridge_acpi_msi_domain(bus);
>=20
> Please use acpi_disabled here.

> BTW. This is another place where we need to know our firmware - DT vs ACP=
I.
> I know we can use acpi_disabled but I think more about generic solution.
> Since we already have:
> struct fwnode_handle	*fwnode;
> we can create macro which identify h/w description style, something like:

> #define FWNODE_TYPE(dev)	dev_fwnode(dev)->type

> and then:

> switch (FWNODE_TYPE(&bus->dev)) {
> case FWNODE_OF:
> ...
> case FWNODE_ACPI:
> ...
> case FWNODE_XXX:
> ...
> }

> Root bus is special case since it has no frimware type but we could factor
> out pci_set_bus_of_node(). For platform devices we have all we need. Just
> thinking aloud, let me know your thoughts.

Not knowing the particular detail here but can we not go a step further
than that and have a fwnode_disabled() for this which does appropriate
things for both ACPI and DT?

--sRqvTRKLZJ0/FE92
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVxIziAAoJECTWi3JdVIfQmZkH/346wicR7qkYGoyPobyUt45E
g1iiykfq6uAz3G6IqPXMPhXkcYVagHZeeEJXMAPWNgBJUIpLfWJ6N33v1YK9kCx5
s8sovhVXw6N+Pdpj1J2y1XrcX4BUfTZvBmKNsgDPIaB1UwLOFJ/hWn4LraDuclXb
wOv6aWN6+6utLzb83n7M5/gsAE1FWvoQwxNLZnRR5KLadtotz5Gjk36RdxhmpCex
eWpqXecxe/GxAfen40D6EkuPQobqcjX1ZOvnzLFPE9d8dHgSSMsHNtuj6ob6TgnV
fNCbzamNqDhc8wcO+POzJiNCBKitgdY8esR+/cM0ZII3O/4ZRz2Y2EA0DUFQ/vg=
=+CUD
-----END PGP SIGNATURE-----

--sRqvTRKLZJ0/FE92--
