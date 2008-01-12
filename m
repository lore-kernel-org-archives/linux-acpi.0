From: giggz <giggzounet@gmail.com>
Subject: Re: Problem with the Fn+F3 key. acpi problem ?
Date: Sat, 12 Jan 2008 13:33:38 +0100
Message-ID: <fmac61$oc8$1@ger.gmane.org>
References: <fmaaj5$jsl$1@ger.gmane.org> <20080112121714.GB15173@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:59139 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759036AbYALMfW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Jan 2008 07:35:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JDfa4-0006sO-3K
	for linux-acpi@vger.kernel.org; Sat, 12 Jan 2008 12:35:20 +0000
Received: from cam44-1-82-67-121-239.fbx.proxad.net ([82.67.121.239])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 12 Jan 2008 12:35:20 +0000
Received: from giggzounet by cam44-1-82-67-121-239.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 12 Jan 2008 12:35:20 +0000
In-Reply-To: <20080112121714.GB15173@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Matthew Garrett a =E9crit :
> On Sat, Jan 12, 2008 at 01:06:30PM +0100, giggz wrote:
>=20
>> I want to associate a script (which works fine) to a key (Fn+F3). Th=
is
>> key is for the video output switching and my script is a video outpu=
t
>> switch using xrandr.
>> But when I try to associate Fn+F3 it doesn't work. I have try with t=
he
>> xen command to catch the keycode, but nothing happends when I press =
on
>> the key. All the others Fn+F* works fine (help, hibernate, luminosit=
y,
>> sound...).
>> So I want to report a bug, but I don't know if it is an acpi problem=
 or
>> a xorg problem... If anyone could help me...?
>=20
> Does pressing the key generate any output in dmesg? If so, you need t=
o=20
> run the setkeycodes command to bind it to a keycode. If not, make sur=
e=20
> you have the acpi video module loaded, do=20
>=20

No, nothing in dmesg.

What is the acpi video module ?

> echo -n 4 >/proc/acpi/video/foo/DOS
>=20

I have done echo -n 4 >/proc/acpi/video/VGA/DOS

> and check whether it generates an acpi event (there'll be a log messa=
ge=20
> in /var/log/acpid.log). If so, sufficiently recent kernels ought to=20
> generate an input event.
>=20

I don't have any /var/log/acpid.log

Thx for your quick answer!
Guillaume

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
