From: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: Fwd: Brightness on HP EliteBook 8460p
Date: Tue, 31 Jul 2012 17:49:32 +0200
Message-ID: <CAKPcRGrLvsTvY2UUTmnQan4uPWk3Nar4HBn3BY4wOyePfQFXGQ@mail.gmail.com>
References: <4F2E8FE40200002300007D85@novprvlin0050.provo.novell.com>
	<1539163.XtGOYjTjgt@pali>
	<CAKPcRGp+1DBjP7ZTnVUphtY2acdU64gGBi9VO5WG7+83revV9g@mail.gmail.com>
	<3502295.b9B3oqyYO6@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:35000 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563Ab2GaPtd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jul 2012 11:49:33 -0400
In-Reply-To: <3502295.b9B3oqyYO6@pali>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Artur Flinta <aflinta@gmail.com>, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, joeyli <jlee@suse.com>, Alex Deucher <alexdeucher@gmail.com>

I'm putting back the CC and adding Alex.

On Tue, Jul 31, 2012 at 5:07 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
> Thanks, now working. When I write to acpi video brightness file
> it change brightness and in dmesg is:
>
> [   47.200998] [drm:radeon_atif_handler], event, device_class =3D
> video, type =3D 0xd0
> [   47.201102] [drm:radeon_atif_get_sbios_requests], SBIOS
> pending requests: 0x80
> [   47.201104] [drm:radeon_atif_handler], ATIF: 1 pending SBIOS
> requests
> [   47.201105] [drm:radeon_atif_handler], Changing brightness to
> 11

Great! I'll send an updated patch to Alex soon.

> I think that acpi only sent event about brightness key pressed,
> because nothing happened when I pressed it.
>
> Also for windows is needed special HP application (hp hotkey) for
> brightness keys. Without it brightness keys not working too...

I've looked at hp-wmi: the hotkey is indeed dispatched via WMI
(hp-wmi) so you need something in userspace (KDE, Gnome, etc) to
respond to that key press.

> And there is one problem with /sys/class/backlight/radeon_bl.
> When I enable Ambient Light Sensor which auto adjust brightness
> based on sensor data, writing value 0 (min) or 255 (max) to
> /sys/class/backlight/radeon_bl/brightness turn off display.

Ok, that's weird. 0 turns off the panel by design, 255 should not...

> All
> other values (1-254) are OK (adjust brightness level). When I
> turn off Ambient Light Sensor (via hp-wmi kernel module) then
> values 0 and 255 also set brightness level (min and max). My
> suggestion is to convert value 0 to 1 and 255 to 254 to prevent
> this problem.

No idea what's going on here... might be some weird vendor magic.
The WMI code is rather obscure...

Luca
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
