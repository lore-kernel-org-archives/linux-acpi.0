From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch update] Re: [linux-pm] Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Thu, 11 Jun 2009 01:07:22 +0200
Message-ID: <200906110107.23023.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0906082233490.19072-100000@netrider.rowland.org> <200906102338.35183.oliver@neukum.org> <200906110001.20718.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:48145 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757206AbZFJXGg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jun 2009 19:06:36 -0400
In-Reply-To: <200906110001.20718.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Am Donnerstag, 11. Juni 2009 00:01:20 schrieb Rafael J. Wysocki:
> We have queued up resume requests for the device's parent, its parent=
 etc.,
> the topmost one goes first. =A0The workqueue is singlethread, so
> pm_autoresume() is going to be run for all parents before the device
> itself, so if that were the only resume mechanism, it would be enough=
 to
> check if the parent is RPM_ACTIVE.

            A (IDLE)
    /                                \
B (SUSPENDED)         C (SUSPENDED)

Suppose C is to be resumed. This means first in case of A the request
to suspend would be cancelled. Here you drop the locks:

+           && (dev->parent->power.runtime_status =3D=3D RPM_IDLE
+             || dev->parent->power.runtime_status =3D=3D RPM_SUSPENDIN=
G
+             || dev->parent->power.runtime_status =3D=3D RPM_SUSPENDED=
)) {
+               spin_unlock_irqrestore(&dev->power.lock, flags);
+               spin_unlock_irqrestore(&dev->parent->power.lock, parent=
_flags);
+
+               /* We have to resume the parent first. */
+               pm_request_resume(dev->parent);

But after pm_request_resume() returns there's no means to make sure
nothing alters it back to RPM_SUSPENDED. The workqueue doesn't help
you because you've scheduled nothing by that time. The suspension will
work because C is still in RPM_SUSPENDED.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
