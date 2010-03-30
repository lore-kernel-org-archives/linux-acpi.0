From: "Joey Lee" <jlee@novell.com>
Subject: Re: [RFC] Shutdown on thermal HOT event if no userspace tool
	 registered being able to do S4
Date: Tue, 30 Mar 2010 10:12:40 -0600
Message-ID: <4BB2BDA8020000230001594B@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: rui.zhang@intel.com, hmacht@suse.de, rwysocki@suse.de, linux-acpi@vger.kernel.org

Hi Thomas,=20

=E6=96=BC =E4=BA=8C=EF=BC=8C2010-03-30 =E6=96=BC 10:23 +0100=EF=BC=8CTh=
omas Renninger =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi,
>=20
> this is related to:
> commit fa80945269f312bc609e8384302f58b03c916e12
>     ACPI thermal: Don't invalidate thermal zone if critical trip poin=
t is bad
> and
> commit 8b7ef6d8f16274da42344cd50746ddb1c93c25ea
>     ACPI thermal: Check for thermal zone requirement
>=20
> There the critical trip point is replaced with the hot trip
> point if latest Windows OS is detected (Vista also? I think yes,
> but need to double check).
>=20
> This seem to get more common and it looks like Windows suggests
> to use hot trip points for thermal emergency shutdowns (S4).
> It looks like the default Windows thermal emergency power off is
> S4. Thus the hot trip point is used and the critical trip point
> is of no use anymore (and often gets replaced or is invalid).
>=20

Sorry, I have didn't test it on Windows 7 by myself, but got informatio=
n
from ODM, the _CRT is still work on Windows 7.

And, the following is 2 point need discuss:
 - Not every OS all support S4, like: Moblin 2.x or MeeGo 1.x
 - If _HOT S4 fail, like disk full, then _CRT still very important to=20
   hardware component if there have no any hardware protect mechanism.

> As thermal emergency shut down is something urgent there is this
> direct call /sbin/poweroff in orderly_poweroff(true) compare with
> kernel/sys.c and drivers/thermal/thermal_sys.c
> This won't work in above cases when BIOS writers assume the machine
> is shut down with _HOT already and do not provide _CRT anymore.
>=20

Agreed! There have a bit BIOS didn't return _CRT value or return the
invalid _CRT value. We still need shutdown machine even on _HOT or _CRT=
=2E

> My idea is to also shutdown the system on _HOT by default,
> the same way as done if _CRT is exceeded as long as no userspace
> explicitly set a sysfs (only one file set by thermal_sys.c somewhere
> in /sys?).
> Background is that S4 needs some setup (e.g. swap) or userspace hooks
> to make sure S4 succeeds and everything (network, whatever...) is set
> up correctly afterwards.
>=20
> Requirement for the userspace tool setting the "do not shutdown if a
> hot thermal event happened" would be:
>   - Fetch the thermal hot event
>   - Reliably power off the system (shutdown if S4 did not succeed)
>   - ...
>=20
> Comments?
> What userspace tools are candidates to implement this if this
> makes sense?
>=20

HAL + pm-util or DeviceKit-power might the candidates. But, if there
have no those component in userland, what will acpi thermal module do?
Direct shutdown?=20
And, how can kernel space know userland can do this job well? Might wai=
t
10 seconds if system doesn't S4 or shutdown?


Thank's
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
