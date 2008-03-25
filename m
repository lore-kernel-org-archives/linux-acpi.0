From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-pm] [RFC][PATCH] PM: Introduce new top level =?iso-8859-1?q?suspend=09and_hibernation_callbacks?= (rev. 2)
Date: Tue, 25 Mar 2008 21:49:36 +0100
Message-ID: <200803252149.37552.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0803251030220.4838-100000@iolanthe.rowland.org> <200803252048.43792.oliver@neukum.org> <200803252141.49049.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:54681 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbYCYUti convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Mar 2008 16:49:38 -0400
In-Reply-To: <200803252141.49049.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>, LKML <linux-kernel@vger.kernel.org>

Am Dienstag, 25. M=E4rz 2008 21:41:48 schrieb Rafael J. Wysocki:
> On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> > Am Dienstag, 25. M=E4rz 2008 15:33:22 schrieb Alan Stern:
> > > > so I'd say a
> > > > failure to resume is just a limited subcase of a device vanishi=
ng during
> > > > sleep.
> > >=20
> > > I'll go along with that. =A0If a device vanishes during sleep, th=
e PM=20
> > > core isn't responsible for unregistering it -- the device's subsy=
stem=20
> > > is.
> >=20
> > Yes, that makes sense. You are right.
>=20
> Still, if ->resume() returns an error, does it make sense, from the P=
M core's
> point of view, to execute ->complete() for that device, for example?

IMO you must always keep the ordering invariant. If a parent returns an=
 error
the PM core must not wake its children.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
