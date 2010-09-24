From: Kamal Mostafa <kamal@canonical.com>
Subject: Re: [RFC PATCH 0/2] i915 brightness control
Date: Fri, 24 Sep 2010 12:12:55 -0700
Message-ID: <1285355575.4644.24.camel@fourier>
References: <1275516702-27090-1-git-send-email-kamal@canonical.com>
	 <20100913174847.GA10443@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-G1xA08RcVfMtddVgZcZn"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:57961 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699Ab0IXTNZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Sep 2010 15:13:25 -0400
In-Reply-To: <20100913174847.GA10443@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org


--=-G1xA08RcVfMtddVgZcZn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-09-13 at 18:48 +0100, Matthew Garrett wrote:
> I've looked into this issue more closely and think I've worked out the=20
> underlying problem. The system in question appears to have two GPUs and=20
> exposes two ACPI backlight devices. Both of these are associated with=20
> existing PCI devices, so we don't ignore either of them because of that.=20
> Further, one of them (the AMD one) implements the spec properly and=20
> should work. We don't seem to perform a more fine-grained check to=20
> identify whether every ACPI backlight has all the required methods, and=20
> so as a result we provide both the working one and the non-working one.
>=20
> Having thought about this some more, I don't think this is the right=20
> approach. We should be ensuring that every backlight ahs all the=20
> required methods and then dropping the one that doesn't. This should be=20
> replaced with a native i915 backlight, and I sent patches to do that=20
> last week.


I agree.  Your proposed design is good, and I have successfully tested
your proposed patches[1] (after minor porting changes to Ubuntu
Maverick's 2.6.35).  Thanks very much Matthew!

FYI, I have published an experimental Ubuntu Maverick PPA kernel[2]
which includes your patches, plus my dell_laptop tweaks to inhibit the
broken dell_backlight by a module param or dmi blacklist table (in lieu
of a yet to be implemented more fine-grained check).

 -Kamal Mostafa <kamal@canonical.com>


[1] 2010-09-08 [Intel-gfx] [PATCH] i915: Add native backlight control
    2010-09-08 [Intel-gfx] [PATCH] Backlight: Add backlight type

[2] https://launchpad.net/~kamalmostafa/+archive/linux-kamal-mjgbacklight


--=-G1xA08RcVfMtddVgZcZn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABAgAGBQJMnPgeAAoJEOf3EFVUCeQi9ckP/0emPdIL89MYq6Hx5u1MF5r+
aGrRbGzc8rEAf7eD4W/Oxg1dZOS909ZwDzgXAahVQHU3LJ/C16IR3IvkzVSUCc3y
emPVTR3brUliDOnPPOCaiGhimQQglRvwgm85UpEFB06F3RySaV0XWKSA+4uxkTLa
7EqqHVnD+PWbFPL9fvanxxbPdEH9D0Gb3kEStr9j+z0a6VcSwJP5Z1lNsSqCL+pe
BBLl7Q81ub6bSH0DcDiBT3Y15hqdPpDkfehPm6DIuM7+QJDOQbcUu+YWAYE/9e/g
BDJPkTZFkdTTVWttWYwLKuGqDyOQmqHcAcODPwRke2hZ1smRcUnIwo4fqYiGx3R4
ni2MOeRhkH1Brri4rD8ctQV5MjYGxnqxhB/9XfmM2GLTTknDttz8+FoEeHW55a8m
Ieg3KteSuEVQKDzwz4z1awmBGZKWSUuj0rsXob6A8OiZ7AtYdllb6B/58gKHtiQf
3mqAfCo3OAG4TMLl32TcsLTXnPJYQbbW9JZIYN6WCJ2f+UdqJeOAOkZQOrNXtvxq
+P4IR4eCDBkbXaflEYlXDcr0sT8BXUl9uUvQX9CFca8HT3A7rE8IfLXHIE5sQH4+
FnWsjMJfwrPY4ny/QmyyRalRW8k11CFYeJRKZpIJG5jyMk00o9M8LvK/fLHq/VoV
yDQUDpurupAFL8OlKTjA
=3hK9
-----END PGP SIGNATURE-----

--=-G1xA08RcVfMtddVgZcZn--

