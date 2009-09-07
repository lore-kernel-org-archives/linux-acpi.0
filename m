From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: RFC: Light sensors, unifying current options?
Date: Mon, 07 Sep 2009 15:32:24 +0800
Message-ID: <1252308744.3483.414.camel@rzhang-dt>
References: <4A9FC9D7.20000@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:3639 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665AbZIGHfK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Sep 2009 03:35:10 -0400
In-Reply-To: <4A9FC9D7.20000@cam.ac.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "Cory T. Tusar" <ctusar@videon-central.com>, "Trisal, Kalhan" <kalhan.trisal@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Hi, Jonathan,

On Thu, 2009-09-03 at 21:51 +0800, Jonathan Cameron wrote:
> Dear All,
>=20
> This thread is a follow up to (amongst others)
>=20
> [lm-sensors] Ambient Light sensor for Intersil-ISL29020 device
>=20
> Currently there are a number of light sensor drivers either in the
> mainline kernel, posted to various mailing lists or sitting in variou=
s
> testing trees.
>=20
> For example.
>=20
> Intersil ISL29020
> http://www.intersil.com/products/deviceinfo.asp?pn=3DISL29020 driver
> posted by Kalan Trisal to lm-sensors (as hwmon device rejected for
> being out of subsystem scope)
> http://lists.lm-sensors.org/pipermail/lm-sensors/2009-September/02657=
5.html
>=20
> ALS_sysfs class and als_acpi driver (V6 posted to lkml earlier this w=
eek).
> http://lkml.org/lkml/2009/9/1/38
>=20
> TSL2561 under the industrial I/O Framework. (in Greg KH's tree, will
> being in staging after merge window - there due to lack of review
> more than any known problems.)
> http://www.farnell.com/datasheets/49661.pdf
> http://lkml.org/lkml/2009/7/2/189
>=20
> TSL2550 under i2c/chips/ which as a location is going away.
> http://www.farnell.com/datasheets/48715.pdf
>=20
> (any others people know of?)
>=20
> Two big questions:
>=20
> * Are there sufficient shared characteristics between these devices t=
o
> all for a unified framework? (would certainly be nice!)
>=20
> * What applications are they used for? This will drive the question
> of what functionality is desirable. (particularly do we need an event
> infrastructure or not).
>=20
> To sumarize the functionality currently provided by the above drivers
> (or that should probably be added)
>=20
> ISL29020:
> * sensing_range
> * lux_level
> * power state (should probably move over to the new power management
>   framework)
>=20
> ALS:
> * illuminance (equivalent of lux_level)
> * adjustment (I don't follow the purpose of this, but then I don't kn=
ow
> anything about how this is being used!)
>=20
adjustment is a percentage value used by userspace to adjust the displa=
y
backlight.

According to the ACPI spec, ACPI ALS device has "ambient light
illuminance to display luminance" mappings that can be used by an OS to
calibrate its ambient light policy for a given sensor configuration. Th=
e
OS can use this information to extrapolate an ALS response curve. i.e.
ACPI ALS knows what to do when ambient light illuminance changes, but i=
t
won't change the backlight. Instead, it exports this info to user space
via the "adjustment" attribute.
user space applications can get this value and change the display
brightness via the backlight sysfs I/F.

IMO, the ALS device should do the following work:
1. catch the ambient light illuminance change.
2. tell the userspace what to do with this change.
isn't this true for the other ALS devices in this thread?

> TSL2561
> * infrared (raw value)
> * broad spectrum (raw value)
> (I'm of the view any derived values should probably be done in usersp=
ace)
> This one is under IIO at the moment for two reasons.
> 1) I hit the same issue of no suitable subsystem, but for a much larg=
er
> class of sensor devices. Light sensors are just one example (that's n=
ot
> to say I mind hiving this lot off to a system of their own).
> 2) To provide an event interface (which I haven't yet done)
> Driver should also include:
> * integration time
> * gain control=20
>=20
> TSL2550
> * power state
> * operating mode
> * lux (actually calculated from two separate readings as
> per the tsl2561 but the are not available to userspace)
>=20
> Applications:
>=20
> 1) Backlight intensity type apps (guessing that covers most people)
> 2) Environmental monitoring apps (the crossbow imb400 imote2 daughter
> board I'm using doesn't have any screen or other direct interface, it=
s
> simply a lightweight sensor platform).
> 3) High speed apps (all current sensors are pretty slow so this isn't
> yet relevant).
>=20
> My personal feelings is that the IIO is overkill for these types
> of sensors (slow update rate, tsl2550 takes 400ms, tsl2561 12-400ms)
> unless we want the event handling infrastructure. I'm inclined to
> say it is unecessary given the same result could be obtained by
> polling only a few times a second.
>=20
agree.
this is not a problem to ACPI ALS device.
ACPI sends a notification to the ACPI ALS device when illuminance is
changed.

> My comments on ALS may be wrong or misleading as they are based on a
> brief read of the code (please correct me!)  A lot of the
> infrastructure is only necessary if we have in kernel users
>  (and at
> the moment the functionality doesn't appear to be there for any such
> users to acquire access to these sensors in the first place.  For
> example, the approach used by hwmon of letting drivers define their
> own attributes seems to me to be more easily extendable than ALS' use
> of an ops structure.

=EF=BB=BFI agree that the ops structure is unnecessary.
To make the als_sys class more generic, we just need to
1. defines the generic attributes that the native ALS driver must
follow.
2. registers an als device in the als_sys class.
and the native driver should be responsible for the sysfs attributes.

Because my approach is made by reading the ACPI spec, I'm not sure what
should be done in the native driver and what should be done in the
generic driver at the beginning.

thanks for pointing this out.

>  For example, I'm not convinced it makes sense for
> drivers to have to have a get_adjustment attribute or indeed even
> necessarily have a direct illuminance attribute (deriving the relevan=
t
> value may be a case of userspace combining several associated
> readings).

what these associated readings are?
I think we can define some optional attributes besides the required
attributes.
but we should make clear what is necessary for an ALS device, and what
optional features it may support.

thanks,
rui


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
