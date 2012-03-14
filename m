From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V2 3/4] usb: Bind devices to ACPI devices when possible
Date: Wed, 14 Mar 2012 10:44:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1203141043370.1644-100000@iolanthe.rowland.org>
References: <20120314142932.GD27770@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:56257 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030697Ab2CNOoo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Mar 2012 10:44:44 -0400
In-Reply-To: <20120314142932.GD27770@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Matthew Garrett <mjg@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, lenb@kernel.org

On Wed, 14 Mar 2012, Greg KH wrote:

> On Wed, Mar 14, 2012 at 12:48:11PM +0000, Matthew Garrett wrote:
> > On Wed, Mar 14, 2012 at 09:20:44AM +0800, Lan Tianyu wrote:
> > > On 2012=E5=B9=B403=E6=9C=8813=E6=97=A5 05:45, Matthew Garrett wro=
te:
> > > >Built-in USB devices will typically have a representation in the=
 system
> > > >ACPI tables. Add support for binding the two together so the USB=
 code can
> > > >make use of the associated methods.
> > > hi Matthew:
> > > 	acpi glue framework only can cover situation that the port has b=
een
> > > connected with some device. so without device, no acpi handle can=
 be used to
> > > access "UPC" and "PLD".
> > > 	Whether the usb port is user-visible or not is also useful when =
there
> > > is no device. For example, if it is known that the usb port is no=
t user-visible
> > > and connectable. The usb hub port can be power-off.
> > > 	So usb/acpi binding should consider those usb ports without plug=
ging device.
> > > Does this make sense? :)
> >=20
> > I agree that this woud be useful, but right now we don't have port=20
> > objects so there's nowhere to expose this. Greg, do you have any=20
> > feelings about how this coud be handled?
>=20
> If you wanted to do something like this, you are right, you would nee=
d
> to create a "port" device and put it on every hub.  Odds are that's
> probably not worth it as you will be adding more indirection on every
> USB device, yet only ACPI based systems would be able to do anything
> with them.

Even on ACPI systems, most host controllers are not able to power off=20
individual ports.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
