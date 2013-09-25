From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v3 0/4] Fix Win8 backlight issue
Date: Wed, 25 Sep 2013 13:41:28 +0300
Message-ID: <87vc1p4207.fsf@intel.com>
References: <1380016052-15315-1-git-send-email-aaron.lu@intel.com> <1380026575.3371.1.camel@ThinkPad-X230.localdomain> <CADDKRnCAZ0DtBUUaMfdTF=yk6PDLpbc9jkuvWWO8hYW4TDLxKw@mail.gmail.com> <20130925091720.GA1921@aaronlu.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130925091720.GA1921@aaronlu.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, =?utf-8?Q?J=C3=B6rg?= Otte <jrg.otte@gmail.com>
Cc: Igor Gnatenko <i.gnatenko.brain@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <matthew.garrett@nebula.com>, Seth Forshee <seth.forshee@canonical.com>, Lee Chun-Yi <joeyli.kernel@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Yves-Alexis Perez <corsac@debian.org>, Felipe Contreras <felipe.contreras@gmail.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Ben Jencks <ben@bjencks.net>, Steven Newbury <steve@snewbury.org.uk>, James Hogan <james@albanarts.com>, Kamal Mostafa <kamal@canonical.com>, Joerg Platte <jplatte@naasa.net>, Kalle Valo <kvalo@adurom.com>, Martin Steigerwald <Martin@lichtvoll.de>, Mike Galbraith <bitbucke>
List-Id: linux-acpi@vger.kernel.org

On Wed, 25 Sep 2013, Aaron Lu <aaron.lu@intel.com> wrote:
> On Wed, Sep 25, 2013 at 10:29:37AM +0200, J=C3=B6rg Otte wrote:
>> Backlight can't be modified with this patch set - neither with
>> function keys nor with the gui. It is a step backward to v3.11-rc1

So both hotkeys and GUI work in v3.11-rc1? And v3.12-rc2?

> Thanks for the test.
>
> Please check /sys/class/backlight, is there only one link file
> intel_backlight?

Indeed, are there others? fujitsu-laptop perhaps? If yes, try
CONFIG_FUJITSU_LAPTOP=3Dn or an appropriate module blacklist.

Just checking, you do have CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy?
Embarrassingly there was a bug in i915 fixed just recently where the
backlight device wasn't registered for
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dm...

> If so, please cd inside and try modify the brightness file using echo
> with some values in the range of 0 - max_brightness, does the
> backlight level change when you echo a new value? I guess it doesn't,
> or you wouldn't notice problem. If indeed so, perhaps file a bug at
> http://bugzilla.kernel.org, Drivers/Video(DRI-Intel)? I suppose Jani
> and Daniel can help fix your problem.

Yup, please check the above, and report back.

BR,
Jani.


>
> Thanks,
> Aaron
>
>>=20
>> Video driver: i915
>> FUJITSU LIFEBOOK AH532/FJNBB1C, BIOS Version 1.09 05/22/2012
>>=20
>> acpi_backlight=3Dvideo works.
>>=20
>> J=C3=B6rg
>>=20
>>=20
>> 2013/9/24 Igor Gnatenko <i.gnatenko.brain@gmail.com>
>>=20
>> > On Tue, 2013-09-24 at 17:47 +0800, Aaron Lu wrote:
>> > > v3:
>> > > 1 Add a new patch 4/4 to fix some problems in thinkpad-acpi modu=
le;
>> > > 2 Remove unnecessary function acpi_video_unregister introduced i=
n
>> > >   patch 2/3 as pointed out by Jani Nikula.
>> > >
>> > > v2:
>> > > v1 has the subject of "Rework ACPI video driver" and is posted h=
ere:
>> > > http://lkml.org/lkml/2013/9/9/74
>> > > Since the objective is really to fix Win8 backlight issues, I ch=
anged
>> > > the subject in this version, sorry about that.
>> > >
>> > > This patchset has three patches, the first introduced a new API =
named
>> > > backlight_device_registered in backlight layer that can be used =
for
>> > > backlight interface provider module to check if a specific type =
backlight
>> > > interface has been registered, see changelog for patch 1/3 for d=
etails.
>> > > Then patch 2/3 does the cleanup to sepeate the backlight control=
 and
>> > > event delivery functionality in the ACPI video module and patch =
3/3
>> > > solves some Win8 backlight control problems by avoiding register=
 ACPI
>> > > video's backlight interface if:
>> > > 1 Kernel cmdline option acpi_backlight=3Dvideo is not given;
>> > > 2 This is a Win8 system;
>> > > 3 Native backlight control interface exists.
>> > >
>> > > Technically, patch 2/3 is not required to fix the issue here. So=
 if you
>> > > think it is not necessary, I can remove it from the series.
>> > >
>> > > Aaron Lu (4):
>> > >   backlight: introduce backlight_device_registered
>> > >   ACPI / video: seperate backlight control and event interface
>> > >   ACPI / video: Do not register backlight if win8 and native int=
erface
>> > >     exists
>> > >   thinkpad-acpi: fix handle locate for video and query of _BCL
>> > >
>> > >  drivers/acpi/internal.h              |   5 +-
>> > >  drivers/acpi/video.c                 | 442
>> > ++++++++++++++++++++---------------
>> > >  drivers/acpi/video_detect.c          |  14 +-
>> > >  drivers/platform/x86/thinkpad_acpi.c |  31 ++-
>> > >  drivers/video/backlight/backlight.c  |  31 +++
>> > >  include/acpi/video.h                 |   2 +
>> > >  include/linux/backlight.h            |   4 +
>> > >  7 files changed, 324 insertions(+), 205 deletions(-)
>> > >
>> >
>> > Excellent! I've tested this patch-set on ThinkPad X230 and backlig=
ht
>> > issue is exhausted.
>> >
>> > Thanks.
>> >
>> > --
>> > Igor Gnatenko
>> > Fedora release 20 (Heisenbug)
>> > Linux 3.11.1-300.fc20.x86_64
>> >
>> >

--=20
Jani Nikula, Intel Open Source Technology Center
