From: Nico Schottelius <nico-linux-acpi@schottelius.org>
Subject: [still there] pdc202xx_new and ACPI
Date: Sat, 10 Jun 2006 23:36:43 +0200
Message-ID: <20060610213643.GB7013@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cable-static-233-101.eblcom.ch ([213.188.233.101]:11424 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1030508AbWFJVgt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Jun 2006 17:36:49 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Developers <linux-acpi@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello dear ACPI-ML!

When I boot with 2.6.16.20, acpi enabled and the Promise pdc202xx_new
installed, the system 'sleeps' / 'freezes' after recognizing
hdi. The message I get is the following:

(damn no serial console, have to copy it by hand....)

---------------------------------------------------------------------------=
-----
irq 10: nobody cared (try booting with the "irpoll" option)
 [<c012c769>] __reportd_bad_irq+0x31/0x77
 ...
 [<c030c607>] start_kernel+0x13e/0x140
handlers:
[<c01fef36>] (ide_intr+0x0/0xca)
Disabling IRQ #10
hdi: lost interrupt
hdi: lost interrupt
hdi: lost interrupt
hdi: lost interrupt
hdi: 234441648 sectors (120034 MB) ...
hdi: lost interrupt
hdi: cache flushes supported
 hdi: dma_timer_expiry: dma status =3D=3D 0x24
PDC202XX: Primary channel reset.
=2E..
---------------------------------------------------------------------------=
-----

This problem is not really new:

In <20041205005946.GA7695@schottelius.org> on Sun, 5 Dec 2004 01:59:46
+0100 I described a problem regarding this controller:

0000:02:01.0 RAID bus controller: Promise Technology, Inc. PDC20270
(FastTrak100 LP/TX2/TX4) (rev 02)

In <1102286168.2308.13.camel@d845pe> Len Brown gave me the hint to
use "acpi=3Dnoirq". This works again.

This time the same controller is installed into a different mainboard,
cpu, ram (so: another computer).=20

I would like to debug it this time to the end, so we can figure out
where the problem is and how to solve it.

Please CC-me on reply.

Nico

--=20
Latest release: ccollect-0.4 (http://linux.schottelius.org/ccollect/)
Open Source nutures open minds and free, creative developers.

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iQIVAwUBRIs7arOTBMvCUbrlAQJs3BAAjqSRv55mu35sQnY1h+v3tGQ1y8XPV78/
219FlIVhthKFbQzc/ywaqXn3HLLJoJ4sOQHH5GjuHsf6VUMTMr7EhGZl0++2CBUj
Q8zPxu2gVLl9h5AbLIdTLRL6x1/fd8S7qvgOc6gFaDoB588TYjC7gzATU5NdOM8k
NwTraXOnyjqqTf9eFhSYZEwqM++VBfzx1TXua7Jz7eKGE6yRbyzgpVHPUUgLFMIf
w5UPVYHeW1ng7p0tEICi+IPz6g1R6BgGA7f+4Qgd+n3LjByZA9cDolp940GgRD5B
TAgA3HknmGZdve73QvStqppFX0tjLOgSC7vcsgk+lUa1v37BnGjl5NpP/ad3j4Id
JUV4USNgOS2bU4+BascBfgv/hs0mEk/wbC1eSmcaAI2tYU4yL33RPmbbmTp5jpa+
4YNL16aDwEjscvhZ0AOAL3D39KwApkmXqErCRf34f9CqFCPJI04QO7NqMzXlDzRg
2vsb5cHkcu/cEo54gYMk0StSWRjQxe7oNhhhnUukRazuQ4w7qZOn+QTv1iwgnQ4+
sd3zsoyVMC+JpAcLRFGGx/++EJ6VN7HrnRandX7+nbigyrIeXS1nY9m6s9RSEyuf
kX6IrwkPRilgpZLSFSC7gyOko/OLF6t/4Csm+fxzczeKdUR7tDbuTTL5w9hmKUyY
UwyfFGinVg0=
=44SF
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
