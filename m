From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Black screen-dead unit on S3 resume - Intel Atom
Date: Tue, 20 Apr 2010 09:15:19 +0800
Message-ID: <1271726119.7167.1347.camel@rzhang1-desktop>
References: <4BCC29D3.9030405@linuxdevelopment.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:65252 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021Ab0DTBO0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Apr 2010 21:14:26 -0400
In-Reply-To: <4BCC29D3.9030405@linuxdevelopment.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert =?ISO-8859-1?Q?W=F6rle?= <robert@linuxdevelopment.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2010-04-19 at 18:00 +0800, Robert W=C3=B6rle wrote:
> Dear List
>=20
> I am approaching this list now as one of my last hopes i ve to fix S3=
 on
> Intel Atom based Tablet PC.
>=20
> The overall description of the situation is as follows.
>=20
> - entereing into S3 via "echo mem > /sys/power/state will result in a
> suspend into the bios which is comparable to the one when running win=
dows.
> The acitivity led starts blinking and it sits there. Power consumptio=
n
> measurments show the equally amounts of mA take.
>=20
Sorry my English is not good.
Do you mean the power consumption is consistent in this state?
Or the power consumption in S3 is the same in both windows and Linux?
Or the power consumption is the same when Linux is in/out of S3?

> The system then reacts on the power button only with a changing power
> led to static. ( after around 1 sec)
> But that is all i can get as reaction.
> No hdd activity at all.
>=20
> So it stucks on the resume situation as early as acpi calls the wakin=
g
> vektor. That is my assumption.
>=20
> Tests taken :
> - All /sys/power/pm_test  `scenarios runs fine without any obvious is=
sue.
> - All test are done with mininal system scenario with only hdd, usb a=
nd
> framebuffer drivers compiled in.
> - s3_beep kernel option also doesnt beep on resume , beepdriver is
> compiled in.
> - testet various options, like acpi old_ordering, rsdt, sci_force_ena=
ble
> and some more
> - most tests where done on 2.6.34-rc1.  but others where with 2.6.27
> (openSuse 11.1) and 2.6.20
>=20
> I am about to recieve a ami bios post code - debug card. That one sho=
uld
> help to determine the bios side.
>=20
> So i am stuck without any further debug information beside the dmesg
> from the bootet system and the pm_test runs.
>=20
>=20
> I can attach or mail any log you guys want me to. Also i ve all acpid=
ump
> `ed tables
>=20
please attach the acpidump of the laptop.
please also attach the dmesg outputa after boot, in 2.6.34-rc1.

thanks,
rui


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
