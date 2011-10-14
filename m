From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] acpiphp: Prevent deadlock on PCI-to-PCI bridge remove
Date: Fri, 14 Oct 2011 09:07:35 -0700
Message-ID: <20111014090735.44b38707@jbarnes-desktop>
References: <1317253253-28259-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/Do41//+4he7S73NVDB.9hNX"; protocol="application/pgp-signature"
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1317253253-28259-1-git-send-email-prarit@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pci@vger.kernel.org, mjg@redhat.com, bhelgaas@google.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

--Sig_/Do41//+4he7S73NVDB.9hNX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Sep 2011 19:40:53 -0400
Prarit Bhargava <prarit@redhat.com> wrote:

> I originally submitted a patch to workaround this by pushing all Ejection
> Requests and Device Checks onto the kacpi_hotplug queue.
>=20
> http://marc.info/?l=3Dlinux-acpi&m=3D131678270930105&w=3D2
>=20
> The patch is still insufficient in that Bus Checks also need to be added.
>=20
> Rather than add all events, including non-PCI-hotplug events, to the
> hotplug queue, mjg suggested that a better approach would be to modify
> the acpiphp driver so only acpiphp events would be added to the
> kacpi_hotplug queue.
>=20
> It's a longer patch, but at least we maintain the benefit of having separ=
ate
> queues in ACPI.  This, of course, is still only a workaround the problem.
> As Bjorn and mjg pointed out, we have to refactor a lot of this code to do
> the right thing but at this point it is a better to have this code workin=
g.
>=20
> Jesse -- Unless there are any objections from the ACPI guys, I think this
> patch should be pushed through linux-pci now since 95% of the changes are
> contained within drivers/pci/hotplug.

Applied to linux-next, thanks.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/Do41//+4he7S73NVDB.9hNX
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJOmF5HAAoJEIEoDkX4Qk9hUP0QAJQF7K6c7oXvl3ib7u6icYKe
DXOuCxKGu3RtCNBHUvQBtinwo3A5l/dIbgXymnN5EOaSBx7J3LSw/ABj2BMfagpa
qTtM6o50TJTOMihxvfBhGYT4VDs4LB7k2DzOWySXyH6S5VwuCSmcANqRX88x7Kcm
AqAENuCQX7btEkGivsiHcnBQ5Ntt+tR5dpuKK72s+8HR7Y/06Jo+0LfeGBa5h+qu
gwpp62fPtkCC4llZI8VPb1GDi52XifqA0TXdXc6yFVahtYHRQB9pSVaJfattLOC/
fuOsrQ9OfNW6+qhpvWtRTiGuGfuoY5p/QEheyj3J2RcEuRrg8ryr7SelBdcrK3rs
rqAEDu1IOFQLvJoYF65gj2dwxC7NKqbWqTlteFZImN3yAM21Zt2adPdwJdcxIPm0
k52vSqUeIwnSUlYboKG0ShxilF/qGa0WL90eoEYbNcLSnwvgcoUJLf7Yrk0AH6PM
chX7xvwis76bgntKDv9PxImzEusLc/Ngxc4V5x4E5kTJxuiXB9EKUto1OfzebtIC
clIgGf/sMyt2zQThUOElHBCGcjvqta/11hNoyxY2uZeAAv9LBNiRUXE5D7EsRmY6
OU0RSdcETmGMj1+OSyDgeUGs0hT2btcP8D6MuByfTz07Fil0BIiB93GNRRUicxNf
4ZnMvRsxvLC68ukyzWz5
=uGJh
-----END PGP SIGNATURE-----

--Sig_/Do41//+4he7S73NVDB.9hNX--
