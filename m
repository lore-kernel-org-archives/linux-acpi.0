From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH 07/32] acpi-video-detect: Rewrite backlight interface selection logic
Date: Thu, 11 Jun 2015 15:28:52 +0300
Message-ID: <87bngm5szf.fsf@intel.com>
References: <1433941292-21530-1-git-send-email-hdegoede@redhat.com> <1433941292-21530-8-git-send-email-hdegoede@redhat.com> <20150611091922.GB19820@pali> <557954F4.3050709@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <557954F4.3050709@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Ike Panhc <ike.pan@canonical.com>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, acpi4asus-user@lists.sourceforge.net, "Rafael J. Wysocki" <rjw@rjwysocki.net>, dri-devel@lists.freedesktop.org, Azael Avalos <coproscefalo@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Mattia Dongili <malattia@linux.it>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Ben Skeggs <bskeggs@redhat.com>, Corentin Chary <corentin.chary@gmail.com>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, 11 Jun 2015, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 11-06-15 11:19, Pali Roh=C3=A1r wrote:
>> On Wednesday 10 June 2015 15:01:07 Hans de Goede wrote:
>>> Currently we have 2 kernel commandline options + dmi-quirks in 3 pl=
aces all
>>> interacting (in interesting ways) to select which which backlight i=
nterface
>>> to use. On the commandline we've acpi_backlight=3D[video|vendor] an=
d
>>> video.use_native_backlight=3D[0|1]. DMI quirks we have in
>>> acpi/video-detect.c, acpi/video.c and drivers/platform/x86/*.c .
>>>
>>> This commit is the first step to cleaning this up, replacing the 2 =
cmdline
>>> options with just acpi_video.backlight=3D[video|vendor|native|none]=
, and
>>> adding a new API to video_detect.c to reflect this.
>>>
>>> Follow up commits will also move other related code, like unregiste=
ring the
>>> acpi_video backlight interface if it was registered before other dr=
ivers
>>> which take priority over it are loaded, to video_detect.c where thi=
s
>>> logic really belongs.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Hello,
>>
>> lot of people are using acpi_backlight parameter in kernel cmdline t=
o
>> fix some of problems. I would like to see this parameter still worki=
ng
>> and to not break existing configuration. E.g acpi_backlight=3Dvendor=
 to
>> use dell-laptop.ko or thinkpad_acpi.ko backlight.
>
> I would have like to keep acpi_backlight=3D for that exact same reaso=
n,
> but that is not possible while keeping acpi_video as a module.
>
> Thinking more about this, this is not strictly true, we could make
> some other (core) part of the acpi code use __setup to get the
> acpi_backlight=3D value and have that part export the value for use
> in the acpi_video module. This is not really pretty, but I think it
> may be the best way to solve this.

It just might be a good idea to try to not change the backlight related
parameters all the time... See [1]. I probably forgot a few.

BR,
Jani.

[1] http://nikula.org/~jani/backlight/#index11h2


>
>> It is still nightmare to get laptop panel backlight working on diffe=
rent
>> (broken) laptops
>
> Well one reason it is a nightmare is because there are too many
> backlight drivers fighting for control and there is not an easy
> way to tell the kernel only register this one, this is exactly
> what this patch-set is trying to address :)  People may still
> need to use a cmdline option but now there is only one option to
> play with.
>
>  > and people learnt to try to use acpi_backlight
>  > parameter for quit/hot fixing these problems.
>
> People who need to pass a kernel commandline option really should
> report a bug once they have figured out what option to use.
>
> Fedora users are getting pretty good at this as the Fedora kernel
> maintainers punt all such bug reports to me and I properly deal
> with them verifying the users solution is sane and then submitting
> a patch with a dmi based quirk for the users laptop upstream.
>
>  > Upgrading kernel (if you
>> remove acpi_backlight parameter) just break it again.
>
> I think that is actually (partially) a good thing, as said people
> who rely on cmdline workarounds should file bugs, so that we can
> add a quirk. Had the users done so, the quirk would be long in
> place and the changing of the cmdline option name would not be
> an issue for them.
>
> I realize that this knife cuts both ways, and that this will
> cause unhappy users, as said if it had been possible to not change
> the cmdline option name in a clean way I would have done so.
>
> If everyone agrees with the solution I've outlined above, we
> can actually make it so as to not break things for users
> who's setup relies on acpi_backlight=3Dfoo
>
> Regards,
>
> Hans
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

--=20
Jani Nikula, Intel Open Source Technology Center
