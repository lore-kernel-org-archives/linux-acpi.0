From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: WHEA Support in Linux
Date: Thu, 28 Feb 2013 21:16:06 -0500
Message-ID: <20130301021606.GA8721@gchen.bj.intel.com>
References: <loom.20130226T053540-195@post.gmane.org>
 <20130227023235.GB29624@gchen.bj.intel.com>
 <loom.20130227T195852-926@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26278 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753509Ab3CACSP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Feb 2013 21:18:15 -0500
Content-Disposition: inline
In-Reply-To: <loom.20130227T195852-926@post.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Manish <manishmj1111@gmail.com>
Cc: linux-acpi@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27, 2013 at 07:00:53PM +0000, Manish wrote:
> Date:	Wed, 27 Feb 2013 19:00:53 +0000 (UTC)
> From: Manish <manishmj1111@gmail.com>
> To: linux-acpi@vger.kernel.org
> Subject: Re: WHEA Support in Linux
> User-Agent: Loom/3.14 (http://gmane.org/)
>=20
>=20
>=20
>=20
> Thanks a lot for your quick response.
>=20
> How can we verify that a particular version of Linux supports WHEA or not?
> In Windows, OSC method returns supported for the Whea Guid. Is it applica=
ble
> also for Linux?

Check drivers/acpi/apei/ghes.c, in function ghes_init:
=2E..
        rc =3D apei_osc_setup();
        if (rc =3D=3D 0 && osc_sb_apei_support_acked)
                pr_info(GHES_PFX "APEI firmware first mode is enabled by AP=
EI bit and WHEA _OSC.\n");
        else if (rc =3D=3D 0 && !osc_sb_apei_support_acked)
                pr_info(GHES_PFX "APEI firmware first mode is enabled by WH=
EA _OSC.\n");
        else if (rc && osc_sb_apei_support_acked)
                pr_info(GHES_PFX "APEI firmware first mode is enabled by AP=
EI bit.\n");
        else
                pr_info(GHES_PFX "Failed to enable APEI firmware first mode=
=2E\n");
=2E..
search above output from dmesg.

> Also, In Windows, Error Injection is verifed using WHEA HCT tool and the =
Errors
> are logged in Windows Event Viewer.
> Is there any such facility/tool available to verify Error Injection (EINJ=
) stack
> in Linux?
modprob einj and use it. Or you can use mce-test to do this:
git://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/mce-test.git

read it and use it by youself.

> Also, Is there any thing similar to Event Viewer of Windows in Linux wher=
e the
> WHEA errors are logged?
>=20
mcelog

> (I'm getting the following message in dmesg log from RHEL:
> "ERST: Could not register with persistent Store"
>=20
> You don't compile pstore support/not loaded it as a module/no NVRAM, UEFI
> runtime space etc. to support pstore.)
>=20
> As far as the above ERST dmesg is concerned, We are allocating a Flash Bl=
ock for
> ERST persistent store.
> The persistent store will be used for Writing/Reading an Error Record by =
the OS
> in case of NMI when fatal error is generated.
Yes.

> In case of fatal error from Windows, it is getting written as well as Read
> correctly from the persistent store and error is avialable in Event Viewe=
r.
Same as in Linux.

> Can you please help us to narrow down this issue or in what could be reas=
on for
> this error in dmesg log.
In simple, pstore doesn't work, so the root cause in pstore. You need to
debug it. Use kernel command parameter pstore.backend=3Derst to try again.
The prerequisite is your platform supports erst.
(Check dmesg to find "Error Record Serialization Table (ERST) support is
initialized.")

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRMA9mAAoJEI01n1+kOSLHSoMQALKwc0C/p6Lxg/V1+4UAACq4
ZssVRrwdS5q73vWQzlc0CcEjLlurevd52ZX0fdfjjaMGzJGyVUCcEok0t0vnkuGB
0wCp18KYuXjM9hKp+/Qxw3qTVHc8w11KVsDbj/3yVMvdT2qyrwDrIRp3BJyWZRa5
B2Mu8GyijS8kEDUUQz50p0N1eWjUHxgiMjeKbJbUW7sHfaXShqvllTxt/JtfuMaq
NXkaOivXrMQjz1kyODbFqZtZxlOLem9t1Xxi/K6PHByddCrK0ATvZYYS84aed+1F
o+cpLVfTNEsP34PEDyuGARzF+5GDvPdLw1mUKcw/HNT+y3gZkTieHHshWGRbM/3c
KIrcCPY8TR+GGwvF7O9LaYzAGopGoEJ+UAoomq6wjJmHb06gHADUL9MlzpCfHfwc
guhDqj8LWaoVnUhFo+GnTsWlARFhXWM1ZLLrDJ/aDx5Zo/yLsXtGgfDrkVbLF7D/
fUFng+NLOUGbimHqZwLGFSXV0/F00mABvLfhkc/UGMsDLsqj0/OHcCnjEO5PzZI3
VbneQ9ZzeAldMb9BeQZruyqyXqFQYyfnAAISPyBi9vfC2StkrmI3iOSePMdDTQDj
OW8JTWa8D1qJn4KIWqGrv29zgSwbAVFoNolsk4TgEa901ZMWEUcotHH2seVApknF
nFNOpi6TRXXeajStX3hf
=Fcbw
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
