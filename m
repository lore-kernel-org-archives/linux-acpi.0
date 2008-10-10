From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Power button not working on T61
Date: Fri, 10 Oct 2008 19:38:51 -0400
Message-ID: <200810101938.51573.dmitry.torokhov@gmail.com>
References: <200810101319.52021.hanno@hboeck.de> <alpine.LFD.1.10.0810101140310.3131@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:57330 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbYJJXi4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Oct 2008 19:38:56 -0400
Received: by wx-out-0506.google.com with SMTP id h27so353964wxd.4
        for <linux-acpi@vger.kernel.org>; Fri, 10 Oct 2008 16:38:55 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0810101140310.3131@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Hanno =?utf-8?q?B=C3=B6ck?= <hanno@hboeck.de>, acpi@linux.intel.com, linux-acpi@vger.kernel.org

On Friday 10 October 2008, Len Brown wrote:
>=20
> On Fri, 10 Oct 2008, Hanno B=C3=B6ck wrote:
>=20
> > I have a T61 8859WFJ. thinkpad_acpi module is loaded (kernel is 2.6=
=2E27, same=20
> > was with 2.6.26).
>=20
> what is the most recent kernel that worked properly?
>=20
> > When I press the power button, nothing happens and no acpi event is=
 generated.=20
> >=20
> > I already posted this on the ibm-acpi-devel list and they told me i=
t's=20
> > probably a problem in acpi core.
> >=20
> > My dmesg, if that helps:
> > http://rafb.net/p/EYOHpq12.html
>=20
> I have a T61 7660-CTO running 2.6.27 and power, lid, sleep seem to be
> working normally.
>=20
> Try killing acpid an
> # cat /proc/acpi/event
> then press the power button, close/open the lid, and the sleep button
> (Fn-F4 on mine) and see if anything appears.
> the standard acpi button driver should handle power and lid.
> in this case the thinkpad driver handles the sleep hotkey.
>=20
> see if things work differently when thinkpad_acpi is not
> included in your kernel.
>=20
> one difference I see is how your devices are registered
> with the input layer:
>=20
> input: Power Button (FF) as /devices/LNXSYSTM:00/LNXPWRBN:00/input/in=
put0
> ACPI: Power Button (FF) [PWRF]
> input: Lid Switch as=20
> /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input1
> ACPI: Lid Switch [LID]
> input: Sleep Button (CM) as=20
> /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input2
> ACPI: Sleep Button (CM) [SLPB]
>=20
>=20
> Where I see this:
>=20
> input: Power Button (FF) as /class/input/input0
> ACPI: Power Button (FF) [PWRF]
> PM: Adding info for No Bus:input1
> input: Lid Switch as /class/input/input1
> ACPI: Lid Switch [LID]
> PM: Adding info for No Bus:input2
> input: Sleep Button (CM) as /class/input/input2
> ACPI: Sleep Button (CM) [SLPB]
>=20
> if you send me your .config, I'll try it out.
>

Len,

You must have CONFIG_SYSFS_DEPRECIATED set, this would explain the
difference in sysfs paths.=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
