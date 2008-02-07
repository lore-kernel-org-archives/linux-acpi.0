From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Subject: Re: [PATCH] Override DSDT and SSDTs via initramfs
Date: Thu, 07 Feb 2008 08:57:09 +0100
Message-ID: <47AAB9D5.3010506@tremplin-utc.net>
References: <4798E2A5.6020804@users.sf.net> <47A0FBD4.6090603@tremplin-utc.net> <1201861297.14573.66.camel@queen.suse.de> <200802062151.48404.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:5721 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbYBGH5R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 02:57:17 -0500
In-Reply-To: <200802062151.48404.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: trenn@suse.de, Andrew Morton <akpm@linux-foundation.org>, Philippe Coval <rzr@users.sourceforge.net>, linux-acpi@vger.kernel.org, dsdt <dsdt@gaugusch.at>

07/02/08 03:51, Len Brown wrote/a =C3=A9crit:
>>>> Jeff (Mahony) has adjusted the last bits of it when he updated it =
to the
>>>> latest rcX-gitY version:
>>>> Changes:
>>>>  We no longer call populate_rootfs() twice. If we want the custom =
DSDT,
>>>>  we load the rootfs before ACPI. Otherwise, it is loaded at the
>>>> appropriate
>>>>  initcall time. -jeffm
>=20
>>> I had left it this way because I though Linus had a good reason for=
=20
>>> delaying populate_rootfs(). But if it works, fine! Maybe some addit=
ional=20
>>> comments should be added in before the #ifdef's to clearly show tha=
t=20
>>> populate_rootfs() is _always_ called, and they modify only the mome=
nt it=20
>>> is called.
>=20
>> I don't know about this, I took that change from your patches...
>=20
> So is the populate_rootfs() change in the pach I have correct, or not=
?
Yes, it's correct. This is the SuSE version, which is slightly differen=
t
from the one I had written for the official patch, but which avoids
calling twice populate_rootfs(). Both versions work fine anyway :-)

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
