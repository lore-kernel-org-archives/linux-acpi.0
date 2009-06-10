From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] Re: [linux-pm] Run-time PM idea (was: Re:
 [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Wed, 10 Jun 2009 19:42:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906101942280.29717-100000@netrider.rowland.org>
References: <200906110107.23023.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:44255 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758272AbZFJXms (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jun 2009 19:42:48 -0400
In-Reply-To: <200906110107.23023.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, 11 Jun 2009, Oliver Neukum wrote:

> Am Donnerstag, 11. Juni 2009 00:01:20 schrieb Rafael J. Wysocki:
> > We have queued up resume requests for the device's parent, its pare=
nt etc.,
> > the topmost one goes first. =A0The workqueue is singlethread, so
> > pm_autoresume() is going to be run for all parents before the devic=
e
> > itself, so if that were the only resume mechanism, it would be enou=
gh to
> > check if the parent is RPM_ACTIVE.
>=20
>             A (IDLE)
>     /                                \
> B (SUSPENDED)         C (SUSPENDED)
>=20
> Suppose C is to be resumed. This means first in case of A the request
> to suspend would be cancelled. Here you drop the locks:
>=20
> +           && (dev->parent->power.runtime_status =3D=3D RPM_IDLE
> +             || dev->parent->power.runtime_status =3D=3D RPM_SUSPEND=
ING
> +             || dev->parent->power.runtime_status =3D=3D RPM_SUSPEND=
ED)) {
> +               spin_unlock_irqrestore(&dev->power.lock, flags);
> +               spin_unlock_irqrestore(&dev->parent->power.lock, pare=
nt_flags);
> +
> +               /* We have to resume the parent first. */
> +               pm_request_resume(dev->parent);
>=20
> But after pm_request_resume() returns there's no means to make sure
> nothing alters it back to RPM_SUSPENDED. The workqueue doesn't help
> you because you've scheduled nothing by that time. The suspension wil=
l
> work because C is still in RPM_SUSPENDED.

This is an example where usage counters come in handy.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
