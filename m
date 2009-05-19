From: Mario Limonciello <mario_limonciello-8PEkshWhKlo@public.gmane.org>
Subject: Re: [PATCH] Explicitly disable BT radio using rfkill interface on
 suspend
Date: Tue, 19 May 2009 17:19:58 -0500
Message-ID: <4A13308E.4040703@dell.com>
References: <4A11C126.1000704@dell.com> <200905192326.46274.oliver@neukum.org> <4A1328D6.5090404@dell.com> <200905200016.49110.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig948EC0435FDE58DFE4091A13"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200905200016.49110.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig948EC0435FDE58DFE4091A13
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Oliver:

Oliver Neukum wrote:
> Am Dienstag, 19. Mai 2009 23:47:02 schrieb Mario Limonciello:
>  =20
>
> That is correct the devices have been successfully resumed and thus are=

> present. Generally the idea of suspened/resume is to have the same syst=
em
> after resumption. It is correct to not generate events. Usbcore cannot =
know
> that you use udev to switch the device from pure HID to HID + bluetooth=
=2E
>
>  =20
Right, which makes sense.
>
> Yes, the question is whether it is the clean thing to do.
>
> Marcel, are the HID devices usable after hid2hci has run? Should we
> choose to not resume from power loss any hid device which hid2hci
> operated on?
>
> 	Regards
> 		Oliver
>
>  =20
I can actually field this answer.  Currently those HID devices have no
purpose after hid2hci has operated on them.  If transitioned back into
full HID mode, then the mouse and keyboard HID devices can be functional.=


Regards

--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello-8PEkshWhKlo@public.gmane.org


--------------enig948EC0435FDE58DFE4091A13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoTMI4ACgkQ2CrZjkA73YuWnQCcDCG2bbVA1oZ9OrcOMPcmKQyd
gb4AoIiFinZdgpdW5+cw9jevG9Bf0ASQ
=wB0I
-----END PGP SIGNATURE-----

--------------enig948EC0435FDE58DFE4091A13--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
