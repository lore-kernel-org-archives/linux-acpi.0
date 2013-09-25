From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v3 0/4] Fix Win8 backlight issue
Date: Wed, 25 Sep 2013 19:17:04 +0300
Message-ID: <87eh8clvun.fsf@intel.com>
References: <1380016052-15315-1-git-send-email-aaron.lu@intel.com> <1380026575.3371.1.camel@ThinkPad-X230.localdomain> <CADDKRnCAZ0DtBUUaMfdTF=yk6PDLpbc9jkuvWWO8hYW4TDLxKw@mail.gmail.com> <20130925091720.GA1921@aaronlu.sh.intel.com> <87vc1p4207.fsf@intel.com> <CADDKRnDqDBfA6e6TE0VTLD9F=TjVZNov53Zk8ydnk2fS32rczQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADDKRnDqDBfA6e6TE0VTLD9F=TjVZNov53Zk8ydnk2fS32rczQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?J=C3=B6rg?= Otte <jrg.otte@gmail.com>
Cc: Aaron Lu <aaron.lu@intel.com>, Igor Gnatenko <i.gnatenko.brain@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <matthew.garrett@nebula.com>, Seth Forshee <seth.forshee@canonical.com>, Lee Chun-Yi <joeyli.kernel@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Yves-Alexis Perez <corsac@debian.org>, Felipe Contreras <felipe.contreras@gmail.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Ben Jencks <ben@bjencks.net>, Steven Newbury <steve@snewbury.org.uk>, James Hogan <james@albanarts.com>, Kamal Mostafa <kamal@canonical.com>, Joerg Platte <jplatte@naasa.net>, Kalle Valo <kvalo@adurom.com>, Martin Steigerwald <Martin@lichtvol>
List-Id: linux-acpi@vger.kernel.org

On Wed, 25 Sep 2013, J=C3=B6rg Otte <jrg.otte@gmail.com> wrote:
> 2013/9/25 Jani Nikula <jani.nikula@linux.intel.com>:
>> On Wed, 25 Sep 2013, Aaron Lu <aaron.lu@intel.com> wrote:
>>> On Wed, Sep 25, 2013 at 10:29:37AM +0200, J=C3=B6rg Otte wrote:
>>>> Backlight can't be modified with this patch set - neither with
>>>> function keys nor with the gui. It is a step backward to v3.11-rc1
>>
>> So both hotkeys and GUI work in v3.11-rc1? And v3.12-rc2?
>
> In  v3.11-rc1 it didn't work.
> Since a later rc (I don't remember exactly which) it did work.
> In v3.12-rc1/2 it does work.
> In v3.12-rc2 + Aaron's patch set it again doesn't work.
>
>>
>>> Thanks for the test.
>>>
>>> Please check /sys/class/backlight, is there only one link file
>>> intel_backlight?
>>
>> Indeed, are there others? fujitsu-laptop perhaps? If yes, try
>> CONFIG_FUJITSU_LAPTOP=3Dn or an appropriate module blacklist.
>>
>> Just checking, you do have CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy?
>
> There is only one intel_backlight link.
> Yes, I have CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
>
>> Embarrassingly there was a bug in i915 fixed just recently where the
>> backlight device wasn't registered for
>> CONFIG_BACKLIGHT_CLASS_DEVICE=3Dm...
>>
>>> If so, please cd inside and try modify the brightness file using ec=
ho
>>> with some values in the range of 0 - max_brightness, does the
>>> backlight level change when you echo a new value? I guess it doesn'=
t,
>>> or you wouldn't notice problem. If indeed so, perhaps file a bug at
>>> http://bugzilla.kernel.org, Drivers/Video(DRI-Intel)? I suppose Jan=
i
>>> and Daniel can help fix your problem.
>>
>> Yup, please check the above, and report back.
>
> - echo 0..max_brightness > brightness does not work.

Thanks for the info.

How about v3.12-rc2 without Aaron's patches? Does intel_backlight also
not work there? How about the acpi_video0 (which I presume is present)
sysfs interface?

BR,
Jani.



>
>>>>
>>>> Video driver: i915
>>>> FUJITSU LIFEBOOK AH532/FJNBB1C, BIOS Version 1.09 05/22/2012
>>>>
>>>> acpi_backlight=3Dvideo works.
>
> J=C3=B6rg
