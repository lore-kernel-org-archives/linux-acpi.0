From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and hibernation
 callbacks (rev. 6)
Date: Wed, 2 Apr 2008 16:28:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0804021623520.2107-100000@iolanthe.rowland.org>
References: <200804022211.36438.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:38434 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760512AbYDBU2b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Apr 2008 16:28:31 -0400
In-Reply-To: <200804022211.36438.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Nigel Cunningham <ncunningham@crca.org.au>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Wed, 2 Apr 2008, Oliver Neukum wrote:

> Am Mittwoch, 2. April 2008 18:42:15 schrieb Alan Stern:
> > On Wed, 2 Apr 2008, Oliver Neukum wrote:
> >=20
> > > Am Mittwoch, 2. April 2008 17:13:11 schrieb Alan Stern:
> > > > Basically yes. =A0Subsystems and drivers are allowed to keep de=
vices
> > > > suspended if they were suspended before the system went to slee=
p. =A0
> > > > Remember, the purpose of the resume method is to let drivers kn=
ow that
> > > > the system is now awake, not to force them to put their devices=
 into a
> > > > high-power state.
> > >=20
> > > Well, sometimes it is exactly that what we desire, eg. as a side =
effect
> > > of lsusb. Should the callbacks have different semantics depending=
 on
> > > the reason you call them? And how should that information be tran=
sferred?
> >=20
> > Which callbacks are you referring to?  When lsusb opens a device an=
d
> > does an autoresume, it does not call the same routine as the PM cor=
e
> > does when resuming from a system sleep.  lsusb ends up calling
> > usb_autoresume_device() whereas the PM core ends up calling
> > usb_resume(), which is the function you quoted earlier.
>=20
> But how is usb_autoresume_device() supposed to take to the driver?
> Furthermore suppose the interface woken up is storage. This will have
> to work across subsystem borders. Why not put it into generic code?

I'm not sure exactly what you're asking.  However it's worth mentioning=
=20
that once the dust from Rafael's changes settles down, I intend to=20
submit a patch creating new PM_EVENT_* codes:

	PM_EVENT_USER_SUSPEND
	PM_EVENT_USER_RESUME
	PM_EVENT_REMOTE_WAKEUP
	PM_EVENT_AUTOSUSPEND
	PM_EVENT_AUTORESUME

(and the corresponding PMSG_* definitions).  The PM core will never use
the new codes, but subsystems like USB will be able to use them
internally.  Does that answer your question?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
