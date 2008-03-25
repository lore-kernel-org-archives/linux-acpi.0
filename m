From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC][PATCH] PM: Introduce new top level
 =?iso-8859-1?q?suspend=09and_hibernation_callbacks?= (rev. 2)
Date: Tue, 25 Mar 2008 10:33:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803251030220.4838-100000@iolanthe.rowland.org>
References: <200803251524.34147.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34888 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754002AbYCYOdX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Mar 2008 10:33:23 -0400
In-Reply-To: <200803251524.34147.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>, LKML <linux-kernel@vger.kernel.org>

On Tue, 25 Mar 2008, Oliver Neukum wrote:

> Am Dienstag, 25. M=E4rz 2008 15:19:45 schrieb Alan Stern:

> > It's not safe for the PM core to do such things unilaterally. =A0Th=
e=20
> > decision to unregister a device should be made by the driver or the=
=20
> > subsystem.
>=20
> Why? You can trigger it from user space via sysfs

How can you do that?

>  and in many cases
> suspending to disk will disconnect all devices on a bus,

But these disconnects aren't done by the PM core; they are done by=20
individual drivers or subsystems.

> so I'd say a
> failure to resume is just a limited subcase of a device vanishing dur=
ing
> sleep.

I'll go along with that.  If a device vanishes during sleep, the PM=20
core isn't responsible for unregistering it -- the device's subsystem=20
is.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
