From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and hibernation
 callbacks (rev. 6)
Date: Wed, 2 Apr 2008 12:42:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0804021238190.5042-100000@iolanthe.rowland.org>
References: <200804021728.45823.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:42996 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755995AbYDBQmR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Apr 2008 12:42:17 -0400
In-Reply-To: <200804021728.45823.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Nigel Cunningham <ncunningham@crca.org.au>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Wed, 2 Apr 2008, Oliver Neukum wrote:

> Am Mittwoch, 2. April 2008 17:13:11 schrieb Alan Stern:
> > Basically yes. =A0Subsystems and drivers are allowed to keep device=
s
> > suspended if they were suspended before the system went to sleep. =A0
> > Remember, the purpose of the resume method is to let drivers know t=
hat
> > the system is now awake, not to force them to put their devices int=
o a
> > high-power state.
>=20
> Well, sometimes it is exactly that what we desire, eg. as a side effe=
ct
> of lsusb. Should the callbacks have different semantics depending on
> the reason you call them? And how should that information be transfer=
red?

Which callbacks are you referring to?  When lsusb opens a device and
does an autoresume, it does not call the same routine as the PM core
does when resuming from a system sleep.  lsusb ends up calling
usb_autoresume_device() whereas the PM core ends up calling
usb_resume(), which is the function you quoted earlier.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
