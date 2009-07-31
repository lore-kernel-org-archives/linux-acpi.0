From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH update] PM: Introduce core framework for run-time PM of
	I/O devices (rev. 11)
Date: Fri, 31 Jul 2009 23:32:13 +0900
Message-ID: <aec7e5c30907310732u35faa15fpab070025f596463e@mail.gmail.com>
References: <200907221701.50449.rjw@sisk.pl> <200907222110.47701.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:14676 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbZGaOcN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2009 10:32:13 -0400
In-Reply-To: <200907222110.47701.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>

Hi Rafail

[Runtime PM v11]

Thanks for your work on this. The code is getting better and better.
I've just finished posting a bunch of patches related to v11 of your
Runtime PM patch. Basically everything seems fine except a few minor
details and the code below: =3D)

On Thu, Jul 23, 2009 at 4:10 AM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> On Wednesday 22 July 2009, Rafael J. Wysocki wrote:
> Index: linux-2.6/drivers/base/dd.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/base/dd.c
> +++ linux-2.6/drivers/base/dd.c
> @@ -23,6 +23,7 @@
> =A0#include <linux/kthread.h>
> =A0#include <linux/wait.h>
> =A0#include <linux/async.h>
> +#include <linux/pm_runtime.h>
>
> =A0#include "base.h"
> =A0#include "power/power.h"
> @@ -202,7 +203,9 @@ int driver_probe_device(struct device_dr
> =A0 =A0 =A0 =A0pr_debug("bus: '%s': %s: matched device %s with driver=
 %s\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv->bus->name, __func__, dev_name(de=
v), drv->name);
>
> + =A0 =A0 =A0 pm_runtime_get_noresume(dev);
> =A0 =A0 =A0 =A0ret =3D really_probe(dev, drv);
> + =A0 =A0 =A0 pm_runtime_put_noidle(dev);
>
> =A0 =A0 =A0 =A0return ret;
> =A0}

This creates problems when drivers want to performing runtime resume
from within probe(). For more details please have a look at "[PATCH
04/04] video: Runtime PM hack for SuperH LCDC driver".

Cheers,

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
