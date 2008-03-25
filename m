From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-pm] [RFC][PATCH] PM: Introduce new top level =?iso-8859-1?q?suspend=09and_hibernation_callbacks?= (rev. 2)
Date: Tue, 25 Mar 2008 15:24:33 +0100
Message-ID: <200803251524.34147.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0803251011110.4838-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:44490 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179AbYCYOYi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Mar 2008 10:24:38 -0400
In-Reply-To: <Pine.LNX.4.44L0.0803251011110.4838-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>, LKML <linux-kernel@vger.kernel.org>

Am Dienstag, 25. M=E4rz 2008 15:19:45 schrieb Alan Stern:
> On Tue, 25 Mar 2008, Oliver Neukum wrote:
>=20
> > Am Dienstag, 25. M=C3=A4rz 2008 14:06:15 schrieb Rafael J. Wysocki:
> > > On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> >=20
> > > > A device that cannot wake up is unusable. Shouldn't the pm core=
 disconnect()
> > > > such a device?
>=20
> It's not safe for the PM core to do such things unilaterally. =A0The=20
> decision to unregister a device should be made by the driver or the=20
> subsystem.

Why? You can trigger it from user space via sysfs and in many cases
suspending to disk will disconnect all devices on a bus, so I'd say a
failure to resume is just a limited subcase of a device vanishing durin=
g
sleep.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
