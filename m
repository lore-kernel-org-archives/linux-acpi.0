From: Florian Echtler <floe@butterbrot.org>
Subject: Notifications about ACPI events in userspace?
Date: Fri, 12 May 2017 10:37:47 +0200
Message-ID: <71a48bf5-54b5-6d7b-d574-e0aa6c1acb80@butterbrot.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cd3sXhQ4GpG9Xg8jBtDGKADfTWDfOO2bx"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:40650 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757112AbdELIoi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 May 2017 04:44:38 -0400
Received: from [141.54.178.119] (anna125.medien.uni-weimar.de [141.54.178.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by butterbrot.org (Postfix) with ESMTPSA id C6F204AE02FC
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2017 10:37:48 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cd3sXhQ4GpG9Xg8jBtDGKADfTWDfOO2bx
Content-Type: multipart/mixed; boundary="966tfA6AQjHAIF4fs8ImuGvnai0ucawOo";
 protected-headers="v1"
From: Florian Echtler <floe@butterbrot.org>
To: linux-acpi <linux-acpi@vger.kernel.org>
Message-ID: <71a48bf5-54b5-6d7b-d574-e0aa6c1acb80@butterbrot.org>
Subject: Notifications about ACPI events in userspace?

--966tfA6AQjHAIF4fs8ImuGvnai0ucawOo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I'm currently adding support for the iMac's target display mode (TDM) to =
Linux.
When an external DisplayPort source is added/removed, the following ACPI =
code is
invoked:

    Scope (\_SB.PCI0.LPCB.SMC)
    {
        Device (DPPT)
        {
            Name (_HID, EisaId ("APP000C"))  // _HID: Hardware ID
            Name (_CID, "smc-dppt")  // _CID: Compatible ID
        }
    }

   Scope (\_SB.PCI0.LPCB.EC)
    {
        Method (_Q30, 0, NotSerialized)  // _Qxx: EC Query
        {
            Notify (\_SB.PCI0.LPCB.SMC.DPPT, 0x80) // Status Change
        }

        Method (_Q31, 0, NotSerialized)  // _Qxx: EC Query
        {
            Notify (\_SB.PCI0.LPCB.SMC.DPPT, 0x81) // Information Change
        }
    }


I've already verified that the method calls do indeed take place, by turn=
ing on
EC debugging. The APP000C device does also exist in /sys.

However, I'm not seeing anything happening with either acpi_listen or kac=
pimon.
Does this require any kernel changes, or could I subscribe to these event=
s somehow?

Best, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL


--966tfA6AQjHAIF4fs8ImuGvnai0ucawOo--

--cd3sXhQ4GpG9Xg8jBtDGKADfTWDfOO2bx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkVdFwACgkQ7CzyshGvatjD4wCdHoRhD++Pzly0DKK+gfkP5T54
RJYAoOaUUGEE+R4z2D9V9/20cy1QCkEl
=KMpS
-----END PGP SIGNATURE-----

--cd3sXhQ4GpG9Xg8jBtDGKADfTWDfOO2bx--
