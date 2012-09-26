From: joeyli <jlee@suse.com>
Subject: Re: PROBLEM: Acer D255E Backlight out for 10 seconds with ACPI
Date: Thu, 27 Sep 2012 07:19:03 +0800
Message-ID: <1348701543.8621.104.camel@linux-s257.site>
References: <CALKZjMKcCA68XLWADb+EmU+a3VTQuOGr1dqNywGCCMj8DWNsiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:56270 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab2IZXZd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Sep 2012 19:25:33 -0400
In-Reply-To: <CALKZjMKcCA68XLWADb+EmU+a3VTQuOGr1dqNywGCCMj8DWNsiQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan <vxltage@gmail.com>
Cc: linux-acpi@vger.kernel.org

=E6=96=BC =E4=B8=89=EF=BC=8C2012-09-26 =E6=96=BC 16:48 -0400=EF=BC=8CDa=
n =E6=8F=90=E5=88=B0=EF=BC=9A
> Hello,
>=20
> Apologies if this was sent to the wrong place.
>=20
> With an Acer AOD255E netbook, the backlight goes out for exactly 10
> seconds before returning while booting.
>=20
> This is a backlight issue and not KMS, as I can shine a flashlight at
> the screen and still see boot text scrolling.
>=20
> With "acpi=3Doff" appended to the kernel line, this no longer occurs =
(Fn
> key backlight controls still work with this appended). With every
> other acpi option I have tried, this still occurs though. This
> includes "acpi_backlight" and "acpi_display_output". With
> "acpi_backlight=3Dvendor" the entry in /sys/class/backlight changes f=
rom
> acpi_video0 to acer_wmi, but backlight still goes out.
>=20
> Otherwise backlight works correctly.=20

Could you please try this kernel parameter?
video.use_bios_initial_backlight=3D0


Thanks
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
