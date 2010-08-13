From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] ideapad-laptop: add new driver
Date: Fri, 13 Aug 2010 08:37:09 +0200
Message-ID: <AANLkTikBZ2SmqWavZ8bw69yQ_A5GTTcB13RKEzUuUcx3@mail.gmail.com>
References: <1281672482-10909-1-git-send-email-ike.pan@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47391 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab0HMGhK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Aug 2010 02:37:10 -0400
In-Reply-To: <1281672482-10909-1-git-send-email-ike.pan@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ike Panhc <ike.pan@canonical.com>
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@linux.intel.com>, Thomas Renninger <trenn@suse.de>, linux-kernel@vger.kernel.org

On Fri, Aug 13, 2010 at 6:08 AM, Ike Panhc <ike.pan@canonical.com> wrot=
e:
> ideapad-laptop is a new driver which enable hotkeys on Lenovo Ideapad=
 laptops
>
> The driver will bind on ACPI HID:VPC2004. When hotkey pressed, the no=
tify
> function will be called and query EC to tell which key pressed.
>
> Hotkeys enabled listed below:
> =A0* LCD backlight switch - reports KEY_DISPLAY_OFF
> =A0* One key restore - reports KEY_PROG1
> =A0* Brightness Up/down - reports KEY_BRIGHTNESS_CYCLE
> =A0 Both up/down keys reports the same event. Need to find other way =
to detect
> =A0* Touchpad switch - reports KEY_F13
> =A0* Video output switch - reports KEY_SWITCHVIDEOMODE
> =A0* Camera switch - reports KEY_CAMERA
> =A0* Video resolution switch - reports KEY_VIDEO_NEXT
> =A0* S/W rfkill key - reports KEY_WLAN
>
> The developing git tree as reference:
> =A0git://kernel.ubuntu.com/ikepanhc/ideapad-laptop.git
>
> This patch made against current checkout of mainline kernel.

Cool, now we got two ideapad drivers :p.

David just sent an rfkill driver to this list. Maybe you could merge yo=
ur work ?

Thanks,
--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
