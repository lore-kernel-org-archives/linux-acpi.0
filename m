From: Norbert Preining <preining@logic.at>
Subject: Re: [ACPI] Call for help: list of machines with working S3
Date: Tue, 15 Feb 2005 13:55:55 +0100
Message-ID: <20050215125555.GD16394@gamma.logic.tuwien.ac.at>
References: <20050214211105.GA12808@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-Disposition: inline
In-Reply-To: <20050214211105.GA12808@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>, kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

On Mon, 14 Feb 2005, Pavel Machek wrote:
> (1) systems where video state is preserved over S3.
>=20
> (2) systems where it is possible to call video bios during S3
>   resume. Unfortunately, it is not correct to call video BIOS at that
>   point, but it happens to work on some machines. Use
>   acpi_sleep=3Ds3_bios.
>=20
> (3) systems that initialize video card into vga text mode and where B=
IOS
>   works well enough to be able to set video mode. Use
>   acpi_sleep=3Ds3_mode on these.
>=20
> (4) on some systems s3_bios kicks video into text mode, and
>   acpi_sleep=3Ds3_bios,s3_mode is needed.
>=20
> (5) radeon systems, where X can soft-boot your video card. You'll nee=
d
>   patched X, and plain text console (no vesafb or radeonfb), see
>   http://www.doesi.gmxhome.de/linux/tm800s3/s3.html.
>=20
> (6) other radeon systems, where vbetool is enough to bring system bac=
k
>   to life. Do vbetool vbestate save > /tmp/delme; echo 3 > /proc/acpi=
/sleep;
>   vbetool post; vbetool vbestate restore < /tmp/delme; setfont
>   <whatever>, and your video should work.
>=20
> Acer TM 800			vga=3Dnormal, X patches, see webpage (5)


Acer TM 650 (Radeon M7)

vga=3Dnormal plus boot-radeon (webpage(5)) works to get text console
back. But switching to X freezes the computer completely.

X from debian sid.=20
XFree86 Version 4.3.0.1 (Debian 4.3.0.dfsg.1-10 20041215174925 fabbione=
@fabbione.net)
Release Date: 15 August 2003
X Protocol Version 11, Revision 0, Release 6.6
Build Operating System: Linux 2.4.26 i686 [ELF]=20
Build Date: 15 December 2004


I would like to get X running to, but there are no traces in the logfil=
e
whatsoever to be seen. Pity.

So it seems that my laptop does not fall in any of these categories.

Best wishes

Norbert

-----------------------------------------------------------------------=
--------
Norbert Preining <preining AT logic DOT at>                 Universit=E0=
 di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 5996=
6-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 0=
9C5 B094
-----------------------------------------------------------------------=
--------
PELUTHO (n.) A South American ball game. The balls are whacked against
a brick wall with a stout wooden bat until the prisoner confesses.
			--- Douglas Adams, The Meaning of Liff
