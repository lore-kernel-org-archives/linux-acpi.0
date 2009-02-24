From: Jachym Cepicky <jachym.cepicky@gmail.com>
Subject: Re: incorrect battery design capacity
Date: Tue, 24 Feb 2009 12:18:54 +0100
Message-ID: <1235474334.7890.90.camel@kocour>
References: <1235377098.7046.20.camel@kocour>
	 <1235379482.5789.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f167.google.com ([209.85.220.167]:50593 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbZBXLTE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Feb 2009 06:19:04 -0500
Received: by fxm11 with SMTP id 11so2674991fxm.13
        for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2009 03:18:59 -0800 (PST)
In-Reply-To: <1235379482.5789.1.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,
yakui_zhao p=C3=AD=C5=A1e v Po 23. 02. 2009 v 16:58 +0800:
> On Mon, 2009-02-23 at 16:18 +0800, Jachym Cepicky wrote:
> > Hi,=20
> > if I'm in wrong mailing list, my apologizes, plese point me to the =
right
> > one.
> > =20
> > It is truth, that my laptop is about 3 years old, and so, I can not
> > expect  miracles from my battery, however, I would call this an bug=
:
> >=20
> > I have HP Compaq nx6125 and on the battery it is written, that it i=
s
> > 10.8V - 4.8 Ahr, which I understand, that capacity of my battery is=
 4800
> > mAh.=20
> >=20
> > However,  cat /proc/acpi/battery/C179/info=20
> > present:                 yes
> > design capacity:         638 mAh
> It seems that the design capacity is not very correct.
> Will you please try the latest kernel and see whether the battery des=
ign
> capacity can be reported correctly?
> Of course please also attach the output of acpidump.
> Thanks.

Sorry, I managed to compile (install) only current 2.6.28 version from
Ubuntu Jaunty (2.6.28.6, I guess) [1]. Compilation of linux-2.6.28.7
from kernel.org went fine, (fakeroot make-kpkg --initrd
--append-to-version=3D-custom kernel_image kernel_headers), but the
post-installation script did not work.

So, if it helps, I have=20
Linux kocour 2.6.28-8-generic #24 SMP Mon Feb 23 15:29:17 CET 2009 i686
GNU/Linux, Ubuntu 8.10

cat /proc/acpi/battery/C179/info
present:                 yes
design capacity:         638 mAh
last full capacity:      638 mAh
battery technology:      rechargeable
design voltage:          11100 mV
design capacity warning: 32 mAh
design capacity low:     7 mAh
capacity granularity 1:  100 mAh
capacity granularity 2:  100 mAh
model number:            Primary
serial number:           03740 2006/01/12
battery type:            LIon
OEM info:                Hewlett-Packard

the output from acpidum can be found at [2], with --binary at [3]

I hope, it helps, thanks a lot

Jachym

[1] http://packages.ubuntu.com/jaunty/linux-image-2.6.28-8-generic
[2] http://les-ejk.cz/tmp/acpidump.txt
[3] http://les-ejk.cz/tmp/acpidump.bin
--=20
Jachym Cepicky
e-mail: jachym.cepicky gmail com
URL: http://les-ejk.cz
GPG: http://les-ejk.cz/pgp/JachymCepicky.pgp

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
