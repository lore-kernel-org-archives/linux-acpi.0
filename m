From: Julius Schulz-Zander <lists@fazzepullis.de>
Subject: ACPI: How to Suspend a PCIe Network Card
Date: Fri, 25 Aug 2006 04:39:32 +0200
Message-ID: <200608250439.44482.lists@fazzepullis.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6709385.5QrSvf7yQx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from a15185716.alturo-server.de ([217.160.128.177]:10509 "EHLO
	fazzepullis.de") by vger.kernel.org with ESMTP id S1751394AbWHYCju
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Aug 2006 22:39:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

--nextPart6709385.5QrSvf7yQx
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

i would like zu suspend my pci-express Atheros Wifi-Card in my MacBook.

All the Kernel-Methods want to get the Device Pointer. But how do i get thi=
s?

These functions are intended for use by individual drivers, and are defined=
 in=20
struct pci_driver:
        int  (*save_state) (struct pci_dev *dev, u32 state);
        int  (*suspend)(struct pci_dev *dev, u32 state);
        int  (*resume) (struct pci_dev *dev);
        int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);

Suspend in general, in every pci driver, has to implement:
pci_disable_device(dev);
and
pci_set_power_state(dev,state);
These are implemented in "/usr/src/linux-2.6.17-gentoo-r4/drivers/pci/pci.c=
".

Hence, suspend in in the madwifi pci driver is using these two funktions in=
=20
the file "/root/madwifi-0.9.2/madwifi-0.9.2/ath/if_ath_pci.c"
ath_pci_suspend(struct pci_dev *pdev, pm_message_t state)
is using
	struct net_device *dev =3D pci_get_drvdata(pdev);
        ath_suspend(dev);
        PCI_SAVE_STATE(pdev, ((struct ath_pci_softc*)dev->priv)->aps_pmstat=
e);
        pci_disable_device(pdev);
        return pci_set_power_state(pdev, PCI_D3hot);


but there is also a acpi-methods like this in the=20
file "/usr/src/linux-2.6.17-gentoo-r4/drivers/pci/pci-acpi.c"
static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
Maybe i can use this one?=20

So now i think that it must be possible, to suspend my Atheros Wifi-Card, w=
hen=20
running "ath_pci_suspend" with the correct device Pointer! Is that correct?
But how do i get this Pointer?

Does anyone has experiences setting the Power-State of PCI Devices?

Greetings,
Julius

=2D-=20
get my public gpg-key: http://julius.fazzepullis.de/key.asc

--nextPart6709385.5QrSvf7yQx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE7mLwyqSoqMnnOn8RAhesAKCJi/Kns+1Nl+KvlJU/WH3EmOqfrgCeOtdy
fmWaWWxBR+WZaAcqK0KB2GM=
=N0w6
-----END PGP SIGNATURE-----

--nextPart6709385.5QrSvf7yQx--
