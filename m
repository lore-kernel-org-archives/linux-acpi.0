From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V2 3/4] usb: Bind devices to ACPI devices when possible
Date: Wed, 14 Mar 2012 07:29:32 -0700
Message-ID: <20120314142932.GD27770@kroah.com>
References: <1331588747-1247-1-git-send-email-mjg@redhat.com>
 <1331588747-1247-3-git-send-email-mjg@redhat.com>
 <4F5FF26C.5040004@intel.com>
 <20120314124811.GB5155@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35142 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030962Ab2CNO3h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Mar 2012 10:29:37 -0400
Received: by iagz16 with SMTP id z16so2396546iag.19
        for <linux-acpi@vger.kernel.org>; Wed, 14 Mar 2012 07:29:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120314124811.GB5155@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, lenb@kernel.org

On Wed, Mar 14, 2012 at 12:48:11PM +0000, Matthew Garrett wrote:
> On Wed, Mar 14, 2012 at 09:20:44AM +0800, Lan Tianyu wrote:
> > On 2012=E5=B9=B403=E6=9C=8813=E6=97=A5 05:45, Matthew Garrett wrote=
:
> > >Built-in USB devices will typically have a representation in the s=
ystem
> > >ACPI tables. Add support for binding the two together so the USB c=
ode can
> > >make use of the associated methods.
> > hi Matthew:
> > 	acpi glue framework only can cover situation that the port has bee=
n
> > connected with some device. so without device, no acpi handle can b=
e used to
> > access "UPC" and "PLD".
> > 	Whether the usb port is user-visible or not is also useful when th=
ere
> > is no device. For example, if it is known that the usb port is not =
user-visible
> > and connectable. The usb hub port can be power-off.
> > 	So usb/acpi binding should consider those usb ports without pluggi=
ng device.
> > Does this make sense? :)
>=20
> I agree that this woud be useful, but right now we don't have port=20
> objects so there's nowhere to expose this. Greg, do you have any=20
> feelings about how this coud be handled?

If you wanted to do something like this, you are right, you would need
to create a "port" device and put it on every hub.  Odds are that's
probably not worth it as you will be adding more indirection on every
USB device, yet only ACPI based systems would be able to do anything
with them.

Is there really a power savings to turn off a port if nothing is presen=
t
in it?  If so, how do we know to wake it up?  What if we really wanted
it on just to "charge" something, and it never was showing up as a real
device?  Messing with that could get very tricky very quickly.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
