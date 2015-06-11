From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 07/32] acpi-video-detect: Rewrite backlight interface
 selection logic
Date: Thu, 11 Jun 2015 14:01:27 +0200
Message-ID: <20150611120127.GE19820@pali>
References: <1433941292-21530-1-git-send-email-hdegoede@redhat.com>
 <1433941292-21530-8-git-send-email-hdegoede@redhat.com>
 <20150611091922.GB19820@pali>
 <557954F4.3050709@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <557954F4.3050709@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 11 June 2015 11:29:24 Hans de Goede wrote:
> Hi,
>=20
> On 11-06-15 11:19, Pali Roh=C3=A1r wrote:
> >On Wednesday 10 June 2015 15:01:07 Hans de Goede wrote:
> >>Currently we have 2 kernel commandline options + dmi-quirks in 3 pl=
aces all
> >>interacting (in interesting ways) to select which which backlight i=
nterface
> >>to use. On the commandline we've acpi_backlight=3D[video|vendor] an=
d
> >>video.use_native_backlight=3D[0|1]. DMI quirks we have in
> >>acpi/video-detect.c, acpi/video.c and drivers/platform/x86/*.c .
> >>
> >>This commit is the first step to cleaning this up, replacing the 2 =
cmdline
> >>options with just acpi_video.backlight=3D[video|vendor|native|none]=
, and
> >>adding a new API to video_detect.c to reflect this.
> >>
> >>Follow up commits will also move other related code, like unregiste=
ring the
> >>acpi_video backlight interface if it was registered before other dr=
ivers
> >>which take priority over it are loaded, to video_detect.c where thi=
s
> >>logic really belongs.
> >>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >
> >Hello,
> >
> >lot of people are using acpi_backlight parameter in kernel cmdline t=
o
> >fix some of problems. I would like to see this parameter still worki=
ng
> >and to not break existing configuration. E.g acpi_backlight=3Dvendor=
 to
> >use dell-laptop.ko or thinkpad_acpi.ko backlight.
>=20
> I would have like to keep acpi_backlight=3D for that exact same reaso=
n,
> but that is not possible while keeping acpi_video as a module.
>=20
> Thinking more about this, this is not strictly true, we could make
> some other (core) part of the acpi code use __setup to get the
> acpi_backlight=3D value and have that part export the value for use
> in the acpi_video module. This is not really pretty, but I think it
> may be the best way to solve this.
>=20

This solution should work. It is not nice, but current mess of backligh=
t
drivers, acpi, etc, is not nice too. It will help users who already kno=
w
(or read on internet/forums/discussions) acpi_backlight=3D parameter...

> >It is still nightmare to get laptop panel backlight working on diffe=
rent
> >(broken) laptops
>=20
> Well one reason it is a nightmare is because there are too many
> backlight drivers fighting for control and there is not an easy
> way to tell the kernel only register this one, this is exactly
> what this patch-set is trying to address :)  People may still
> need to use a cmdline option but now there is only one option to
> play with.
>=20

It is not only that. Sometimes there are three possible ways how to
control backlight (vendor driver, acpi driver, gpu driver). And all
those driver can work, but some of them works "better".

E.g in my case on Dell Latitude E6440 all three drivers can register
backlight interface and export it to userspace via sysfs.

But the best option for *me* is to use one from dell-laptop.ko because
it has good granularity of levels for controlling backlight. Intel one
has too many levels and does not fit some linear distribution (which I
would like to see). ACPI video.ko sometimes does not work correctly wit=
h
KDE4 setting -- sometimes I need to press brightness key more times to
take effect. I do not know if this is problem of KDE or ACPI or
whatever. For me for my current desktop & kernel setup is the best
solution to use dell-laptop.ko with acpi_backlight=3Dvendor param. I do
not have to debug or change anything, just add one param to cmdline.

And I think other users (without programming knowledge) who need
immediately working laptop will use same option as me.

> > and people learnt to try to use acpi_backlight
> > parameter for quit/hot fixing these problems.
>=20
> People who need to pass a kernel commandline option really should
> report a bug once they have figured out what option to use.
>=20

This is good assumption, but do not forget that there are people who:

1) do not have time to trying find out where to report bug and how
2) do not know how to report bug
3) even do not know that they can do something (like for MS systems)

> Fedora users are getting pretty good at this as the Fedora kernel
> maintainers punt all such bug reports to me and I properly deal
> with them verifying the users solution is sane and then submitting
> a patch with a dmi based quirk for the users laptop upstream.
>=20
> > Upgrading kernel (if you
> >remove acpi_backlight parameter) just break it again.
>=20
> I think that is actually (partially) a good thing, as said people
> who rely on cmdline workarounds should file bugs, so that we can
> add a quirk. Had the users done so, the quirk would be long in
> place and the changing of the cmdline option name would not be
> an issue for them.
>=20
> I realize that this knife cuts both ways, and that this will
> cause unhappy users, as said if it had been possible to not change
> the cmdline option name in a clean way I would have done so.
>=20
> If everyone agrees with the solution I've outlined above, we
> can actually make it so as to not break things for users
> who's setup relies on acpi_backlight=3Dfoo
>=20
> Regards,
>=20
> Hans

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
