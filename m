From: Nico Schottelius <nico-kernel-xuaVFQXs+5hIG4jRRZ66WA@public.gmane.org>
Subject: Re: [nico-kernel-xuaVFQXs+5hIG4jRRZ66WA@public.gmane.org: [BUG] pdc202xx_new and ACPI fails]
Date: Tue, 7 Dec 2004 08:01:43 +0100
Message-ID: <20041207070143.GE2266@schottelius.org>
References: <200412070207.iB727OK6016916@fire-1.osdl.org> <20041205211754.GB7695@schottelius.org> <1102286168.2308.13.camel@d845pe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="maH1Gajj2nflutpK"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200412070207.iB727OK6016916-vHB9QIM/jDtb5UGfqNBoRg@public.gmane.org> <1102286168.2308.13.camel@d845pe>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, bugme-daemon-3NddpPZAyC0@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--maH1Gajj2nflutpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry for breaking References, should I only answer bugme-daemon?
(I never used bugzilla before, sorry)

I tried the patch, but it does not apply:

------------< snip >----------------

eiche# patch --dry-run < ../patch-acpi=20
can't find file to patch at input line 15
Perhaps you should have used the -p or --strip option?
The text leading up to this was:
--------------------------
|http://bugme.osdl.org/show_bug.cgi?id=3D3876
|
|
|
|
|
|------- Additional Comments From shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org  2004-12-06 18:07 --=
-----
|Looks like ACPI is doing the right thing. Per PCI spec, add-in card get=20
|derived IRQ from its parent. In your system, the BIOS tells us IDE 3 get 1=
9=20
|and IDE 5 get 16. I'd like know the dmesg output after apply the below deb=
ug=20
|code. Thanks.
|
|--- drivers/acpi/pci_irq.c.orig      2004-12-07 09:56:36.604609696 +0800
|+++ drivers/acpi/pci_irq.c   2004-12-07 09:58:16.857368960 +0800
--------------------------
File to patch: drivers/acpi/pci_irq.c
patching file drivers/acpi/pci_irq.c
patch: **** malformed patch at line 18: &edge_level, &active_high_low);

------------< snap >----------------

(Perhaps because I am too tired)

Anyway inserting the code into drivers/acpi/pci_irq.c manually at
line 370 works.

Here is the relevant part of dmesg:


------------< snip >----------------

apm: BIOS not found.
PDC20270: IDE controller at PCI slot 0000:02:01.0
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 19 (level, low) -> IRQ 19
PDC20270: chipset revision 2
PDC20270: ROM enabled at 0xdfee0000
PDC20270: 100% native mode on irq 19
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:pio, hdh:pio
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 16 (level, low) -> IRQ 16
    ide4: BM-DMA at 0xa800-0xa807, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0xa808-0xa80f, BIOS settings: hdk:pio, hdl:pio
Probing IDE interface ide2...
Probing IDE interface ide3...
hdh: IDE DVD-ROM 16X, ATAPI CD/DVD-ROM drive
ide3 at 0xc400-0xc407,0xc002 on irq 19
Probing IDE interface ide4...
hdj: TOSHIBA MK4025GAS, ATA DISK drive
Warning: Primary channel requires an 80-pin cable for operation.
hdj reduced to Ultra33 mode.
ide4 at 0xb800-0xb807,0xb402 on irq 16
hdj: max request size: 128KiB
irq 19: nobody cared!
 [<c0130ca4>] __report_bad_irq+0x24/0x80
 [<c0130d81>] note_interrupt+0x61/0xa0
 [<c01307e3>] __do_IRQ+0x113/0x130
 [<c0105119>] do_IRQ+0x19/0x30
 [<c0103916>] common_interrupt+0x1a/0x20
 [<c0101030>] default_idle+0x0/0x30
 [<c0101053>] default_idle+0x23/0x30
 [<c01010ca>] cpu_idle+0x3a/0x60
 [<c03da77f>] start_kernel+0x12f/0x150
 [<c03da3a0>] unknown_bootoption+0x0/0x1a0
handlers:
[<c0294b20>] (ide_intr+0x0/0x170)
Disabling IRQ #19

------------< snap >----------------

> +       if (!irq) {
> +               printk("LSH-TEST:" "PCI interrupt %s[%c]: no GSI",
> +                       pci_name(dev), ('A' + pin));
> +               printk("LSH-TEST:BIOS assign IRQ %d\n", dev->irq);
> +       }

Hrm, this code block you sent me should printout something,
shouldn't it?

I just verified that I booted the correct kernel and foolproofed
tested the output:

eiche# dmesg| grep LSH
eiche#=20

Did I do something wrong?

Have a look at http://schotteli.us/~nico/bug.acpi/dmesg.2.6.10-rc3-LSH-TEST=
-patch
for full dmesg and at=20
http://schotteli.us/~nico/bug.acpi/handpatched-pci_irq.c

for the source file I created with manually patching.

Nico

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--maH1Gajj2nflutpK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQIVAwUBQbVVVbOTBMvCUbrlAQIp+A/9H9tGZSQbYc41g4SBAvVqWpJDfTYUgW8E
tnKWyC8j/Q1tEVH/gBijKqx02mJKtZfzziKAHrJlHnPww0C2mLGMD6sk0i7DTB+P
oDbkbD8BgQyKK4PUL3TTkXw4CiYdFFS0A7iWXa4rC5m81qMnHA6j5hIpIkDxteVL
okT+icElExE/gVlDA1mZcKYdK0RdvMCMB7c8+IJFfvaeKma2d9MD4gdWpS3COjNT
VPrNQAto3vS4L5c8Pja5kGhbEKnP1bB8NzGpH0XzCVj2UYXcIAb8N5FNVOIkoIkL
wJ9RY4HcAgND5YARf3Vjs1EKiVW4q7XfAlQBnkuLfTSL92xhdNR0X95Yt2mMdnBF
dde5K+1Hipljc7rQx2ec7i1kHIC/1erRfVIX20rtEeyvi9p+4oj+Zvb20qVLXPe4
vJ+xpEmu82rbEDu9p7riDmJmBppCWHHyngZVgh6a7Uh6jowv9ZmevVbpVt6TPCcg
xWiThGn2To7k1pQie8SPgURiPe2UCoCCpMNXNK2ajqMdWkngK/H9TgIjqnbKdNCG
wtucPUNaH+l+7v20Qv57a/iw6XmM4YaUoW1cA/APxBBGA6S5PgI8IgyMlt8KgdaB
tc+G2Pmb8cY54vT34XHnWDDIt4tTcgeFyQUDwt3kme34HLPpena6zjfMP7hhp6sw
1wueIZriB4s=
=Wwvs
-----END PGP SIGNATURE-----

--maH1Gajj2nflutpK--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
