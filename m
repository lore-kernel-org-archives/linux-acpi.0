From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm] Hibernation: Check if ACPI is enabled during restore in the right place
Date: Thu, 6 Sep 2007 01:56:03 +0000
Message-ID: <20070906015603.GA5097@ucw.cz>
References: <200709020021.37881.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:44179 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541AbXIFJAW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Sep 2007 05:00:22 -0400
Content-Disposition: inline
In-Reply-To: <200709020021.37881.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Sun 2007-09-02 00:21:37, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> The following scenario leads to total confusion of the platform firmw=
are on
> some boxes (eg. HPC nx6325):
> * Hibernate with ACPI enabled
> * Pass "acpi=3Doff" to the boot kernel
>=20
> To prevent this from happening it's necessary to check if ACPI is ena=
bled (and
> enable it if that's not the case) _right_ _after_ control has been tr=
ansfered
> from the boot kernel to the image kernel, before device_power_up() is=
 called
> (ie. with interrupts disabled). =A0Enabling ACPI after calling device=
_power_up()
> turns out to be insufficient.
>=20
> For this reason, introduce new hibernation callback ->leave() that wi=
ll be
> executed before device_power_up() by the restored image kernel. =A0To=
 make it
> work, it also is necessary to move swsusp_suspend() from swsusp.c to =
disk.c
> (it's name is changed to "create_image", which is more up to the poin=
t).
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
