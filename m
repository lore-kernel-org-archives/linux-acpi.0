From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: ACPI ALS Status ?
Date: Mon, 30 Jan 2012 09:28:03 +0100
Message-ID: <CAHR064hSrEQESJwa6hu5mzbCBgXWUwQyN4VZuF9+teZK_fNp6Q@mail.gmail.com>
References: <CAHR064iRm37Wf4QrYEOvsxT0=wZZbY1XQiZfmrJdqyTj1h8sPA@mail.gmail.com>
	<CAJvTdKnW9VESyiF7Rden698EvRgT=805hyKXtXhFpKkTxLv64w@mail.gmail.com>
	<CAHR064hprC29+4wso1nR8cL4ZDXEqj7CONF6h2cdyeuHxmkjiw@mail.gmail.com>
	<CAHR064icLG7+FJse1n+MVa0z6scec2b3c3oxJBFtu5vRtfnPzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33720 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab2A3I2F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2012 03:28:05 -0500
Received: by bkas6 with SMTP id s6so2942098bka.19
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2012 00:28:03 -0800 (PST)
In-Reply-To: <CAHR064icLG7+FJse1n+MVa0z6scec2b3c3oxJBFtu5vRtfnPzQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>

On Sat, Dec 3, 2011 at 10:43 AM, Corentin Chary
<corentin.chary@gmail.com> wrote:
> On Sun, Nov 6, 2011 at 11:51 PM, Corentin Chary
> <corentin.chary@gmail.com> wrote:
>> On Sun, Nov 6, 2011 at 11:16 PM, Len Brown <lenb@kernel.org> wrote:
>>>> I was looking at the DSDT of a new samsung laptop (I can send you =
the
>>>> output of acpidump if interested), and it export a standard ACPI A=
LS
>>>> device. So, it's actually great to see vendor using that, but it s=
eems
>>>> that the series adding support for that and sent back in 2009 is n=
ot
>>>> available in the kernel. I'd really like to use my the ALS, what's=
 the
>>>> current status of the driver ? Still blocked because we don't have=
 a
>>>> generic sysfs class ? If yes, can't we just use a non-standard
>>>> interface ? It would still be better than no driver at all.
>>>
>>> Yes, I think ACPI ALS support has been waiting for hardware to just=
ify
>>> its existence.
>>>
>>> When it first entered the spec, we were excited to see it was prese=
nt
>>> in some high-end laptops, but IIR on closer examination the AML tur=
ned
>>> out to be dummy code.
>>>
>>> If you can verify that your Samsung really does implement ACPI ALS,
>>> then that is all we need to stumble forward.
>
> I just found some time to try the latest patch series I could found o=
n
> gmane (v6 I think).
> Here are the results:
>
> $ uname -s -r
> Linux 3.0.0-14-generic
>
> $ tree -L 1 /sys/class/als/acpi_als0/
> /sys/class/als/acpi_als0/
> =E2=94=9C=E2=94=80=E2=94=80 device -> ../../../LNXSYSTM:00/device:00/=
PNP0A08:00/device:02/PNP0C09:00/ACPI0008:00
> =E2=94=9C=E2=94=80=E2=94=80 display_adjustment
> =E2=94=9C=E2=94=80=E2=94=80 illuminance
> =E2=94=9C=E2=94=80=E2=94=80 power
> =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../class/als
> =E2=94=94=E2=94=80=E2=94=80 uevent
>
> // light off
> $ cat display_adjustment
> 23%
> $ cat illuminance
> 7
>
> // light on
> $ cat display_adjustment
> 74%
> $ cat illuminance
> 368
>
> // finger on sensor
> $ cat display_adjustment
> 7%
> $ cat illuminance
> 1
>
> So, it works perfectly, and since I've just added keyboard backlight
> support in samsung-laptop, that would be the last (kernel) bit to
> enable automagic screen/keyboard backlight :).

Hi,

Any plan to revive this driver for 3.4 or 3.5 ?
Thanks,



--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
