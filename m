From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: RFC: Light sensors, unifying current options?
Date: Mon, 07 Sep 2009 12:42:12 +0100
Message-ID: <4AA4F194.1070507@cam.ac.uk>
References: <4A9FC9D7.20000@cam.ac.uk> <1252308744.3483.414.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:53770 "EHLO
	ppsw-5.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbZIGLmG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2009 07:42:06 -0400
In-Reply-To: <1252308744.3483.414.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "Cory T. Tusar" <ctusar@videon-central.com>, "Trisal, Kalhan" <kalhan.trisal@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Zhang Rui wrote:
> Hi, Jonathan,
>=20
> On Thu, 2009-09-03 at 21:51 +0800, Jonathan Cameron wrote:
>> Dear All,
>>
>> This thread is a follow up to (amongst others)
>>
>> [lm-sensors] Ambient Light sensor for Intersil-ISL29020 device
>>
>> Currently there are a number of light sensor drivers either in the
>> mainline kernel, posted to various mailing lists or sitting in vario=
us
>> testing trees.
>>
>> For example.
>>
>> Intersil ISL29020
>> http://www.intersil.com/products/deviceinfo.asp?pn=3DISL29020 driver
>> posted by Kalan Trisal to lm-sensors (as hwmon device rejected for
>> being out of subsystem scope)
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2009-September/0265=
75.html
>>
>> ALS_sysfs class and als_acpi driver (V6 posted to lkml earlier this =
week).
>> http://lkml.org/lkml/2009/9/1/38
>>
>> TSL2561 under the industrial I/O Framework. (in Greg KH's tree, will
>> being in staging after merge window - there due to lack of review
>> more than any known problems.)
>> http://www.farnell.com/datasheets/49661.pdf
>> http://lkml.org/lkml/2009/7/2/189
>>
>> TSL2550 under i2c/chips/ which as a location is going away.
>> http://www.farnell.com/datasheets/48715.pdf
>>
>> (any others people know of?)
>>
>> Two big questions:
>>
>> * Are there sufficient shared characteristics between these devices =
to
>> all for a unified framework? (would certainly be nice!)
>>
>> * What applications are they used for? This will drive the question
>> of what functionality is desirable. (particularly do we need an even=
t
>> infrastructure or not).
>>
>> To sumarize the functionality currently provided by the above driver=
s
>> (or that should probably be added)
>>
>> ISL29020:
>> * sensing_range
>> * lux_level
>> * power state (should probably move over to the new power management
>>   framework)
>>
>> ALS:
>> * illuminance (equivalent of lux_level)
>> * adjustment (I don't follow the purpose of this, but then I don't k=
now
>> anything about how this is being used!)
>>
> adjustment is a percentage value used by userspace to adjust the disp=
lay
> backlight.
>=20
> According to the ACPI spec, ACPI ALS device has "ambient light
> illuminance to display luminance" mappings that can be used by an OS =
to
> calibrate its ambient light policy for a given sensor configuration. =
The
> OS can use this information to extrapolate an ALS response curve. i.e=
=2E
> ACPI ALS knows what to do when ambient light illuminance changes, but=
 it
> won't change the backlight. Instead, it exports this info to user spa=
ce
> via the "adjustment" attribute.
> user space applications can get this value and change the display
> brightness via the backlight sysfs I/F.
Is this conversion entirely independent of the physical configuration o=
f
the sensor?  I can sort of imagine cases where some direct pickup from
the backlight occurs alongside the ambient and some where none does.
=46air enough if not.

