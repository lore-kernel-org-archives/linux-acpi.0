From: Andrey Rahmatullin <wrar@altlinux.org>
Subject: Re: [PATCH 2/2] eeepc-laptop: don't enable camera at startup if
 it's already on.
Date: Tue, 20 Oct 2009 15:24:02 +0600
Message-ID: <20091020092402.GI19095@wrars-comp.wrarsdomain>
References: <1255724567-25597-1-git-send-email-corentincj@iksaif.net>
 <1255724567-25597-2-git-send-email-corentincj@iksaif.net>
 <1255724567-25597-3-git-send-email-corentincj@iksaif.net>
 <20091020083555.GG19095@wrars-comp.wrarsdomain>
 <9b2b86520910200204n2089bcf1h2535e56d2ec4156e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E0LdhqWfziiBVv4P"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from k66.ru ([87.224.128.21]:57576 "EHLO k66.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbZJTJYA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Oct 2009 05:24:00 -0400
Content-Disposition: inline
In-Reply-To: <9b2b86520910200204n2089bcf1h2535e56d2ec4156e@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: Corentin Chary <corentincj@iksaif.net>, lenb@kernel.org, linux-acpi@vger.kernel.org, Luca Niccoli <lultimouomo@gmail.com>, Len Brown <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>


--E0LdhqWfziiBVv4P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2009 at 10:04:04AM +0100, Alan Jenkins wrote:
> Yup.  The original patch from Pekka was accepted alongside a patch
> which enabled auto-suspend for the uvcvideo driver by default.  This
> was shown to have the same effect on CPU wakeups as measured by
> powertop.
When the camera is enabled, powertop says "device is active 100% of time".
That was enough for me :)

> Have you measured the power consumption on the current kernel using a
> more comprehensive method than powertop?
No.

> Or perhaps you have a different camera chip?  Have you tried enabling
> auto-suspend manually?  If it works, perhaps that driver can enable
> auto-suspend as well.
/sys/module/usbcore/parameters/autosuspend and
/sys/devices/pci0000:00/0000:00:1d.7/usb5/5-8/power/autosuspend both
contain 1, but powertop still suggests adding usbcore.autosuspend=3D1.
Though nothing related to USB exists in wakeup causes list.

--=20
WBR, wRAR (ALT Linux Team)

--E0LdhqWfziiBVv4P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBCAAGBQJK3YGyAAoJEOih81koZvPBM/MIAIn/clUYqDsUoPx7VF02xxFa
H/YBtAfPiIJ7bb6E2Ljf0cjvNm88VeL92WUcOw6IcqGOL0zSPRaf3SED7wJMtJIj
MPTKKU1JfrKt4tItlGmMKpNTj++jKdb4B3ZhoQsmKi+TxmL8Lh6cJsCjEoubKsXr
WnvuCgYzy3ffEevLijC1grEDDYGqqo6FW+NYuubK1+GkyGl2mWFvs0rGCbM3Myp5
TBO5+zb+4UTyzpLqmFqr6S5ScnnUeC8Ci3+nm/C+Ftqi5cAPNnhrnZgMDXkYVUeD
jIpGqpNeXWIAaq00pNk59hIbxvFIacbPSdnVsrKcJH119kKV/Bu6nlV12GIWduk=
=xH51
-----END PGP SIGNATURE-----

--E0LdhqWfziiBVv4P--
