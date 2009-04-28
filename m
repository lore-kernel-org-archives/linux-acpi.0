From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: acpi 'video' driver, and issues with
	'brightness_switch_enabled=0'
Date: Tue, 28 Apr 2009 10:43:24 +0800
Message-ID: <1240886605.4639.19.camel@rzhang-dt>
References: <1240855052.11237.7.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:24780 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469AbZD1CnL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Apr 2009 22:43:11 -0400
In-Reply-To: <1240855052.11237.7.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2009-04-28 at 01:57 +0800, Maxim Levitsky wrote:
> I have a notebook which handles brightness keys in hardware, but tell=
s
> loudly when it does so.
>=20
if you boot into console mode w/o ACPI video driver, does the brightnes=
s
still change when you press the hotkeys?

> Currently, acpi 'video' also sets the brightness, which result in dou=
ble
> setting, and on top of that it emits a key that makes gpm set brightn=
ess
> again.
>=20
we need to support the brightness control in console mode.
and "=EF=BB=BFbrightness_switch_enabled" should be cleared in graphics =
mode to
prevent the ACPI video driver action upon hotkey events.

> And (yes...) on top of that keyboard emits a brightness up/down even,
> which (you guessed...) sets brightness again.
>=20
> I found out that it is possible to tell gnome-power-manager not to se=
t
> brightness, but yet in kernel driver still sets it.
>=20
> I found out even earlier that I can use brightness_switch_enabled=3D0=
,
> which supposed to make inkernel driver not touch the brightness.
> But I found out that this driver won't update the brightness, in /sys
> interface when I set this param.
>=20
No, when =EF=BB=BF"=EF=BB=BFbrightness_switch_enabled" is cleared, gdm =
should still use
the ACPI backlight sysfs I/F if available to change the backlight,
i.e. /sys/class/backlight/acpi_video0/...

what's the model name of your laptop?
are you using Intel graphics?
please attach the output of acpidump and lspci.
It would be great if you can file a bug report about this issue at
bugzilla.kernel.org.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
