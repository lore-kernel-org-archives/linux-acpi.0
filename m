From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and hibernation callbacks (rev. 6)
Date: Wed, 2 Apr 2008 22:11:35 +0200
Message-ID: <200804022211.36438.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0804021238190.5042-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:46797 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbYDBUMU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Apr 2008 16:12:20 -0400
In-Reply-To: <Pine.LNX.4.44L0.0804021238190.5042-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Nigel Cunningham <ncunningham@crca.org.au>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Am Mittwoch, 2. April 2008 18:42:15 schrieb Alan Stern:
> On Wed, 2 Apr 2008, Oliver Neukum wrote:
>=20
> > Am Mittwoch, 2. April 2008 17:13:11 schrieb Alan Stern:
> > > Basically yes. =A0Subsystems and drivers are allowed to keep devi=
ces
> > > suspended if they were suspended before the system went to sleep.=
 =A0
> > > Remember, the purpose of the resume method is to let drivers know=
 that
> > > the system is now awake, not to force them to put their devices i=
nto a
> > > high-power state.
> >=20
> > Well, sometimes it is exactly that what we desire, eg. as a side ef=
fect
> > of lsusb. Should the callbacks have different semantics depending o=
n
> > the reason you call them? And how should that information be transf=
erred?
>=20
> Which callbacks are you referring to?  When lsusb opens a device and
> does an autoresume, it does not call the same routine as the PM core
> does when resuming from a system sleep.  lsusb ends up calling
> usb_autoresume_device() whereas the PM core ends up calling
> usb_resume(), which is the function you quoted earlier.

But how is usb_autoresume_device() supposed to take to the driver?
=46urthermore suppose the interface woken up is storage. This will have
to work across subsystem borders. Why not put it into generic code?

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
