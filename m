From: Ben Jencks <ben@bjencks.net>
Subject: Re: "Windows 2012" OSI causes backlight problems on current ThinkPad
 firmware
Date: Mon, 24 Dec 2012 21:10:03 -0500
Message-ID: <50D90AFB.8060802@bjencks.net>
References: <50D8C9D1.2060801@bjencks.net> <1356390303.6113.47.camel@linux-s257.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33419 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385Ab2LYCRc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Dec 2012 21:17:32 -0500
Received: by mail-ob0-f173.google.com with SMTP id xn12so7071581obc.18
        for <linux-acpi@vger.kernel.org>; Mon, 24 Dec 2012 18:17:31 -0800 (PST)
In-Reply-To: <1356390303.6113.47.camel@linux-s257.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: linux-acpi@vger.kernel.org

On 12/24/2012 06:05 PM, joeyli wrote:
> =E6=96=BC =E4=B8=80=EF=BC=8C2012-12-24 =E6=96=BC 16:32 -0500=EF=BC=8C=
Ben Jencks =E6=8F=90=E5=88=B0=EF=BC=9A
>> The addition of "Windows 2012" to the OSI strings in the 3.7 cycle h=
as
>> caused backlight brightness adjustment to break on my ThinkPad T530.
>>
>> Without "Windows 2012" _BCL returns the actual 16 brightness levels:
>>
>> 5, 10, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 80, 90, 100
>>
>> When "Windows 2012" is present, it returns 101 levels 0-100, but _BC=
M
>> rounds any value up to one of the real values above.
>>
>> This interacts badly with gnome-settings-daemon, which attempts to
>> change brightness in increments of 5 (1/20 of 100). If brightness is
>> currently 100, it attempts to decrement it to 95, but it gets rounde=
d
>> back up to 100, so it's impossible to decrease the brightness.
>>
>> Booting with acpi_osi=3D"!Windows 2012" fixes the problem, though I'=
m
>> not
>> sure if it introduces others; I see several other things depend on
>> WIN8
>> in DSDT.
>>
>> Perhaps this should be fixed in gnome-settings-daemon, but since it
>> appears on the surface to be a kernel regression (3.6 works, 3.7
>> broken)
>> I thought I'd report it here first.=20
>=20
> Yes, this is g-s-d's problem, g-s-d should adapt to more levels of
> brightness:
>=20
> plugins/power/gsd-power-manager.c
>=20
> /* on ACPI machines we have 4-16 levels, on others it's ~150 */
> #define BRIGHTNESS_STEP_AMOUNT(max) ((max) < 20 ? 1 : (max) / 20)

Actually, thinking about this some more, I'm not sure what g-s-d could
do about this. It could behave better if brightness changes don't
"stick", but as long as the hardware/kernel is lying to userspace about
how many brightness levels are available the experience can't be
completely right.

If the exact brightness levels aren't exposed, pressing the brightness
up/down keys will skip a real level or not change the real level at all
in some cases.

Would it be possible to add a quirk in to exclude "Windows 2012" on thi=
s
hardware/bios?

-Ben
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
