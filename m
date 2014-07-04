From: "Vadim A. Misbakh-Soloviov" <mva@mva.name>
Subject: [RFC] [HELP] [WMI] Media keys on MSI GE60 (patching msi_wmi for it)
Date: Fri, 04 Jul 2014 15:05:48 +0700
Message-ID: <1578502.VNsf8Sat2f@note>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5817870168037435648=="
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: linux-acpi@vger.kernel.org, driverdev-devel@linuxdriverproject.org
List-Id: linux-acpi@vger.kernel.org


--===============5817870168037435648==
Content-Type: multipart/signed; boundary="nextPart1912611.6QqbcFGFUF"; micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart1912611.6QqbcFGFUF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi there!

I'm trying to modify msi_wmi driver to get it work with mediakeys on my=
 MSI=20
GE60 laptop.

By default, I get "Unknown event received" message.

For now, I diagnosed that event, that every key press produces has 0x03=
 (
ACPI_TYPE_BUFFER?) type, instead of 0x01 (ACPI_TYPE_INTEGER) which in-k=
ernel=20
msi_wmi module wants.

Further diagnostic with that code:

232 =E2=80=BA   } else if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER) {
233 =E2=80=BA   =E2=80=BA   int eventcode =3D obj->integer.value;
234 =E2=80=BA   =E2=80=BA   pr_info("Eventcode: 0x%x\n", eventcode);
235 =E2=80=BA   =E2=80=BA   key =3D sparse_keymap_entry_from_scancode(m=
si_wmi_input_dev,
236 =E2=80=BA   =E2=80=BA   =E2=80=BA   =E2=80=BA   eventcode);
237 =E2=80=BA   =E2=80=BA   if (!key) {
238 =E2=80=BA   =E2=80=BA   =E2=80=BA   pr_info("Unknown key pressed - =
%x\n", eventcode);
239 =E2=80=BA   =E2=80=BA   =E2=80=BA   goto msi_wmi_notify_exit;
240 =E2=80=BA   =E2=80=BA   }
241
242 =E2=80=BA   =E2=80=BA   pr_info("%d\n",key->type);
243 =E2=80=BA   } else
244 =E2=80=BA   =E2=80=BA   pr_info("Unknown event received\n");

(only patched part)
Gives me following info:
Wen I press on any of media-keys =E2=80=94 I get the same eventcode (an=
d every time I=20
get if(!key) error. Moreover, evencode value changes in time (something=
 about=20
4 seconds), so, if I'll press some key many times, eventcode value will=
 be=20
changed after 4s, but it will not change if I press another mediakeys.

Can anybody advice me, why can I experience such behaviour?

And is it a way to get mediakeys working  without patching DSDT (last t=
ime I=20
did that I brake my bluetooth module in that way, that even rfkill was =
unable=20
to enable it :P)?

=2D-=20
Best regsrds,
mva

--nextPart1912611.6QqbcFGFUF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJTtmBcAAoJECZQPTSbOzNL5ysP/1TOj7MdQ27++7joMwKTDz+G
UjAIOTu/FnPtbae/sHBYxoefqg+HBMQ99TtvItcxYagko8nadQarWMp1nRXgcUsh
yZOikE/tjqwXCfH7QKv0zfUcNFSU9D0KEEiycVT+RH3Y4KUcedKSw3rN58kZHUqQ
oi5dSmKm7SQZtCn5/Bev7NKPqb2MeKgKG5JsUKxYtw31n6QulDyOh75BF/DIlyP1
sLihGcwnSpMsq2eI7NTIuH/GpAyu7apG7k+ZMNPnt9USTquvWgcg4gBSrhkiZmab
U99Rp+l2YZNzTaEiwdJ/4Oy8vfhu+FkSsDBByJiRKe1UpPEFF/dRBMVDDTyW0Ms5
LAIowgoOcEim11K65Cy2m4qjfdMBojLOP7UWE4j6A7oxdFSFjBxRRKiavaFX7BtI
22Rgn74qaD/sVl7Nuari5cf7WA61svwYXrqnEcdp9WihJtEm3Kh8QGCn+cs+/b0Y
09hQq5Npnfbwmno7SEqYnjdAtiMtWmkO6tpm+GYd8E4WbTcP4jBTIKqcnC9bA4uK
wE7m0bcKrD9voVwVDOqxjAs+P1LN9+5GUtheWaRRBaOuNDzFxJArIWnqUFSU61H/
lMmu6cCz7oJjlHTyrENmFlHe3pA+8v1inWcLrQgMieWFhbpFh0px/kJtLSl4HMY0
LV1iU3ZiWh/tZIOJ0Koz
=o+yc
-----END PGP SIGNATURE-----

--nextPart1912611.6QqbcFGFUF--


--===============5817870168037435648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============5817870168037435648==--