> IMO, the ALS device should do the following work:
> 1. catch the ambient light illuminance change.
Sometimes this is more complex with the ability to separately read ligh=
t
levels in different frequency ranges (e.g. infrared and visible)  Still
this value can usually be derived.
> 2. tell the userspace what to do with this change.
> isn't this true for the other ALS devices in this thread?
None of the others (other than the additional asus one mentioned
later in this thread - which I haven't looked at) have any concept of w=
hat userspace
should do with the value. They simply measure it (and supply appropriat=
e
threshold interrupts etc)
>=20
>> TSL2561
>> * infrared (raw value)
>> * broad spectrum (raw value)
>> (I'm of the view any derived values should probably be done in users=
pace)
>> This one is under IIO at the moment for two reasons.
>> 1) I hit the same issue of no suitable subsystem, but for a much lar=
ger
>> class of sensor devices. Light sensors are just one example (that's =
not
>> to say I mind hiving this lot off to a system of their own).
>> 2) To provide an event interface (which I haven't yet done)
>> Driver should also include:
>> * integration time
>> * gain control=20
>>
>> TSL2550
>> * power state
>> * operating mode
>> * lux (actually calculated from two separate readings as
>> per the tsl2561 but the are not available to userspace)
>>
>> Applications:
>>
>> 1) Backlight intensity type apps (guessing that covers most people)
>> 2) Environmental monitoring apps (the crossbow imb400 imote2 daughte=
r
>> board I'm using doesn't have any screen or other direct interface, i=
ts
>> simply a lightweight sensor platform).
>> 3) High speed apps (all current sensors are pretty slow so this isn'=
t
>> yet relevant).
>>
>> My personal feelings is that the IIO is overkill for these types
>> of sensors (slow update rate, tsl2550 takes 400ms, tsl2561 12-400ms)
>> unless we want the event handling infrastructure. I'm inclined to
>> say it is unecessary given the same result could be obtained by
>> polling only a few times a second.
>>
> agree.
> this is not a problem to ACPI ALS device.
> ACPI sends a notification to the ACPI ALS device when illuminance is
> changed.
>=20
>> My comments on ALS may be wrong or misleading as they are based on a
>> brief read of the code (please correct me!)  A lot of the
>> infrastructure is only necessary if we have in kernel users
>>  (and at
>> the moment the functionality doesn't appear to be there for any such
>> users to acquire access to these sensors in the first place.  For
>> example, the approach used by hwmon of letting drivers define their
>> own attributes seems to me to be more easily extendable than ALS' us=
e
>> of an ops structure.
>=20
> =EF=BB=BFI agree that the ops structure is unnecessary.
> To make the als_sys class more generic, we just need to
> 1. defines the generic attributes that the native ALS driver must
> follow.
> 2. registers an als device in the als_sys class.
> and the native driver should be responsible for the sysfs attributes.
Yup.=20
> Because my approach is made by reading the ACPI spec, I'm not sure wh=
at
> should be done in the native driver and what should be done in the
> generic driver at the beginning.
=46or now I'd be tempted to keep as little as possible in the generic
driver and start moving stuff in only once a particular element
is verified to be relevant to almost every device.
>=20
> thanks for pointing this out.
>=20
>>  For example, I'm not convinced it makes sense for
>> drivers to have to have a get_adjustment attribute or indeed even
>> necessarily have a direct illuminance attribute (deriving the releva=
nt
>> value may be a case of userspace combining several associated
>> readings).
>=20
> what these associated readings are?
> I think we can define some optional attributes besides the required
> attributes.
Agreed.
> but we should make clear what is necessary for an ALS device, and wha=
t
> optional features it may support.
Yes,

=46or now I'd be inclined to stick to the ability to read illuminance=20
in some specified unit.  Perhaps some other flag to specify something
about the frequency range of the sensor?

Maybe similar to hwmon approach allowing for multiple readings of a giv=
en
type?

illumiance[n]
illuminmance_type[n]

Everything else optional.  Actually I'm personally of the view everythi=
ng
should be optional as long as any close matches in functionality are gi=
ven
the same names.  It's up to userspace to figure out of the device suppo=
rts
what it wants to use.  Things that I can envisioned not meeting the abo=
ve
but still being appropriately placed within als:

* Device that simply tells you whether ambient is greater or less than
backlight value + some offset (perhaps with controllable offset).

* Weird and wonderful sensor types we can't even envision at this point=
 in
time!

Perhaps the trick is to document the 'required' parameters as being tho=
se
required without consulting the maintainer / mailing list then they can=
 be
adjusted over time as more device drivers are written.

This is definitely the sort of driver
where the fine grained power management stuff should be encouraged.  Af=
ter
all not a lot of point in having them powered up if the screen is off!
As ever whether people put this stuff in is up to them.  Others can alw=
ays
submit patches adding it drivers at a later date.

>=20
> thanks,
> rui

Thanks for your work on this. Will certainly be nice to clean up the cu=
rrent
mess with light sensors all over the place!

Jonathan
=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
