From: Kel Modderman <kel@otaku42.de>
Subject: Re: backlight regression on ASUS F6S: inverted brightness control
Date: Mon, 5 Jan 2009 06:49:19 +1000
Message-ID: <200901050649.19747.kel@otaku42.de>
References: <200812280611.18320.kel@otaku42.de> <200812310202.16459.kel@otaku42.de> <1230694408.562.306.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from venema.h4ckr.net ([217.24.1.135]:35383 "EHLO venema.h4ckr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373AbZADUte convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Jan 2009 15:49:34 -0500
In-Reply-To: <1230694408.562.306.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wednesday 31 December 2008 13:33:28 Zhang Rui wrote:
> the ACPI video backlight I/F on your laptop is broken.
> could you please boot with acpi_backlight=3Dvendor and see if it work=
s at
> before?
>=20
> BTW: please attach the output of =EF=BB=BF"grep . /proc/acpi/video/*/=
*/*" in=20
> 1. 2.6.28 kenrel & boot with "acpi_backlight=3Dvendor"

/proc/acpi/video/VGA/CRTD/brightness:<not supported>
/proc/acpi/video/VGA/CRTD/EDID:<not supported>
/proc/acpi/video/VGA/CRTD/info:device_id:    0x0100
/proc/acpi/video/VGA/CRTD/info:type:         UNKNOWN
/proc/acpi/video/VGA/CRTD/info:known by bios: no
/proc/acpi/video/VGA/CRTD/state:state:     0x1d
/proc/acpi/video/VGA/CRTD/state:query:     0x00
/proc/acpi/video/VGA/DVID/brightness:<not supported>
/proc/acpi/video/VGA/DVID/EDID:<not supported>
/proc/acpi/video/VGA/DVID/info:device_id:    0x0120
/proc/acpi/video/VGA/DVID/info:type:         UNKNOWN
/proc/acpi/video/VGA/DVID/info:known by bios: no
/proc/acpi/video/VGA/DVID/state:state:     0x1d
/proc/acpi/video/VGA/DVID/state:query:     0x00
/proc/acpi/video/VGA/LCDD/brightness:<not supported>
/proc/acpi/video/VGA/LCDD/EDID:<not supported>
/proc/acpi/video/VGA/LCDD/info:device_id:    0x0110
/proc/acpi/video/VGA/LCDD/info:type:         UNKNOWN
/proc/acpi/video/VGA/LCDD/info:known by bios: no
/proc/acpi/video/VGA/LCDD/state:state:     0x1f
/proc/acpi/video/VGA/LCDD/state:query:     0x01

> 2. an earlier working kernel, say 2.6.26.

/proc/acpi/video/VGA/CRTD/brightness:<not supported>
/proc/acpi/video/VGA/CRTD/EDID:<not supported>
/proc/acpi/video/VGA/CRTD/info:device_id:    0x0100
/proc/acpi/video/VGA/CRTD/info:type:         UNKNOWN
/proc/acpi/video/VGA/CRTD/info:known by bios: no
/proc/acpi/video/VGA/CRTD/state:state:     0x1d
/proc/acpi/video/VGA/CRTD/state:query:     0x00
/proc/acpi/video/VGA/DVID/brightness:<not supported>
/proc/acpi/video/VGA/DVID/EDID:<not supported>
/proc/acpi/video/VGA/DVID/info:device_id:    0x0120
/proc/acpi/video/VGA/DVID/info:type:         UNKNOWN
/proc/acpi/video/VGA/DVID/info:known by bios: no
/proc/acpi/video/VGA/DVID/state:state:     0x1d
/proc/acpi/video/VGA/DVID/state:query:     0x00
/proc/acpi/video/VGA/LCDD/brightness:levels:  15 14 13 12 11 10 9 8 7 6=
 5 4 3 2 1 0
/proc/acpi/video/VGA/LCDD/brightness:current: 13
/proc/acpi/video/VGA/LCDD/EDID:<not supported>
/proc/acpi/video/VGA/LCDD/info:device_id:    0x0110
/proc/acpi/video/VGA/LCDD/info:type:         UNKNOWN
/proc/acpi/video/VGA/LCDD/info:known by bios: no
/proc/acpi/video/VGA/LCDD/state:state:     0x1f
/proc/acpi/video/VGA/LCDD/state:query:     0x01

Thanks, Kel.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
