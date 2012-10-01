From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] acpi: fix brightness level is initialized to zero when
 BIOS does not restore the brightness value to _BQC.
Date: Mon, 01 Oct 2012 16:34:10 +0800
Message-ID: <1349080450.24232.35.camel@linux-s257.site>
References: <1349069987-23992-1-git-send-email-alex.hung@canonical.com>
	 <1349074033.24232.19.camel@linux-s257.site>
	 <50694027.5060902@canonical.com>
	 <1349075823.24232.30.camel@linux-s257.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:57009 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab2JAIk5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Oct 2012 04:40:57 -0400
In-Reply-To: <1349075823.24232.30.camel@linux-s257.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>
Cc: rui.zhang@intel.com, linux-acpi@vger.kernel.org

=E6=96=BC =E4=B8=80=EF=BC=8C2012-10-01 =E6=96=BC 15:17 +0800=EF=BC=8Cjo=
eyli =E6=8F=90=E5=88=B0=EF=BC=9A
> =E6=96=BC =E4=B8=80=EF=BC=8C2012-10-01 =E6=96=BC 15:03 +0800=EF=BC=8C=
Alex Hung =E6=8F=90=E5=88=B0=EF=BC=9A
> > On 10/01/2012 02:47 PM, joeyli wrote:
> > > Hi Alex,
> > >
> > > =E6=96=BC =E4=B8=80=EF=BC=8C2012-10-01 =E6=96=BC 13:39 +0800=EF=BC=
=8CAlex Hung =E6=8F=90=E5=88=B0=EF=BC=9A
> > >> Signed-off-by: Alex Hung <alex.hung@canonical.com>
> > >> ---
> > >>   drivers/acpi/video.c |    4 ++++
> > >>   1 files changed, 4 insertions(+), 0 deletions(-)
> > >>
> > >> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> > >> index 42b226e..eaa9573 100644
> > >> --- a/drivers/acpi/video.c
> > >> +++ b/drivers/acpi/video.c
> > >> @@ -724,6 +724,10 @@ acpi_video_init_brightness(struct acpi_vide=
o_device *device)
> > >>   				if (level_old =3D=3D br->levels[i])
> > >>   					level =3D level_old;
> > >>   		}
> > >> +
> > >> +		if (level =3D=3D 0)
> > >> +			level =3D br->levels[(br->count) / 2 + 1];
> > >
> > > Looks here used the 50% brightness level.
> > >
> > > Per comment in video.c, we want set the backlight to max_level wh=
en
> > > level_old is invalid:
> > >
> > >          if (!br->flags._BQC_use_index) {
> > >                  /*
> > >                   * Set the backlight to the initial state.
> > >                   * On some buggy laptops, _BQC returns an uninit=
ialized value
> > >                   * when invoked for the first time, i.e. level_o=
ld is invalid.
> > >                   * set the backlight to max_level in this case
> > >                   */
> > >
> > > I think here used max_level to fulfill it, e.g.
> > > =09
> > > +		if (level =3D=3D 0)
> > > +			level =3D max_level;
> > >
> > > How do you think?
> > Hi Joey,
> >=20
> > I was debating with myself which level to be set, ex. 50%, ~75% or =
100%,=20
> > and I think 50% *might* be closer to normal use-case (just a person=
al=20
> > guess).
> >=20
> > However, "max_level" seems to fit best if we treat the initial zero=
=20
> > brightness in invalid. I can modify it according it that's preferre=
d.
> >=20
> > Thanks for the feedback.
> >=20
> > Cheers,
> > Alex Hung
> >=20
>=20
> hm.... I have a question for what's the BIOS's problem that causes
> 'level =3D=3D 0'?
> That implied the issue machine's max_level is 0?
>=20
> 		/*
> 		 * Set the level to maximum and check if _BQC uses indexed value
> 		 */
> 		result =3D acpi_video_device_lcd_set_level(device, max_level);		/* =
write max_level purposely, then read level back, compare them */
> 		...
> 		result =3D acpi_video_device_lcd_get_level_current(device, &level, =
0);
> 		...
> 		br->flags._BQC_use_index =3D (level =3D=3D max_level ? 0 : 1);
> 		if (!br->flags._BQC_use_index) {				/* _BQC_use_index is 0 will run=
 into if, means level =3D=3D max_level */
>=20
> So, looks the 'level =3D=3D max_level =3D=3D 0' when level_old is inv=
alid.
>=20
> Just wonder what's defect of BIOS (in _BCL?) causes problem.
>=20
>=20

Sorry for my misunderstood!

I think that's possible the level_old is 0 and there have a 0 value in
the return package from _BCL.=20

Could you please share the _BCL in DSDT from issue machine? Does there
have 0 value in _BCL?


Thanks a lot!
Joey Lee


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
