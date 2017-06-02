From: Florian Echtler <floe@butterbrot.org>
Subject: Re: iMac 10,1 with Ubuntu 16.04: black screen after suspend
Date: Fri, 2 Jun 2017 09:35:38 +0200
Message-ID: <171a9895-b020-7630-b90c-d166f45e44e3@butterbrot.org>
References: <30380cb3-0f26-8aea-2689-d4886879129c@butterbrot.org>
 <20170526210340.GA5114@wunner.de>
 <1e60811b-a8ac-017c-d350-8a40e4323870@butterbrot.org>
 <20170530105404.GA29865@wunner.de>
 <64a4829c-3141-6ff6-9369-6ca9ed0facf4@butterbrot.org>
 <20170531092145.ytc2d6shpukxziie@wunner.de>
 <CADnq5_MGWOX47tcvkfjHRxRv_eTbo_kvpVKyTpo8WGNw+xBvPA@mail.gmail.com>
 <65c88b03-45d7-d67b-2a2c-6c7047a73c80@butterbrot.org>
 <CADnq5_Mvyz1KUw26Emt8_d_XNeQ=MUqx8WF=iCxa6jagCXNCQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WumoKffSbhTiakL6BJdFBuJELq6kt8U8o"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:59146 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbdFBHfo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Jun 2017 03:35:44 -0400
In-Reply-To: <CADnq5_Mvyz1KUw26Emt8_d_XNeQ=MUqx8WF=iCxa6jagCXNCQQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WumoKffSbhTiakL6BJdFBuJELq6kt8U8o
Content-Type: multipart/mixed; boundary="AvD5qcvMQP9xBDqBARk3PsMqxxT6A0Wbv";
 protected-headers="v1"
From: Florian Echtler <floe@butterbrot.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Message-ID: <171a9895-b020-7630-b90c-d166f45e44e3@butterbrot.org>
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
In-Reply-To: <CADnq5_Mvyz1KUw26Emt8_d_XNeQ=MUqx8WF=iCxa6jagCXNCQQ@mail.gmail.com>

--AvD5qcvMQP9xBDqBARk3PsMqxxT6A0Wbv
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 01.06.2017 19:53, Alex Deucher wrote:
> On Thu, Jun 1, 2017 at 4:27 AM, Florian Echtler <floe@butterbrot.org> w=
rote:
>> On 31.05.2017 14:57, Alex Deucher wrote:
>>> On Wed, May 31, 2017 at 5:21 AM, Lukas Wunner <lukas@wunner.de> wrote=
:
>>
>> Here's the (substantial) dmesg output, with drm.debug=3D0xf:
>> http://floe.butterbrot.org/external/radeon/dmesg_after_suspend
>>
>> I haven't been able to find any references to link training, though.
>=20
> I need your dmesg from boot to confirm the display topology, but eDP
> with r7xx asics was pretty rare.  I suspect your system just uses
> LVDS; as such there is no link training involved.

I've updated the trace with increased log_buf_len so nothing is truncated=
:

http://floe.butterbrot.org/external/radeon/dmesg_after_suspend.txt

(trace now contains a full boot including suspend and wakeup)

However, what I'm seeing now does sound like the internal connection is i=
ndeed eDP:

[  166.816162] [drm:drm_mode_setcrtc] [CRTC:34:crtc-0]
[  166.816166] [drm:drm_mode_setcrtc] [CONNECTOR:40:eDP-1]
[  166.816167] [drm:drm_crtc_helper_set_config]
[  166.816169] [drm:drm_crtc_helper_set_config] [CRTC:34:crtc-0] [FB:54]
#connectors=3D1 (x y) (0 0)
[  166.816170] [drm:drm_crtc_helper_set_config] crtc has no fb, full mode=
 set
[  166.816172] [drm:drm_mode_object_reference] OBJ ID: 40 (4)
[  166.816173] [drm:drm_crtc_helper_set_config] encoder changed, full mod=
e switch
[  166.816174] [drm:drm_crtc_helper_set_config] crtc changed, full mode s=
witch
[  166.816174] [drm:drm_crtc_helper_set_config] [CONNECTOR:40:eDP-1] to
[CRTC:34:crtc-0]
[  166.816175] [drm:drm_crtc_helper_set_config] attempting to set mode fr=
om
userspace
[  166.816177] [drm:drm_mode_debug_printmodeline] Modeline 65:"" 0 241500=
 2560
2608 2640 2720 1440 1443 1448 1481 0x0 0x9
[  166.816180] [drm:radeon_encoder_set_active_device] setting active devi=
ce to
00000002 from 00000002 00000002 for encoder 3
[  166.816183] [drm:radeon_get_monitor_bpc] eDP-1: Display bpc=3D8, retur=
ned bpc=3D8
[  166.816185] [drm:drm_detect_monitor_audio] Monitor has basic audio sup=
port
[  166.816186] [drm:radeon_get_monitor_bpc] eDP-1: Display bpc=3D8, retur=
ned bpc=3D8
[  166.816188] [drm:drm_detect_monitor_audio] Monitor has basic audio sup=
port
[  166.816192] [drm:drm_crtc_helper_set_mode] [CRTC:34:crtc-0]
[  166.816208] [drm:radeon_get_monitor_bpc] eDP-1: Display bpc=3D8, retur=
ned bpc=3D8
[  166.816210] [drm:radeon_atom_encoder_dpms] encoder dpms 30 to mode 3, =
devices
00000008, active_devices 00000000
[  166.816213] [drm:radeon_atom_encoder_dpms] encoder dpms 22 to mode 3, =
devices
00000010, active_devices 00000000
[  166.816235] [drm:drm_detect_monitor_audio] Monitor has basic audio sup=
port
[  166.816237] [drm:radeon_compute_pll_avivo] 360000 - 360000, pll divide=
rs -
fb: 80.0 ref: 2, post 3
[  166.824475] done.

=2E.. and a bit later:

[  166.853787] [drm:radeon_dp_link_train_cr] clock recovery at voltage 0
pre-emphasis 0
[  166.853788] [drm:drm_detect_monitor_audio] Monitor has basic audio sup=
port
[  166.855953] [drm:radeon_dp_link_train_ce] channel eq at voltage 0 pre-=
emphasis 0

Best, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL


--AvD5qcvMQP9xBDqBARk3PsMqxxT6A0Wbv--

--WumoKffSbhTiakL6BJdFBuJELq6kt8U8o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkxFUoACgkQ7CzyshGvatj1LgCdGn/WK7BwWirIWk+Zkw7ayKl7
37EAoJveAn8CP/bQi2kUTJY3tiRfZPt7
=MOjT
-----END PGP SIGNATURE-----

--WumoKffSbhTiakL6BJdFBuJELq6kt8U8o--
