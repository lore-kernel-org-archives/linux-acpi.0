From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: what is MCFG area ?
Date: Wed, 07 Jun 2006 14:33:12 +0100
Message-ID: <1149687192.3011.3.camel@localhost.localdomain>
References: <1149637549.3057.4.camel@localhost.portugal>
	 <20060607041525.GA10931@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay2.ptmail.sapo.pt ([212.55.154.22]:51369 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S932067AbWFGNdP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jun 2006 09:33:15 -0400
In-Reply-To: <20060607041525.GA10931@tangens.sinus.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Troller <patrol@sinus.cz>
Cc: linux-acpi@vger.kernel.org

On Wed, 2006-06-07 at 06:15 +0200, Pavel Troller wrote:
> > On my buggy computer i get=20
> > cat dmesg09 | grep  "MM\|MCFG"
> > ACPI: MCFG (v001 A M I  OEMMCFG  0x05000602 MSFT 0x00000097) @ 0x00=
0000003ffb0410
> > PCI: BIOS Bug: MCFG area is not E820-reserved
> > PCI: Not using MMCONFIG.
> > PCI-DMA: Disabling IOMMU.
>=20
> I'm getting exactly the same messages, just the numbers in the MCFG l=
ine are
> different:
> root@arcus:~# dmesg | grep  "MM\|MCFG"
> ACPI: MCFG (v001 A M I  OEMMCFG  0x11000524 MSFT 0x00000097) @ 0x0000=
00003f7d03f0
> PCI: BIOS Bug: MCFG area is not E820-reserved
> PCI: Not using MMCONFIG.
> PCI-DMA: Disabling IOMMU.
>=20
> It's on a MSI motherboard with Intel 945 chipset (MS-7210). The machi=
ne
> otherwise works very well.
>   The "Disabling IOMMU" message I'm getting also on another, Nvidia N=
=464/Opteron
> based board, without this MCFG bug. I think it's unrelated and becaus=
e Linux
> properly detected the BIOS bug and probably fixed it, I think the MCF=
G message
> is harmless.=20
>                With regards, Pavel Troller


yes, IOMMU is a different thing some AGPs have it. But I don't what is
too.

S=C3=A9rgio M. B.=20

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
