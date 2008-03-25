From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-pm] [RFC][PATCH] PM: Introduce new top level =?utf-8?q?suspend=09and_hibernation_callbacks?= (rev. 2)
Date: Tue, 25 Mar 2008 14:15:08 +0100
Message-ID: <200803251415.09088.oliver@neukum.org>
References: <200803210101.04706.rjw@sisk.pl> <200803251049.27696.oliver@neukum.org> <200803251406.16741.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:42359 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750AbYCYNPK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Mar 2008 09:15:10 -0400
In-Reply-To: <200803251406.16741.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, LKML <linux-kernel@vger.kernel.org>

Am Dienstag, 25. M=C3=A4rz 2008 14:06:15 schrieb Rafael J. Wysocki:
> On Tuesday, 25 of March 2008, Oliver Neukum wrote:
> > Am Freitag, 21. M=C3=A4rz 2008 01:21:03 schrieb Johannes Berg:
> > > > + * All of the above callbacks, except for @complete(), return =
error codes.
> > > > + * However, the error codes returned by the resume operations,=
 @resume(),
> > > > + * @thaw(), and @restore(), are only printed in the system log=
s, since the PM
> > > > + * core cannot do anything else about them.
> > >=20
> > > Why bother and not just make them return void, the error printing=
 can
> > > most likely be done much much better in the callback since that p=
ossibly
> > > has information on why it failed.
> >=20
> > A device that cannot wake up is unusable. Shouldn't the pm core dis=
connect()
> > such a device?
>=20
> Well, if ->resume() returns an error, the driver already knows there'=
s a
> problem and it can act upon that, at least in principle.

Then why return an error? If a driver returns an error I would assume t=
hat
to indicate an irrecoverable error.

> However, the PM core probably shouldn't try to resume the children of=
 a failing
> device.  Also, if ->resume_noirq() fails, it probably is not a good i=
dea to
> call ->resume() and ->complete() for the same device and for it's chi=
ldren.

Exactly. But we need to define what happens in these cases. If we simpl=
y
ignore the errors, the drivers must be able to deal with IO to half sus=
pended
devices.

	Regards
		Oliver


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
