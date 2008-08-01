From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Check for ACPI backlight support otherwise use vendor
	ACPIdrivers - version 2
Date: Fri, 01 Aug 2008 09:28:18 +0800
Message-ID: <1217554098.2969.152.camel@rzhang-dt>
References: <1216205553-8486-1-git-send-email-trenn@suse.de>
	 <1217399377.23004.0.camel@hidalgo>  <200807301106.40521.trenn@suse.de>
	 <1217518335.12217.24.camel@earth.gruber.myown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:29502 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753112AbYHABaf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jul 2008 21:30:35 -0400
In-Reply-To: <1217518335.12217.24.camel@earth.gruber.myown>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nokos@gmx.net
Cc: Thomas Renninger <trenn@suse.de>, ak@linux.intel.com, mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it, Jesse Barnes <jbarnes@virtuousgeek.org>

On Thu, 2008-07-31 at 23:32 +0800, nokos@gmx.net wrote:
> Hi Thomas
>=20
> I didi some testing and found whats wrong with the backlight detectio=
n
> in video_detect.c you should change:
>=20
> --- video_detect.c 2008-07-31 17:20:59.540059897 +0200
> +++ video_detect.c 2008-07-31 17:22:15.752034851 +0200
> @@ -45,9 +45,9 @@
>                 ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found generic
> backlight "
>                                   "support\n"));
>                 *cap |=3D ACPI_VIDEO_BACKLIGHT;
> -               return 0;
> +               return -ENODEV;
>         }
> -       return -ENODEV;
> +       return 0;
>  }
>=20
Yes, that's the problem.=20

In the original patch,
=EF=BB=BFacpi_walk_namespace(ACPI_TYPE_DEVICE, device->handle, ACPI_UIN=
T32_MAX,
                     acpi_backlight_cap_match, &video_caps, NULL)
in =EF=BB=BFacpi_is_video_device() returns if the first video device do=
esn't
support backlight control.

>=20
> otherwise it stops walking the subtree at the first device which does
> not contain backlight (in my case GFX0 has CRT_ as first child which
> does not support backlight). Its ok to stop scanning at the first
> positive match since cap then already has ACPI_VIDEO_BACKLIGHT.
> (ENODEV
> is probably not the best error code here ...)
>=20
> probably you might want to change in acpi_is_video_device:
>=20
> --- video_detect.c 2008-07-31 17:20:59.540059897 +0200
> +++ video_detect.c 2008-07-31 17:22:15.752034851 +0200
> @@ -93,8 +93,10 @@
>                 video_caps |=3D ACPI_VIDEO_IGD;
>         }
>=20
> -       acpi_walk_namespace(ACPI_TYPE_DEVICE, device->handle,
> ACPI_UINT32_MAX,
> +        if (video_caps) {
> +               acpi_walk_namespace(ACPI_TYPE_DEVICE, device->handle,
> ACPI_UINT32_MAX,
>                             acpi_backlight_cap_match, &video_caps,
> NULL);
> +        }
>=20
>         return video_caps;
>  }
No.
=46or a video bus device, video_caps can never be 0 here.

> otherwise the whole ACPI namespace is scanned several times and this
> restricts the scanning only on those subtrees where the head might be
> a
> video device
>=20
>=20
> BTW. the DRDY detection (for IGD) works ... now I have to find the IG=
D
> patches ... couldn't find them on the list and the version of
> linux-next
> I tried didn't contain anything which looked like it.
You can get them here.
http://cgit.freedesktop.org/mesa/drm/diff/?id=3Ddfd441cf964f20e4a761cb8=
490d7cd82cf32e7b9

don't know if this is the latest version, cc Matthew and Jessie.

thanks,
rui


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
