From: "Joey Lee" <jlee@novell.com>
Subject: Re: [RFC] Shutdown on thermal HOT event if no userspace tool
	 registered being able to do S4
Date: Thu, 01 Apr 2010 07:18:57 -0600
Message-ID: <4BB537F10200002300015C07@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kay.sievers@suse.de, trenn@suse.de
Cc: rui.zhang@intel.com, hmacht@suse.de, rwysocki@suse.de, linux-acpi@vger.kernel.org

Hi Thomas,=20

=E6=96=BC =E4=BA=8C=EF=BC=8C2010-03-30 =E6=96=BC 17:31 +0100=EF=BC=8CTh=
omas Renninger =E6=8F=90=E5=88=B0=EF=BC=9A
> On Tuesday 30 March 2010 18:12:40 Joey Lee wrote:
> > Hi Thomas,=20
> >=20
> > =E6=96=BC =E4=BA=8C=EF=BC=8C2010-03-30 =E6=96=BC 10:23 +0100=EF=BC=8C=
Thomas Renninger =E6=8F=90=E5=88=B0=EF=BC=9A
> > > Hi,
> ...
> > > Comments?
> > > What userspace tools are candidates to implement this if this
> > > makes sense?
> > >=20
> >=20
> > HAL + pm-util or DeviceKit-power might the candidates. But, if ther=
e
> > have no those component in userland, what will acpi thermal module =
do?
> > Direct shutdown?
> > And, how can kernel space know userland can do this job well? Might=
 wait
> > 10 seconds if system doesn't S4 or shutdown?
> Yep, my idea is to e.g. provide:
> /sys/class/thermal/S4_capable
> By default you get:
> cat /sys/class/thermal/S4_capable
> 0
> and the thermal driver will call the same shutdown method
> if the hot thermal tp is reached as if the critical is reached.
>=20
> If pm-utils does:
> echo 1 >/sys/class/thermal/S4_capable
> it has to make sure it picks up acpi thermal hot event and initiates
> S4. If S4 fails for whatever reasons (no swap,
> stroking some kernel drivers fails, unmounting file systems fails, ..=
=2E),
> it has to make sure to force a system shutdown (just call /sbin/power=
off
> the same way the kernel does currently with a critical thermal event?=
).
> Emergency shutdown is then out of kernels hand (as it is currently fo=
r HOT
> anyway which is dangerous).
>=20
> Hmm, this is acpi specific, possibly it should be a new dir here:
> /sys/firmware/acpi/thermal/S4_capable
> or something else?
>=20

Your idea looks good to me, but, the DeviceKit-power will rename to
upower, and Kay is the udev expert.
I think will need kay's professional comment on udev side.


Hi Kay,=20

We are discussing about how to handle the situtation if BIOS ACPI didn'=
t
return the _CRT value, and even have _HOT value, if S4 fail, what can w=
e
do on kernel space and userland.

_CRT value is the shutdown critical temperature
_HOT value is the critical temperature for sleep (entry to S4)

Per ACPI spec:
The platform vendor should define _HOT to be far enough below _CRT so a=
s
to allow OSPM enough time to transition the system into the S4 sleeping
state.

Currently, there have a bit platform provider (OEM/ODM) only return the
_HOT, but didn't have _CRT value. But, if _HOT S4 fail, the system
components might dangerous if there have no any hardware protected
Mechanism.

Thomas's idea is add a sysfs interface /sys/class/thermal/S4_capable fo=
r
userland to tell kernel userland component (pm-util or upower?) already
take the _HOT event and try to do S4.

How do you think about this idea?


Thank's
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
