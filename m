From: Bruno Friedmann <bruno@ioda-net.ch>
Subject: Re: [PATCH] x86: Add reboot quirk for Dell Precision M4600
Date: Sat, 06 Aug 2011 20:18:52 +0200
Message-ID: <4E3D858C.5050804@ioda-net.ch>
References: <20110727125651.GH3010@suse.de> <20110806065635.GE13220@elte.hu> <24c471f7-80f5-4102-a12b-d6245c8d0921@email.android.com> <alpine.LFD.2.02.1108061120150.3197@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.ioda.net ([87.98.140.96]:48509 "EHLO smtp.ioda.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753414Ab1HFS2u (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 6 Aug 2011 14:28:50 -0400
In-Reply-To: <alpine.LFD.2.02.1108061120150.3197@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Mel Gorman <mgorman@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 08/06/2011 05:31 PM, Len Brown wrote:
> On Sat, 6 Aug 2011, H. Peter Anvin wrote:
>=20
>> Ingo Molnar <mingo@elte.hu> wrote:
>>
>>> * Mel Gorman <mgorman@suse.de> wrote:
>>>
>>>> ACPI reboot does not work for Dell Precision M4600. Detect this
>>>> machine via DMI and force the use of the PCI reboot method.
>>>>    =20
>>>> Reported-and-tested-by: Bruno Friedmann <bruno@ioda-net.ch>
>>>> Signed-off-by: Mel Gorman <mgorman@suse.de>
>>>> ---
>>>>  arch/x86/kernel/reboot.c |    9 +++++++++
>>>>  1 files changed, 9 insertions(+), 0 deletions(-)
>>>
>>> Weird - ACPI is the default Windows method of reboot - how come it=20
>>> does not work on that box? Does Windows work around this specific=20
>>> machine (unlikely), or is our ACPI boot sequence not 100% compatibl=
e=20
>>> with the Windows method (more likely IMO)?
>>
>> It seems almost all the affected machines are Dell, too... very odd,=
 no?
>=20
> Dell website says that the M4600 is current,
> and ships with Windows 7.  It is a "mobile workstation",
> so it is more likely to have a windows "feature" driver,
> say, than Dell's servers.

And this computer can be buyed with RedHat 6.0 by phone call.
If you check the support website download and drivers you will some dri=
vers for Redhat
(mainly the new version of alsa)
http://dell.to/r1IKhp

>=20
> Matthew,
> Did you do your reboot comopatibility test using Win7,
> or something older?
>=20
> BTW, it would be nice if ACPI incompatibilities and workarounds
> somehow got stuck in the ACPI code rather than the arch code.
> Unfortunately this kind sets a working reboot method instead
> of disabling a non-working one -- so what it overrides has
> changed when the default changed.
>=20
> thanks,
> -Len Brown, Intel Open Source Technolgy Center
>=20

In any case, if you want anymore testing, and dumps of something, just =
drop me an email
and the howto get it formatted as you want it.

Actually I'm in the desktop summit with the computer until 9th August n=
ight.

I don't know if we can find an owner of the M6600 (the 17") version to =
get feedback about that hardware which share
a lot with the M4600.

Also Dell can upgrade their Bios.

The only error or significant warning I saw in boot.msg is
<3>[   36.851649] sdhci-pci 0000:0b:00.1: Invalid iomem size. You may e=
xperience problems.




--=20

Bruno Friedmann
Ioda-Net S=C3=A0rl www.ioda-net.ch

openSUSE Member & Ambassador
GPG KEY : D5C9B751C4653227
irc: tigerfoot
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
