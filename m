From: Valdis.Kletnieks@vt.edu
Subject: Re: linux-next 20160512 - ACPI issue with screen brightness
Date: Fri, 20 May 2016 03:02:08 -0400
Message-ID: <2897.1463727728@turing-police.cc.vt.edu>
References: <4736.1463510462@turing-police.cc.vt.edu> <CAJZ5v0jrFoQxLY_ZQrP-HP888swZbvSJPM=xNopC5MgQgnSxNg@mail.gmail.com> <6459.1463698397@turing-police.cc.vt.edu> <7208.1463713500@turing-police.cc.vt.edu>
 <6674547c-cefb-1b93-893a-7c5909a180a7@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1463727728_2055P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6674547c-cefb-1b93-893a-7c5909a180a7@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

--==_Exmh_1463727728_2055P
Content-Type: text/plain; charset=us-ascii

On Fri, 20 May 2016 13:45:30 +0800, Aaron Lu said:
> On 05/20/2016 11:05 AM, Valdis.Kletnieks@vt.edu wrote:
> > On Thu, 19 May 2016 18:53:17 -0400, Valdis.Kletnieks@vt.edu said:
> >
> >>>> next-20160512 sets the screen brightness to about 40%-ish or so, rather
> >>>> than the 100% intensity I want.
>
> Do you mean after boot, the screen brightness is now 40% instead of the
> previous 100%? Are you using a GUI?

Nope, even the very first line of output from initramfs is dim, and if I then
reboot and go into the BIOS settings, the screen intensity is at 40%. While
it's rebooting, the Dell bios splash will start off bright and then suddenly
dim down.

With the patches reverted:

[/sys/class/backlight/acpi_video0] grep . *bright*
actual_brightness:95
brightness:95
max_brightness:95

And the weird part inside the kernel - on a kernel that has the problem,
/sys/class/backlight is *empty* - only '.' and '..' entries.

No, I don't understand why the acpi_video0 entry isn't created when that
commit is in place.



--==_Exmh_1463727728_2055P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBVz62cAdmEQWDXROgAQJ+zg/+J0K0GG4Ke6RZwUPYEMtNQwjhd17tk98j
xWNwDEec9LanYpPOL3Cxgw0NnrfONFv6XGLoOSQL2V9Z/ZoKnGv7gcfyoesaChOT
FyyzqUIQfPYeSQqB5jVkZM9Rn//g4TL/aL8Eej/CgTlZfOgEK2HO9ni3dXeMGhYZ
CK37Xcf/Sz71sKcCTLIq788FKZXw49ahvWKOBPilSanUN3Yv6LgVkWujYEQnDaov
FsWHL16lZd4f/dNv9PAiH8A7IcKChQS1PuRaRwjwgbEoeZg/DqOGX4z0+BDkMBMR
EgK7yESwwa3oHujrPMZYy7zm+TtivRsbEB+XdN2UIyFekv8HcQdAm0Hv/kDdWTRV
5LQqvRnWMTvm28RJuzYaO1on+vpIGuwErsV9YHc56TFK1UArDym8h+QwfF/OkPdJ
JV4hYD5MdggfZVxy3k24nUjwgBXjuJ/fmdCc/u4O5quYU4YDDvrO4l25/uiRKeFm
cTLka5dBsGtblSd/tSVgG4gsReL451dFDGI2MFHLc3Lm2MhyMQ0V0HgOpxFrP09O
jdq4aRjx0UHjwuQs0DT8zWKee5qDqSGvf/pptmTWArd9Gy3vWfzNu6HDFPHw92dh
zQwH17oWkryeHeWMvzoFbNxwhxLmXFSScoJ7HoKQhn9jrVFBHXf2qQHFxH13oi2G
AYiMHE/jVDs=
=0Ut+
-----END PGP SIGNATURE-----

--==_Exmh_1463727728_2055P--
