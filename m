From: "Joey Lee" <jlee@novell.com>
Subject: Re: bug in acer-wmi.c, wmid3_set_device_status(),
 initialization of params.
Date: Tue, 31 May 2011 00:12:45 -0600
Message-ID: <4DE5137D020000230002D4B2@novprvlin0050.provo.novell.com>
References: <4DE4FF2B020000230002D493@novprvlin0050.provo.novell.com>
 <20110531051042.GA3083@joerntop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20110531051042.GA3083@joerntop>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@joern.heissler.de
Cc: Joey Lee <JLee@novell.com>, linux-acpi@vger.kernel.org

=E6=96=BC =E4=BA=8C=EF=BC=8C2011-05-31 =E6=96=BC 17:10 +1200=EF=BC=8CJo=
ern Heissler =E6=8F=90=E5=88=B0=EF=BC=9A
> On Mon, May 30, 2011 at 10:46:03PM -0600, Joey Lee wrote:
> > Hi Joern,=20
> >=20
> > =E6=96=BC =E4=B8=80=EF=BC=8C2011-05-30 =E6=96=BC 21:39 -0600=EF=BC=8C=
Joey Lee =E6=8F=90=E5=88=B0=EF=BC=9A
> > > Hi Joern,=20
> > >=20
> > > =E6=96=BC =E4=BA=8C=EF=BC=8C2011-05-31 =E6=96=BC 15:03 +1200=EF=BC=
=8CJoern Heissler =E6=8F=90=E5=88=B0=EF=BC=9A
> > > > Hello,
> > > >=20
> > > > I think I have found a bug in acer-wmi.c,
> > > > commit 987dfbaa65b2c3568b85e29d2598da08a011ee09:
> > > >=20
> > > > The function wmid3_set_device_status contains:
> > > >=20
> > > >     struct wmid3_gds_input_param params =3D {
> > > >         .function_num =3D 0x1,
> > > >         .hotkey_number =3D 0x01,
> > > >         .devices =3D ACER_WMID3_GDS_WIRELESS &
> > > >                 ACER_WMID3_GDS_THREEG &
> > > >                 ACER_WMID3_GDS_WIMAX &
> > > >                 ACER_WMID3_GDS_BLUETOOTH,
> > > >     };
> > > >=20
> > > > (1<<0) & (1<<6) & (1<<7) & (1<<11) is zero. Meant bitwise or?
> > > >=20
> > >=20
> > > OK, it's my mistake, must be OR but not AND.
> > > I will generate a fix patch, I will test it again, please kindly =
help
> > > test it later.
> > >=20
> >=20
> > Please kindly help to review this patch for bitwise bug:
> >=20
> >=20
> > >From 57756e3f0c727b07314485833e4b9b557bf158ce Mon Sep 17 00:00:00 =
2001
> > From: Lee, Chun-Yi <jlee@novell.com>
> > Date: Tue, 31 May 2011 12:36:09 +0800
> > Subject: [PATCH] acer-wmi: fix bitwise bug when set device state
> >=20
> > Fix a bitwise bug that was found by Joern Heissler, it must be OR
> > but not AND when we query current device state.
> >=20
> > Cc: Joern Heissler <linux-acpi@joern.heissler.de>
> > Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
> > ---
> >  drivers/platform/x86/acer-wmi.c |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86=
/acer-wmi.c
> > index 005417b..7d4675a 100644
> > --- a/drivers/platform/x86/acer-wmi.c
> > +++ b/drivers/platform/x86/acer-wmi.c
> > @@ -1156,9 +1156,9 @@ static acpi_status wmid3_set_device_status(u3=
2 value, u16 device)
> >  	struct wmid3_gds_input_param params =3D {
> >  		.function_num =3D 0x1,
> >  		.hotkey_number =3D 0x01,
> > -		.devices =3D ACER_WMID3_GDS_WIRELESS &
> > -				ACER_WMID3_GDS_THREEG &
> > -				ACER_WMID3_GDS_WIMAX &
> > +		.devices =3D ACER_WMID3_GDS_WIRELESS |
> > +				ACER_WMID3_GDS_THREEG |
> > +				ACER_WMID3_GDS_WIMAX |
> >  				ACER_WMID3_GDS_BLUETOOTH,
> >  	};
> >  	struct acpi_buffer input =3D {
> > --=20
> > 1.6.0.2
>=20
> The patch looks good and works in my heavily stripped-down version of
> acer-wmi.c.
>=20

Thank's for your review, will send out patch to 3.0-rc2

Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
