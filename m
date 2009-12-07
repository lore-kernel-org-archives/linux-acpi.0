From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCHv2 0/2] Introducing the Ambient Light Sensor (ALS) class
Date: Mon, 7 Dec 2009 16:04:32 +0100
Message-ID: <20091207160432.3108e17b@hyperion.delvare>
References: <1259581514-15356-1-git-send-email-amit.kucheria@verdurent.com>
	<37786d4b0912070650g7ba7604bv63365a21f980501d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bamako.nerim.net ([62.4.17.28]:61719 "EHLO bamako.nerim.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935167AbZLGPEa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2009 10:04:30 -0500
In-Reply-To: <37786d4b0912070650g7ba7604bv63365a21f980501d@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: List Linux Kernel <linux-kernel@vger.kernel.org>, rui.zhang@intel.com, jic23@cam.ac.uk, alan@linux.intel.com, linux-acpi@vger.kernel.org, gregkh@suse.de, Andrew Morton <akpm@linux-foundation.org>

On Mon, 7 Dec 2009 16:50:23 +0200, Amit Kucheria wrote:
> On Mon, Nov 30, 2009 at 1:45 PM, Amit Kucheria
> <amit.kucheria@verdurent.com> wrote:
> > Introduce a new class of devices to handle ambient light sensors. C=
urrently
> > only one sysfs inteface, 'illuminance' is introduced. More will be =
added as
> > drivers are ported to use this new class.
> >
> > Amit Kucheria (1):
> > =C2=A0als: add unique device-ids to the als device class
> >
> > Zhang Rui (1):
> > =C2=A0introduce ALS sysfs class
> >
> > =C2=A0Documentation/ABI/testing/sysfs-class-als | =C2=A0 =C2=A09 ++
> > =C2=A0MAINTAINERS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
6 ++
> > =C2=A0drivers/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +
> > =C2=A0drivers/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
> > =C2=A0drivers/als/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 10 +++
> > =C2=A0drivers/als/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A05 +
> > =C2=A0drivers/als/als_sys.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0116 +++++++++++++++++++++++++++++
> > =C2=A0include/linux/als_sys.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 35 +++++++++
> > =C2=A08 files changed, 184 insertions(+), 0 deletions(-)
> > =C2=A0create mode 100644 Documentation/ABI/testing/sysfs-class-als
> > =C2=A0create mode 100644 drivers/als/Kconfig
> > =C2=A0create mode 100644 drivers/als/Makefile
> > =C2=A0create mode 100644 drivers/als/als_sys.c
> > =C2=A0create mode 100644 include/linux/als_sys.h
> >
>=20
> (Bump)
>=20
> Is there any blocker to adding this for 2.6.33?

As far as I am concerned, it's ready to go. And I would love to see it
in 2.6.33.

> Which maintainer will pick up the ALS framework?

As Rui volunteered to be the maintainer of this new subsystem, it would
seem fair that he takes care of the initial push as well.

--=20
Jean Delvare
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
