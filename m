From: =?ISO-8859-1?Q?=C2ngelo?= Miguel Arrifano <miknix@gmail.com>
Subject: Re: [PATCH] ACPI: Platform driver to support App Hot Startup
 (PNP0C32)
Date: Mon, 1 Sep 2008 01:21:29 +0200
Message-ID: <20080901012129.304c50cf.miknix@gmail.com>
References: <1206585013.8282.17.camel@sli10-desk.sh.intel.com>
	<20080327160346.424052fe.miknix@gmail.com>
	<1206668215.12574.8.camel@sli10-desk.sh.intel.com>
	<20080328193919.fb23bcc8.miknix@gmail.com>
	<20080824183924.daf28d3b.miknix@gmail.com>
	<1219627740.24775.12.camel@rzhang-dt>
	<878wujsjku.fsf@basil.nowhere.org>
	<20080828143708.25815142.miknix@gmail.com>
	<20080828134055.GA27158@srcf.ucam.org>
	<20080901003856.2d855880.miknix@gmail.com>
	<20080831220038.GA5573@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:8326 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252AbYHaWVh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 31 Aug 2008 18:21:37 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1010685yxm.1
        for <linux-acpi@vger.kernel.org>; Sun, 31 Aug 2008 15:21:36 -0700 (PDT)
In-Reply-To: <20080831220038.GA5573@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: andi@firstfloor.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>, linux-acpi@vger.kernel.org

On Sun, 31 Aug 2008 23:00:38 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Mon, Sep 01, 2008 at 12:38:56AM +0200, =C2ngelo Miguel Arrifano wr=
ote:
> > On Thu, 28 Aug 2008 14:40:55 +0100
> > Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > +	else if (event =3D=3D QUICKSTART_EVENT_RUNTIME) {
> > +		input_report_key(quickstart_input, quickstart->btn->id, 1);
> > +		input_sync(quickstart_input);
> > +		input_report_key(quickstart_input, quickstart->btn->id, 0);
> > +		input_sync(quickstart_input);
> >=20
> > The button usage ID is used as key code.
>=20
> Right, that's probably not how you want to do it. Keycodes should be =
the=20
> things in include/linux/input.h. The problem you have is that there's=
 no=20
> way of mapping the usage ID to the keycode without knowing the specif=
ic=20
> laptop layout. The right way of doing this is to use the usage ID as =
a=20
> scancode, and then implement the get and setkeycode functions. Usersp=
ace=20
> can then alter the keymap. Check the wistron_btns driver for an examp=
le=20
> of this.
>=20
> > Buffer dump:
> > QBTN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 0=
0 00 00 00 01 00 00 00 00 00 00 00
> > DBTN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 0=
0 00 00 00 02 00 00 00 00 00 00 00
> > MUBN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 0=
0 00 00 00 03 00 00 00 00 00 00 00
> > PIBN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 0=
0 00 00 00 06 00 00 00 00 00 00 00
> > WEBN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 0=
0 00 00 00 04 00 00 00 00 00 00 00
> > LVBN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 0=
0 00 00 00 08 00 00 00 00 00 00 00
> > VOBN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 0=
0 00 00 00 07 00 00 00 00 00 00 00
> >                                                                    =
           +---------------------+
> > Does it return a QWORD?? Why is it at the end of the buffer?
>=20
> This is the raw dump of what GHID returns? I'm not quite clear on wha=
t's=20
> going on here.

Yes, GHID returns a auto-allocated buffer of 32bytes.

=46or instance, the returned buffer for WEBN device is:
03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 00 00 00 00=
 04 00 00 00 00 00 00 00
                                                                       =
 /\
4 is the button usage ID (see bellow). I don't know why is in that plac=
e and why the rest of the garbage.
>=20
> > +	/* <<The GHID method can return a BYTE, WORD, or DWORD.
> > +	 * The value must be encoded in little-endian byte
> > +	 * order (least significant byte first).>> */
> > +	ACPI_MOVE_32_TO_32(&usageid, buffer.pointer + (buffer.length - 8)=
);
> > +	quickstart->btn->id =3D usageid;
> >=20
> > I need your help in here, I doubt this code runs for anyone but me.
>=20
> Right. For instance, GHID on another system I have here is just:
>=20
>                         Method (GHID, 0, NotSerialized)
>                         {
>                             Acquire (MUT1, 0xFFFF)
>                             And (MBTB, 0x02, Local0)
>                             Release (MUT1)
>                             If (Local0)
>                             {
>                                 Notify (DAL2, 0x02)
>                             }
>=20
>                             Return (Buffer (One)
>                             {
>                                 0x02
>                             })
>=20
> which doesn't look like your code would cope at all.

The GHID method here is also similar:

           Method (GHID, 0, NotSerialized)
            {
                If (LEqual (HOTB, 0x10))
                {
                    Notify (WEBN, 0x02)
                    Store (Zero, HOTB)
                }

                Return (Buffer (One)
                {
                    /* 0000 */    0x04
                })
            }

Shouldn't GHID be returning a 1 byte buffer?
>=20
> --=20
> Matthew Garrett | mjg59@srcf.ucam.org

Are you able to dump the returned buffer somewhere?

Thanks,
Angelo Arrifano
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
