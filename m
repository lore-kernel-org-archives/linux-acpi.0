From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: ACPI ALS Status ?
Date: Sat, 3 Dec 2011 10:43:09 +0100
Message-ID: <CAHR064icLG7+FJse1n+MVa0z6scec2b3c3oxJBFtu5vRtfnPzQ@mail.gmail.com>
References: <CAHR064iRm37Wf4QrYEOvsxT0=wZZbY1XQiZfmrJdqyTj1h8sPA@mail.gmail.com>
	<CAJvTdKnW9VESyiF7Rden698EvRgT=805hyKXtXhFpKkTxLv64w@mail.gmail.com>
	<CAHR064hprC29+4wso1nR8cL4ZDXEqj7CONF6h2cdyeuHxmkjiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:33024 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906Ab1LCJnL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Dec 2011 04:43:11 -0500
Received: by eeaq14 with SMTP id q14so1299895eea.19
        for <linux-acpi@vger.kernel.org>; Sat, 03 Dec 2011 01:43:10 -0800 (PST)
In-Reply-To: <CAHR064hprC29+4wso1nR8cL4ZDXEqj7CONF6h2cdyeuHxmkjiw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>

On Sun, Nov 6, 2011 at 11:51 PM, Corentin Chary
<corentin.chary@gmail.com> wrote:
> On Sun, Nov 6, 2011 at 11:16 PM, Len Brown <lenb@kernel.org> wrote:
>>> I was looking at the DSDT of a new samsung laptop (I can send you t=
he
>>> output of acpidump if interested), and it export a standard ACPI AL=
S
>>> device. So, it's actually great to see vendor using that, but it se=
ems
>>> that the series adding support for that and sent back in 2009 is no=
t
>>> available in the kernel. I'd really like to use my the ALS, what's =
the
>>> current status of the driver ? Still blocked because we don't have =
a
>>> generic sysfs class ? If yes, can't we just use a non-standard
>>> interface ? It would still be better than no driver at all.
>>
>> Yes, I think ACPI ALS support has been waiting for hardware to justi=
fy
>> its existence.
>>
>> When it first entered the spec, we were excited to see it was presen=
t
>> in some high-end laptops, but IIR on closer examination the AML turn=
ed
>> out to be dummy code.
>>
>> If you can verify that your Samsung really does implement ACPI ALS,
>> then that is all we need to stumble forward.

I just found some time to try the latest patch series I could found on
gmane (v6 I think).
Here are the results:

$ uname -s -r
Linux 3.0.0-14-generic

$ tree -L 1 /sys/class/als/acpi_als0/
/sys/class/als/acpi_als0/
=E2=94=9C=E2=94=80=E2=94=80 device -> ../../../LNXSYSTM:00/device:00/PN=
P0A08:00/device:02/PNP0C09:00/ACPI0008:00
=E2=94=9C=E2=94=80=E2=94=80 display_adjustment
=E2=94=9C=E2=94=80=E2=94=80 illuminance
=E2=94=9C=E2=94=80=E2=94=80 power
=E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../class/als
=E2=94=94=E2=94=80=E2=94=80 uevent

// light off
$ cat display_adjustment
23%
$ cat illuminance
7

// light on
$ cat display_adjustment
74%
$ cat illuminance
368

// finger on sensor
$ cat display_adjustment
7%
$ cat illuminance
1

So, it works perfectly, and since I've just added keyboard backlight
support in samsung-laptop, that would be the last (kernel) bit to
enable automagic screen/keyboard backlight :).

--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
