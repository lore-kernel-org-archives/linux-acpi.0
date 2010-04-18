From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: Looking for some pointers on WMI/EC access
Date: Sun, 18 Apr 2010 21:21:14 +0200
Message-ID: <q2s71cd59b01004181221kce7c1e5cn7742b1063827ac3b@mail.gmail.com>
References: <1271518653.4549.186.camel@flunder>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1271518653.4549.186.camel@flunder>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Apr 17, 2010 at 5:37 PM, Florian Echtler <floe@butterbrot.org> =
wrote:
> Hello everyone,
>
> I've just bought an Ideapad S10-3t, and most features including ACPI
> work fine. However, since neither thinkpad-acpi nor lenovo-sl-laptop
> support this device, I've been looking around for some hints on how t=
o
> access the embedded controller in order to get the hotkeys working. I=
'll
> post what I've found so far and hope that somebody could give me some
> hints as to how to proceed.
>
> First, I've dumped the DSDT and browsed through it. I've found a _WDT
> section, and wmidump shows:

Wow, someone actually used that tool ^^
A Quick hint would be to look at
https://patchwork.kernel.org/patch/87210/ which is basically a really
short example of what a wmi-driver is.
Just change the guid, buid/load, push some hotkeys, see dmesg, edit
the keymap, build, load, test ..

> ABBC0F20-8EA1-11D1-00A0-C90629100000:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0object_id: =EF=BF=BD
> =C2=A0 =C2=A0 =C2=A0 =C2=A0notify_id: 80
> =C2=A0 =C2=A0 =C2=A0 =C2=A0reserved: 00
> =C2=A0 =C2=A0 =C2=A0 =C2=A0instance_count: 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0flags: 0x8 ACPI_WMI_EVENT
> ABBC0F40-8EA1-11D1-00A0-C90629100000:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0object_id: IO
> =C2=A0 =C2=A0 =C2=A0 =C2=A0notify_id: 49
> =C2=A0 =C2=A0 =C2=A0 =C2=A0reserved: 4F
> =C2=A0 =C2=A0 =C2=A0 =C2=A0instance_count: 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0flags: 0x1 ACPI_WMI_EXPENSIVE
> 05901221-D566-11D1-B2F0-00A0C9062910:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0object_id: AE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0notify_id: 41
> =C2=A0 =C2=A0 =C2=A0 =C2=A0reserved: 45
> =C2=A0 =C2=A0 =C2=A0 =C2=A0instance_count: 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0flags: 0
>
> As this laptop also runs some kind of Splashtop instant-on Linux call=
ed
> Lenovo Quickstart, I've decided to extract the initrd from its kernel
> (*) and browse through the modules. Interestingly, I've found a
> lenovo_ec.ko: strings shows that it accesses some DSDT elements which
> are present on the S10-3t. Would it make sense to disassemble this?

You can also try to see if the manufacturer give some sources or ask th=
em to ...

(ccing platform-x86)
--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe platform-driv=
er-x86" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
