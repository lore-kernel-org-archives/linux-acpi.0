From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [Intel-gfx] [RFC] i915/acpi: add lid status notification and
	detection
Date: Tue, 16 Jun 2009 21:08:42 +0200
Message-ID: <71cd59b00906161208lb7734a6yd148f9d1c496d905@mail.gmail.com>
References: <20090513115734.338b7d55@jbarnes-g45>
	 <1242264144.3773.415.camel@localhost.localdomain>
	 <20090519171545.GA17801@srcf.ucam.org>
	 <1242896273.32574.10.camel@rzhang-dt>
	 <20090521093418.3f1a03d5@jbarnes-g45>
	 <4A15FE57.7040002@linux.intel.com>
	 <20090527015801.2f47089f@jbarnes-x200>
	 <1244704587.3616.109.camel@localhost.localdomain>
	 <20090616113320.69fa477d@jbarnes-g45>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:46098 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760418AbZFPTIl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jun 2009 15:08:41 -0400
Received: by bwz9 with SMTP id 9so4300157bwz.37
        for <linux-acpi@vger.kernel.org>; Tue, 16 Jun 2009 12:08:42 -0700 (PDT)
In-Reply-To: <20090616113320.69fa477d@jbarnes-g45>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: yakui_zhao <yakui.zhao@intel.com>, Fu Michael <michael_fu@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "lenb@kernel.org" <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Tue, Jun 16, 2009 at 8:33 PM, Jesse Barnes<jbarnes@virtuousgeek.org>=
 wrote:
> On Thu, 11 Jun 2009 15:16:27 +0800
> yakui_zhao <yakui.zhao@intel.com> wrote:
>
>> On Wed, 2009-05-27 at 16:58 +0800, Jesse Barnes wrote:
>> > > >
>> > > Jesse, Just talked with Rui, =A0the above status is based on "BI=
OS
>> > > upgrade or FW fix is acceptable as a bug fix solution". are you =
ok
>> > > with this? :) Many lid status has to be fixed via action such as
>> > > DSDT upgrade...
>> >
>> > Yeah, I think that's ok, even if we need quirks for some
>> > platforms. =A0I really hate relying on BIOS vendors/OEMs to provid=
e
>> > BIOS updates in general: =A0if Windows works on a given platform, =
why
>> > should Linux require a BIOS "fix" on it? =A0In this case though, w=
e
>> > can work around broken platforms by just returning "open" all the
>> > time, if it comes to that.
>> Hi,
>> =A0 =A0 It is a good point that the LID status is used to decide whe=
ther
>> the LVDS is connected or not.
>> =A0 =A0 As Rui said in the previous thread, sometimes the initial st=
atus
>> of LID is incorrect on some laptops. If we expect that LVDS can be
>> initialized correctly on such boxes, we will have to add the quirk s=
o
>> that the LID status is not used for LVDS detection.
>> =A0 =A0But maybe on such boxes the LID initial status is correct aft=
er
>> BIOS upgrading or using custom DSDT. Do we need to delete the quirk
>> for such box? =A0It is difficult to manage.
>>
>> =A0 =A0So IMO we had better not use the LID status to determine whet=
her
>> the LVDS is connected or not.
>
> Well, what should we use then? =A0Think of a common use case: you plu=
g in
> an external monitor and shut your lid. =A0Do we want to make the user
> manually change their configuration? =A0Or detect that the lid is no
> longer in use? =A0And what about the case where they boot with the li=
d
> closed (e.g. in a docked scenario)? =A0We want to support that
> automatically too...

Just another use case for this patch :
Michael Ringe recently sended me a patch to handle backlight power in
eeepc-laptop.

> There is another minor problem I could not solve. When the lid is clo=
sed, the
> status of the backlight device driver is not updated, so reading from
> /sys/class/backlight/eeepc/bl_power still yields 0 (=3Dpower on). Or,=
 if you
> switch off the backlight and then close and reopen the lid, the backl=
ight is on,
> but the driver still thinks it's off. If you reboot in this status, t=
he notebook
> will come up with the backlight switched off, and you have to press F=
n-F7 to
> switch it on.

> To solve this problem, eeepc-laptop would need to register a notifica=
tion handler
> with \_SB.LIB. But this is not possible because a handler is already =
registered by
> the acpi button driver. Maybe there is a way too register a handler w=
ith the button driver?

We ended up with an input handler, checking on SW_LID, but it's not
very clean, and
 I'd better use your patch.

--=20
Corentin Chary
http://xf.iksaif.net - http://uffs.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
