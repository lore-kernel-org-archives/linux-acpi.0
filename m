From: Eric Piel <eric.piel@tremplin-utc.net>
Subject: Re: [Fwd: Overriding ACPI tables]
Date: Fri, 02 May 2008 12:15:44 +0200
Message-ID: <481AE9D0.1030407@tremplin-utc.net>
References: <1209661364.1131.8.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:29745 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759027AbYEBKPu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 May 2008 06:15:50 -0400
In-Reply-To: <1209661364.1131.8.camel@linux-2bdv.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de, "H. Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org, Richard <tuxbox.guru@gmail.com>, andreas.herrmann3@amd.com

> Thomas Renninger wrote:
>> Peter: You wrote the syslinux stuff, right? What kind of luck is tha=
t :)
>> There currently is a discussion about being able to override ACPI ta=
bles
>> via initrd. The discussion is a bit stuck because the data is needed
>> earlier than initrd is unpacked and the hacks to make it work are no=
t
>> accepted by Linus. I thought about adding another binary image to i3=
86
>> boot protocol, similar to initrd=3D which contains data for very ear=
ly
>> kernel boot initialization, but this would be a heavy hammer (but IM=
O
>> still better than only do it for kexec, another suggestion...) , =EF=
=BB=BFI
>> better open a separate thread or pre-ask privately whether this make=
s
>> sense at all. It would be great if you could advise and possibly hel=
p to
>> convince so that we finally may find a solution accepted mainline.
>=20
> We're putting in a mechanism for pushing larger tables already; we ne=
ed=20
> it for other things (in particular, the zones for E820 and EDD in the=
=20
> boot_info_table are simply not big enough.)  That gives a generic=20
> mechanism for sending arbitrary-sized binary images to the kernel.  T=
hat=20
> would be the mechanism to use.
>=20
> I believe it's in upstream as this merge window; it's definitely in=20
> x86.git already.
Hi Peter,

Thank you for the pointer. You are talking about setup_data, right? I'l=
l=20
try to use it for reading the DSDT table. I have a couple of questions=20
though:
* I can find reference of it only in setup_64.c, is it planned to add=20
support also for 32bit? (That's a must for me)
* From inside the kernel, all I have to do is to add a hook inside=20
parse_setup_data(), allocate memory and I'll be able to copy the data=20
into this safe place, right?
* Is there any bootloader which already has support for this extension?=
=20
  By chance, would you have a patch for grub?

See you,
Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
