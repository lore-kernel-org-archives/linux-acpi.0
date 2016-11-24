From: Ben Skeggs <skeggsb@gmail.com>
Subject: Re: [PATCH] acpi: video: Move ACPI_VIDEO_NOTIFY_* defines to
 acpi/video.h
Date: Thu, 24 Nov 2016 11:30:36 +1000
Message-ID: <e7e4b056-d375-49cc-fcc3-21917b024f9d@gmail.com>
References: <20161109171556.4003-1-hdegoede@redhat.com>
 <4010260.RhimP6FkGx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cNaheDAiX5HIFQUquodQpivsnKve8rqf3"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34123 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935138AbcKXBam (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Nov 2016 20:30:42 -0500
Received: by mail-pf0-f193.google.com with SMTP id y68so1181435pfb.1
        for <linux-acpi@vger.kernel.org>; Wed, 23 Nov 2016 17:30:42 -0800 (PST)
In-Reply-To: <4010260.RhimP6FkGx@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Dave Airlie <airlied@redhat.com>, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cNaheDAiX5HIFQUquodQpivsnKve8rqf3
Content-Type: multipart/mixed; boundary="RqC9ctgKXQCjegg9pL4oRkMvN8hqFEg6t"
From: Ben Skeggs <skeggsb@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
 Dave Airlie <airlied@redhat.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org
Message-ID: <e7e4b056-d375-49cc-fcc3-21917b024f9d@gmail.com>
Subject: Re: [PATCH] acpi: video: Move ACPI_VIDEO_NOTIFY_* defines to
 acpi/video.h
References: <20161109171556.4003-1-hdegoede@redhat.com>
 <4010260.RhimP6FkGx@vostro.rjw.lan>
In-Reply-To: <4010260.RhimP6FkGx@vostro.rjw.lan>

--RqC9ctgKXQCjegg9pL4oRkMvN8hqFEg6t
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/24/2016 11:27 AM, Rafael J. Wysocki wrote:
> On Wednesday, November 09, 2016 06:15:56 PM Hans de Goede wrote:
>> acpi_video.c passed the ACPI_VIDEO_NOTIFY_* defines as type code to
>> acpi_notifier_call_chain(). Move these defines to acpi/video.h so
>> that acpi_notifier listeners can check the type code using these
>> defines.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>=20
> I've applied this one, but I'd like to get an ACK from the DRM folks on=

> the second one.
I've already taken the Nouveau patch through my tree.

Ben.
>=20
> Thanks,
> Rafael
>=20


--RqC9ctgKXQCjegg9pL4oRkMvN8hqFEg6t--

--cNaheDAiX5HIFQUquodQpivsnKve8rqf3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYNkK8AAoJEHYLnGJQkpH7UpUP/RUqdr7r/tv5RkkX4BTLDBv2
Z6sWWaeKpoNhW1zHFlTnu4XsHWnaIHrwHr+eehH3H6MZbnwc3YFP0WPnXpbJ3N9H
OPgw0qMxmSupRxHPsqZCaCABgvgBin/VNjvZhSx98jh2kylkZF/ukaCioGd1u5Iv
PYBLab0e9LCblmDtvIbeMJu5CWRN/PRA9Ttvl0Imm/EjT9lXJbMBqa7i4XZWBbmH
Y+YhjdK0aeAif6L20lYeBSl6fOZy3eo62vVw0YDHtVclHa2bjBxCAZPSaUm69d3n
tfKDOx06MmwYZCJ6IN0WD42atsq4dInNvX5QDCejnRDuKQvVaZfTZTMBYDYDYliz
VlKLdiChzQHanTuFycUFG/52pWOLgXpIEo3+i0/SMcvE3MoRTtVmqOF9jQlexvJU
oADBw6X3oHzA0w5nKN1qHkG/AHu7gDDP1GesiorYR8ZMyuJafxCaF/D6g2HuMWrO
+AJ0pAXHERedxU4cZ4vvH8g3V4jo5fPYi+boIjQiJl/yNRKLAoaC0G8rDLiAmKyG
SW/ZFhBtBkxZLMMqvlPYDQ/NDp4be2x2awvfMP97762/2YU6cTCEV7Yu1LhBq5s6
S84AkIjrOzMgCnHVHg+3KVtK1TQ+fFS1022OXt2rFVx+lKyZC1el++LiwXjQjk0W
Wafb4llvEkAxEgLGl9cd
=udwz
-----END PGP SIGNATURE-----

--cNaheDAiX5HIFQUquodQpivsnKve8rqf3--
