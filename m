From: Karol Babioch <karol@babioch.de>
Subject: Re: no brightness with acpi video since 3.3 [was Re: Issues with
 the sony-platform module]
Date: Sat, 16 Jun 2012 13:24:58 +0200
Message-ID: <4FDC6D0A.8080505@babioch.de>
References: <4FDA2051.3050108@babioch.de> <20120614203914.GA2645@kamineko.org> <4FDAE7FE.5030706@babioch.de> <20120615113637.GA5904@kamineko.org> <4FDB5202.706@babioch.de> <20120615223711.GA31180@kamineko.org> <4FDBC183.7050203@babioch.de> <20120616025223.GA5200@kamineko.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1745A8541A8BEFEBFFD57CDB"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20120616025223.GA5200@kamineko.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: platform-driver-x86@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1745A8541A8BEFEBFFD57CDB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Am 16.06.2012 04:52, schrieb Mattia Dongili:
> This is a known issue (at least to me) but it shouldn't really be a
> problem as it existed for quite some time. Reading the brightness level=

> at boot returns an uninitialized value so the driver displays that
> negative number. After echoing below you should see the actual value yo=
u
> set.
Ok. Just wanted you to see it.

> this looks ok. I'm wondering if the nouveau driver may be getting in th=
e
> way somehow or if I broke backlight support in sony-laptop.
I have no idea.

> Can you try applying the sony-laptop patches on 3.2, boot with
> acpi_backlight=3Dvendor and see what is the state there?
It behaves just like 3.3. What might be interesting is 3.1. Here some
really strange values get returned:

[root@vpcs nv_backlight]# cat actual_brightness brightness max_brightness=

1073864551
1073864551
1025

When setting brightness to something between 0 and 1025, the screen is
basically black. At least there seems to be no backlight.

> there are various (potentially conflicting) ways to control the
> brightness levels, acpi, platform and raw (via the video driver).
Any chance to get this thing sorted, so the right way of control will be
reported to Gnome (or for that matter any other instance in control of
brightness).

I'm currently trying to reconstruct the last version that worked for me.
I'm quite sure that "vaio-full-3.0.4.patch" (from here [1]), worked fine
with the 3.1.x branch. However I've just recompiled 3.1.10 and it
doesn't seem to work. Anyway it worked without the
"acpi_backlight=3Dvendor" parameter, so I'm not quite sure whether this i=
s
of interest for you right now.

Best regards,
Karol Babioch

[1] http://www.absence.it/vaio-acpi/source/patches/?C=3DM;O=3DD


--------------enig1745A8541A8BEFEBFFD57CDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJP3G0NAAoJEHSaZc1HnzIVK1MP/R674i7i71wJTWws8Jj30M0z
0ZTD8bKeP9LQmPXM9Z1zy0W54+48NTQ2KuyWAJQQhDIZlZeHd8ecEZ9j5UfFzpPW
Hfl+/iIfg+7Mfrvf2H77HeTNcraYe7qPfsywcYe5YsVIa33WWo1sHSfd6LwAu/lQ
7MlfEqV6H5XbLy8iCu9pD9RYJpqLCSkyXKQq0CEb/P0i+ySz6gCPkDdiRLOjopAp
99pLaqLlB/+DhReX5QSzXER7NhnfRGys3wLJlG0ZY29j1/jfC68Jz+SF9VIhuvD1
z3vFz18cH4beAFDcMutAQ55sLS1urqMhKX6FvG4tbgkJv+QYbwGR0kUd6kQwJ6OX
WfHFUohQycOYAmHZAZ0WfUqnX/rhgIO7mpFly6MTlkEGFjCGTex/34IMFyzBXyyk
QcpKNbOO/Hkzq55AhPmJtJ/DBYiLxZoexnfJqk5RdQg4ZaF5OXSHPtaRrusaYA1o
jWvTjZB/buQGbX93va71V2GBzwqWsA1WqUPbuvuDUPnU5cqwdv/lED9Tav713EZj
4O/HsjsB4UQfNWLYolyq8jXQIkCiu8Ofbz2YJXcf8svD5Sag59yXq0t1+6Dl0nW0
hejF+kSLHmG0w0OQvv1CUWq99+HEykfPzqwmC8cSKgucrCK/NPb4qP/GGZmbVBFi
xLoKUwTSrnrpmEL7CidT
=Sjfo
-----END PGP SIGNATURE-----

--------------enig1745A8541A8BEFEBFFD57CDB--
