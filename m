From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] ACPI / Video: blacklist some samsung laptops
Date: Sun, 8 Jan 2012 14:40:29 +0100
Message-ID: <20120108134029.GA7708@ubuntu-mba>
References: <20120105150832.GA25386@ubuntu-macmini>
 <1325945558-4661-1-git-send-email-corentincj@iksaif.net>
 <20120108104630.GA4354@ubuntu-mba>
 <CAHR064h287UFd4bBnWCJz61qw-wZBYRrF=5FKAmFg8YwaWN1Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHR064h287UFd4bBnWCJz61qw-wZBYRrF=5FKAmFg8YwaWN1Zw@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Corentin Chary <corentincj@iksaif.net>, platform-driver-x86@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Andrzej Prochyra <andrzej@prochyra.name>, Matthew Garrett <mjg59@srcf.ucam.org>, David Herrmann <dh.herrmann@googlemail.com>, Richard =?utf-8?Q?Sch=C3=BCtz?= <r.schtz@t-online.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Jan 08, 2012 at 01:36:45PM +0100, Corentin Chary wrote:
> On Sun, Jan 8, 2012 at 11:46 AM, Seth Forshee
> <seth.forshee@canonical.com> wrote:
> > On Sat, Jan 07, 2012 at 03:12:38PM +0100, Corentin Chary wrote:
> >> On these laptops, the ACPI video is not functional, and very unlik=
ely
> >> to be fixed by the vendor. Note that intel_backlight works for som=
e
> >> of these laptops, and the backlight from samsung-laptop always wor=
k.
> >>
> >> The good news is that newer laptops have functional ACPI video dev=
ice
> >> and won't end up growing this list.
> >>
> >> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
> >> ---
> >>
> >> Could the concerned people test this patch and check that it corre=
ctly
> >> disable the acpi_video backlight ?
> >>
> >> =C2=A0drivers/acpi/video_detect.c | =C2=A0 40 ++++++++++++++++++++=
++++++++++++++++++++
> >> =C2=A01 files changed, 40 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_dete=
ct.c
> >> index 45d8097..376bce2 100644
> >> --- a/drivers/acpi/video_detect.c
> >> +++ b/drivers/acpi/video_detect.c
> >> @@ -132,6 +132,44 @@ find_video(acpi_handle handle, u32 lvl, void =
*context, void **rv)
> >> =C2=A0 =C2=A0 =C2=A0 return AE_OK;
> >> =C2=A0}
> >>
> >> +/* Force to use vendor driver when the ACPI device is known to be
> >> + * buggy */
> >> +static int video_detect_force_vendor(const struct dmi_system_id *=
d)
> >> +{
> >> + =C2=A0 =C2=A0 acpi_video_support |=3D ACPI_VIDEO_BACKLIGHT_DMI_V=
ENDOR;
> >> + =C2=A0 =C2=A0 return 0;
> >> +}
> >> +
> >> +static struct dmi_system_id video_detect_dmi_table[] =3D {
> >> + =C2=A0 =C2=A0 {
> >> + =C2=A0 =C2=A0 =C2=A0.callback =3D video_detect_force_vendor,
> >> + =C2=A0 =C2=A0 =C2=A0.ident =3D "N150P",
> >> + =C2=A0 =C2=A0 =C2=A0.matches =3D {
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_SYS_VEND=
OR, "SAMSUNG ELECTRONICS CO., LTD."),
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_PRODUCT_=
NAME, "N150P"),
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_BOARD_NA=
ME, "N150P"),
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
> >> + =C2=A0 =C2=A0 },
> >> + =C2=A0 =C2=A0 {
> >> + =C2=A0 =C2=A0 =C2=A0.callback =3D video_detect_force_vendor,
> >> + =C2=A0 =C2=A0 =C2=A0.ident =3D "N145P/N250P/N260P",
> >> + =C2=A0 =C2=A0 =C2=A0.matches =3D {
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_SYS_VEND=
OR, "SAMSUNG ELECTRONICS CO., LTD."),
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_PRODUCT_=
NAME, "N145P/N250P/N260P"),
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_BOARD_NA=
ME, "N145P/N250P/N260P"),
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
> >> + =C2=A0 =C2=A0 },
> >> + =C2=A0 =C2=A0 {
> >> + =C2=A0 =C2=A0 =C2=A0.callback =3D video_detect_force_vendor,
> >> + =C2=A0 =C2=A0 =C2=A0.ident =3D "N150/N210/N220",
> >> + =C2=A0 =C2=A0 =C2=A0.matches =3D {
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_SYS_VEND=
OR, "SAMSUNG ELECTRONICS CO., LTD."),
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_PRODUCT_=
NAME, "N150/N210/N220"),
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_BOARD_NA=
ME, "N150/N210/N220"),
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
> >> + =C2=A0 =C2=A0 },
> >> +};
> >> +
> >
> > I don't see NF110/NF210/NF310 in this list. Was that an oversight?
>=20
> Ooops. Could you add it and try the patch, then send me lines you add=
ed ?
> Thanks,

Sure, but it won't be until next week. I'm travelling this week and
don't have the machine with me.
