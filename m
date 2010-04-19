From: Florian Echtler <floe@butterbrot.org>
Subject: Re: Looking for some pointers on WMI/EC access
Date: Mon, 19 Apr 2010 16:25:30 +0200
Message-ID: <1271687130.26267.147.camel@pancake>
References: <1271518653.4549.186.camel@flunder>
	 <q2s71cd59b01004181221kce7c1e5cn7742b1063827ac3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static.88-198-47-201.clients.your-server.de ([88.198.47.201]:50232
	"EHLO butterbrot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754800Ab0DSOZd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Apr 2010 10:25:33 -0400
In-Reply-To: <q2s71cd59b01004181221kce7c1e5cn7742b1063827ac3b@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org

Am Sonntag, den 18.04.2010, 21:21 +0200 schrieb Corentin Chary:
> On Sat, Apr 17, 2010 at 5:37 PM, Florian Echtler <floe@butterbrot.org=
> wrote:
> > I've just bought an Ideapad S10-3t, and most features including ACP=
I
> > work fine. However, since neither thinkpad-acpi nor lenovo-sl-lapto=
p
> > support this device, I've been looking around for some hints on how=
 to
> > access the embedded controller in order to get the hotkeys working.=
 I'll
> > post what I've found so far and hope that somebody could give me so=
me
> > hints as to how to proceed.
> > First, I've dumped the DSDT and browsed through it. I've found a _W=
DT
> > section, and wmidump shows:
> Wow, someone actually used that tool ^^
> A Quick hint would be to look at
> https://patchwork.kernel.org/patch/87210/ which is basically a really
> short example of what a wmi-driver is.
> Just change the guid, buid/load, push some hotkeys, see dmesg, edit
> the keymap, build, load, test ..
Thanks for the pointer - I've given it a quick try and the driver loads
successfully, however, the event doesn't seem to be triggered. I've put
a printk into the eeepc_wmi_notify function, and this is seemingly neve=
r
called.. although I believe this may be the right direction, as the GUI=
D
from the eeepc driver (ABBC0F72-8EA1-11D1-00A0-C90629100000) and the on=
e
from my Lenovo (ABBC0F20-8EA1-11D1-00A0-C90629100000) differ only by a
single byte. Could this event be disabled somehow?=20

> > ABBC0F20-8EA1-11D1-00A0-C90629100000:
> >        object_id: =EF=BF=BD
> >        notify_id: 80
> >        reserved: 00
> >        instance_count: 1
> >        flags: 0x8 ACPI_WMI_EVENT
> > ABBC0F40-8EA1-11D1-00A0-C90629100000:
> >        object_id: IO
> >        notify_id: 49
> >        reserved: 4F
> >        instance_count: 1
> >        flags: 0x1 ACPI_WMI_EXPENSIVE
> > 05901221-D566-11D1-B2F0-00A0C9062910:
> >        object_id: AE
> >        notify_id: 41
> >        reserved: 45
> >        instance_count: 1
> >        flags: 0
Corresponding to the 2nd GUID, there's also a WQIO method in my DSDT
which should return a data block, correct?

> > As this laptop also runs some kind of Splashtop instant-on Linux ca=
lled
> > Lenovo Quickstart, I've decided to extract the initrd from its kern=
el
> > (*) and browse through the modules. Interestingly, I've found a
> > lenovo_ec.ko: strings shows that it accesses some DSDT elements whi=
ch
> > are present on the S10-3t. Would it make sense to disassemble this?
> You can also try to see if the manufacturer give some sources or ask =
them to ...
I've done that, let's see if I will get some response.

=46lorian
--=20
0666 - Filemode of the Beast

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
