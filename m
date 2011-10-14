From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] PCI / PM: Extend PME polling to all PCI devices
Date: Fri, 14 Oct 2011 09:08:10 -0700
Message-ID: <20111014090810.7d34906a@jbarnes-desktop>
References: <201110032316.33786.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/K_gsFGF1fqbFWQmNvdaEaHM"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201110032316.33786.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

--Sig_/K_gsFGF1fqbFWQmNvdaEaHM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Oct 2011 23:16:33 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> The land of PCI power management is a land of sorrow and ugliness,
> especially in the area of signaling events by devices.  There are
> devices that set their PME Status bits, but don't really bother
> to send a PME message or assert PME#.  There are hardware vendors
> who don't connect PME# lines to the system core logic (they know
> who they are).  There are PCI Express Root Ports that don't bother
> to trigger interrupts when they receive PME messages from the devices
> below.  There are ACPI BIOSes that forget to provide _PRW methods for
> devices capable of signaling wakeup.  Finally, there are BIOSes that
> do provide _PRW methods for such devices, but then don't bother to
> call Notify() for those devices from the corresponding _Lxx/_Exx
> GPE-handling methods.  In all of these cases the kernel doesn't have
> a chance to receive a proper notification that it should wake up a
> device, so devices stay in low-power states forever.  Worse yet, in
> some cases they continuously send PME Messages that are silently
> ignored, because the kernel simply doesn't know that it should clear
> the device's PME Status bit.
>=20
> This problem was first observed for "parallel" (non-Express) PCI
> devices on add-on cards and Matthew Garrett addressed it by adding
> code that polls PME Status bits of such devices, if they are enabled
> to signal PME, to the kernel.  Recently, however, it has turned out
> that PCI Express devices are also affected by this issue and that it
> is not limited to add-on devices, so it seems necessary to extend
> the PME polling to all PCI devices, including PCI Express and planar
> ones.  Still, it would be wasteful to poll the PME Status bits of
> devices that are known to receive proper PME notifications, so make
> the kernel (1) poll the PME Status bits of all PCI and PCIe devices
> enabled to signal PME and (2) disable the PME Status polling for
> devices for which correct PME notifications are received.
>=20
> Tested-by: Sarah Sharp <sarah.a.sharp@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---

Applied to linux-next, thanks.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/K_gsFGF1fqbFWQmNvdaEaHM
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJOmF5qAAoJEIEoDkX4Qk9hVowQALJN9VFseqKrP5tvWJx/ie5N
PG3AO3W6uo7axFF6xJ5s/4hfPIryfZFsX/04fq3/8DOybJX+A8rXX9o6ws002nyF
35SkCbwTwhKVqB2gNh/hmo4brcYD4uED/W3Ft0qQF7N00bpCpVRv8b4o2RJiVCqN
QeGuzkT9aQHtvFBbJseR+9ie5ulVg1uBUZl2757VRaZjVQOoVQdzLjD//WTc3F4c
NzavnchUv+YiizHAhNFA7wpi/QwzTTfb1O7ppPCC1AjiFtalyPRrwjoylDQ+dt2H
R2gX7JU1TX5csOba37K+FP8HF2YRqJ9S0+xz7IVUqiAeCZLBM1INsRplvacbIE4I
JtnXkvm5NXfjOdmRY0m5W8S7UJ9X7U/FQTnyMdvRgUyeJENZBuQkqZ7NAuSr9e5v
HGHTckJXdUQumjBRVBfE96Sd4C3FkeBYy+V6Pef4HeUcwenv6Bo70TfRIkTIHOjB
LM6Rh75qt8TaE/tJR5boh3QFAgl0Rt0Wu8NDO1ZRUnVbOiuLDvDLU8y59IbiViwH
lXpDurlhcEkK7UWi/d9pHtyR8bEJHTIYusRS31YUNlSIX9+OopC6D9jboEDiE9Vo
J697ZI+eS1xUt6xC1GOOhxLuViJTM4hvkPt16fuWFiJvVBHMYhY3E+x6fenm3Qds
HOgfiKOjndlLMDNCe+O5
=ESmF
-----END PGP SIGNATURE-----

--Sig_/K_gsFGF1fqbFWQmNvdaEaHM--
