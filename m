From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Date: Mon, 05 Mar 2007 14:56:44 +0100
Message-ID: <E1HODgC-0000h8-Vc@be1.lrz>
References: <7PvLN-1cj-3@gated-at.bofh.it> <7TEGV-6Jy-39@gated-at.bofh.it> <7TUBX-6TN-5@gated-at.bofh.it> <7UeqX-4QO-17@gated-at.bofh.it> <7UeqZ-4QO-27@gated-at.bofh.it> <7UgM5-np-1@gated-at.bofh.it> <7UgM8-np-11@gated-at.bofh.it> <7UnaS-2xP-9@gated-at.bofh.it> <7UnkC-2JB-9@gated-at.bofh.it> <7Uzcd-49u-3@gated-at.bofh.it> <7UEEN-4xi-3@gated-at.bofh.it>
Reply-To: 7eggert@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.174]:60516 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932697AbXCEN7H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Mar 2007 08:59:07 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Hubbard <david.c.hubbard@gmail.com>, Jean Delvare <khali@linux-fr.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, Chuck Ebbert <cebbert@redhat.com>, Rudolf@atrpms.net

David Hubbard <david.c.hubbard@gmail.com> wrote:

> For I/O and memory that ACPI accesses and has not reserved, the AML
> interpreter could allocate at run-time.
>=20
> I'm not sure how to implement exactly. For example, it would be bad t=
o
> have a /proc/ioports that had a lot of single ports allocated, for
> example:
> 1000-107f : 0000:00:1f.0
>  1000-1000 : ACPI PM1a_EVT_BLK
>  1001-1001 : ACPI PM1a_EVT_BLK
>  1002-1002 : ACPI PM1a_EVT_BLK
>  1003-1003 : ACPI PM1a_EVT_BLK
>=20
> Thus the AML interpreter would need to have some reasonable
> intelligence when allocating regions. Conflict resolution would also
> be more difficult, e.g. if a hwmon driver was loaded first and then
> acpi as a module, ACPI could not allocate the region. Maybe run-time
> allocating won't work.
>=20
> And then, how would ACPI release a region after it has used it? The
> easiest method would be to never release anything used even once.
>=20
> Thoughts?

1) Make a general resource allocation lock, if there is none.
2) make ACPI take this lock whenever it touches ports not allocated by =
itself
   and release it on function return.
3) Make ACPI callback the allocating device if it touches allocated ran=
ges,
   and on function return.

1 + 2 will replace allocating single ports and freeing them again (so A=
CPI won't
prevent e.g. the display driver from loading just because it turned on =
the
backlight) while preventing races with newly allocated ranges, and 3 al=
lows
coexistence with other drivers.
--=20
The problem with the easy way out is that it has already been mined.=20

=46ri=DF, Spammer: TKF8@jQXoImLG.7eggert.dyndns.org
 lG@aOkf0g.7eggert.dyndns.org hffltUu@6au8pBwc.7eggert.dyndns.org
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
