From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Re: Call for help: list of machines with working S3
Date: Sun, 20 Feb 2005 10:21:04 +0100
Message-ID: <87ekfbvb7j.fsf@gismo.pca.it>
References: <20050214211105.GA12808@elf.ucw.cz>
	<200502151742.55362.s0348365@sms.ed.ac.uk>
	<1108563926.4986.3.camel@localhost.localdomain>
	<200502182049.11088.s0348365@sms.ed.ac.uk>
Reply-To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
In-Reply-To: <200502182049.11088.s0348365-Y3tGgqFSo3OFxr2TtlUqVg@public.gmane.org> (Alistair John
 Strachan's message of "Fri, 18 Feb 2005 20:49:11 +0000")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alistair John Strachan <s0348365-Y3tGgqFSo3OFxr2TtlUqVg@public.gmane.org>
Cc: Kjartan Maraas <kmaraas-gyXR7Lt7FVk/G1V5fR+Y7Q@public.gmane.org>, Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, seife-l3A5Bk7waGM@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

Hello!

On Fri 18 Feb 2005 21:49, Alistair John Strachan wrote:
> I discovered that either the i2c_core.ko or i2c_i801.ko modules cause the=
 hang=20
> on resume! If you stop the entire i2c subsystem from being loaded by hotp=
lug=20
> (note this is the BUS driver, not the sensors driver!), then resume works=
=20
> perfectly! Presumably there's a bug in the resuming of this module.

Well, on my IBM ThinkPad T42p (ATI FireGL T2 128MB), I can resume with
both I2C modules loaded, so probably the problem is not specific to
the I2C subsystem.

> In other news, USB devices only work after I remove uhci_hcd and ehci_hcd=
 and=20
> reload them.

I just tested two USB devices after S3 resuming without having removed
the USB modules (uhci-hcb and ehci-hcd):

=2D Logitech USB Wheel Mouse (046d:c00c, USB 1.x), it works with no
  problem on console, but not on X (this was caused by the fact that
  I've two corepointer on my XF86Config-4, in fact after having
  corrected this error and restarted X, the USB mouse works)

=2D Mitsubishi Chemical 2.5" HD Case (05e3:0702, USB 2.0 [1], with a
  SAMSUNG MP0804H 80GB), it works with no problem :-D

> The s3_bios workaround allows video to kind of work, but I can't use anyt=
hing=20
> other than vga=3Dnormal (vesafb results in corruption), and the screen is=
 no=20
> longer artificially resized to fill the LCD, it's native res and centered=
=20
> (which sure is annoying).

Again, IMHO the problem is specific to your machine: I use the
radeonfb (with acpi_sleep=3Ds3_bios) and the resume is ok (both in
console and Debian XFree86-4.3.0.dfsg.1-11, radeon driver).

Thx, bye,
Gismo / Luca

[1] http://www.qbik.ch/usb/devices/showdescr.php?id=3D3039

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCGFaLVAp7Xm10JmkRAmCvAJ96dE6QMZ7wfu93rsPet+4ocBZkngCfaFSy
ef9c6EATNoT+/ceN3Q8F1bg=
=WCCz
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
