From: Kel Modderman <kel@otaku42.de>
Subject: Re: backlight regression on ASUS F6S: inverted brightness control
Date: Wed, 31 Dec 2008 02:02:16 +1000
Message-ID: <200812310202.16459.kel@otaku42.de>
References: <200812280611.18320.kel@otaku42.de> <200812291839.47270.kel@otaku42.de> <1230601067.562.235.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IYkWJI0tTcuvQjo"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from venema.h4ckr.net ([217.24.1.135]:56049 "EHLO venema.h4ckr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbYL3QC2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Dec 2008 11:02:28 -0500
In-Reply-To: <1230601067.562.235.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

--Boundary-00=_IYkWJI0tTcuvQjo
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 30 December 2008 11:37:47 Zhang Rui wrote:
> On Mon, 2008-12-29 at 16:39 +0800, Kel Modderman wrote:
> > On Monday 29 December 2008 11:07:32 Zhang Rui wrote:
> > > hi,
> > > 
> > > This is a duplicate of bug
> > > http://bugzilla.kernel.org/show_bug.cgi?id=12302
> > > please try the patch at
> > > http://bugzilla.kernel.org/show_bug.cgi?id=12037#c5
> > 
> > When patch is applied backlight control returned to normality.
> > 
> please attach the output of "grep . /proc/acpi/video/*/*/*" both before
> and after applying this patch.

Attached.

Thanks, Kel

--Boundary-00=_IYkWJI0tTcuvQjo
Content-Type: text/plain;
  charset="iso 8859-15";
  name="before"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="before"

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
/proc/acpi/video/VGA/LCDD/brightness:levels:  15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
/proc/acpi/video/VGA/LCDD/brightness:current: 0
/proc/acpi/video/VGA/LCDD/EDID:<not supported>
/proc/acpi/video/VGA/LCDD/info:device_id:    0x0110
/proc/acpi/video/VGA/LCDD/info:type:         UNKNOWN
/proc/acpi/video/VGA/LCDD/info:known by bios: no
/proc/acpi/video/VGA/LCDD/state:state:     0x1f
/proc/acpi/video/VGA/LCDD/state:query:     0x01

--Boundary-00=_IYkWJI0tTcuvQjo
Content-Type: text/plain;
  charset="iso 8859-15";
  name="after"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="after"

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
/proc/acpi/video/VGA/LCDD/brightness:levels:  15 14 0 1 2 3 4 5 6 7 8 9 10 11 12 13
/proc/acpi/video/VGA/LCDD/brightness:current: 13
/proc/acpi/video/VGA/LCDD/EDID:<not supported>
/proc/acpi/video/VGA/LCDD/info:device_id:    0x0110
/proc/acpi/video/VGA/LCDD/info:type:         UNKNOWN
/proc/acpi/video/VGA/LCDD/info:known by bios: no
/proc/acpi/video/VGA/LCDD/state:state:     0x1f
/proc/acpi/video/VGA/LCDD/state:query:     0x01

--Boundary-00=_IYkWJI0tTcuvQjo--
