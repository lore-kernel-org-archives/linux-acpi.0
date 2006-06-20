From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [Fwd: Re: [Linux-usb-users] Fwd: Re:
	2.6.17-rc6-mm2 - USB issues]
Date: Tue, 20 Jun 2006 17:59:38 +0400
Message-ID: <20060620135938.GS3206@master.mivlgu.local>
References: <44953B4B.9040108@agotnes.com> <4497DA3F.80302@agotnes.com>
	<20060620120937.GR3206@master.mivlgu.local>
	<1150810206.7194.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0841291066=="
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1150810206.7194.33.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: Andrew Morton <akpm@osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>, Chris Wedgwood <cw@f00f.org>, kernel list <linux-kernel@vger.kernel.org>, linux-usb-users@lists.sourceforge.net, linux-acpi@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Johny <kernel@agotnes.com>
List-Id: linux-acpi@vger.kernel.org


--===============0841291066==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3sseE1tnmEs+TkKq"
Content-Disposition: inline


--3sseE1tnmEs+TkKq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2006 at 02:30:06PM +0100, Sergio Monteiro Basto wrote:
> someone has it has a case similar and said that won't work without
> acpi=3Dnoirq
>=20
> http://bugzilla.kernel.org/show_bug.cgi?id=3D6654

Yes, acpi=3Dnoirq will work around this bug in many cases, because Linux
will not try to reassign IRQs set up by BIOS.

BTW, the problem may be considered as an ACPI BIOS bug, because
reconfiguring a PCI Interrupt Link should set up IRQ routing, but it
obviously does not.  Unfortunately, this problem seems to be widespread,
so a workaround in kernel is needed.

--3sseE1tnmEs+TkKq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEl/9KW82GfkQfsqIRAmD3AJ4sokTGVa1Jg0XoPrz7ZuUFzLh4TgCfde79
hF9ih77uaAMgGPCHj+8nd/o=
=FerS
-----END PGP SIGNATURE-----

--3sseE1tnmEs+TkKq--


--===============0841291066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0841291066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

--===============0841291066==--
