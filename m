From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 07/32] acpi-video-detect: Rewrite backlight interface
 selection logic
Date: Thu, 11 Jun 2015 11:19:22 +0200
Message-ID: <20150611091922.GB19820@pali>
References: <1433941292-21530-1-git-send-email-hdegoede@redhat.com>
 <1433941292-21530-8-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:36771 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbbFKJT0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jun 2015 05:19:26 -0400
Content-Disposition: inline
In-Reply-To: <1433941292-21530-8-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org

On Wednesday 10 June 2015 15:01:07 Hans de Goede wrote:
> Currently we have 2 kernel commandline options + dmi-quirks in 3 plac=
es all
> interacting (in interesting ways) to select which which backlight int=
erface
> to use. On the commandline we've acpi_backlight=3D[video|vendor] and
> video.use_native_backlight=3D[0|1]. DMI quirks we have in
> acpi/video-detect.c, acpi/video.c and drivers/platform/x86/*.c .
>=20
> This commit is the first step to cleaning this up, replacing the 2 cm=
dline
> options with just acpi_video.backlight=3D[video|vendor|native|none], =
and
> adding a new API to video_detect.c to reflect this.
>=20
> Follow up commits will also move other related code, like unregisteri=
ng the
> acpi_video backlight interface if it was registered before other driv=
ers
> which take priority over it are loaded, to video_detect.c where this
> logic really belongs.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Hello,

lot of people are using acpi_backlight parameter in kernel cmdline to
fix some of problems. I would like to see this parameter still working
and to not break existing configuration. E.g acpi_backlight=3Dvendor to
use dell-laptop.ko or thinkpad_acpi.ko backlight.

It is still nightmare to get laptop panel backlight working on differen=
t
(broken) laptops and people learnt to try to use acpi_backlight
parameter for quit/hot fixing these problems. Upgrading kernel (if you
remove acpi_backlight parameter) just break it again.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
