From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/3] PM: Introduce new top level suspend and hibernation callbacks (rev. 7)
Date: Wed, 2 Apr 2008 15:12:15 +0200
Message-ID: <20080402131215.GC5295@ucw.cz>
References: <200804020207.40278.rjw@sisk.pl> <200804020209.47207.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2445 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752846AbYDBNMj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Apr 2008 09:12:39 -0400
Content-Disposition: inline
In-Reply-To: <200804020209.47207.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Oliver Neukum <oliver@neukum.org>, Nigel Cunningham <ncunningham@crca.org.au>

On Wed 2008-04-02 02:09:46, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> Introduce 'struct pm_ops' and 'struct pm_ext_ops' ('ext' meaning
> 'extended') representing suspend and hibernation operations for bus
> types, device classes, device types and device drivers.
>=20
> Modify the PM core to use 'struct pm_ops' and 'struct pm_ext_ops'
> objects, if defined, instead of the ->suspend() and ->resume(),
> ->suspend_late(), and ->resume_early() callbacks (the old callbacks
> will be considered as legacy and gradually phased out).
>=20
> The main purpose of doing this is to separate suspend (aka S2RAM and
> standby) callbacks from hibernation callbacks in such a way that the
> new callbacks won't take arguments and the semantics of each of them
> will be clearly specified. =A0This has been requested for multiple
> times by many people, including Linus himself, and the reason is that
> within the current scheme if ->resume() is called, for example, it's
> difficult to say why it's been called (ie. is it a resume from RAM or
> from hibernation or a suspend/hibernation failure etc.?).
>=20
> The second purpose is to make the suspend/hibernation callbacks more
> flexible so that device drivers can handle more than they can within
> the current scheme.  For example, some drivers may need to prevent
> new children of the device from being registered before their
> ->suspend() callbacks are executed or they may want to carry out some
> operations requiring the availability of some other devices, not
> directly bound via the parent-child relationship, in order to prepare
> for the execution of ->suspend(), etc.
>=20
> Ultimately, we'd like to stop using the freezing of tasks for suspend
> and therefore the drivers' suspend/hibernation code will have to take
> care of the handling of the user space during suspend/hibernation.
> That, in turn, would be difficult within the current scheme, without
> the new ->prepare() and ->complete() callbacks.
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
