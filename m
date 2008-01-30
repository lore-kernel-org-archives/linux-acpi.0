From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Subject: Re: [PATCH] Override DSDT and SSDTs via initramfs
Date: Wed, 30 Jan 2008 23:36:04 +0100
Message-ID: <47A0FBD4.6090603@tremplin-utc.net>
References: <4798E2A5.6020804@users.sf.net>	 <20080125063328.4e3b4752.akpm@linux-foundation.org>	 <200801252339.44246.lenb@kernel.org> <1201714051.1222.131.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:11627 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763855AbYA3XER (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jan 2008 18:04:17 -0500
In-Reply-To: <1201714051.1222.131.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>

Hi,
Just a few comments for now as I don't have much time until this weeken=
d.
30/01/08 18:27, Thomas Renninger wrote/a =C3=A9crit:
:
> On Fri, 2008-01-25 at 23:39 -0500, Len Brown wrote:
:
>> Probably it is best to forward the original patch
>> w/ proper credits, and then send updates to address 1-4.
Thomas, the patch you have included is only the "original" patch, right=
?=20
We need to address the points 1-4 (which seem very reasonable) later on=
=20
with additional patches. I think most of them are already implemented i=
n
http://gaugusch.at/acpi-dsdt-initrd-patches/acpi-dsdt-initrd-v0.8.2-2.6=
=2E17-ssdt.patch
So that should be quite easy :-)

> I do not know who initially came up with this, I just modified/adjust=
ed
> the patch sometimes. I expect it's Markus, possibly Eric or best both
> who should be mentioned as author.
Yep, to be precise, Markus Gaugusch is the original author, I'm just th=
e=20
current maintainer, and Thomas has been very helpful for a looong time =
:-)

:
> Jeff (Mahony) has adjusted the last bits of it when he updated it to =
the
> latest rcX-gitY version:
> Changes:
>  We no longer call populate_rootfs() twice. If we want the custom DSD=
T,
>  we load the rootfs before ACPI. Otherwise, it is loaded at the
> appropriate
>  initcall time. -jeffm
I had left it this way because I though Linus had a good reason for=20
delaying populate_rootfs(). But if it works, fine! Maybe some additiona=
l=20
comments should be added in before the #ifdef's to clearly show that=20
populate_rootfs() is _always_ called, and they modify only the moment i=
t=20
is called.

>  There is a new version at
> http://gaugusch.at/acpi-dsdt-initrd-patches/acpi-dsdt-initrd-v0.8.4-2=
=2E6.21.patch,
>  but there doesn't seem to be any real changes other than elminating =
the
> file
>  name array.
Yes, exactly.

> In fact, I added the array some time ago.
> Not sure whether the latest Version of Eric/Markus can also load seve=
ral
> DSDT/SSDTs? Maybe you found a more elegant way?
Nope. On the website (http://gaugusch.at/kernel.shtml) you can just fin=
d=20
two versions of the patch: one simple and one with your addition for=20
SSDTs support. At least with SSDTs support there is even an advantage=20
over the DSDT-in-kernel version :-)

Just one comment about the patch for now: it misses=20
Documentation/dsdt-initrd.txt . Please include this file too so that th=
e=20
documentation is provided at the same time (it's in the official patch)=
=2E

I'll test the patch and try to be productive this weekend.
See you,
Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
