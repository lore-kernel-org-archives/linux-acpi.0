From: Keith Packard <keithp@keithp.com>
Subject: Re: [PATCH] i915: Fix opregion notifications
Date: Tue, 12 Jul 2011 15:20:23 -0700
Message-ID: <yunhb6rjg48.fsf@aiko.keithp.com>
References: <1310507496-20116-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from home.keithp.com ([63.227.221.253]:34579 "EHLO keithp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756015Ab1GLWU3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Jul 2011 18:20:29 -0400
In-Reply-To: <1310507496-20116-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org, Matthew Garrett <mjg@redhat.com>

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Jul 2011 17:51:36 -0400, Matthew Garrett <mjg@redhat.com> wrote:

> -		keycode =3D KEY_SWITCHVIDEOMODE;
> +		if (!acpi_notifier_call_chain(device, event, 0))
> +			keycode =3D KEY_SWITCHVIDEOMODE;

Right, acpi_notify_call_chain returns -EINVAL when the underlying
function call returns NOTIFY_BAD.

> -	acpi_notifier_call_chain(device, event, 0);
> +	if (event !=3D ACPI_VIDEO_NOTIFY_SWITCH)
> +		acpi_notifier_call_chain(device, event, 0);

Not ideal to have two calls to this function only one of which will be
used. Could look like

        bool    check_call_chain =3D false;

        ...
        case ACPI_VIDEO_NOTIFY_SWITCH:
                acpi_bus_generate_proc_event(device, event, 0);
                keycode =3D KEY_SWITCHVIDEOMODE;
                check_call_chain =3D true
                break;
        ...

        if (acpi_notifier_call_chain(device, event, 0) < 0)
                if (check_call_chain)
                        keycode =3D 0;

Feel free to just call me for bikeshedding.

> +	if (strcmp(event->device_class, ACPI_VIDEO_CLASS))
> +		return NOTIFY_DONE;

I'm not entirely clear on accepted coding style here, but I'd much
rather this look like:

        if (strcmp(event->device_class, ACPI_VIDEO_CLASS) !=3D 0)

I must have read this four times before I figured out that you weren't
early returning on all "video" devices...
=20=20=20=20=20
> +
> +	if (event->type =3D=3D 0x80 && !(acpi->cevt & 0x1))
> +		ret =3D NOTIFY_BAD;
> +

Seriously? It's some kind of magic non-switch switch event? And you can
tell by checking magic bits within the event?

How can I test this and know if it works?

=2D-=20
keith.packard@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iD8DBQFOHMinQp8BWwlsTdMRAulwAJ940gKRGzeFad1RILwFGTxAKEvU8ACeIA6L
IXpSF4NDb4iFloumT7aXIQo=
=0t8N
-----END PGP SIGNATURE-----
--=-=-=--
