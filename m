From: Florian Echtler <floe@butterbrot.org>
Subject: Re: iMac 10,1 with Ubuntu 16.04: black screen after suspend
Date: Fri, 2 Jun 2017 18:47:07 +0200
Message-ID: <c1ed89a5-e6a1-1903-05ee-a9dfcdb2ef61@butterbrot.org>
References: <30380cb3-0f26-8aea-2689-d4886879129c@butterbrot.org>
 <20170526210340.GA5114@wunner.de>
 <1e60811b-a8ac-017c-d350-8a40e4323870@butterbrot.org>
 <20170530105404.GA29865@wunner.de>
 <64a4829c-3141-6ff6-9369-6ca9ed0facf4@butterbrot.org>
 <20170531092145.ytc2d6shpukxziie@wunner.de>
 <CADnq5_MGWOX47tcvkfjHRxRv_eTbo_kvpVKyTpo8WGNw+xBvPA@mail.gmail.com>
 <65c88b03-45d7-d67b-2a2c-6c7047a73c80@butterbrot.org>
 <CADnq5_Mvyz1KUw26Emt8_d_XNeQ=MUqx8WF=iCxa6jagCXNCQQ@mail.gmail.com>
 <171a9895-b020-7630-b90c-d166f45e44e3@butterbrot.org>
 <CADnq5_P_H8ZZXnXOoUcxNOFece3BRyzhZh2Z3mkw53eA20KiMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="n10VEnUCq5mxSC13NlOB65eVkWNcGXNgF"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:46703 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbdFBQrQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Jun 2017 12:47:16 -0400
In-Reply-To: <CADnq5_P_H8ZZXnXOoUcxNOFece3BRyzhZh2Z3mkw53eA20KiMQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n10VEnUCq5mxSC13NlOB65eVkWNcGXNgF
Content-Type: multipart/mixed; boundary="4liRsGNuAwckBChcKsnE5tbJCeHnqQpIF";
 protected-headers="v1"
From: Florian Echtler <floe@butterbrot.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Message-ID: <c1ed89a5-e6a1-1903-05ee-a9dfcdb2ef61@butterbrot.org>
Subject: Re: iMac 10,1 with Ubuntu 16.04: black screen after suspend
References: <30380cb3-0f26-8aea-2689-d4886879129c@butterbrot.org>
 <20170526210340.GA5114@wunner.de>
 <1e60811b-a8ac-017c-d350-8a40e4323870@butterbrot.org>
 <20170530105404.GA29865@wunner.de>
 <64a4829c-3141-6ff6-9369-6ca9ed0facf4@butterbrot.org>
 <20170531092145.ytc2d6shpukxziie@wunner.de>
 <CADnq5_MGWOX47tcvkfjHRxRv_eTbo_kvpVKyTpo8WGNw+xBvPA@mail.gmail.com>
 <65c88b03-45d7-d67b-2a2c-6c7047a73c80@butterbrot.org>
 <CADnq5_Mvyz1KUw26Emt8_d_XNeQ=MUqx8WF=iCxa6jagCXNCQQ@mail.gmail.com>
 <171a9895-b020-7630-b90c-d166f45e44e3@butterbrot.org>
 <CADnq5_P_H8ZZXnXOoUcxNOFece3BRyzhZh2Z3mkw53eA20KiMQ@mail.gmail.com>
In-Reply-To: <CADnq5_P_H8ZZXnXOoUcxNOFece3BRyzhZh2Z3mkw53eA20KiMQ@mail.gmail.com>

--4liRsGNuAwckBChcKsnE5tbJCeHnqQpIF
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 02.06.2017 17:12, Alex Deucher wrote:
> On Fri, Jun 2, 2017 at 3:35 AM, Florian Echtler <floe@butterbrot.org> w=
rote:
>>
>> [  166.853787] [drm:radeon_dp_link_train_cr] clock recovery at voltage=
 0
>> pre-emphasis 0
>> [  166.853788] [drm:drm_detect_monitor_audio] Monitor has basic audio =
support
>> [  166.855953] [drm:radeon_dp_link_train_ce] channel eq at voltage 0 p=
re-emphasis 0
>=20
> Yes, the link training appears to complete fine.  I guess it's
> something to do with the proprietary mux or backlight controls.

OK, so back to square... well, not one, but definitely back to the regist=
ers
(SMC and GPU).

As mentioned, the diff for the GPU registers before/after suspend is huge=
,
there's 117 register values that have changed. I assume that most of them=
 are
actually internal frame pointers, but which ones? I tried to find some of=
 that
information in drivers/gpu/drm/radeon/, but quickly got lost :-/

Regarding the SMC, there's actually only one key that consistently seems =
to have
a different value whether the display is on or off:

--- blank	2017-05-05 08:40:53.694565045 +0200
+++ non_blank	2017-05-05 08:40:53.702565066 +0200
@@ -143,7 +143,7 @@
   MSWR  [ui8 ]  0 (bytes 00)
   MVBO  [hex_]  (bytes ff ff)
   MVDC  [bin_]  (bytes 00)
-  MVDS  [bin_]  (bytes 08)
+  MVDS  [bin_]  (bytes 0a)
   MVE1  [si8 ]  (bytes 0d)
   MVE5  [si8 ]  (bytes 0b)
   MVHR  [flag]  (bytes 01)

However, even with my modified SmcDumpKeys.c which I can use to enable TD=
M, I
cannot write to that key. Since other MV__ keys control the display, too,=
 it
would make sense that that is related to the display state, but it seems =
to be a
read-only key :-/

Running out of ideas again... any suggestions?

Best, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL


--4liRsGNuAwckBChcKsnE5tbJCeHnqQpIF--

--n10VEnUCq5mxSC13NlOB65eVkWNcGXNgF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkxlosACgkQ7CzyshGvatiU6QCfePg9aoDyVvIvBJHY+B/hgow2
HbIAn23PdslQ5a8Y6wH5HoeiqwfKzgsq
=fkdX
-----END PGP SIGNATURE-----

--n10VEnUCq5mxSC13NlOB65eVkWNcGXNgF--
