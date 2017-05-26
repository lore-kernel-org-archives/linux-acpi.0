From: Florian Echtler <floe@butterbrot.org>
Subject: iMac 10,1 with Ubuntu 16.04: black screen after suspend
Date: Fri, 26 May 2017 14:13:29 +0200
Message-ID: <30380cb3-0f26-8aea-2689-d4886879129c@butterbrot.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rq41emNfklMLM0hmxr0TSKnOIi3MIuAT0"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:38472 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422818AbdEZMNm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 May 2017 08:13:42 -0400
Received: from [192.168.188.25] (unknown [95.91.181.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by butterbrot.org (Postfix) with ESMTPSA id 4FD5B4AE02CC
        for <linux-acpi@vger.kernel.org>; Fri, 26 May 2017 14:13:34 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rq41emNfklMLM0hmxr0TSKnOIi3MIuAT0
Content-Type: multipart/mixed; boundary="HSL6Pp4hTLAceBBROuPiB2GB8XdG0fPVG";
 protected-headers="v1"
From: Florian Echtler <floe@butterbrot.org>
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Message-ID: <30380cb3-0f26-8aea-2689-d4886879129c@butterbrot.org>
Subject: iMac 10,1 with Ubuntu 16.04: black screen after suspend

--HSL6Pp4hTLAceBBROuPiB2GB8XdG0fPVG
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I'm running Ubuntu 16.04.2 on a 27" unibody iMac 10,1 from 2009. However,=
 even
with the most recent HWE stack (kernel 4.8), the display stays black afte=
r
suspend. I can ssh into the machine, so wakeup is OK, but the display is
entirely black (backlight stays off).

Note: this appears to be entirely unrelated to the TDM stuff I posted abo=
ut
earlier. Interestingly, when I enable TDM, even after suspend, the displa=
y works
while TDM is active. Once I disable TDM, it's back to black (unintentiona=
l song
reference there).

I've noted that in /sys/class/backlight, there are two different control
interfaces, apple_backlight and radeon_bl0. Before suspend, I can control=
 the
screen brightness from system settings, even if only one of them is loade=
d, so
both brightness interfaces work.

What I've already tried without success:

- Blindly switching to the console and back.
- Calling DISPLAY=3D:0.0 xrandr --output eDP1 --auto via ssh.
- Restarting X via ssh.
- Blacklist apple_bl on the kernel cmdline (modprobe.blacklist=3Dapple_bl=
).
- Disabling the radeon backlight on the kernel cmdline (radeon.backlight=3D=
0).
- Using radeontool to turn the backlight back on after suspend.
- Directly using the interface in /sys/class/backlight/ to turn it back o=
n.

I'm starting to run out of ideas... any hints?

Regards, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL


--HSL6Pp4hTLAceBBROuPiB2GB8XdG0fPVG--

--rq41emNfklMLM0hmxr0TSKnOIi3MIuAT0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkoG+kACgkQ7CzyshGvatisvQCg9Q2fMlNlm2+V58aBcDT/isTD
I5MAn0Qr6RNv0CQmKjvixdaAnOFnXL+w
=9hw8
-----END PGP SIGNATURE-----

--rq41emNfklMLM0hmxr0TSKnOIi3MIuAT0--
