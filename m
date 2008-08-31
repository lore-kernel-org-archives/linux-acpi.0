From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: Platform driver to support App Hot Startup (PNP0C32)
Date: Sun, 31 Aug 2008 23:00:38 +0100
Message-ID: <20080831220038.GA5573@srcf.ucam.org>
References: <1206585013.8282.17.camel@sli10-desk.sh.intel.com> <20080327160346.424052fe.miknix@gmail.com> <1206668215.12574.8.camel@sli10-desk.sh.intel.com> <20080328193919.fb23bcc8.miknix@gmail.com> <20080824183924.daf28d3b.miknix@gmail.com> <1219627740.24775.12.camel@rzhang-dt> <878wujsjku.fsf@basil.nowhere.org> <20080828143708.25815142.miknix@gmail.com> <20080828134055.GA27158@srcf.ucam.org> <20080901003856.2d855880.miknix@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44463 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbYHaWAs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 31 Aug 2008 18:00:48 -0400
Content-Disposition: inline
In-Reply-To: <20080901003856.2d855880.miknix@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-1?Q?=C2ngelo?= Miguel Arrifano <miknix@gmail.com>
Cc: andi@firstfloor.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>, linux-acpi@vger.kernel.org

On Mon, Sep 01, 2008 at 12:38:56AM +0200, =C2ngelo Miguel Arrifano wrot=
e:
> On Thu, 28 Aug 2008 14:40:55 +0100
> Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> +	else if (event =3D=3D QUICKSTART_EVENT_RUNTIME) {
> +		input_report_key(quickstart_input, quickstart->btn->id, 1);
> +		input_sync(quickstart_input);
> +		input_report_key(quickstart_input, quickstart->btn->id, 0);
> +		input_sync(quickstart_input);
>=20
> The button usage ID is used as key code.

Right, that's probably not how you want to do it. Keycodes should be th=
e=20
things in include/linux/input.h. The problem you have is that there's n=
o=20
way of mapping the usage ID to the keycode without knowing the specific=
=20
laptop layout. The right way of doing this is to use the usage ID as a=20
scancode, and then implement the get and setkeycode functions. Userspac=
e=20
can then alter the keymap. Check the wistron_btns driver for an example=
=20
of this.

> Buffer dump:
> QBTN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 00 =
00 00 00 01 00 00 00 00 00 00 00
> DBTN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 00 =
00 00 00 02 00 00 00 00 00 00 00
> MUBN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 00 =
00 00 00 03 00 00 00 00 00 00 00
> PIBN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 00 =
00 00 00 06 00 00 00 00 00 00 00
> WEBN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 00 =
00 00 00 04 00 00 00 00 00 00 00
> LVBN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 00 =
00 00 00 08 00 00 00 00 00 00 00
> VOBN: 03 00 00 00 01 00 00 00 58 78 6c 4c 00 81 ff ff 00 00 00 00 00 =
00 00 00 07 00 00 00 00 00 00 00
>                                                                      =
         +---------------------+
> Does it return a QWORD?? Why is it at the end of the buffer?

This is the raw dump of what GHID returns? I'm not quite clear on what'=
s=20
going on here.

> +	/* <<The GHID method can return a BYTE, WORD, or DWORD.
> +	 * The value must be encoded in little-endian byte
> +	 * order (least significant byte first).>> */
> +	ACPI_MOVE_32_TO_32(&usageid, buffer.pointer + (buffer.length - 8));
> +	quickstart->btn->id =3D usageid;
>=20
> I need your help in here, I doubt this code runs for anyone but me.

Right. For instance, GHID on another system I have here is just:

                        Method (GHID, 0, NotSerialized)
                        {
                            Acquire (MUT1, 0xFFFF)
                            And (MBTB, 0x02, Local0)
                            Release (MUT1)
                            If (Local0)
                            {
                                Notify (DAL2, 0x02)
                            }

                            Return (Buffer (One)
                            {
                                0x02
                            })

which doesn't look like your code would cope at all.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
