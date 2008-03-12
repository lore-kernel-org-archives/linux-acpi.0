From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Separate suspend and hibernation callbacks (highest level) - updated
Date: Wed, 12 Mar 2008 22:22:36 +0100
Message-ID: <200803122222.37024.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0803092219290.31643-100000@netrider.rowland.org> <200803101758.01826.rjw@sisk.pl> <200803120237.24857.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43991 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752409AbYCLVXY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Mar 2008 17:23:24 -0400
In-Reply-To: <200803120237.24857.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>

On Wednesday, 12 of March 2008, David Brownell wrote:
> On Monday 10 March 2008, Rafael J. Wysocki wrote:
> > + * @poweroff: Hibernation-specific, executed after saving a hibern=
ation image.
> > + *=A0=A0=A0=A0=A0Quiesce the device, put it into a low power state=
 appropriate for the
> > + *=A0=A0=A0=A0=A0upcoming system state (such as PCI_D3hot), and en=
able wakeup events as
> > + *=A0=A0=A0=A0=A0appropriate.
>=20
> This seems uncomfortably similar to device_driver.shutdown().
> The only obvious difference is wakeup event handling, and even
> that is already a function of the target system state.
>=20
> Are both methods needed?
>=20
> Shouldn't this be more generic, not "hibernation-specific"?

Well, let's not make restrictions at this point.  There's nothing wrong=
 with
pointing both at the same function and if everyone turns out to do that=
, we'll
remove one callback.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
