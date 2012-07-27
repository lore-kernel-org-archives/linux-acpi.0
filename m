From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] drm/radeon: add new AMD ACPI header and update
 relevant code
Date: Fri, 27 Jul 2012 23:36:46 +0800
Message-ID: <1343403406.1788.27.camel@linux-s257.site>
References: <1343237889-5220-1-git-send-email-alexdeucher@gmail.com>
	 <20120726125838.GA28853@growl> <1343357441.8142.18.camel@linux-s257.site>
	 <CADnq5_Mz5cjyYZ=1gjq+iaGtizhckKBL23gLaNJQFAPXHGF4TQ@mail.gmail.com>
	 <1343364410.8142.42.camel@linux-s257.site>
	 <CADnq5_PZoRGAs+cYAA+x3XEDF622xHoMD9msOqvp_XH68Bv_9g@mail.gmail.com>
	 <1343403127.1788.26.camel@linux-s257.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:45203 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678Ab2G0PjX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jul 2012 11:39:23 -0400
In-Reply-To: <1343403127.1788.26.camel@linux-s257.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>, airlied@gmail.com, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

=E6=96=BC =E4=BA=94=EF=BC=8C2012-07-27 =E6=96=BC 23:32 +0800=EF=BC=8Cjo=
eyli =E6=8F=90=E5=88=B0=EF=BC=9A
> =E6=96=BC =E4=BA=94=EF=BC=8C2012-07-27 =E6=96=BC 09:21 -0400=EF=BC=8C=
Alex Deucher =E6=8F=90=E5=88=B0=EF=BC=9A
> > On Fri, Jul 27, 2012 at 12:46 AM, joeyli <jlee@suse.com> wrote:
> > >
> > > + * flags
> > > + * bits 1:0:
> > > + * 0 - Notify(VGA, 0x81) is not used for notification
> > > + * 1 - Notify(VGA, 0x81) is used for notification
> > >
> > > Per the above flags, when we detect bit set to 1, means 0x81 used=
 for radeon-acpi
> > > to be a general notification event. My question is: what's the ev=
ent number for
> > > ACPI_VIDEO_NOTIFY_PROBE on this AMD/ATI machine when 0x81 not ava=
ilable for acpi/video?
> > >
> >=20
> >=20
> > +/* ARG0: ATIF_FUNCTION_GET_SYSTEM_PARAMETERS
> > + * ARG1: none
> > + * OUTPUT:
> > + * WORD  - structure size in bytes (includes size field)
> > + * DWORD - valid flags mask
> > + * DWORD - flags
> > + *
> > + * OR
> > + *
> > + * WORD  - structure size in bytes (includes size field)
> > + * DWORD - valid flags mask
> > + * DWORD - flags
> > + * BYTE  - notify command code
> > + *
> > + * flags
> > + * bits 1:0:
> > + * 0 - Notify(VGA, 0x81) is not used for notification
> > + * 1 - Notify(VGA, 0x81) is used for notification
> > + * 2 - Notify(VGA, n) is used for notification where
> > + * n (0xd0-0xd9) is specified in notify command code.
> > + * bit 2:
> > + * 1 - lid changes not reported though int10
> > + */
> >=20
> > if bits 1:0 =3D=3D 0, there is no notify event for radeon.  When bi=
ts 1:0
> > =3D=3D 1, it uses 0x81; when bits 1:0 =3D=3D 2 it uses the event nu=
mber
> > specified in the following byte (notify command code) which would b=
e
> > something in the 0xd0-0xd9 range.
> >=20
> > Alex
>=20
> Did you mean every time we received 0x81 event in kernel module, we n=
eed
> access GET_SYSTEM_PARAMETERS to get the flags for distinguish between
> ACPI_VIDEO_NOTIFY_PROBE?
>=20
> Or just need access ONE time when system boot?
>=20
>=20
> I have a machine the GET_SYSTEM_PARAMETERS looks like this:
>=20
> Method (AF01, 0, NotSerialized)                 /* ATIF_FUNCTION_GET_=
SYSTEM_PARAMETERS 0x1 */
> {
>     CreateWordField (ATIB, Zero, SSZE)
>     CreateDWordField (ATIB, 0x02, VMSK)
>     CreateDWordField (ATIB, 0x06, FLGS)         /* flags bits 1:0 */
>     Store (0x0A, SSZE)		/* structure SIZE fixed */
>     Store (0x03, VMSK)		/* valid flags mask fixed to 0x03 */
>     Store (One, FLGS)		/* FLAGS always set to 1 */
>     Return (ATIB)
> }
>=20
> Looks like just need access ONE time when system boot because those
> return value of AF01 fixed in DSDT.
>=20
> On this machine doesn't support probe event, I didn't see any event
> issued when I plug D-Sub. Does that means those kind of ATI/AMD machi=
nes
> do NOT support probe notify?
>=20
> If YES, then we can just direct disable acpi/video driver by radeon-a=
cpi
					^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> when we detected FLAGS is 1.
>=20

I mean disable the ACPI_VIDEO_NOTIFY_PROBE related code in acpi/video
driver.


Thanks
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
