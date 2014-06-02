From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH resend 2/4] backlight: Add backlight device
 (un)registration notification
Date: Mon, 2 Jun 2014 08:33:26 +0100
Message-ID: <20140602073326.GB4319@lee--X1>
References: <1400679596-19663-1-git-send-email-hdegoede@redhat.com>
 <538323A3.1050209@redhat.com>
 <20140527092033.GF5875@lee--X1>
 <3320448.t5cXUpNSer@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:54535 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020AbaFBHdd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Jun 2014 03:33:33 -0400
Received: by mail-ig0-f173.google.com with SMTP id hn18so3025004igb.12
        for <linux-acpi@vger.kernel.org>; Mon, 02 Jun 2014 00:33:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3320448.t5cXUpNSer@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Hans de Goede <hdegoede@redhat.com>, Jingoo Han <jg1.han@samsung.com>, 'Aaron Lu' <aaron.lu@intel.com>, 'Bryan Wu' <cooloney@gmail.com>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Ben Skeggs' <bskeggs@redhat.com>, 'David Airlie' <airlied@linux.ie>, 'Zhang Rui' <rui.zhang@intel.com>, 'Len Brown' <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Sun, 01 Jun 2014, Rafael J. Wysocki wrote:
> On Tuesday, May 27, 2014 10:20:33 AM Lee Jones wrote:
> > > On 05/26/2014 01:03 PM, Rafael J. Wysocki wrote:
> > > > On Monday, May 26, 2014 12:03:43 PM Jingoo Han wrote:
> > > >> On Thursday, May 22, 2014 6:02 PM, Lee Jones wrote:
> > > >>> On Thursday, May 22, 2014 5:45 PM, Hans de Goede wrote:
> > > >>>> On Thursday, May 22, 2014 8:31 AM, Rafael J. Wysocki wrote:
> > > >>>>> On Wednesday, May 21, 2014 10:40 PM, Hans de Goede wrote:
> > > >>>>>> Some firmware drivers, ie acpi-video want to get themselve=
s out of the
> > > >>>>>> way (in some cases) when their also is a raw backlight dev=
ice available.
> > > >>>>>>
> > > >>>>>> Due to module loading ordering being unknown, acpi-video c=
annot be certain
> > > >>>>>> that the backlight_device_registered(BACKLIGHT_RAW) it doe=
s for this is
> > > >>>>>> the final verdict wrt there being a BACKLIGHT_RAW device.
> > > >>>>>>
> > > >>>>>> By adding notification acpi-video can listen for backlight=
 devices showing
> > > >>>>>> up after it has loaded, and unregister its backlight devic=
e if desired.
> > > >>>>>>
> > > >>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > >>>>>
> > > >>>>> Backlight maintainer's ACK is requisite here.
> > > >>>>
> > > >>>> Agreed, which is why I send this set to all 3 the backlight =
maintainers
> > > >>>> directly on both postings.
> > > >>>>
> > > >>>> What may be helpful for them is to hear from you if you're o=
k with the
> > > >>>> acpi-video bits which are actually going to use this, since =
those will
> > > >>>> be the only user of the new backlight api (for now).
> > > >>>
> > > >>> I'm happy to apply any Backlight patches which have either Br=
yan or
> > > >>> Jingoo's Ack, as they are the reviewers for the BL subsystem.
> > > >>
> > > >> Acked-by: Jingoo Han <jg1.han@samsung.com>
> > > >>
> > > >> Lee Jones,
> > > >> Would you merge this patch into your backlight git tree?
> > > >=20
> > > > Hans, does this series depend on things that I've applied alrea=
dy?  If so,
> > > > I'd very much prefer to take this series too as a whole.
> > >=20
> > > The 3th patch in this series:
> > > " acpi-video: Unregister the backlight device if a raw one shows =
up later"
> > > depends on my "acpi-video: Add an acpi_video_unregister_backlight=
 function"
> > > patch, which you've applied to your linux-next branch already.
> > >=20
> > > As well as on the 2nd patch in this series:
> > > "backlight: Add backlight device (un)registration notification"
> > >=20
> > > So I agree that it is a good idea to take the whole series throug=
h your tree.
> >=20
> > I'm fine with that.
> >=20
> > Rafael, could you apply the set onto an immutable branch and send m=
e a
> > signed pull-request please?
>=20
> You can find this patch on the branch at
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acp=
i-video
>=20
> The top-most commit is 0dc6b96ac20c (ACPI / video: Add 4 new models t=
o the
> use_native_backlight DMI list).
>=20
> Please feel free to pull from there if necessary, it is not going to =
be rebased.

acpi-video contains 14 patches!  If we share patches in the future,
the branches really need to contain as few patches as possible.  I'm
happy to set-up a special 'mfd-pm' immutable branch for future
releases to save either one of use pulling in more patches into our
respective trees than is necessary.

Rather than pull all those patches in to the MFD tree, I'll simply run
the risk of a merge conflict this time.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
