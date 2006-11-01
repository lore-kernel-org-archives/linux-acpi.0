From: Stefan Seyfried <seife@suse.de>
Subject: Re: [PATCH] swsusp: Use platform mode by default
Date: Wed, 1 Nov 2006 13:45:01 +0100
Message-ID: <20061101124501.GE10269@suse.de>
References: <200611011323.14830.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:23772 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752078AbWKAMpZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Nov 2006 07:45:25 -0500
Content-Disposition: inline
In-Reply-To: <200611011323.14830.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-acpi@vger.kernel.org

On Wed, Nov 01, 2006 at 01:23:14PM +0100, Rafael J. Wysocki wrote:
> It has been reported that on some systems the functionality after a r=
esume
> from disk is limited if the system is simply powered off during the s=
uspend
> instead of using the ACPI S4 suspend (aka platform mode).
>=20
> Unfortunately the default is currently to power off the system during=
 the
> suspend so the users of these systems experience problems after the r=
esume
> if they don't switch to the platform mode explicitly.  This patch mak=
es swsusp
> use the platform mode by default to avoid such situations.
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---

Acked-by: Stefan Seyfried <seife@suse.de>

Some background: i have put this as a default (from userspace, via
echo "platform" > disk) since at least two years (SuSE 9.3, probably
earlier) and have received one single bugreport where using "shutdown"
mode fixed a problem. I had much more reports from users that upgraded
from 9.1 and did not get the new setting about problems with "shutdown"
which were solved by changing to "platform", so from my experience,
"platform" mode is actually working better than "shutdown" mode.

Note that shutdown mode will not lead to spectacular failures, but smal=
l
annoyances like incorrectly reported AC / battery state etc.

> Index: linux-2.6.19-rc4-mm1/kernel/power/disk.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.19-rc4-mm1.orig/kernel/power/disk.c
> +++ linux-2.6.19-rc4-mm1/kernel/power/disk.c
> @@ -62,9 +62,11 @@ static void power_down(suspend_disk_meth
> =20
>  	switch(mode) {
>  	case PM_DISK_PLATFORM:
> -		kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
> -		error =3D pm_ops->enter(PM_SUSPEND_DISK);
> -		break;
> +		if (pm_ops && pm_ops->enter) {
> +			kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
> +			error =3D pm_ops->enter(PM_SUSPEND_DISK);
> +			break;
> +		}

I have never heard of a system that had problems with not-present
pm_ops->enter, but this extra safety net cannot hurt.
--=20
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out."=
=20
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
