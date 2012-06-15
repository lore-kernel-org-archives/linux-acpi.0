From: Karol Babioch <karol@babioch.de>
Subject: Re: no brightness with acpi video since 3.3 [was Re: Issues with
 the sony-platform module]
Date: Fri, 15 Jun 2012 09:45:02 +0200
Message-ID: <4FDAE7FE.5030706@babioch.de>
References: <4FDA2051.3050108@babioch.de> <20120614203914.GA2645@kamineko.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA29280C3B8F4132B89DCD48C"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20120614203914.GA2645@kamineko.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: platform-driver-x86@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA29280C3B8F4132B89DCD48C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

it seems that the first version was blocked due to the attachments,
which were quite big, so I'm resending this without any attachments this
time. You'll find links to the files over on pastebin.mozilla.org.

Am 14.06.2012 22:39, schrieb Mattia Dongili:
> You can boot with acpi_backlight=3Dvendor and get brightness control ba=
ck
> but the issue with acpi_video remains.
Unfortunately that doesn't work either . According to the dmesg output
the key presses itself get registered by the sony_module in both cases.
However when booting with acpi_backlight=3Dvendor I don't get any
brightness control at all, whereas when booting without it the
brightness indicator from Gnome 3 pops up whenever trying to change the
brightness. But in both cases the actual brightness of the screen
doesn't change.

I've attached a complete dmesg output of both cases (dmesg.log and
dmesg_backlight_vendor.log). Alternatively you'll find both files over
on pastebin.mozilla.org, see [1] and [2].

Maybe somewhat suspicious is the following line:
[    0.710585] [Firmware Bug]: ACPI: No _BQC method, cannot determine
initial brightness

It can be found in the dmesg output of both cases. As already said it
had worked in the past. However I'm not entirely sure whether it was 3.2
or 3.3 that broke it. If it's important to know, let me know, and I'll
recompile an old version of the kernel.

> please provide your laptop's DSDT table as well.
I've attached a disassembled version of the DSDT to this mail. However
it is 449 KB in size, so I don't know whether it will get through . In
case something doesn't work out, you'll find the file here [3].

Thanks in advance!

Best regards,
Karol Babioch

[1] http://pastebin.mozilla.org/1662565
[2] http://pastebin.mozilla.org/1662566
[3] http://pastebin.mozilla.org/1662564


--------------enigA29280C3B8F4132B89DCD48C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJP2uf/AAoJEHSaZc1HnzIV/5sQALIeqjWMFqVIvhvyFGpqMCMd
nkdToV7ZBX1BBF8IOLgUrHY8+CibeD2iwzlTG0EqlETyMaiYSPoIvfiOYjWC6tm/
Woj+70BAzg4ifpN/iCuQpxho1O+gu91crXmcIjYlumbJgLuJX2g4Hdc5u9rLqCWV
Q1tHteugHxux7OauD/7f+APiY/RuXlGW+eGK6/6Y1AF7dzgFTWIVDI0iTAm38Eza
rLyvW+6P3m7SA2agXfH6sjE3IUfylN+AzwOMm3fyxV4/YIiP5/BBOzdiOHRKRUYM
yuaa3eOTZfT9OfhscpaVvvP8CJv72jXNgeJUx/fgV0zsV1o9nhLS59LkdxFmAPks
wFewBQVn7CjH+jdpMGaQQWGfvQaY1vYjSqOQ0R5WZdkpk7BC2k3nS7k+QGFT4/d0
KL+8JB9yerjVTlIrSGZTi36IBCd4cPccJSNszR5/i3h4LiTClgAtd8Ozmgc/fbqA
QnCshfzBy2mKr81neFf7r1BgBYgdBckTuk8bCc4Zq2h2IlD3ZvJhDxbwyNT3+7gy
qo0WhlomLmqO4Vl+mKCJeOWhbLeyzXJAy17kuggZ41lFUWZCrgBjmc8xInk68j6M
MOOalOYePZIR9EgrCWLzzuSpW0yM6MYXBQbi//yeGNooUkKd7hlesci/BPdNaC8+
r/ExdF6yCfHZrQP9uH4z
=IdOX
-----END PGP SIGNATURE-----

--------------enigA29280C3B8F4132B89DCD48C--
